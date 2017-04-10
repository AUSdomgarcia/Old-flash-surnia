package com.surnia.socialStar.crafting.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Windz
	 */
	public class CraftingEvent extends Event
	{
		private  var _obj:Object;
		public static const UPDATE_CONTAINER_POSITION:String = 'Crafting UI Container Position update';
		public static const CRAFT_UI_ON_CLOSE:String = 'Crafting UI Close';
		public static const UPDATE_TABS:String = 'Crafting UI Tabs update';
		public static const UPDATE_SCROLLER:String = 'Crafting UI Scroller update';
		public static const UPDATE_DATA:String = 'Crafting Materials data update';
		public static const REMOVE_ALL:String = 'Crafting UI remove';
		public static const RESET_ALL:String = 'Crafting UI Reset All';
		public static const UPDATE_MATERIAL_DATA:String = 'Crafting Material Data update';
		public static const UPDATE_MATERIAL_VIEW:String = 'Crafting Material Data View';
		
		
		public function CraftingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = new Object();
			super (type, bubbles, cancelable) ;
		}
		
		public override function clone():Event 
		{ 
			return new CraftingEvent(type, bubbles, cancelable);
		} 
		
		/*----------------
		 * METHODS
		 * --------------*/
		public override function toString():String 
		{ 
			return formatToString("CraftingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*----------------
		 * SETTER
		 * --------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*----------------
		 * GETTER
		 * --------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}