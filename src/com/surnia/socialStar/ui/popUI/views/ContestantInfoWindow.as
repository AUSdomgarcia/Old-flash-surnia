package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.contestantinformation.ContestantInformationView;
	import com.surnia.socialStar.ui.popUI.components.*;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ContestantInfoWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:ContestantInformationView;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function ContestantInfoWindow( windowName:String, windowSkin:MovieClip ) 
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
			_mc = new ContestantInformationView();
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