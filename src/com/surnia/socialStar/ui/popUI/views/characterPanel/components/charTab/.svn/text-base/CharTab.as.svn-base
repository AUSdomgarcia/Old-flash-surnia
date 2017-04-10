package com.surnia.socialStar.ui.popUI.views.characterPanel.components.charTab 
{
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.CharHead;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class CharTab extends MovieClip
	{
		private var _charLayer:Sprite;
		
		private var _callBack:Function;
		private var _background:MovieClip;
		private var _mask:MovieClip;
		
		private var _X:int;
		private var _Y:int;
		
		private var _itemDisplay:CharHead;
		private var _button:MovieClip;
		public function CharTab(background:MovieClip, maskBG:MovieClip, X:int, Y:int, button:SwitchComponent)
		{	
			_background = background;	
			_mask = maskBG;
			
			_background.mask = _mask;
			
			_button = button;
			
			_X = X;
			_Y = Y;		
			initialization();
			display();	
			
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		public function onRemove(e:Event):void {
			trace("CLEAN :", this, " CLEAN :", _itemDisplay);
			if (_itemDisplay != null) {
				if (_charLayer.contains(_itemDisplay)) {	
					_itemDisplay.remove();
					_charLayer.removeChild(_itemDisplay);
					_itemDisplay = null;
				}
			}
			
			if (_charLayer != null) {
				if (_background.contains(_charLayer)) {
				
					_background.removeChild(_charLayer);
					_charLayer = null;
				}
			}
			
			if (_button != null) {
				if (_background.contains(_button)) {
				
					removeChild(_button);
					_button = null;
				}
			}
			
			if (_background != null) {
				if (this.contains(_background)) {
				
					removeChild(_background);
					_background = null;
				}
			}
			
		}
		
		private function initialization():void {
			_charLayer = new Sprite;
		}
		
		private function display():void {			
			addChild(_background);		
			addChild(_mask);
			_background.addChild(_charLayer);
			addChild(_button);
			
			this.x = _X;
			this.y = _Y;		
			
			_button.x = (_background.width / 2) - (_button.width / 2);
			_button.y = _background.height - (_button.height /2)
		}		
		
		public function displayItem(itemDisplay:CharHead):void {
			_itemDisplay = itemDisplay;
			
			_itemDisplay.x = (_background.width / 2);
			_itemDisplay.y = (_background.height / 2) - 5;
			
			_charLayer.addChild(_itemDisplay);
		}
		
		public function removeItem():void {
			if (_itemDisplay != null) {
				if (_charLayer.contains(_itemDisplay)) {
					_charLayer.removeChild(_itemDisplay);
				}
			}
		}
		
	}

}