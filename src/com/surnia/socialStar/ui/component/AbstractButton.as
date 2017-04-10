package com.surnia.socialStar.ui.component 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class AbstractButton extends Sprite
	{
		
		/*-----------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Properties---------------------------------------------------------------------------*/
		private var _mc:MovieClip;
		private var _xPos:Number;
		private var _yPos:Number;
		
		private var _event:*;
		/*-----------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		/**
		 * 
		 * @param	mc
		 * @param	xPos
		 * @param	yPos
		 */
		
		public function AbstractButton( event:*, mc:MovieClip, xPos:Number = 0, yPos:Number = 0  ) 
		{
			_event = event;
			_mc = mc;
			_xPos = xPos;
			_yPos = yPos;
			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-----------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			addChild( _mc );
			_mc.x = _xPos;
			_mc.y = _yPos;
			
			_mc.buttonMode = true;
			_mc.addEventListener( MouseEvent.CLICK, onClickBtn );
			_mc.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
			_mc.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );
			_mc.addEventListener( MouseEvent.MOUSE_OVER, onMouseOverBtn );
			_mc.addEventListener( MouseEvent.MOUSE_UP, onMouseUpBtn );
			_mc.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownBtn );
		}				
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_mc.removeEventListener( MouseEvent.CLICK, onClickBtn );
				_mc.removeEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				_mc.removeEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );
				_mc.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOverBtn );
				_mc.removeEventListener( MouseEvent.MOUSE_UP, onMouseUpBtn );
				_mc.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDownBtn );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		private function dispatchBtnEvent():void 
		{
			dispatchEvent( _event );
		}
		
		/*-----------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/
		public function onRollOutBtn(e:MouseEvent):void 
		{
			
		}
		
		public function onRollOverBtn(e:MouseEvent):void 
		{
			
		}
		
		public function onClickBtn(e:MouseEvent):void 
		{
			dispatchBtnEvent();
		}
		
		public function onMouseDownBtn(e:MouseEvent):void 
		{
			
		}
		
		public function onMouseUpBtn(e:MouseEvent):void 
		{
			
		}
		
		private function onMouseOverBtn(e:MouseEvent):void 
		{
			
		}
	}

}