package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author DF
	 */
	public class buttonComponent extends MovieClip
	{
		
		private var _button:MovieClip;
		private var isOver:Boolean = false;
		
		private var _parent:Sprite;
		public function buttonComponent(button:MovieClip, parent:Sprite) 
		{
			_parent = parent;			
			_button = button;				
			_button.buttonMode = true;
			_button.gotoAndStop(1);
			this.addChild(_button);
			
			addListeners();
		}	
		
		private function onCloseClick():void {
			_parent.dispatchEvent(new MapEvent(MapEvent.GAME_CLOSE));			
		}	
		
		public function addListeners():void {
		
			_button.addEventListener(MouseEvent.ROLL_OVER, onButtonOver);
			_button.addEventListener(MouseEvent.ROLL_OUT, onButtonOut);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
			_button.addEventListener(MouseEvent.MOUSE_UP, onButtonUp);
		}
		
		public function removeListeners():void {
			
			_button.removeEventListener(MouseEvent.ROLL_OVER, onButtonOver);
			_button.removeEventListener(MouseEvent.ROLL_OUT, onButtonOut);
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
			_button.removeEventListener(MouseEvent.MOUSE_UP, onButtonUp);
		}
		
		private function onButtonOver(e:MouseEvent):void {
			if (isOver == false) {
				isOver = true;
				_button.gotoAndStop(2);
			}
		}
		private function onButtonOut(e:MouseEvent):void {
			isOver = false;
			_button.gotoAndStop(1);
		}
		private function onButtonDown(e:MouseEvent):void {			
			isOver = false;
			_button.gotoAndStop(1);			
		}
		private function onButtonUp(e:MouseEvent):void {			
			onCloseClick();
		}
		
	}

}