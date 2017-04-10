package com.surnia.socialStar.ui.popUI.itemShopUI.events 
{	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class InventoryEvent extends Event 
	{
		/*-------------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		public static const SET_OFFICE_INVENTORY_ITEM:String = "SET_OFFICE_INVENTORY_ITEM";
		/*-------------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*-------------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		
		
		public function InventoryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-------------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new InventoryEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InventoryEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*-------------------------------------------------------------------------------Setters----------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-------------------------------------------------------------------------------Getters----------------------------------------------------------------*/		
		
		public function get obj():Object 
		{
			return _obj;
		}
		
		/*-------------------------------------------------------------------------------EventHandlers----------------------------------------------------------*/
	}
	
}