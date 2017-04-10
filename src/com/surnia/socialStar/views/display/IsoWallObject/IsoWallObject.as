package com.surnia.socialStar.views.display.IsoWallObject 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IsoScene;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.SWFLoader;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class IsoWallObject extends Sprite
	{
		/*------------------------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _instance:IsoSprite;
		private var _isoScene:IsoScene;		
		private var _dir:String;
		
		private var _gd:GlobalData;		
		private var _movieclip:MovieClip;
		private var _id:String;
		
		
		//new
		private var _imageHolder:Sprite;
		private var _loadingMC:LoadingMC; 
		private var _imageStorage:ImageStorage;
		private var imageLoader:ImageLoader;
		private var _swfLoader:SWFLoader;
		private var _imageName:String=null;
		private var _isSwf:Boolean;
		private var _url:String = null;
		private var _isRotated:Boolean;
		private var _es:EventSatellite;
		/*------------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function IsoWallObject( scene:IsoScene, id:String, i:int, j:int , dir:String  ) 
		{
			_gd = GlobalData.instance;
			_isoScene = scene;
			_id = id;
			_dir = dir;
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onQuickUpdate );
			
			//_movieclip = new Objects();
			_instance = new IsoSprite();
			//_movieclip.gotoAndStop( _id );
			name = dir + "_i" + i + "_j" + j;
			//_instance.sprites = [ _movieclip ];
			
			_imageStorage = ImageStorage.getInstance();	
			addPreloader();
			showDisplay( _imageName, _url );
			
			_instance.sprites = [ _imageHolder ];
			if ( dir == "right" ) {
				_instance.container.scaleX = -(_instance.container.scaleX);
			}
			_instance.moveBy( i * _gd.CELL_SIZE, j * _gd.CELL_SIZE, GlobalData.ISO_WALL_OBJECT_DEPTH );
			_isoScene.addChild( _instance );			
		}			
		
		/*------------------------------------------------------------------------Methods---------------------------------------------------------------*/
		private function showDisplay( imageName:String = null, url:String = null ):void 
		{
			if ( imageName != null  ){
				_imageName = imageName;
			}
			
			//trace( "show display" );			
			var found:Boolean = _imageStorage.search( _imageName );
			if ( found ) {
				//trace( "[ IsoWallObject ] found image for wall reused image!!........" );
				_loadingMC.stop();
				_loadingMC.visible = false;
				var image:Bitmap = _imageStorage.getImage( _imageName );				
				_imageHolder.addChild( image );					
				
				
				if ( _dir == "right" ) {
					if ( _instance != null ) {
						if( !_isRotated ){
							_instance.container.scaleX = -(_instance.container.scaleX);
							_isRotated = true;
						}
						_imageHolder.x = 0;
						_imageHolder.y = -126;
					}
				}else{										
					_imageHolder.x = -45;
					_imageHolder.y = -126;
				}
			}else {
				//trace( "[ IsoWallObject ] can't find image for wall image download new image for wall!!........" );
				if ( url != null ) {
					_url = url;
					start( _url );
				}else {
					start(  );	
				}
			}
		}
		
		private function addPreloader():void 
		{
			_isSwf = false;			
			
			if ( _dir == "left" ){
				//_gd.wallImageLeftName;
				if ( _gd.wallImageLeftName != "" ) {
					_imageName = _gd.wallImageLeftName;
					_url = _gd.wallImageLeft;
				}else {
					_imageName = "Wall_Sprite02_L";
				}				
			}else {
				if ( _gd.wallImageRightName != "" ) {
					_imageName = _gd.wallImageRightName;
					_url = _gd.wallImageRight;
				}else {
					_imageName = "Wall_Sprite02_R";
				}
				//_gd.wallImageRightName;				
			}
			
			_imageHolder = new Sprite();
			addChild( _imageHolder );
			
			_loadingMC = new LoadingMC();
			_imageHolder.addChild( _loadingMC );
			
			if ( _dir == "right" ) {
				_loadingMC.x = 0;
				_loadingMC.y = -126;
			}else {
				_loadingMC.x = -45;
				_loadingMC.y = -126;
			}			
			_movieclip = new MovieClip();
		}
		
		private function start( url:String = null ):void 
		{				
			var config:ImageLoaderVars = new ImageLoaderVars();
			config.container(_movieclip);
			config.onComplete(_completeHandler);
			config.onProgress(_progressHandler);
			config.onIOError(_ioErrorHandler);
			config.onFail(_failHandler);
			config.autoDispose(true);
			config.name(_imageName);
			
			if ( !_isSwf ) {
				if ( _dir == "left" ) {					
					if ( url != null ) {
						imageLoader = new ImageLoader( _url, config);
						//_gd.wallImageLeft = _gd.absPath + _url;
						//_gd.wallImageLeftName = _imageName;
					}else{						
						//imageLoader = new ImageLoader(_gd.wallImageLeft, config);						
						imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Wall/Wall_Sprite02_L.png", config);
						//imageLoader = new ImageLoader("images/Wall/Wall_Sprite02_L.png", config);						
					}
					imageLoader.load();
				}else{					
					if ( url != null ) {
						imageLoader = new ImageLoader( _url, config);
						//_gd.wallImageRight = _gd.absPath + _url;
						//_gd.wallImageRightName = _imageName;
					}else {						
						//imageLoader = new ImageLoader(_gd.wallImageRight, config);						
						imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Wall/Wall_Sprite02_R.png", config);
						//imageLoader = new ImageLoader("images/Wall/Wall_Sprite02_R.png", config);
					}
					imageLoader.load();
				}				
			}else {				
				_swfLoader = new SWFLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Deco_Plane01.swf", config);
				_swfLoader.load();
			}
		}
		
		public function destroy():void 
		{
			if ( _instance != null ) {
				if ( _isoScene.contains( _instance ) ) {
					_isoScene.removeChild( _instance );
					_instance = null;
				}
			}
		}
		
		public function updateSkin( leftImageName:String, rightImageName:String, leftImageUrl:String, rightImageUrl:String  ):void 
		{
			if ( _dir =="right" ){
				showDisplay( rightImageName, rightImageUrl );
			}else {
				showDisplay( leftImageName, leftImageUrl );
			}
		}
		
		/*------------------------------------------------------------------------Setters---------------------------------------------------------------*/
		public function set instance(value:IsoSprite):void 
		{
			_instance = value;
		}
		
		public function set movieclip(value:MovieClip):void 
		{
			_movieclip = value;
		}
		/*------------------------------------------------------------------------Getters---------------------------------------------------------------*/
		public function get instance():IsoSprite 
		{
			return _instance;
		}
		
		public function get movieclip():MovieClip 
		{
			return _movieclip;
		}
		
		/*------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		//new
		private function _progressHandler(event:LoaderEvent):void {
			//this.progress_mc.progressBar_mc.scaleX = event.target.progress;
			trace( "percernt loaded check: ", event.target.progress );
		}
		
		private function _completeHandler(event:LoaderEvent):void {
			//TweenLite.to(event.target.content, 1, 
						 //{alpha:1, scaleX:1, scaleY:1, rotation:"360", 
						  //ease:Back.easeOut});
			trace("Finished loading " + event.target);
			trace( "name please" + event.target.name , "content", event.target.content );			
			_imageStorage.addImage( event.target.name, _movieclip );			
			showDisplay();
			
			var imageLoaderEvent:ImageLoaderEvent = new ImageLoaderEvent( ImageLoaderEvent.IMAGE_LOADED );
			imageLoaderEvent.obj.name = event.target.name;
			_es.dispatchESEvent( imageLoaderEvent  );
		}
		
		private function _ioErrorHandler(event:LoaderEvent):void {
			trace("Asset IOError:", event);
		}
		
		private function _failHandler(event:LoaderEvent):void {
			trace("Asset failed to load:", event);
		}
		
		private function onQuickUpdate(e:ImageLoaderEvent):void 
		{			
			if ( e.obj.name == _imageName ) {
				//quick update here
				//trace( "show display" );			
				var found:Boolean = _imageStorage.search( _imageName );
				if ( found ) {
					trace( "[ IsoWallObject ] found image for wall reused image!!........" );
					_loadingMC.stop();
					_loadingMC.visible = false;
					var image:Bitmap = _imageStorage.getImage( _imageName );				
					_imageHolder.addChild( image );					
					imageLoader.pause();
					imageLoader.dispose();
					
					if ( _dir == "right" ) {
						if ( _instance != null ) {
							if( !_isRotated ){
								_instance.container.scaleX = -(_instance.container.scaleX);
								_isRotated = true;
							}
							_imageHolder.x = 0;
							_imageHolder.y = -126;
						}
					}else{										
						_imageHolder.x = -45;
						_imageHolder.y = -126;
					}
				}
			}	
		}
	}

}