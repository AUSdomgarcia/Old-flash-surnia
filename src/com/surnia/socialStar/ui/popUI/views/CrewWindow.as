package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.views.crew.CrewView;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class CrewWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:CrewView;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function CrewWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();	
			
			_mc = new CrewView();
			addChild( _mc );
			_mc.init();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			
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