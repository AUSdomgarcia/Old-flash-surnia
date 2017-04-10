package com.surnia.socialStar.ui.cursor 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class Cursor extends Sprite
	{
		
		/*----------------------------------------------------------Constant-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties-----------------------------------------------------------------------*/
		private var _mc:CursorMC;
		/*----------------------------------------------------------Constructor-----------------------------------------------------------------------*/
		
		public function Cursor() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*----------------------------------------------------------Methods-------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new CursorMC();
			addChild( _mc );
			_mc.x = stage.mouseX;
			_mc.y = stage.mouseY;			
			mouseChildren = false;
			mouseEnabled = false;
			//stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			addEventListener( Event.ENTER_FRAME, onCursorMove );
		}					
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				//_mc.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				removeEventListener( Event.ENTER_FRAME, onCursorMove );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		
		/**
		 * 
		 * @param	type - move, rotate, sell
		 */
		
		public function showCursor( type:String ):void 
		{
			_mc.gotoAndStop( type );
		}
		/*----------------------------------------------------------Setters-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------EventHandlers-------------------------------------------------------------------*/	
		//private function onMouseMove(e:MouseEvent):void 
		//{
			//if ( stage != null ) {			
				//_mc.x = stage.mouseX;
				//_mc.y = stage.mouseY;
			//}
		//}
		
		private function onCursorMove(e:Event):void 
		{
			if ( stage != null ) {			
				_mc.x = stage.mouseX;
				_mc.y = stage.mouseY;
			}
		}
	}

}