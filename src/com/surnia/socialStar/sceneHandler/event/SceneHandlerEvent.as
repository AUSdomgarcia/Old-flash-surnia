package com.surnia.socialStar.sceneHandler.event 
{
	import flash.events.Event;
	
	public class SceneHandlerEvent extends Event
	{
		private  var _obj:Object;
		public static const DATA_LOADED:String = 'Scene Handler Data loaded';
		public static const CURRENT_SCENE_CHANGE:String = 'Current Scene number change';
		public static const CURRENT_SEQUENCE_CHANGE:String = 'Current Sequence number change';
		public static const BUTTON_CHANGE:String = 'Current Button Change';
		
		/*----------------
		 * CONSTRUCTOR
		 * --------------*/
		public function SceneHandlerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = new Object();
			super (type, bubbles, cancelable) ;
		}
		
		/*----------------
		 * METHODS
		 * --------------*/
		public override function clone():Event 
		{ 
			return new SceneHandlerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SceneHandlerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}