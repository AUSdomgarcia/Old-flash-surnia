package com.surnia.socialStar.views.isoItems.miniProgressbar 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.views.isoItems.miniProgressbar.events.MiniProgressBarEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterapatties
	 */
	public class MiniProgressBar extends Sprite
	{
		
		/*---------------------------------------------------------------Constant------------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties----------------------------------------------------------------------------*/
		private var _mc:ProgressMC04;
		private var _xPos:Number;
		private var _yPos:Number;
		/*---------------------------------------------------------------Constructor---------------------------------------------------------------------------*/
		
		
		public function MiniProgressBar( xPos:Number, yPos:Number ) 
		{
			_xPos = xPos;
			_yPos = yPos;
			setDisplay();
			hide();
			reset();
		}		
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);			
			removeDisplay();
		}
		
		/*---------------------------------------------------------------Methods------------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new ProgressMC04();
			addChild( _mc );
			_mc.x = _xPos;
			_mc.y = _yPos;			
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		public function activate():void 
		{	
			show();
			TweenLite.to( _mc.progressBar, 1, { scaleX:1 , onComplete:progressDone } );
		}		
		
		public function hide():void 
		{
			_mc.visible = false;			
		}	
		
		public function show():void 
		{
			_mc.visible = true;
		}
		
		private function reset():void 
		{
			_mc.progressBar.scaleX = 0;
		}
		
		private function progressDone():void 
		{
			hide();
			reset();
			var miniProgressBarEvent:MiniProgressBarEvent = new MiniProgressBarEvent( MiniProgressBarEvent.ON_PROGRESS_DONE );
			dispatchEvent( miniProgressBarEvent );
		}
		/*---------------------------------------------------------------Setters------------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Getters------------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers------------------------------------------------------------------------*/
		
	}

}