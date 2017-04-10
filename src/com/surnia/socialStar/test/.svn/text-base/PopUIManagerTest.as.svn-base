package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.InviteFriendsPopUpWindow;
	import com.surnia.socialStar.ui.popUI.views.MiniMapPopUpWindow;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class PopUIManagerTest extends Sprite
	{
		/*------------------------------------------------------------------------------constant------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties----------------------------------------------------------*/
		private var _popUIManager:PopUpUIManager;
		/*------------------------------------------------------------------------------constructor---------------------------------------------------------*/
		
		
		public function PopUIManagerTest() 
		{
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
		
		/*------------------------------------------------------------------------------Methods------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_popUIManager = PopUpUIManager.getInstance();
			addChild( _popUIManager );
			
			
			var miniMapPopUp:MiniMapPopUpWindow = new MiniMapPopUpWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW, 300, 300 );
			var inviteFriendsPopUp:InviteFriendsPopUpWindow = new InviteFriendsPopUpWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW, 300, 300 );
			_popUIManager.addWindow( miniMapPopUp );
			_popUIManager.addWindow( inviteFriendsPopUp );
			//_popUIManager.searchWindow(  WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			_popUIManager.loadWindow(WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
		}
		
		private function removeDisplay():void 
		{
			
		}
		/*------------------------------------------------------------------------------Setters------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Getters------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		
	}

}