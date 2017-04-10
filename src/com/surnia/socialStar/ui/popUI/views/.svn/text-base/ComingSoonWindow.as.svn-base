package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import flash.display.*;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ComingSoonWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:ComingSoonMC;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function ComingSoonWindow( windowName:String, windowSkin:MovieClip ) 
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
			_mc = new ComingSoonMC();
			addChild( _mc );
			_mc.buttonMode = true;
			_mc.okBtn.addEventListener( MouseEvent.CLICK, onCloseWindow );
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
		private function onCloseWindow(e:MouseEvent):void 
		{
			var popUpUIManager:PopUpUIManager = PopUpUIManager.getInstance();
			popUpUIManager.removeWindow( WindowPopUpConfig.COMING_SOON_WINDOW );
		}
	}

}