package 
{
	// flash libraries
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUI;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUIEvent;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUI;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.playerStatus.PlayerStatusManager;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.miniMap.MinimapMain;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.settingUI.events.SettingUIEvent;
	import com.surnia.socialStar.views.MainUI;
	import com.surnia.socialStar.views.display.IsoRoom;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	[Frame(factoryClass="SocialStarLoader")]
	public class OfficeShopTest extends Sprite
	{
		private var _mainUI:MainUI;
		private var _popUpUiManager:PopUpUIManager;
		private var _es:EventSatellite;
		private var _playerStatusManager:PlayerStatusManager;
		private var _mainView:Sprite;
		
		private var _ofcRoom:IsoRoom;
		private var _coins:Coin;
		private var _star:Star;
		
		//private var _ofcShop:OfficeShopUI;
		
		private var _charHireUI:mc_hire;
		private var _charTooltip:AvatarTooltipUI;
		
		private var _miniMap:MinimapMain;
		
		public function OfficeShopTest()
		{
			
		}
		
		public function applicationStart(app:Sprite):void{
			_mainView = app;
			alpha = .0;
			TweenLite.to(this, .5, {delay:1, alpha:1, onComplete:init});
		}
		
		public function init(e:Event = null):void {	
			initMiniMap();
			initOfficeRoom();
			initOfficeShop();
			initTokenIcons();
			initAvatarComponents();
			initPlayerUIManager();
			initSampleMain();
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
			
			addEventListener(MouseEvent.MOUSE_DOWN, _onStageClick);
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
			_ofcRoom = new IsoRoom();
			addChild(_ofcRoom);
		}
		
		private function _onSettingsZoomInBtnPress(e:SettingUIEvent):void {
			_ofcRoom.zoomIn();
		}
		
		private function _onSettingsZoomOutBtnPress(e:SettingUIEvent):void {
			_ofcRoom.zoomOut();
		}
		
		private function addTempObjectFunctions():void {
			
		}
		
		private function _onMainMenuMoveBtnPress(e:MainMenuUIEvent):void
		{
			_ofcRoom.createMovePointer();
		}
		
		private function _onMainMenuRotateBtnPress(e:MainMenuUIEvent):void
		{
			_ofcRoom.createRotatePointer();
		}
		
		private function _onMainMenuSellBtnPress(e:MainMenuUIEvent):void
		{
			trace('main menu sell tool');
			_ofcRoom.sellObject();
		}
		
		private function _onMainMenuReturnBtnPress(e:MainMenuUIEvent):void
		{
			_ofcRoom.removePointer();
		}
		
		/****************************************************************************************************************************
		/------------------------------------------------------ OFFICE SHOP ---------------------------------------------------------
		/***************************************************************************************************************************/
		
		private function initOfficeShop():void 
		{
			//_ofcShop = new OfficeShopUI();
			//addChild(_ofcShop);
			//_ofcShop.init();
			//_ofcShop.y = (stage.stageHeight/2) - (_ofcShop.height/2) + 20;
			//_ofcShop.x = (stage.stageWidth / 2) - (_ofcShop.width / 2);
			//_ofcShop.visible = false;
			
			_ofcRoom.addNewCharacter("", 2, 2);
			_ofcRoom.addNewCharacter("", 4, 4);
			_ofcRoom.addNewCharacter("", 6, 6);
			
			_ofcRoom.addObject(1, 2, 0, 7);
			_ofcRoom.addObject(1, 3, 1, 6);
			_ofcRoom.addObject(1, 4, 2, 5);
			_ofcRoom.addObject(2, 5, 3, 4);
			_ofcRoom.addObject(2, 6, 4, 3);
			
			_ofcRoom.addNewDoor(4, 0, 170, 0);
			_ofcRoom.addNewDoor(4, 0, 204, 0);
			
			_ofcRoom.addNewWindow(6, 0, 102, 0);
			_ofcRoom.addNewWindow(6, 0, 272, 0);
			_ofcRoom.addNewWindow(6, 238, 0, 1);
		}
		
		private function _onMainMenuOfcBtnPress(e:MainMenuUIEvent):void 
		{			
			//EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_PLAYERSTATUS));
			//addChild(_ofcShop);
			//_ofcShop.visible = true;
			_popUpUiManager.loadWindow( WindowPopUpConfig.BUILD_SHOP_POPUP , 0,40 );
		}
		
		private function _onMainMenuUiShowInvBtnPress(e:MainMenuUIEvent):void
		{
			_popUpUiManager.loadWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW, 0, 40);
			//_ofcRoom.addNewCabinet(1);
		}
		
		private function _onOfficeShopUICloseBtnPress(e:OfficeShopUIEvent):void 
		{
			//_ofcShop.visible = false;
			//removeChild(_ofcShop);
			//EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_PLAYERSTATUS));
		}
		
		//private function _onOfficeShopObjBuyBtnPress(e:OfficeShopUIEvent):void 
		//{	
			//trace( "seeeme ", e.obj  );			
			//switch ( e.obj ) {
				//case 'staff' : 
					//
				//break;
					//
				//case 'training' : 					
					//
				//break;
				//
				//case 'machine' : 					
					//
				//break;
				//
				//case 'deco' : 					
					//
				//break;
				//
				//case 'tile' : 					
					//
				//break;
				//
				//case 'expansion' : 
										//
				//break;
				//
				//case 'power': 					
					//
				//break;
				//
			//default:
					//_ofcRoom.addNewObject(_ofcShop.objPos, 1000, 1000, 0);
				//break;
			//}
			//
			//_popUpUiManager.removeCurrentWindow();
			//_ofcShop.visible = false;
			//_ofcRoom.addNewCabinet(1);
			//_ofcRoom.addObject(_ofcShop.objCat, _ofcShop.objPos);
			//
		//}
		
		private function _onOfficeShopUIExpBtnPress(e:OfficeShopUIEvent):void
		{
			trace( "expansion", e.obj.cat, e.obj.pos );
			_ofcRoom.updateGrid();
			_ofcRoom.expandWalling();
			_ofcRoom.expandFlooring();
		}
		
		private function _onOfficeShopUITileBtnPress(e:OfficeShopUIEvent):void
		{
			_ofcRoom.editFlooring(e.obj.pos);
		}
		
		//***************************************************************************************************************************
		//-------------------------------------------------------- AVATAR ----------------------------------------------------------
		//***************************************************************************************************************************
		private function initAvatarComponents():void
		{
			_charHireUI = new mc_hire();
			addChild(_charHireUI);
			//_charHireUI.loadXML('sample.xml');
			_charHireUI.loadXML("http://1.234.2.179/socialstardev/characters/create");
			_charHireUI.visible = false;
			
			_charHireUI.addEventListener('hired', _onCharHireUIOkBtnPress);
			_charHireUI.addEventListener('refreshed', _onCharHireUIRefreshBtnPress);
			_charHireUI.addEventListener('closed', _onCharHireUICloseBtnPress);
			
			initCharTooltip();
		}
		
		private function _onCharHireUIOkBtnPress(e:Event):void
		{
			trace('character hire ui ok btn press');
			_charHireUI.visible = false;
			trace('character value : ' + _charHireUI.charData[3]);
			_ofcRoom.addNewCharacter(_charHireUI.charData[3], 3, 3);
		}
		
		private function _onCharHireUIRefreshBtnPress(e:Event):void
		{
			trace('character hire ui refresh button press');
			
		}
		
		private function _onCharHireUICloseBtnPress(e:Event):void
		{
			trace('character hire ui hire button press');
			_charHireUI.visible = false;
		}
		
		private function _onMainMenuInvBtnPress(e:MainMenuUIEvent):void
		{
			_ofcRoom.addNewCharacter("", 250, 250);
		}
		
		//***************************************************************************************************************************
		//------------------------------------------------- AVATAR TOOLTIPS ---------------------------------------------------------
		//***************************************************************************************************************************
		private function initCharTooltip():void
		{
			_charTooltip = new AvatarTooltipUI();
			addChild(_charTooltip);
			_charTooltip.visible = false;
		}
		
		private function _onAvaTooltipUICloseBtnPress(e:AvatarTooltipUIEvent):void 
		{
			_charTooltip.visible = false;
		}
		
		private function _onAvaTooltipUIStaffBtnPress(e:AvatarTooltipUIEvent):void
		{
			addChild(_charHireUI);
			_charHireUI.loadXML("http://1.234.2.179/socialstardev/characters/create");
			_charHireUI.creditsCoin = 5000;
			_charHireUI.creditsCash = 8000;
			_charHireUI.visible = true;
		}
		
		private function _onIsoRoomCharSelect(e:IsoRoomEvent):void
		{
			_charTooltip.x = stage.mouseX + 25;
			_charTooltip.y = stage.mouseY - 25;
			_charTooltip.visible = true;
		}
		
		//***************************************************************************************************************************
		//***************************************************************************************************************************
		//------------------------------------------------------ MINIMAP -----------------------------------------------------------
		//***************************************************************************************************************************
		private function initMiniMap():void
		{
			//_minimapUI.remove();
		}
		
		private function _onMainMenuUIStoryBtnPress(e:MainMenuUIEvent):void
		{			
			_miniMap = new MinimapMain();
			addChild(_miniMap);
			//addChild(_minimapUI);
			//trace('show minimap');
			//_minimapUI.display();
			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
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
		
		private function _onIsoRoomObjectSelected(e:IsoRoomEvent):void {
			
			//_coins.x = stage.mouseX;
			//_coins.y = stage.mouseY;
			//_coins.visible = true;
			
			//_star.x = stage.mouseX;
			//_star.y = stage.mouseY;
			//_star.visible = true;
			
			//_coins.gotoAndPlay(2);
			//_star.gotoAndPlay(2);
		}
		//***************************************************************************************************************************
		//------------------------------------------------ STAGE EVENT HANDLERS -----------------------------------------------------
		//***************************************************************************************************************************
		private function _onStageClick(e:MouseEvent):void
		{
			if (_charTooltip != visible) 
			{
				_charTooltip.visible = false;
			}
		}		
		
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
			_es.addEventListener( IsoRoomEvent.ON_CHARACTER_SELECT, _onIsoRoomCharSelect);
			
			_es.addEventListener( MainMenuUIEvent.SELECT_MOVE_TOOL, _onMainMenuMoveBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_ROTATE_TOOL, _onMainMenuRotateBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_SELL_TOOL, _onMainMenuSellBtnPress);
			_es.addEventListener( MainMenuUIEvent.SELECT_RETURN_TOOL, _onMainMenuReturnBtnPress);
			_es.addEventListener( MainMenuUIEvent.CANCEL_TOOL, _onMainMenuReturnBtnPress);
			
			_es.addEventListener( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT, _onAvaTooltipUICloseBtnPress);
			_es.addEventListener( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_STAFF_BUTTON_SELECT, _onAvaTooltipUIStaffBtnPress);
		}										
		
		// popup manager is the one who hold all window popup in the game
		//note: it needs to be add last to the main of the game to ensure that the window popup will appear always on top.
		private function addPopUpManager():void 
		{
			_popUpUiManager = PopUpUIManager.getInstance();
			stage.addChild( _popUpUiManager );			
			
			//CALL ACTTION POP UP WINDOW WHEN RUN OUT OF ACTION POINTS
			//_popUpUiManager.loadWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW );			
			
			//CALL COIN POP UP WINDOW WHEN RUN OUT OF COINS
			//_popUpUiManager.loadWindow( WindowPopUpConfig.COIN_POPUP_WINDOW );

			//call miniMap
			//_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			
			//_popUpUiManager.loadWindow( WindowPopUpConfig.ITEM_SHOP_POPUP_WINDOW, 0, 90 );
		}		
		
		/*--------------------------------------------------------------------------Setters---------------------------------------------------------------*/		
		
		/*--------------------------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		/*--------------------------------------------------------------------------EventHandlers---------------------------------------------------------------*/		
		
		
		//the event that will be called for every dispatched		
		
		//buying part
		private function _onOfficeShopObjBuyBtnPress(e:OfficeShopUIEvent):void 
		{
			//code for placing office item to office Iso World!!
			trace( "obj cat and pos", e.obj.cat, e.obj.pos );
			//_ofcRoom.addObject(_ofcShop.objCat, _ofcShop.objPos);
			//_ofcRoom.addNewCabinet(1);
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
			_popUpUiManager.loadWindow( WindowPopUpConfig.HIRE_POPUP_WINDOW );
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