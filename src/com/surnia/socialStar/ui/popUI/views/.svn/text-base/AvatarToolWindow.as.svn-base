package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUI;
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.crew.event.CrewEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class AvatarToolWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/					
		private var  _popUpUIManager:PopUpUIManager;
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;		
		private var _avatarUI:AvatarTooltipUI;
		private var _gd:GlobalData;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function AvatarToolWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			_gd = GlobalData.instance;
			_sdc = ServerDataController.getInstance();
			_es = EventSatellite.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();
		}
		
		private function setDisplay():void 
		{		
			_avatarUI = new AvatarTooltipUI(_gd.currentCharId);
			addChild( _avatarUI );
		}
		
		private function removeDisplay():void 
		{
			if ( _avatarUI != null ) {
				if ( this.contains( _avatarUI ) ) {
					this.removeChild( _avatarUI );
					_avatarUI = null;
				}
			}
		}
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/				
		
	}

}