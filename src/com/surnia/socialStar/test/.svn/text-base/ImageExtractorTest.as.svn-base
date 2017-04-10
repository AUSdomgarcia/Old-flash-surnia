package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class ImageExtractorTest
	{
	
		/*-------------------------------------------------------------------Constant------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private var _imageExtractor:ImageExtractor;
		private var _es:EventSatellite;
		/*-------------------------------------------------------------------Constructor---------------------------------------------------------------------*/
		
		public function ImageExtractorTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_imageExtractor = new ImageExtractor();
			_imageExtractor.extractXml();
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE, onLoadImage );			
		}		
		
		
		/*-------------------------------------------------------------------Methods------------------------------------------------------------------------*/
		private function addImage():void 
		{			
			var image:* = _imageExtractor.getImage( "J6VfAalX8e8HXkg7Fq2h" );
			
			if( image != null ){				
				addChild( image );
			}else {
				trace( "no image found!!!!!!!!!!!!!!!!" );
			}		
		}
		
		private function addImages():void 
		{
			var ids:Array = [ "J6VfAalX8e8HXkg7Fq2h", "m6mb9QnsSIViafVrr1sW", "97jNSX3VVg4dextxjNC" ];			
			
			var images:Array = _imageExtractor.getImagePackage( ids );
			
			if ( images != null ) {
				for (var i:int = 0; i < images.length; i++) 
				{					
					addChild( images[ i ] );					
					images[ i ].x = images[ i ].width * i;
				}				
			}else {
				trace( "no image found!!!!!!!!!!!!!!!!" );
			}
		}
		/*-------------------------------------------------------------------Setters------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------Getters------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------Eventhandlers------------------------------------------------------------------*/
		private function onLoadImage(e:ImageExtractorEvent):void 
		{
			addImage();
		}
	}

}