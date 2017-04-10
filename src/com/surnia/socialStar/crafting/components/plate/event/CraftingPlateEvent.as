package com.surnia.socialStar.crafting.components.plate.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Windz
	 */
	public class CraftingPlateEvent extends Event
	{
		private var _obj:Object;
		public static const MAKE_BUTTON_PRESS:String = 'crafting plate make button pressed';
		public static const TOTAL_BUTTON_PRESS:String = 'crafting plate total button pressed';
		public static const INCREASE_DATA_QUANTITY:String = 'increase crafting plate data';
		public static const DECREASE_DATA_QUANTITY:String = 'decrease crafting plate data';
		public static const UPDATE_VIEW:String = 'crafting plate view';
		
		
		public function CraftingPlateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = new Object();
			super (type, bubbles, cancelable) ;
		}
		
		public override function clone():Event 
		{ 
			return new CraftingPlateEvent(type, bubbles, cancelable);
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