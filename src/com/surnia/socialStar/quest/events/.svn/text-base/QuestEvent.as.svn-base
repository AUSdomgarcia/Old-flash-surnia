package com.surnia.socialStar.quest.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 *
	 */
	public class QuestEvent extends Event 
	{
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		public static const QUEST_ONE:String = "QUEST_ONE";
		public static const QUEST_TWO:String = "QUEST_TWO";		
		public static const QUEST_THREE:String = "QUEST_THREE";		
		public static const QUEST_LOAD_COMPLETE:String = "QUEST_LOAD_COMPLETE";
		
		public static const SHOW_QUEST_POP_UP_WINDOW:String = "SHOW_QUEST_POP_UP_WINDOW";
		//public static const UPDATE_QUEST_WINDOW_INFO:String = "UPDATE_QUEST_WINDOW_INFO";
		public static const UPDATE_QUEST_DISPLAY:String = "UPDATE_QUEST_DISPLAY";
		
		public static const UPDATE_QUEST_DISPLAY_WITH_ANIMATION:String = "UPDATE_QUEST_DISPLAY_WITH_ANIMATION";
		public static const UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION:String = "UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION";
		/*----------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private  var _obj:Object =  new Object();		
		/*----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function QuestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new QuestEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("QuestEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}		
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}	
		
		/*----------------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		
	}
	
}