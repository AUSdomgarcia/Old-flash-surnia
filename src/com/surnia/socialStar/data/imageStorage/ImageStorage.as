package com.surnia.socialStar.data.imageStorage 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ImageStorage 
	{
		/*--------------------------------------------------------------------------------Constant-----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Properties---------------------------------------------------------*/
		private var _images:Array;
		/*--------------------------------------------------------------------------------Constructor--------------------------------------------------------*/
		
		
		private static var _instance:ImageStorage;
		
		
		public function ImageStorage( enforcer:SingletonEnforcer ) 
		{
			init();
		}		
		
		public static function getInstance ():ImageStorage 
		{
			if ( ImageStorage._instance == null ) {
				ImageStorage._instance = new ImageStorage( new SingletonEnforcer() );
			}
			
			return ImageStorage._instance;
		}
		
		private function init():void 
		{
			_images = new Array();
			trace( "init ImageStorage......." );
		}
		
		/*--------------------------------------------------------------------------------Methods-----------------------------------------------------------*/
		public function addImage( imageName:String, image:MovieClip ):void 
		{				
			var found:Boolean = search( imageName );
			
			if( !found ){
				var imageData:ImageData = new ImageData();
				imageData.name = imageName;
				imageData.image = image;
				_images.push( imageData );
				//trace( "[ImageStorage]: added new image name", _images[ _images.length - 1 ].name , "width",  _images[ _images.length - 1 ].image.width, "height", _images[ _images.length - 1 ].image.height );
			}else {
				//trace( "[ImageStorage]: this image is already existing this will not add imagename", imageName );
			}
		}		
		
		public function getImage( imageName:String ):Bitmap 
		{
			var len:int = _images.length;
			var bm:Bitmap = null;
			
			for (var i:int = 0; i < len ; i++) 
			{
				if ( _images[ i ].name == imageName ) {
					//var bmd:BitmapData = new BitmapData( _images[ i ].image.width + 5 , _images[ i ].image.height + 5, true , 0 );
					var bmd:BitmapData = new BitmapData( _images[ i ].image.width, _images[ i ].image.height, true , 0 );
					bm = new Bitmap( bmd );
					bmd.draw( _images[ i ].image );
					break;
				}
			}			
			return bm;
		}
		
		public function getMovieClip( imageName:String ):MovieClip
		{
			var len:int = _images.length;
			var mc:MovieClip = null;
			
			for (var i:int = 0; i < len ; i++) 
			{
				if ( _images[ i ].name == imageName ) {					
					mc = _images[ i ].image;					
					break;
				}
			}			
			return mc;
		}
		
		public function search( imageName:String ):Boolean 
		{
			var len:int = _images.length;
			var found:Boolean = false;
			
			for (var i:int = 0; i < len ; i++) 
			{				
				if ( _images[ i ].name == imageName ) {					
					found = true;
					//trace( "[ImageStorage]: found image , imageName: ",imageName  );
					break;
				}
				//trace( "[ImageStorage]: Searching image imageName: ",imageName  );
			}			
			return found;
		}
		
		
		/*--------------------------------------------------------------------------------Setters-----------------------------------------------------------*/
		/*--------------------------------------------------------------------------------Getters-----------------------------------------------------------*/
		/*--------------------------------------------------------------------------------EventHandlers-----------------------------------------------------*/
	}

}

class SingletonEnforcer {}