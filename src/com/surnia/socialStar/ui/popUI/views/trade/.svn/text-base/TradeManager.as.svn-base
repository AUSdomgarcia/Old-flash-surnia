package com.surnia.socialStar.ui.popUI.views.trade
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.views.trade.events.TradeEvent;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;

	public class TradeManager extends EventDispatcher
	{
		
		public var _tradeUI:TradeUI;
		private var _tradeConfirmUI:TradeConfirmUI;
		public var _stage:Stage;
		
		public function TradeManager(stage:Stage)
		{
			_stage = stage;
		}
		
		public function startTradeManager():void{
			_tradeUI = new TradeUI();
			_stage.addChild(_tradeUI);
			_tradeUI.show();
			
			_tradeConfirmUI = new TradeConfirmUI();
			_stage.addChild(_tradeConfirmUI);
			
			addListeners();
		}
		
		public function addListeners():void{
			_tradeUI.addEventListener(TradeEvent.TRADE_CLICK, handleEvents);
			_tradeUI.addEventListener(TradeEvent.NO_CLICK, handleEvents);
			_tradeUI.addEventListener(TradeEvent.YES_CLICK, handleEvents);
			
		}
		
		public function handleEvents(ev:TradeEvent):void{
			switch(ev.type)
			{
				case TradeEvent.TRADE_CLICK:
				{
					_tradeUI.hide();
					_tradeConfirmUI.show();
					break;
				}
				case TradeEvent.YES_CLICK:
				{
					EventSatellite.getInstance().dispatchESEvent(new TradeEvent(TradeEvent.YES_CLICK));	
					break;
				}
				case TradeEvent.NO_CLICK:
				{
					_tradeConfirmUI.hide();	
					_tradeUI.show();
					break;
				}
				case TradeEvent.TRADECON_CLOSE_CLICK:
				{
					_tradeConfirmUI.hide();	
					break;
				}
				case TradeEvent.TRADE_CLOSE_CLICK:
				{
					_tradeUI.hide();	
					break;
				}
			}
		}
	}
}