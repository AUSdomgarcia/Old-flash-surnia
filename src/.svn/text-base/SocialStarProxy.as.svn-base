package 
{
	// flash libraries
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUI;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.playerStatus.PlayerStatusManager;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.miniMap.MinimapMain;
	import com.surnia.socialStar.ui.settingUI.events.SettingUIEvent;
	import com.surnia.socialStar.views.MainUI;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.proxy.IsoRoomEventProxy;
	import com.surnia.socialStar.views.proxy.IsoRoomProxy;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[Frame(factoryClass="SocialStarLoaderProxy")]
	[SWF (height = "630", width="760")]
	public class SocialStarProxy extends Sprite
	{
		private var _mainUI:MainUI;
		private var _popUpUiManager:PopUpUIManager;
		private var _es:EventSatellite;
		private var _playerStatusManager:PlayerStatusManager;
		private var _mainView:Sprite;
		
		private var _isoOffice:IsoRoomProxy;
		private var _coins:Coin;
		private var _star:Star;
		
		private var _charTooltip:AvatarTooltipUI;
		private var _tweening:Boolean = true;
		
		private var _globalData:GlobalData = GlobalData.instance;
		private var _popArray:Array = [new Array()];
		private var _charTimerArray:Array = [];
		
		private var _miniMap:MinimapMain;
		private var _firstRun:Boolean = true;
		
		private var _serverDataController:ServerDataController;
		
		private var _popUIManager:PopUpUIManager;
		
		public function SocialStarProxy()
		{
			_popUIManager = PopUpUIManager.getInstance();
			_serverDataController = ServerDataController.getInstance();
		}
		
		public function applicationStart(app:Sprite):void{
			_mainView = app;
			alpha = .0;
			TweenLite.to(this, .5, {delay:1, alpha:1, onComplete:init});
		}
		
		public function init(e:Event = null):void {	
			//trace('WIDTH : ' + friendOfficeStateArray[0][GlobalData.OFFICESTATE_DIMENSION].x);					
			initOfficeRoom();
			initTokenIcons();
			initPlayerUIManager();
			initSampleMain();			
			populateHomeOffice();
			addListeners();			
		}
		
		private function initPlayerUIManager():void{
			_playerStatusManager = new PlayerStatusManager(_mainView);
			_playerStatusManager.start();
		}
		
		private function addListeners():void{
			EventSatellite.getInstance().addEventListener(PlayerStatusEvent.AP_POPUP, onPopup);
			EventSatellite.getInstance().addEventListener(PlayerStatusEvent.CASH_POPUP, onPopup);
			EventSatellite.getInstance().addEventListener(PlayerStatusEvent.COIN_POPUP, onPopup);
			
			EventSatellite.getInstance().addEventListener(SSEvent.ACTIONPOINT_POPUP, onManagePopup);
			EventSatellite.getInstance().addEventListener(SSEvent.STARPOINT_POPUP, onManagePopup);
			EventSatellite.getInstance().addEventListener(SSEvent.COIN_POPUP, onManagePopup);
			
			_es.addEventListener(SettingUIEvent.ZOOM_IN_CLICK, _onSettingsZoomOutBtnPress);
			_es.addEventListener(SettingUIEvent.ZOOM_OUT_CLICK, _onSettingsZoomInBtnPress);
			
			_es.addEventListener(OfficeShopUIEvent.ON_OFFICE_CLOSE, _onOfficeShopUICloseBtnPress);
			_es.addEventListener(OfficeShopUIEvent.ON_OBJECT_BUY, _onOfficeShopObjBuyBtnPress);
			_es.addEventListener(OfficeShopUIEvent.ON_EXPANSION_BUY, _onOfficeShopUIExpBtnPress);
			_es.addEventListener(OfficeShopUIEvent.ON_TILE_BUY, _onOfficeShopUITileBtnPress);
			_es.addEventListener(OfficeShopUIEvent.ON_WALL_BUY, _onOfficeShopUIWallBtnPress);			
			
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDOFFICESTATEXML_LOADED, onChangeView);
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICESTATEXML_LOADED, onChangeView);
			addEventListener( Event.ENTER_FRAME, onLoop );
		}				
		
		private function onLoop(e:Event):void 
		{
			//trace( "onLoop", stage.mouseX, stage.mouseY );
		}
		
		public function onChangeView(ev:SSEvent):void{
			trace("loaded office states");
			switch(ev.type)
			{
				case SSEvent.FRIENDOFFICESTATEXML_LOADED:
				{
					trace("loaded friend office state");
					setFriendOfficeObjects();
					break;
				}
				case SSEvent.OFFICESTATEXML_LOADED:
				{
					trace("loaded office state");
					setHomeOfficeObjects();
					break;
				}
			}			
		}
		
		/**
		 * opens up the popup for the different managers.
		 * 
		 * @param ev - event handler for popup windows
		 * 
		 */
		
		private function onPopup(ev:PlayerStatusEvent):void{
			switch(ev.type)
			{
				case PlayerStatusEvent.AP_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.ACTION_POPUP_WINDOW);
					break;
				}
					
				case PlayerStatusEvent.COIN_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.COIN_POPUP_WINDOW);
					break;
				}
					
				case PlayerStatusEvent.CASH_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.CASH_POPUP_WINDOW);
					break;
				}
			}
		}
		
		private function onManagePopup(ev:SSEvent):void{
			switch(ev.type)
			{
				case SSEvent.ACTIONPOINT_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.ACTION_POPUP_WINDOW);
					break;
				}
					
				case SSEvent.COIN_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.COIN_POPUP_WINDOW);
					break;
				}
					
				case SSEvent.STARPOINT_POPUP:
				{
					_popUpUiManager.loadWindow(WindowPopUpConfig.CASH_POPUP_WINDOW);
					break;
				}
			}
		}
		
		//***************************************************************************************************************************
		//---------------------------------------------- OFFICE ROOM ----------------------------------------------------------------
		//***************************************************************************************************************************
		
		private function initOfficeRoom():void
		{
			_isoOffice = new IsoRoomProxy();
			addChild(_isoOffice);
			_isoOffice.initialize();
		}
		
		private function _onSettingsZoomInBtnPress(e:SettingUIEvent):void {
			_isoOffice.clearDragObject();
			_isoOffice.zoomIn();
		}
		
		private function _onSettingsZoomOutBtnPress(e:SettingUIEvent):void {
			_isoOffice.clearDragObject();
			_isoOffice.zoomOut();
		}
		
		private function addTempObjectFunctions():void {
			
		}
		
		private function _onMainMenuMoveBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.clearDragObject();
			_isoOffice.createMovePointer();			
		}
		
		private function _onMainMenuRotateBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.clearDragObject();
			_isoOffice.createRotatePointer();
		}
		
		private function _onMainMenuSellBtnPress(e:MainMenuUIEvent):void
		{
			trace('main menu sell tool');
			_isoOffice.clearDragObject();
			_isoOffice.sellObject();
		}
		
		private function _onMainMenuReturnBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.removeDragObject();
			_isoOffice.removePointer();
		}
		
		/****************************************************************************************************************************
		 /------------------------------------------------------ OFFICE SHOP ---------------------------------------------------------
		/***************************************************************************************************************************/
		
		private function populateHomeOffice():void{
			if (GlobalData.instance.officeStateDataLoaded == true){
				setHomeOfficeObjects();
			} else {
				EventSatellite.getInstance().addEventListener(SSEvent.OFFICESTATEXML_LOADED, setHomeOfficeObjects);
			}
		}
		
		private function setHomeOfficeObjects(ev:SSEvent = null):void{	
			var globalData:GlobalData = GlobalData.instance;
			
			trace("Home office Set");
			_isoOffice.clearObjectData();
			if (ev == null){
				EventSatellite.getInstance().removeEventListener(SSEvent.OFFICESTATEXML_LOADED, setHomeOfficeObjects);
			}
			var officeStateArray:Array = globalData.officeStateDataArray;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			
			EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_BLACKSTAR, {tweening:_tweening}));
			EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_REDSTAR, {tweening:_tweening}));
			
			for (var x:int = 0;x<len; x++){
				var xPos:int = officeStateArray[x][GlobalData.OFFICESTATE_POSITION].x;
				var yPos:int = officeStateArray[x][GlobalData.OFFICESTATE_POSITION].y;
				var zPos:int = officeStateArray[x][GlobalData.OFFICESTATE_POSITION].z;
				
				switch(officeStateArray[x][GlobalData.OFFICESTATE_TYPE])
				{
					case GlobalData.ITEMCATEGORY_STAFF:
					{
						_isoOffice.addObject(globalData.getInitialOfficeStateData(officeStateArray[x][GlobalData.OFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_DECO:
					{
						_isoOffice.addObject(globalData.getInitialOfficeStateData(officeStateArray[x][GlobalData.OFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_TILE:
					{
						switch(officeStateArray[x][GlobalData.OFFICESTATE_SUBTYPE])
						{
							case GlobalData.ITEMTYPE_TILE_WALL:
							{
								_isoOffice.editWalling(globalData.officeStateWallID); 
								break;
							}
							case GlobalData.ITEMTYPE_TILE_TILE:
							{
								_isoOffice.editFlooring(globalData.officeStateTileID); 
								break;
							}
						}
					}
					case GlobalData.ITEMCATEGORY_MACHINE:
					{
						_isoOffice.addObject(globalData.getInitialOfficeStateData(officeStateArray[x][GlobalData.OFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_TRAINING:
					{
						_isoOffice.addObject(globalData.getInitialOfficeStateData(officeStateArray[x][GlobalData.OFFICESTATE_ENTRY]));
						break;
					}
				}
			}
		}
		
		private function setFriendOfficeObjects():void{
			var globalData:GlobalData = GlobalData.instance;
			// clean data and timer as well as remove dialogue popup
			
			_isoOffice.clearObjectData();
			
			if (globalData.isChallenge == true){
				trace ("challenged");
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_BLACKSTAR, {tweening:_tweening}));
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_REDSTAR, {tweening:_tweening}));
			} else {
				trace ("visited");
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_BLACKSTAR, {tweening:_tweening}));
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_REDSTAR, {tweening:_tweening}));
			}
			
			var friendOfficeStateArray:Array = globalData.friendOfficeStateDataArray;
			var len:int = GlobalData.instance.friendOfficeStateDataArray.length;
			
			for (var x:int = 0;x<len; x++){
				switch(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_TYPE])
				{
					case GlobalData.ITEMCATEGORY_STAFF:
					{
						_isoOffice.addObject(globalData.getInitialFriendOfficeStateData(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_DECO:
					{
						_isoOffice.addObject(globalData.getInitialFriendOfficeStateData(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_TILE:
					{
						switch(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_SUBTYPE])
						{
							case GlobalData.ITEMTYPE_TILE_WALL:
							{
								_isoOffice.editWalling(globalData.friendOfficeStateWallID); 
								break;
							}
							case GlobalData.ITEMTYPE_TILE_TILE:
							{
								_isoOffice.editFlooring(globalData.friendOfficeStateTileID); 
								break;
							}
						}
					}
					case GlobalData.ITEMCATEGORY_MACHINE:
					{
						_isoOffice.addObject(globalData.getInitialFriendOfficeStateData(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY]));
						break;
					}
					case GlobalData.ITEMCATEGORY_TRAINING:
					{
						_isoOffice.addObject(globalData.getInitialFriendOfficeStateData(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY]));
						break;
					}
				}
			}			
		}
		
		private function _onMainMenuOfcBtnPress(e:MainMenuUIEvent):void 
		{			
			_isoOffice.clearDragObject();
			_popUpUiManager.loadWindow( WindowPopUpConfig.BUILD_SHOP_POPUP , 0, 40 );
			
			if ( !GlobalData.instance.isTutorialDone ) {
				_popUpUiManager.loadSubWindow( WindowPopUpConfig.TUTORIAL_WINDOW );
			}
		}
		
		private function _onMainMenuUiShowInvBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.clearDragObject();
			_popUpUiManager.loadWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW, 0, 40);			
		}
		
		private function _onOfficeShopUICloseBtnPress(e:OfficeShopUIEvent):void 
		{
			_isoOffice.clearDragObject();
			_popUpUiManager.removeWindow(WindowPopUpConfig.BUILD_SHOP_POPUP);			
		}
		
		private function _onOfficeShopUIExpBtnPress(e:OfficeShopUIEvent):void
		{
			_isoOffice.clearDragObject();
			_isoOffice.updateGrid();
			_isoOffice.expandWalling();
			_isoOffice.expandFlooring();
		}
		
		private function _onOfficeShopUITileBtnPress(e:OfficeShopUIEvent):void
		{
			_isoOffice.clearDragObject();
			_isoOffice.editFlooring(e.obj.pos);
		}
		
		
		private function _onOfficeShopUIWallBtnPress(e:OfficeShopUIEvent):void
		{
			_isoOffice.clearDragObject();
			_isoOffice.editWalling(e.obj.pos);
		}
		
		//***************************************************************************************************************************
		//--------------------------------------------------------- AVATAR ----------------------------------------------------------
		//***************************************************************************************************************************
		
		private function _onMainMenuInvBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.clearDragObject();
			_popUpUiManager.loadWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW, 0, 0, true, 12 ,83 );
		}
		
		/****************************************************************************************************************************
		 ------------------------------------------------------ MINIMAP -----------------------------------------------------------
		/***************************************************************************************************************************/	
		private function _onMainMenuUIStoryBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.clearDragObject();
			_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
		}
		
		//***************************************************************************************************************************
		//--------------------------------------------------- TOKEN ICONS ----------------------------------------------------------
		//***************************************************************************************************************************
		private function initTokenIcons():void
		{			
			_coins = new Coin();
			addChild(_coins);
			_coins.visible = false;
			
			_star = new Star();
			addChild(_star);
			_star.visible = false;
		}
		
		private function _onIsoRoomObjectSelected(e:IsoRoomEventProxy):void {		
			
		}
		//***************************************************************************************************************************
		//------------------------------------------------ STAGE EVENT HANDLERS -----------------------------------------------------
		//***************************************************************************************************************************

		//***************************************************************************************************************************
		//--------------------------------------------------------- MAIN UI ---------------------------------------------------------
		//***************************************************************************************************************************
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
			_mainUI.y = 429
		}
		
		//eventsatelite this controllers is the one who listen to the event that dispatched by different UI and transmit the event using eventSatelite
		private function prepareControllers():void 
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener( FriendUIEvent.CLICK_ADD_FRIENDS, onClickAddFriends );
			_es.addEventListener( MainMenuUIEvent.SHOW_CHARACTER_POP_UP_WINDOW, onShowCharWindow );
			_es.addEventListener( MainMenuUIEvent.SHOW_CLOSET_POP_UP_WINDOW, onShowClosetWindow );
			_es.addEventListener( MainMenuUIEvent.SHOW_HIRE_POP_UP_WINDOW, onShowHireWindow );
			_es.addEventListener( MainMenuUIEvent.SHOW_TRADE_POP_UP_WINDOW, onShowTradeWindow );
			_es.addEventListener( FriendUIEvent.CLICK_SHOP_NAME, onClickShopName );
			
			_es.addEventListener( MainMenuUIEvent.SHOW_SETUP, _onMainMenuOfcBtnPress);
			_es.addEventListener( MainMenuUIEvent.SHOW_COLLECTION, _onMainMenuInvBtnPress);
			_es.addEventListener( MainMenuUIEvent.SHOW_INVENTORY, _onMainMenuUiShowInvBtnPress);
			_es.addEventListener( MainMenuUIEvent.SHOW_STORY_MODE, _onMainMenuUIStoryBtnPress);
			
			_es.addEventListener( IsoRoomEvent.ON_OBJECT_SELECT,  _onIsoRoomObjectSelected);
			
			_es.addEventListener( MainMenuUIEvent.SELECT_MOVE_TOOL, _onMainMenuMoveBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_ROTATE_TOOL, _onMainMenuRotateBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_SELL_TOOL, _onMainMenuSellBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_RETURN_TOOL, _onMainMenuReturnBtnPress);
			_es.addEventListener( MainMenuUIEvent.CANCEL_TOOL, _onMainMenuReturnBtnPress);			
		}	
		
		// popup manager is the one who hold all window popup in the game
		//note: it needs to be add last to the main of the game to ensure that the window popup will appear always on top.
		private function addPopUpManager():void 
		{
			_popUpUiManager = PopUpUIManager.getInstance();
			stage.addChild( _popUpUiManager );
			
			if ( !GlobalData.instance.isTutorialDone ) {
				_popUpUiManager.loadSubWindow( WindowPopUpConfig.TUTORIAL_WINDOW );
			}
		}	
		
		private function _onOfficeShopObjBuyBtnPress(e:OfficeShopUIEvent):void 
		{
			_isoOffice.clearDragObject();		
			_isoOffice.buyNewObject(e.obj);			
		}
		
		private function onClickAddFriends(e:FriendUIEvent):void 
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
		}
		
		private function onClickShopName(e:FriendUIEvent):void 
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.CHANGE_OFFICE_NAME_POP_UP   );
		}
		
		private function onShowHireWindow(e:MainMenuUIEvent):void 
		{
			//_popUpUiManager.loadWindow( WindowPopUpConfig.HIRE_POPUP_WINDOW );
		}
		
		private function onShowClosetWindow(e:MainMenuUIEvent):void 
		{
			
			trace( "show closet window" );
		}
		
		private function onShowCharWindow(e:MainMenuUIEvent):void 
		{
			
			trace( "show character window" );
		}
		
		private function onShowTradeWindow(e:MainMenuUIEvent):void 
		{
			
			trace( "show Trade window" );
		}
	}	 
}