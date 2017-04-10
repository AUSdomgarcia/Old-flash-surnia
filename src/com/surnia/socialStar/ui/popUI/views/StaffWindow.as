package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.views.staff.StaffView;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class StaffWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _staffView:StaffView;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function StaffWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();			
			_staffView = new StaffView();
			addChild( _staffView );		
			_staffView.init();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			
			if ( _staffView != null ) {
				_staffView.removeListeners();
				if ( this.contains( _staffView ) ) {
					this.removeChild( _staffView );
					_staffView = null;
				}
			}
		}		
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}