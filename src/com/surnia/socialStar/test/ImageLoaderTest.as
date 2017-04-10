package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.controllers.imageLoader.ImageLoader;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ImageLoaderTest extends Sprite
	{
		private var imageLoader:ImageLoader;
		
		public function ImageLoaderTest() 
		{
			imageLoader = ImageLoader.getInstance();
			imageLoader.extractXmlByQid( "qicon003" );
			imageLoader.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onImageLoaded );			
		}
		
		private function onImageLoaded(e:ImageLoaderEvent):void 
		{
			for (var i:int = 0; i < 10; i++) 
			{
				var img:Bitmap = imageLoader.getImage( "qicon003" );
				addChild( img );
				img.x = img.width * i;
			}			
			imageLoader.extractXmlByQid( "qicon003" );
			
		}
		
	}

}