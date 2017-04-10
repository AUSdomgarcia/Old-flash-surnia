package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.tutorial.arrowManager.ArrowController;
	import com.surnia.socialStar.tutorial.views.Tutorial;
	import com.surnia.socialStar.ui.popUI.components.*;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TutWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:Tutorial;
		private var _arrowGuideController:ArrowController;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function TutWindow( windowName:String, windowSkin:MovieClip  ) 
		{
			super( windowName, windowSkin  );
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
			_mc = new Tutorial();
			addChild( _mc );	
			
			//addArrowController()
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
			
			//removeArrowController();
		}
		
		private function addArrowController():void 
		{
			_arrowGuideController = new ArrowController();
			addChild( _arrowGuideController );			
		}
		
		private function removeArrowController():void 
		{
			if ( _arrowGuideController != null ) {
				if ( this.contains( _arrowGuideController ) ) {
					this.removeChild( _arrowGuideController );
					_arrowGuideController = null;
				}
			}
		}
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}