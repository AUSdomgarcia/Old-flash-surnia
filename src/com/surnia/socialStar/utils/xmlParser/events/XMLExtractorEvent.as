package com.surnia.socialStar.utils.xmlParser.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class XMLExtractorEvent extends Event 
	{
		/*-----------------------------------------------------------------------Constant---------------------------------------------------------------*/
		public static const XML_EXTRACTION_COMPLETE:String = "XML_EXTRACTION_COMPLETE";
		public static const XML_EXTRACTION_FAILED:String = "XML_EXTRACTION_FAILED";
		/*-----------------------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _obj:Object;
		/*-----------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		public function XMLExtractorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-----------------------------------------------------------------------Methods--------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new XMLExtractorEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("XMLExtractorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*-----------------------------------------------------------------------Setters--------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-----------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-----------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		
	}
	
}