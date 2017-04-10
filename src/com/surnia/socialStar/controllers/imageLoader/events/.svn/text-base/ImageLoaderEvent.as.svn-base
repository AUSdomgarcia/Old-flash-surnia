package com.surnia.socialStar.controllers.imageLoader.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ImageLoaderEvent extends Event 
	{
		/*--------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		public static const IMAGE_LOADED:String = "IMAGE_LOADED";
		/*--------------------------------------------------------------------Properties------------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*--------------------------------------------------------------------Constructor--------------------------------------------------------------------*/		
		public function ImageLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new ImageLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ImageLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*--------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*--------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*--------------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
	}
	
}