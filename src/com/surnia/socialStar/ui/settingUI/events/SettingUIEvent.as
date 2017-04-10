package com.surnia.socialStar.ui.settingUI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SettingUIEvent extends Event 
	{		
		/*--------------------------------------------------------------------------------------Constant-------------------------------------------------------*/
		public static const SOUND_ENABLE:String = "SOUND_ENABLE";
		public static const SOUND_DISABLE:String = "SOUND_DISABLE";
		
		public static const MUSIC_ENABLE:String = "MUSIC_ENABLE";
		public static const MUSIC_DISABLE:String = "MUSIC_DISABLE";
		
		
		public static const ZOOM_OUT_CLICK:String = "ZOOM_OUT_CLICK";
		public static const ZOOM_IN_CLICK:String = "ZOOM_IN_CLICK";
		
		public static const FULL_SCREEN_CLICK :String = "FULL_SCREEN_CLICK";
		/*--------------------------------------------------------------------------------------Properties----------------------------------------------------*/
		private  var _obj:Object = new Object();
		/*--------------------------------------------------------------------------------------Constant-------------------------------------------------------*/
		
		public function SettingUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		/*--------------------------------------------------------------------------------------Methods-------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new SettingUIEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SettingUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*--------------------------------------------------------------------------------------Setters-------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*--------------------------------------------------------------------------------------Getters-------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*--------------------------------------------------------------------------------------EventHandlers-------------------------------------------------*/
	}
	
}