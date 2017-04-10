package com.surnia.socialStar.views.display.IsoFloorObject 
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
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import eDpLib.events.ProxyEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.Capabilities;
	
	
	
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class IsoFloorObject extends Sprite
	{
		/*--------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Properties-------------------------------------------------------------*/				
		private var _floorId:String;
		private var _scene:IsoScene;
		private var _gd:GlobalData;
		
		public var floorName:String;
		public var instance:IsoSprite;
		public var fid:String;		
		public var _image:MovieClip;
		public var occupied:int;
		public var selectable:Boolean = true;
		public var selected:Boolean = false;
		public var xPos:int;
		public var yPos:int;
		
		private var _es:EventSatellite;
		private var _isoRoomEvent:IsoRoomEvent;		
		private var _popUpUIManager:PopUpUIManager;		
		
		//new
		private var _imageHolder:Sprite;
		private var _loadingMC:LoadingMC; 
		private var _imageStorage:ImageStorage;
		private var imageLoader:ImageLoader;
		private var _swfLoader:SWFLoader;
		private var _imageName:String;
		private var _url:String;
		private var _isSwf:Boolean;
		
		/*--------------------------------------------------------------------Constructor------------------------------------------------------------*/		
		public function IsoFloorObject(iScene:IsoScene,_i:int, _j:int )
		{
			_popUpUIManager = PopUpUIManager.getInstance();
			_es = EventSatellite.getInstance();
			_es.addEventListener( ImageLoaderEvent.IMAGE_LOADED, quickUpdataTile );
			_gd = GlobalData.instance;
			
			xPos = _i * _gd.CELL_SIZE;
			yPos = _j * _gd.CELL_SIZE;			
			
			_scene = iScene;
			//_image = new Objects;
			//_image = new MovieClip();
			
			_imageStorage = ImageStorage.getInstance();	
			addPreloader();
			showDisplay();
			//start();			
			
			instance = new IsoSprite;
			name = 'floor_' + String(_i) + '_' + String(_j);			
			occupied = 0;
			instance.setSize(0, 0, GlobalData.ISO_FLOOR_DEPTH );
			//instance.sprites = [_image];
			instance.sprites = [_imageHolder];			
			instance.moveBy(_i * _gd.CELL_SIZE, _j * _gd.CELL_SIZE, GlobalData.ISO_FLOOR_DEPTH );
			
			_scene.addChild(instance);
			//_scene.render();			
			
			instance.addEventListener(MouseEvent.CLICK, onClickFloor );
			instance.addEventListener(MouseEvent.MOUSE_DOWN, onStartPanFloor );
			instance.addEventListener(MouseEvent.MOUSE_UP, onStopPanFloor);			
		}						
		
		public function destroy():void 
		{
			if ( instance != null ) {
					//imageLoader.dispose();
					//imageLoader.unload();
				if ( _scene.contains( instance ) ) {
					_scene.removeChild( instance );
					instance = null;					
				}
			}
		}
		
		/*--------------------------------------------------------------------Methods--------------------------------------------------------------*/
		
		public function updateTileSkin( imageName:String, url:String ):void 
		{
			//_image.gotoAndStop( id );
			_loadingMC.play();
			_loadingMC.visible = true;
			showDisplay( imageName, url );
		}		
		
		public function select(color:uint):void{
			instance.container.filters = [new GlowFilter( color, 1, 4, 4, 48 )];
		}
		
		public function deselect():void{
			instance.container.filters = [];
		}
		
		
		private function addPreloader():void 
		{
			_imageHolder = new Sprite();
			addChild( _imageHolder );
			
			_loadingMC = new LoadingMC();
			_imageHolder.addChild( _loadingMC );			
			_loadingMC.x = ( 70 / 2 ) - ( ( _loadingMC.width / 2 ) + 20 );
			_loadingMC.y = ( 36 / 2 ) -  ( ( _loadingMC.height / 2 ) + 25 );
			
			_image = new MovieClip();	
			
			_isSwf = false;
			//_imageName = "Deco_Plane01";
			
			if( _gd.tileImageName != "" ){
				_imageName = _gd.tileImageName;
			}else {
				_imageName = "Tile01";
			}
		}
		
		private function start( url:String = null ):void 
		{			
			var config:ImageLoaderVars = new ImageLoaderVars();
			config.container(_image);
			config.onComplete(_completeHandler);
			config.onProgress(_progressHandler);
			config.onIOError(_ioErrorHandler);
			config.onFail(_failHandler);
			config.autoDispose(true);
			config.name(_imageName);
			
			if ( !_isSwf ) {
				if ( url != null ){
					imageLoader = new ImageLoader( url, config);
				}else {
					//imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Tile18.png", config);
					//imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Tile24.png", config);
					imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Tile01.png", config);
					//imageLoader = new ImageLoader("images/Tile/Tile08.png", config);
				}				
				imageLoader.load();
			}else {
				if ( url != null ) {
					_swfLoader = new SWFLoader( url, config);
				}else{
					_swfLoader = new SWFLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Tile/Deco_Plane01.swf", config);
				}				
				_swfLoader.load();
			}			
			//addChild( imageLoader.content );		
		}
		
		private function clearImageHolder():void 
		{
			while ( _imageHolder.numChildren > 0 ) 
			{				
				_imageHolder.removeChildAt( 0 );
			}
		}
		
		private function showDisplay( imageName:String = null ,url:String = null ):void 
		{
			if ( imageName != null ){
				_imageName = imageName;
			}
			
			//trace( "show display" );			
			var found:Boolean = _imageStorage.search( _imageName );
			if ( found ){
				_loadingMC.stop();
				_loadingMC.visible = false;
				
				clearImageHolder();
				
				var image:Bitmap = _imageStorage.getImage( _imageName );			
				_imageHolder.addChild( image );
				_imageHolder.x = -35;
				//_imageHolder.y = -125;
			}else {
				if ( url != null ) {
					_url = url;
					start( _url );
				}else {
					var runingOn:String = Capabilities.playerType;
					if (runingOn != 'StandAlone')
					{
						start( _gd.tileImage );						
					}else {
						start(  );
					}					
				}				
			}
		}
		
		/*--------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
	
		
		
		/*--------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function getName():String
		{
			return floorName;
		}		
		
		public function get xloc():int
		{
			return instance.x;
		}
		
		public function get yloc():int
		{
			return instance.y;
		}
		
		/*--------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		
		private function onStartPanFloor(e:ProxyEvent):void 
		{
			//trace('floor name : ' + name , "isDraging", _gd.isDragging , "isWindowActive" , _popUpUIManager.isWindowActive , "isSubWindowActive", _popUpUIManager.isSubWindowActive, "currentWindow", _popUpUIManager.currentWindow );
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_START_PAN );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function onStopPanFloor(e:ProxyEvent):void 
		{
			//trace('floor name : ' + name);
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_PAN );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function onClickFloor(e:ProxyEvent):void 
		{
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_CLICK_FLOOR );
			_isoRoomEvent.obj = this;
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		//new
		private function _progressHandler(event:LoaderEvent):void {
			//this.progress_mc.progressBar_mc.scaleX = event.target.progress;
			//trace( "percernt loaded check: ", event.target.progress );
		}
		
		private function _completeHandler(event:LoaderEvent):void {
			//TweenLite.to(event.target.content, 1, 
						 //{alpha:1, scaleX:1, scaleY:1, rotation:"360", 
						  //ease:Back.easeOut});
			trace("Finished loading " + event.target);
			trace( "name please" + event.target.name , "content", event.target.content );			
			_imageStorage.addImage( event.target.name, _image );			
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
		
		private function quickUpdataTile(e:ImageLoaderEvent):void 
		{
			//showDisplay();
			if ( e.obj.name == _imageName ) {
				var found:Boolean = _imageStorage.search( _imageName );
				if ( found ){
					_loadingMC.stop();
					_loadingMC.visible = false;
					var image:Bitmap = _imageStorage.getImage( _imageName );
					clearImageHolder();					
					_imageHolder.addChild( image );
					_imageHolder.x = -35;
					imageLoader.pause();
					imageLoader.dispose(  );
					//imageLoader.unload();
					//_imageHolder.y = -125;
				}
			}			
		}
	}

}