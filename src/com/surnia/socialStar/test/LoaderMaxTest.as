package com.surnia.socialStar.test 
{
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.TweenLite;	
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class LoaderMaxTest extends Sprite
	{
		/*-------------------------------------------------------------Constant---------------------------------------------------------*/
		
		/*-------------------------------------------------------------properties---------------------------------------------------------*/
		private var _image:MovieClip;
		private var _imageHolder:Sprite;
		private var _loadingMC:LoadingMC; 
		private var _imageStorage:ImageStorage;
		private var imageLoader:ImageLoader;
		private var _swfLoader:SWFLoader;
		private var _imageName:String;
		private var _isSwf:Boolean; 		
		/*-------------------------------------------------------------Constructor-------------------------------------------------------*/
		
		
		public function LoaderMaxTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			_imageStorage = ImageStorage.getInstance();			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			trace( "init loader max test" );
			start();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		/*-------------------------------------------------------------Methods---------------------------------------------------------*/
		private function start():void 
		{
			_imageHolder = new Sprite();
			addChild( _imageHolder );
			
			_loadingMC = new LoadingMC();
			_imageHolder.addChild( _loadingMC );
			//_loadingMC.x = ( 73.55 / 2 ) - ( _loadingMC.width + 25 );
			//_loadingMC.y = ( 81.7 / 2 ) -  ( _loadingMC.height + 15 );
			//_loadingMC.x = ( 70 / 2 ) - ( ( _loadingMC.width / 2 ) + 20 );
			//_loadingMC.y = ( 36 / 2 ) -  ( ( _loadingMC.height / 2 ) + 25 );
			_loadingMC.x = 15;
			_loadingMC.y = 36;
			
			_image = new MovieClip();	
			
			_isSwf = false;
			//_imageName = "Deco_Plane01";
			_imageName = "Deco_fan01";
			
			var config:ImageLoaderVars = new ImageLoaderVars();
			config.container(_image);			
			//config.x(35);
			//config.y(-125);
			//config.centerRegistration(true);
			//config.alpha(0);
			//config.scaleX(0);
			//config.scaleY(0);
			config.onComplete(_completeHandler);
			config.onProgress(_progressHandler);
			config.onIOError(_ioErrorHandler);
			config.onFail(_failHandler);
			config.autoDispose(true);
			config.name(_imageName);
			
			if ( !_isSwf ) {
				imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Deco/Table/Deco_fan01.png", config);						
				imageLoader.load();
			}else {
				_swfLoader = new SWFLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Deco/Table/Deco_fan01.png", config);
				_swfLoader.load();
			}			
			//addChild( imageLoader.content );		
		}
		
		private function showDisplay():void 
		{
			trace( "show display" );			
			var found:Boolean = _imageStorage.search( _imageName );
			if ( found ) {
				//_loadingMC.stop();
				//_loadingMC.visible = false;
				var image:Bitmap = _imageStorage.getImage( _imageName );
				_imageHolder.addChild( image );
				_imageHolder.x = -20;
				_imageHolder.y = -26;
			}
			
			//for (var i:int = 0; i < 6; i++) 
			//{
				//var found:Boolean = _imageStorage.search( "_imageName" );
				//
				//if( found ){
					//var image:Bitmap = _imageStorage.getImage( "_imageName" );				
					//image.x = i * image.width;
					//addChild( image );
				//}
			//}
		}
		/*-------------------------------------------------------------Setters---------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters---------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers----------------------------------------------------*/
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
			_imageStorage.addImage( event.target.name, _image );
			//_imageStorage.addImage( event.target.name, _image );
			
			showDisplay();
		}
		
		private function _ioErrorHandler(event:LoaderEvent):void {
			trace("Asset IOError:", event);
		}
		
		private function _failHandler(event:LoaderEvent):void {
			trace("Asset failed to load:", event);
		}
	}

}