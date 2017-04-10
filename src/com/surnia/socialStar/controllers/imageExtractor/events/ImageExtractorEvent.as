package com.surnia.socialStar.controllers.imageExtractor.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class ImageExtractorEvent extends Event 
	{
		
		/*--------------------------------------------------------------------Constant------------------------------------------------------------------------*/
		public static const OFFICE_ITEM_IMAGE_LOAD_COMPLETE:String = "OFFICE_ITEM_IMAGE_LOAD_COMPLETE";
		
		/*--------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		
		
		/*--------------------------------------------------------------------Constructor---------------------------------------------------------------------*/
		
		public function ImageExtractorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------Methods-------------------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new ImageExtractorEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ImageExtractorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*--------------------------------------------------------------------Setters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Getters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Eventhandlers-------------------------------------------------------------------------*/
		
	}
	
}