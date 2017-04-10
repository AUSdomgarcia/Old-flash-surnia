package com.surnia.socialStar.ui.popUI.itemShopUI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class ItemShopEvent extends Event 
	{
		
		/*------------------------------------------------------------------------------Constant-------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		
		public static const CHANGE_TAB:String = "onTabChange";
		public static const BUY_ITEM:String = "onBuyItem";
		
		public static const SHOW_SELL_POPUP:String = "SHOW_SELL_POPUP";
		public static const REMOVE_SELL_POPUP:String = "REMOVE_SELL_POPUP";
		
		
		public static const SELL_OFFICE_ITEM:String = "SELL_OFFICE_ITEM";
		public static const SET_OFFICE_ITEM:String = "SET_OFFICE_ITEM";
		
		
		private var _obj:Object = new Object();
		
		public function ItemShopEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*------------------------------------------------------------------------------Methods-------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new ItemShopEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ItemShopEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*------------------------------------------------------------------------------Setters-------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*------------------------------------------------------------------------------Getters-------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*------------------------------------------------------------------------------EventHandlers-------------------------------------------------------*/	
		
	}
	
}