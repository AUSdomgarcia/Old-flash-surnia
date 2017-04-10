package com.surnia.socialStar.tutorial.components 
{
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ArrowGuide extends Sprite
	{
		/*-------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private var _mc:ArrowGuideMC;
		private var _dir:int;
		private var _xPos:int;
		private var _yPos:int;
		/*-------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		/**
		 * 
		 * @param	dir 1 - left , 2 - right , 3 - down 
		 * @param  xPos - x position, 
		 * @param  yPos - y position, 
		 */
		public function ArrowGuide( dir:int, xPos:int, yPos:int ) 
		{
			_dir = dir;
			_xPos = xPos;
			_yPos = yPos;
			
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
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new ArrowGuideMC();
			addChild( _mc );
			_mc.gotoAndStop( _dir );
			_mc.x = _xPos;
			_mc.y = _yPos;
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild(  _mc );
					_mc = null;
				}
			}
		}
		/*-------------------------------------------------------------Setters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/		
	}

}