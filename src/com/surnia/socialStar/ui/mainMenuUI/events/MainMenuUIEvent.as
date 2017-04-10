package com.surnia.socialStar.ui.mainMenuUI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MainMenuUIEvent extends Event 
	{
		/*-------------------------------------------------------------------------Constant-------------------------------------------------------------------*/		
		public static const SHOW_TRADE_POP_UP_WINDOW:String = "SHOW_TRADE_POP_UP_WINDOW";
		public static const SHOW_CHARACTER_POP_UP_WINDOW:String = "SHOW_CHARACTER_POP_UP_WINDOW";
		public static const SHOW_CLOSET_POP_UP_WINDOW:String = "SHOW_CLOSET_POP_UP_WINDOW";
		public static const SHOW_HIRE_POP_UP_WINDOW:String = "SHOW_HIRE_POP_UP_WINDOW";
		
		//public static const OFFICE_BTN_CLICK:String = "OFFICE_BTN_CLICK";		
		//public static const COLLECTION_BTN_CLICK:String = "COLLECTION_BTN_CLICK";
		//public static const INVENTORY_BTN_CLICK:String = "INVENTORY_BTN_CLICK";
		
		public static const SHOW_COLLECTION:String = "SHOW_COLLECTION";
		public static const SHOW_SETUP:String = "SHOW_SETUP";
		public static const SHOW_INVENTORY:String = "SHOW_INVENTORY";
		public static const SHOW_TOOLS:String = "SHOW_TOOLS";
		public static const SHOW_STORY_MODE:String = "SHOW_STORY_MODE";
		
		//public static const REMOVE_CHARACTER_PANEL:String = "REMOVE_CHARACTER_PANEL";
		
		//new
		public static const REMOVE_MAIN_MENU_TOOL_PANEL:String = "REMOVE_MAIN_MENU_TOOL_PANEL";
		public static const SELECT_MOVE_TOOL:String = "SELECT_MOVE_TOOL";
		public static const SELECT_ROTATE_TOOL:String = "SELECT_ROTATE_TOOL";
		public static const SELECT_SELL_TOOL:String = "SELECT_SELL_TOOL";
		public static const SELECT_RETURN_TOOL:String = "SELECT_RETURN_TOOL";
		public static const CANCEL_TOOL:String = "CANCEL_TOOL";
		/*-------------------------------------------------------------------------Properties-----------------------------------------------------------------*/			
		private  var _obj:Object = new Object();
		
		/*-------------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		public function MainMenuUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MainMenuUIEvent(type, bubbles, cancelable);
		} 
		
		/*-------------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		public override function toString():String 
		{ 
			return formatToString("MainMenuUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*-------------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-------------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-------------------------------------------------------------------------EventHandl----------------------------------------------------------------*/
		
	}
	
}