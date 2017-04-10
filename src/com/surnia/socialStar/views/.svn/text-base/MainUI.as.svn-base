package com.surnia.socialStar.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.friendUI.view.FriendUI;
	import com.surnia.socialStar.ui.mainMenuUI.view.MainMenuUI;
	import com.surnia.socialStar.ui.settingUI.SettingUI;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MainUI extends Sprite
	{
		/*------------------------------------------------------------------------Constant-----------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _friendUI:FriendUI;
		private var _mainMenuUI:MainMenuUI;	
		private var _settingUI:SettingUI;	
		
		private var _es:EventSatellite;
		/*------------------------------------------------------------------------Construc-----------------------------------------------------------------*/
		
		
		public function MainUI() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			addFriendUI();
			addMainMenuUI();
			addSettingUI();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeSettingUI();
			removeMainMenuUI();
			removeFriendUI();
		}
		
		/*------------------------------------------------------------------------Methods-----------------------------------------------------------------*/
		
		private function addFriendUI():void 
		{
			_friendUI = new FriendUI();
			addChild( _friendUI );			
		}
		
		private function removeFriendUI():void 
		{
			if ( _friendUI != null ) {
				if ( this.contains( _friendUI ) ) {
					this.removeChild( _friendUI );
					_friendUI = null;
				}
			}
		}
		
		private function addMainMenuUI():void 
		{
			_mainMenuUI = new MainMenuUI();
			addChild( _mainMenuUI );
			_mainMenuUI.x = 600;
			_mainMenuUI.y = 35;			
		}
		
		
		private function removeMainMenuUI():void 
		{
			if ( _mainMenuUI != null ) {
				if ( this.contains( _mainMenuUI ) ) {
					this.removeChild( _mainMenuUI );
					_mainMenuUI = null;
				}
			}
		}
		
		private function addSettingUI():void 
		{
			_settingUI = new SettingUI();
			addChild( _settingUI );
			_settingUI.x = 725;
			_settingUI.y = -10;			
		}
		
		private function removeSettingUI():void 
		{
			if ( _settingUI != null ) {
				if ( this.contains( _settingUI ) ) {
					this.removeChild( _settingUI );
					_settingUI = null;
				}
			}			
		}
		
		/*------------------------------------------------------------------------Setters-----------------------------------------------------------------*/
		/*------------------------------------------------------------------------Getters-----------------------------------------------------------------*/
		/*------------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
	}

}