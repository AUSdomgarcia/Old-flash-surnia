package com.surnia.socialStar.ui.popUI.views.trade.events
{
	import flash.events.Event;

	public class TradeEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const TRADE_CLICK:String = "onShowTradeConfirmUI";
		public static const YES_CLICK:String = "onYesButtonClicked";
		public static const NO_CLICK:String = "onNoButtonClicked";
		public static const TRADECON_CLOSE_CLICK:String = "onTradeConCloseButtonClicked";
		public static const TRADE_CLOSE_CLICK:String = "onTradeCloseButtonClicked";
		
		public function TradeEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}