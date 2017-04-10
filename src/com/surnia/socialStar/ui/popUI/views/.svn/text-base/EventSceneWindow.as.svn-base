package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.views.eventScene.EventScenePopup;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class EventSceneWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:EventScenePopup;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function EventSceneWindow( windowName:String, windowSkin:MovieClip = null ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();			
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}		
		
		
		private function setDisplay():void 
		{
			_mc = new EventScenePopup();
			addChild( _mc );
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
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}