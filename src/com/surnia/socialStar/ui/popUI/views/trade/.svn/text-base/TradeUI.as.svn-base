package com.surnia.socialStar.ui.popUI.views.trade
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.trade.events.TradeEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TradeUI extends Sprite
	{
		private var _characterTradeUI:CharacterTradeUI;
		private var _charPanelArray:Array = [];
		
		public function TradeUI()
		{
			
		}
		
		/**
		 *	
		 * This is the first thing that is called 
		 * after instantiating the UI. Shows the 
		 * tradeUI.
		 * 
		 */	
		
		public function show():void{
			this.alpha = 0;
			TweenLite.to(this, .5, {alpha:1, onComplete:init()});
		}
		
		/**
		 *	
		 * Initializes and adds events for the TradeUI
		 * 
		 */	
		
		private function init():void{
			initAssets();
			addListeners();
		}
		
		/**
		 *	
		 * Initializes trade assets for display.
		 * 
		 */	
		
		public function initAssets():void{
			_characterTradeUI = new CharacterTradeUI();
			_characterTradeUI.x  = stage.stageWidth/2 - _characterTradeUI.width/2;
			_characterTradeUI.y  = stage.stageHeight/2 - 268;
			_characterTradeUI.textField.text = String(GlobalData.instance.pCoin);
			_characterTradeUI.textField.mouseEnabled = false;
			addChild(_characterTradeUI);
			initCharacterPanels();
		}
		
		public function initCharacterPanels():void{
			var xPos:Number = 40;
			var yPos:Number = 44;
			for (var x:int = 0; x<8; x++){
				var charPanel:CharacterPanel = new CharacterPanel()
				_characterTradeUI.addChild(charPanel);
				charPanel.x = xPos;
				charPanel.y = yPos;
				charPanel.clickableCharPanel.alpha = 0;
				charPanel.clickableCharPanel.enabled = false;
				charPanel.starRating.alpha = 0;
				charPanel.textField.text = "";
				charPanel.textField.mouseEnabled = false;
				_charPanelArray[x] = charPanel;
				if (((x+1) % 4) == 0){
					xPos = 40; 
					yPos = _charPanelArray[x].height + 42;
				} else {
					xPos += _charPanelArray[x].width + 5.8;
				}
			}
		}
		
		/**
		 *
		 * Adding of event listeners 
		 * 
		 */		
		
		private function addListeners():void{
			_characterTradeUI.tradeButton.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(ev:Event):void{
			dispatchEvent(new TradeEvent (TradeEvent.TRADE_CLICK));
		}
		
		/**
		 *
		 * Hides the display and removes any event listeners
		 * associated with this class. 
		 * 
		 */		
		
		public function hide():void{
			removeListener();
		}
		
		/**
		 * 
		 * Removes event listeners. 
		 * 
		 */		
		
		public function removeListener():void{
			
		}
	}
}