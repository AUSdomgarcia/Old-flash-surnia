package com.surnia.socialStar.test
{
	import com.surnia.socialStar.ui.popUI.views.trade.TradeManager;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF (height = "630", width="768")]
	
	public class TradeTest extends Sprite
	{
		private var _tradeManager:TradeManager;
		public function TradeTest()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(ev:Event = null):void{
			_tradeManager = new TradeManager(this.stage);
			_tradeManager.startTradeManager();
		}
	}
}