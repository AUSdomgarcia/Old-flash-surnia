package com.surnia.socialStar.test 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;		
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;	
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.MainUI;	
	import flash.display.Sprite;
	
	
	/**
	 * this test is the sample implementation of MainUI view with the combination of popUPManager this popUp Manager controlls all pop up windows in the game so
	 * it needs to add last into the Top display of the game.
	 * @author monsterpatties
	 */
	public class MainUITest extends Sprite
	{
		/*--------------------------------------------------------------------------constant---------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _mainUI:MainUI;		
		private var _popUpUiManager:PopUpUIManager;
		private var _es:EventSatellite;		
		/*--------------------------------------------------------------------------Constructor---------------------------------------------------------------*/		
		
		public function MainUITest() 
		{
			initSampleMain();
		}
		
		/*--------------------------------------------------------------------------Methods---------------------------------------------------------------*/
		
		private function initSampleMain():void 
		{
			prepareControllers();			
			addMainMenuUI();			
			addPopUpManager();			
		}
		
		
		// this mainUI is the actual mainUI of the game it is composed of friendUI, MainMenuUI, Saettings UI		
		private function addMainMenuUI():void 
		{
			_mainUI = new MainUI();
			addChild( _mainUI );
			_mainUI.y = 429;
		}		
		
		//eventsatelite this controllers is the one who listen to the event that dispatched by different UI and transmit the event using eventSatelite
		private function prepareControllers():void 
		{				
			_es = EventSatellite.getInstance();			
			_es.addEventListener( FriendUIEvent.CLICK_ADD_FRIENDS, onClickAddFriends );			
			_es.addEventListener( FriendUIEvent.CLICK_SHOP_NAME, onClickShopName );
			_es.addEventListener( MainMenuUIEvent.SHOW_COLLECTION, onShowCollectionWindow );
			_es.addEventListener( MainMenuUIEvent.SHOW_SETUP, onShowSetUpWindow );
			_es.addEventListener( MainMenuUIEvent.SHOW_INVENTORY, onShowInventoryWindow );
			_es.addEventListener( MainMenuUIEvent.CANCEL_TOOL, onCancelTool );
			_es.addEventListener( MainMenuUIEvent.SHOW_STORY_MODE, onShowStoryModeWindow );
			_es.addEventListener( MiniGameEvent.SELECT_BUILDING, onSelectBuilding );
		}													
		
		
		// popup manager is the one who hold all window popup in the game
		//note: it needs to be add last to the main of the game to ensure that the window popup will appear always on top.
		private function addPopUpManager():void 
		{
			_popUpUiManager = PopUpUIManager.getInstance();
			addChild( _popUpUiManager );			
			
			//CALL ACTTION POP UP WINDOW WHEN RUN OUT OF ACTION POINTS
			//_popUpUiManager.loadWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW );			
			
			//CALL COIN POP UP WINDOW WHEN RUN OUT OF COINS
			//_popUpUiManager.loadWindow( WindowPopUpConfig.COIN_POPUP_WINDOW );

			//call miniMap
			//_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.ITEM_SHOP_POPUP_WINDOW, 0, 90 );
			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW, 0, 90 );
		}		
		
		/*--------------------------------------------------------------------------Setters---------------------------------------------------------------*/		
		
		/*--------------------------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		/*--------------------------------------------------------------------------EventHandlers---------------------------------------------------------------*/		
		
		
		//the event that will be called for every dispatched		
		
		
		private function onClickAddFriends(e:FriendUIEvent):void 
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
		}
		
		
		private function onClickShopName(e:FriendUIEvent):void 
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.CHANGE_OFFICE_NAME_POP_UP , 0, - 50, true, 0,0 );
		}		
		
		
		private function onShowStoryModeWindow(e:MainMenuUIEvent):void 
		{
			trace( "show World map window here........." );
			_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			//_popUpUiManager.loadWindow( WindowPopUpConfig.STAFF_WINDOW );			
		}
		
		private function onCancelTool(e:MainMenuUIEvent):void 
		{
			trace( "on cancel tool here remove tool icon........." );
		}
		
		private function onShowInventoryWindow(e:MainMenuUIEvent):void 
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW, 0, 40 );
			trace( "show Inventory window here........." );
		}
		
		private function onShowSetUpWindow(e:MainMenuUIEvent):void 
		{
			trace( "show setup or shop window here........." );
			_popUpUiManager.loadWindow( WindowPopUpConfig.ITEM_SHOP_POPUP_WINDOW, 0, 40 );
		}
		
		private function onShowCollectionWindow(e:MainMenuUIEvent):void 
		{
			trace( "show collection window........." );
			//_popUpUiManager.loadWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW, 0, 0, false, 12 ,83 );			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );
			
			//if ( GlobalData.instance.miniGameData != null  ) {
				//_popUpUiManager.loadSubWindow( WindowPopUpConfig.RUNNING_MAN_POP_UP  );
			//}
			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.STAFF_WINDOW );
			//_popUpUiManager.loadWindow( WindowPopUpConfig.CREW_WINDOW );
			_popUpUiManager.loadWindow( WindowPopUpConfig.CHARSHOP_WINDOW );
		}
		
		private function onSelectBuilding(e:MiniGameEvent):void 
		{
			trace( "select building!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" );
			trace( "data ko", e.obj.reference, e.obj.myPlayer,e.obj.myRival,e.obj.weakInterval,e.obj.numberOfRounds,e.obj.raceDuration ,e.obj.obstacleIntervals, e.obj.startDelay );
			//GlobalData.instance.miniGameData = e.obj;
			//if ( GlobalData.instance.miniGameData != null  ) {
				//_popUpUiManager.loadSubWindow( WindowPopUpConfig.RUNNING_MAN_POP_UP  );
			//}
		}
	}

}