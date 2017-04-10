package com.surnia.socialStar.ui.popUI.views.characterPanel.components.button 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	//import com.surnia.socialStar.minigames.MovieGame.MovieGameController;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author DF
	 */
	public class SwitchComponent extends MovieClip
	{
				
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		private var isOver:Boolean = false;			
		private var _buttonMC:MovieClip;
		private var _buttonOverMC:MovieClip;	
		private var _buttonDownMC:MovieClip;
		
		private var _thirdFrame:Boolean;
		private var _callBackID:int;
		private var _X:int;
		private var _Y:int;
		
		public var _callBack:Function;
		
				
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR	
		 * ----------------------------------------------------------------------------------------------------------*/
		public function SwitchComponent(callBack:Function, buttonMC:MovieClip, callBackID:int = 0, X:int = 0, Y:int = 0 ) 
		{
			_buttonMC = buttonMC;			
			_callBack = callBack;
			_callBackID = callBackID;
			_X = X;
			_Y = Y;
			
			if (_buttonMC.totalFrames == 3) {
				_thirdFrame = true;
			}
			else {
				_thirdFrame = false;
			}			
			initialization();
			display();
			addListener();
		}
		
				
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			_buttonMC.gotoAndStop(1);
		}
		
		private function display():void {
			
			if (_buttonMC != null) {
				if (this.contains(_buttonMC)) {
					removeChild(_buttonMC);
				}
			}
			
			addChild(_buttonMC);
			
			this.x = _X;
			this.y = _Y;
		}		
		
		public function addListener():void {		
			_buttonMC.addEventListener(MouseEvent.ROLL_OVER, onSelectOver);
			_buttonMC.addEventListener(MouseEvent.ROLL_OUT, onSelectOut);
			_buttonMC.addEventListener(MouseEvent.MOUSE_DOWN, onSelectDown);
			_buttonMC.addEventListener(MouseEvent.MOUSE_UP, onSelectUp);
			_buttonMC.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);			
		}
		public function removeListener():void {
			_buttonMC.removeEventListener(MouseEvent.ROLL_OVER, onSelectOver);
			_buttonMC.removeEventListener(MouseEvent.ROLL_OUT, onSelectOut);
			_buttonMC.removeEventListener(MouseEvent.MOUSE_DOWN, onSelectDown);
			_buttonMC.removeEventListener(MouseEvent.MOUSE_UP, onSelectUp);
			_buttonMC.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
				
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HADLER METHODS
		 * ----------------------------------------------------------------------------------------------------------*/		
		private function onRemove(e:Event):void {			
			if (_buttonMC != null) {
				if (this.contains(_buttonMC)) {					
					removeListener();
					removeChild(_buttonMC);
					_buttonMC = null;
				}
			}		
		}
		private function onSelectOver(e:MouseEvent):void {			
			if (isOver == false) {
				isOver = true;
				e.target.gotoAndStop(2);
			}
		}
		private function onSelectOut(e:MouseEvent):void {		
			isOver = false;
			e.target.gotoAndStop(1);		
		}
		private function onSelectDown(e:MouseEvent):void {		
			isOver = false;		
			if (_thirdFrame == true) {
				e.target.gotoAndStop(3);
			}
			else{
				e.target.gotoAndStop(1);
			}					
		}			
		private function onSelectUp(e:MouseEvent):void {			
			_callBack(_callBackID);
		}			
	}

}