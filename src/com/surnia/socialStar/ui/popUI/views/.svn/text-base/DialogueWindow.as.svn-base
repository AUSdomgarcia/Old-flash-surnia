package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.views.dialogue.DialogueView;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class DialogueWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:DialogueView;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function DialogueWindow( windowName:String, windowSkin:MovieClip ) 
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
			_mc = new DialogueView();			
			addChild( _mc );
			_mc.init();
		}
		
		private function removeDisplay():void 
		{
			if (  _mc != null ) {
				_mc.removeListeners();
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