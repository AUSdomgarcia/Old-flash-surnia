package //init GetActionPoint popup window
{	
	import com.fluidLayout.FluidObject;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.quest.QuestMain;
	import com.surnia.socialStar.tutorial.controller.TutorialGuideManager;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUI;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.ui.playerStatus.PlayerStatusManager;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUpManagerEvent;
	import com.surnia.socialStar.ui.popUI.views.eventScene.event.EventSceneEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.MinimapMain;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.display.IsoRoom;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.MainUI;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	
	
	
	[Frame(factoryClass="SocialStarLoader")]
	[SWF (height = "630", width = "760")]
	
	public class SocialStar extends Sprite
	{
		private var _mainUI:MainUI;
		private var _popUpUiManager:PopUpUIManager;
		private var _tutGuideManager:TutorialGuideManager;
		private var _playerStatusManager:PlayerStatusManager;
		private var _mainView:Sprite;
		
		private var _isoOffice:IsoRoom;
		private var _coins:CoinRewardMC;
		private var _star:Star;
		
		private var _charTooltip:AvatarTooltipUI;
		private var _tweening:Boolean = true;
		
		private var _globalData:GlobalData = GlobalData.instance;
		private var _popArray:Array = [new Array()];
		private var _charTimerArray:Array = [];
		
		private var _miniMap:MinimapMain;
		private var _firstRun:Boolean = true;
		
		private var _serverDataController:ServerDataController;
		private var _es:EventSatellite;
		
		private var _tutEvent:TutorialEvent;
		private var _gd:GlobalData;
		private var _questUI:QuestMain;
		
		private var _isoRoomEvent:IsoRoomEvent;
		private var _popupEventManager:PopUpManagerEvent;		
		private var _fontManager:FontManager;
		
		public function SocialStar()
		{			
			_fontManager = FontManager.getInstance();			
			_fontManager.loadSwfFont();
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();			
			_serverDataController = ServerDataController.getInstance();
			
			//addEventListener( MouseEvent.MOUSE_MOVE, onMouseMoveCheckPos );
		}		
		
		public function applicationStart(app:Sprite):void{
			_mainView = app;
			alpha = .0;
			TweenLite.to(this, .5, { delay:1, alpha:1, onComplete:init } );			
		}
		
		public function init(e:Event = null):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			initGame();
		}
		
		private function initGame():void 
		{
			//_serverDataController.getGridWidthLength(); QuestEvent.UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION
			_gd.GameStage = stage;	
			_gd.stage = stage;
			initOfficeRoom();
			initTokenIcons();
			initPlayerUIManager();
			initSampleMain();
			populateHomeOffice();
			addListeners();
			
			//if ( !GlobalData.instance.isTutorialDone ){				
				//_tutEvent = new TutorialEvent( TutorialEvent.START_TUTORIAL );
				//_es.dispatchESEvent( _tutEvent );
			//}
		}
		
		private function clearGame():void 
		{
			removeControllers();
			clearIsoOffice();
			clearInitTokenIcons();
			clearInitPlayerUIManager();
			removePopUpManager();
			clearMain();
		}
		
		private function initPlayerUIManager():void{
			_playerStatusManager = new PlayerStatusManager(this);
			_playerStatusManager.start();
			
			var playerStatusUIEvent:PlayerStatusEvent = new PlayerStatusEvent( PlayerStatusEvent.ON_PLAYER_STATUS_UI_ADDED_TO_STAGE ); 			
			_es.dispatchESEvent( playerStatusUIEvent  );
		}
		
		private function clearInitPlayerUIManager():void 
		{
			if ( _playerStatusManager != null ) {				
				_playerStatusManager.destroy();
				_playerStatusManager = null;
			}
		}
		
		private function addListeners():void{
			_es.addEventListener(PlayerStatusEvent.AP_POPUP, onPopup);
			_es.addEventListener(PlayerStatusEvent.CASH_POPUP, onPopup);
			_es.addEventListener(PlayerStatusEvent.COIN_POPUP, onPopup);
			
			_es.addEventListener(SSEvent.ACTIONPOINT_POPUP, onManagePopup);
			_es.addEventListener(SSEvent.STARPOINT_POPUP, onManagePopup);
			_es.addEventListener(SSEvent.COIN_POPUP, onManagePopup);
			
			_es.addEventListener(OfficeShopUIEvent.ON_OBJECT_BUY, onBuyOfficeObject);
			_es.addEventListener(ServerDataControllerEvent.BUY_OFFICE_ITEM_FAILED, onBuyOfficeItemFailed );			
			
			_es.addEventListener(SSEvent.FRIENDOFFICESTATEXML_LOADED, onChangeView);
			_es.addEventListener(SSEvent.OFFICESTATEXML_LOADED, onChangeView);
			
			_es.addEventListener( IsoRoomEvent.ON_SHOW_QUEST, onShowQuest );
			_es.addEventListener( IsoRoomEvent.ON_HIDE_QUEST, onHideQuest );
			_es.addEventListener( PlayerStatusEvent.ON_PLAYER_STATUS_UI_ADDED_TO_STAGE, onUpdateGUIPosition );
			//stage.addEventListener(FullScreenEvent.FULL_SCREEN, screenHandler);
		}					
		
		public function onChangeView(ev:SSEvent):void{
			trace("loaded office states");
			
			//reset grid here
			//create new grid
			//set office item
			//load character			
			
			//_isoOffice.clearOfficeObjects();
			//_isoOffice.clearFloorWall();
			//_isoOffice.initPathGrid();			
			//_isoOffice.initWallFloor();
			
			//clearGame();
			//initGame();
			
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
			_isoOffice = new IsoRoom();
			addChild(_isoOffice);
			_isoOffice.initialize();			
		}
		
		private function clearIsoOffice():void 
		{
			if ( _isoOffice != null ) {
				_isoOffice.destroy();
				if ( this.contains( _isoOffice ) ) {
					this.removeChild( _isoOffice );
					_isoOffice = null;
				}
			}
		}
		
		private function _onMainMenuReturnBtnPress(e:MainMenuUIEvent):void
		{
			_isoOffice.removeDragObject();
			//_isoOffice.removeCursor();
		}
		
		/****************************************************************************************************************************
		/------------------------------------------------------ OFFICE SHOP ---------------------------------------------------------
		/***************************************************************************************************************************/
		
		private function populateHomeOffice():void{
			if (GlobalData.instance.officeStateDataLoaded == true){
				setHomeOfficeObjects();				
			} else {
				_es.addEventListener(SSEvent.OFFICESTATEXML_LOADED, setHomeOfficeObjects);				
			}
		}		
		
		private function setHomeOfficeObjects(ev:SSEvent = null):void {				
			_isoOffice.clearOfficeObjects();
			_isoOffice.clearFloorWall();			
			_isoOffice.initPathGrid();
			_isoOffice.initWallFloor();
			
			trace( "[ SOcial Star ]: updated grid width and length", _globalData.expansion, _globalData.expansion );			
			trace( "[ SOcial Star ]: setHome Office Objects" );	
			var globalData:GlobalData = GlobalData.instance;
			
			trace("Home office Set");
			//_isoOffice.clearOfficeObject();
			//_isoOffice.clearOfficeObjects();
			
			if (ev == null){
				_es.removeEventListener(SSEvent.OFFICESTATEXML_LOADED, setHomeOfficeObjects);
			}
			//_globalData.officeStateDataArray
			var officeStateArray:Array = globalData.officeStateDataArray;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			
			_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_BLACKSTAR, {tweening:_tweening}));
			_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_REDSTAR, { tweening:_tweening } ));
			
			var playerStatusEvent:PlayerStatusEvent = new PlayerStatusEvent( PlayerStatusEvent.HIDE_HELPINGENERGY  ); 
			_es.dispatchESEvent( playerStatusEvent );			
			
			trace( "grid width length", _gd.expansion, _gd.expansion );
			
			for (var x:int = 0; x < len; x++){				
				if( officeStateArray[x][GlobalData.OFFICESTATE_POSITION] != undefined  ){
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
							var isoRoomEvent:IsoRoomEvent;
							var obj:Object;
							
							switch(officeStateArray[x][GlobalData.OFFICESTATE_SUBTYPE])
							{							
								case GlobalData.ITEMTYPE_TILE_WALL:
								{								
									isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_UPDATE_WALL_SKIN );
									obj = new Object();
									obj.id = globalData.officeStateWallID;
									_es.dispatchESEvent( isoRoomEvent, obj );
									break;
								}
								case GlobalData.ITEMTYPE_TILE_TILE:
								{							
									obj = new Object();
									obj.id = globalData.officeStateTileID;									
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
			
			_gd.objectsLoaded = true;
			_es.dispatchEvent(new SSEvent (SSEvent.CHECK_OFFICECHARSTATE));			
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_SET_OFFICE_ROOM_OBJECT_COMPLETE );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function setFriendOfficeObjects():void {			
			_isoOffice.clearOfficeObjects();
			_isoOffice.clearFloorWall();			
			_isoOffice.initPathGrid();
			_isoOffice.initWallFloor();
			
			var globalData:GlobalData = GlobalData.instance;
			// clean data and timer as well as remove dialogue popup
			
			//_isoOffice.clearOfficeObject();					
			//_isoOffice.clearOfficeObjects();
			// to be restored when not needed and the activity associated with it is created
			if (globalData.isChallenge == true){
				trace ("challenged");
				//_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_BLACKSTAR, {tweening:_tweening}));
				//_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_REDSTAR, {tweening:_tweening}));
			} else {
				trace ("visited");
				//_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_BLACKSTAR, {tweening:_tweening}));
				//_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_REDSTAR, { tweening:_tweening } ));
				
				var playerStatusEvent:PlayerStatusEvent = new PlayerStatusEvent( PlayerStatusEvent.SHOW_HELPINGENERGY  ); 
				_es.dispatchESEvent( playerStatusEvent );
			}
			
			var friendOfficeStateArray:Array = globalData.friendOfficeStateDataArray;
			//globalData.officeStateDataArray.push(newOfficeData);
			globalData.officeStateDataArray = globalData.friendOfficeStateDataArray;
			var len:int = GlobalData.instance.friendOfficeStateDataArray.length;
			
			for (var x:int = 0; x < len; x++) {
				if( friendOfficeStateArray[x][GlobalData.OFFICESTATE_POSITION] != undefined  ){
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
							var isoRoomEvent:IsoRoomEvent;
							var obj:Object;
								
							switch(friendOfficeStateArray[x][GlobalData.FRIENDOFFICESTATE_SUBTYPE])
							{							
								
								case GlobalData.ITEMTYPE_TILE_WALL:
								{								
									isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_UPDATE_WALL_SKIN );
									obj = new Object();
									obj.id = globalData.friendOfficeStateWallID;
									_es.dispatchESEvent( isoRoomEvent, obj );
									break;
								}
								case GlobalData.ITEMTYPE_TILE_TILE:
								{									
									obj = new Object();
									obj.id = globalData.friendOfficeStateTileID;									
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
			
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE );
			_es.dispatchESEvent( _isoRoomEvent );			
		}
		
		private function onShowOfficeShop(e:MainMenuUIEvent):void 
		{
			if( !_gd.isDragging  && !_gd.friendView ){
				_isoOffice.clearDragObject();
				_isoOffice.removeCursor();
			
				_popUpUiManager.loadWindow( WindowPopUpConfig.BUILD_SHOP_POPUP  );
				_tutEvent = new TutorialEvent( TutorialEvent.CLICK_SHOP_BTN );
				_es.dispatchESEvent( _tutEvent );		
			}
		}
		
		private function onShowOfficeInventory(e:MainMenuUIEvent):void
		{
			if( !_gd.isDragging && !_gd.friendView ){
				_isoOffice.clearDragObject();
				_isoOffice.removeCursor();
				_popUpUiManager.loadWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW );
			}
		}	
		
		//***************************************************************************************************************************
		//--------------------------------------------------------- AVATAR ----------------------------------------------------------
		//***************************************************************************************************************************
		
		private function onShowCollection(e:MainMenuUIEvent):void
		{
			if( !_gd.isDragging ){				
				_popUpUiManager.loadWindow( WindowPopUpConfig.COLLECTION_WINDOW );
			}
		}
		
		/****************************************************************************************************************************
		------------------------------------------------------ MINIMAP -----------------------------------------------------------
		/***************************************************************************************************************************/	
		private function onShowMiniMapWindow(e:MainMenuUIEvent):void
		{
			if( !_gd.isDragging ){
				_popUpUiManager.loadWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			}
		}
		
		//***************************************************************************************************************************
		//--------------------------------------------------- TOKEN ICONS ----------------------------------------------------------
		//***************************************************************************************************************************
		private function initTokenIcons():void
		{			
			_coins = new CoinRewardMC();
			addChild(_coins);
			_coins.visible = false;
			
			_star = new Star();
			addChild(_star);
			_star.visible = false;
		}
		
		private function clearInitTokenIcons():void 
		{
			if ( _coins != null ) {
				if ( this.contains( _coins ) ) {
					this.removeChild( _coins );
					_coins = null;
				}
			}
			
			if ( _star != null ) {
				if ( this.contains( _star ) ) {
					this.removeChild( _star );
					_star = null;
				}
			}	
		}
		
		private function toggleFullScreen():void 
		{
			var isoRoomEvent:IsoRoomEvent;
			
			if ( stage.displayState == StageDisplayState.NORMAL ) {				
				isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_GAME_FULL_SCREEN );
				_es.dispatchESEvent( isoRoomEvent );
				
				//StageAlignTool.init(stage, 760, 630 ); //init(stage:Stage, minW:uint = 1024, minH:uint = 768):void
				//StageAlignTool.registerLocation( this, StageAlignTool.BR, true);
				//StageAlignTool.registerLocation( this, StageAlignTool.MC, false );
				//registerLocation(disp:DisplayObject, loc:uint, stayRelative:Boolean = false):void
				//possible locations are StageAlignTool.[TL, TC, TR, ML, MC, MR, BL, BC, BR]			
				
				stage.displayState = StageDisplayState.FULL_SCREEN;
				trace( "go full screen..", stage.stageWidth, stage.stageHeight );
				
			}else {
				isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_GAME_NORMAL_SCREEN );
				_es.dispatchESEvent( isoRoomEvent );
				
				//StageAlignTool.init(stage, 760, 630 ); //init(stage:Stage, minW:uint = 1024, minH:uint = 768):void
				//StageAlignTool.registerLocation( this, StageAlignTool.BR, true); 				
				//StageAlignTool.registerLocation( this, StageAlignTool.TL, false); 
				
				stage.displayState = StageDisplayState.NORMAL;
				trace( "go normal screen..", stage.stageWidth, stage.stageHeight );
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
			addQuestUI();
			addTutGuideManager();
		}
		
		private function clearMain():void 
		{
			removeControllers();
			clearMainMenuUI();
			removePopUpManager();
			removeQuestUI();
			removeTutGuideManager();
		}
		
		
		// this mainUI is the actual mainUI of the game it is composed of friendUI, MainMenuUI, Saettings UI		
		private function addMainMenuUI():void 
		{
			_mainUI = new MainUI();
			addChild( _mainUI );
			//_mainUI.y = 429;
			updatePosition();			
		}
		
		private function updatePosition():void 
		{
			var mainUIWidth:int = 760;
			var mainUIHeight:int = 200;
			
			var mainUIParam = {
				x:0.5,
				y:1,
				offsetX:-mainUIWidth/2,
				offsetY:-mainUIHeight
			}
			new FluidObject(_mainUI,mainUIParam );		
			_es.dispatchEvent(new EventSceneEvent(EventSceneEvent.EVENTSCENE_UPDATEPOSTION));
			/*
			var runningOn:String = Capabilities.playerType;			
			if ( runningOn != 'StandAlone' ) {
				if ( stage.displayState == StageDisplayState.NORMAL ){
					_mainUI.x = ( _gd.offsetWidth / 2 ) - ( mainUIWidth / 2 );
					_mainUI.y = 429;
				}else{
					_mainUI.x = ( _gd.screenWidth / 2 ) - ( mainUIWidth / 2 );
					_mainUI.y = _gd.screenHeight - mainUIHeight;
				}
			}else{
				_mainUI.x = 0;
				_mainUI.y = 429;
			}*/
		}
		
		private function clearMainMenuUI():void 
		{
			if ( _mainUI != null ) {
				if ( this.contains( _mainUI ) ) {
					this.removeChild( _mainUI );
					_mainUI = null;
				}
			}
		}
		
		private function addQuestUI():void 
		{
			_questUI = new QuestMain();
			addChild( _questUI );
			//_questUI.x = 50;
			//_questUI.y = 40;
			
			var questUIOffsetX:int = 50;
			var questUIOffsetY:int = -290;
			
			var questUIParam = {
				x:0,
				y:0.5,
				offsetX:questUIOffsetX,
				offsetY:questUIOffsetY
			}
			new FluidObject(_questUI,questUIParam );	
			
		}
		
		private function removeQuestUI():void 
		{
			if ( _questUI != null ) {
				if ( this.contains( _questUI ) ) {
					this.removeChild( _questUI );
					_questUI = null;
				}
			}
		}
		
		//eventsatelite this controllers is the one who listen to the event that dispatched by different UI and transmit the event using eventSatelite
		private function prepareControllers():void 
		{			
			_es.addEventListener( FriendUIEvent.CLICK_ADD_FRIENDS, onClickAddFriends );
			_es.addEventListener( FriendUIEvent.CLICK_SHOP_NAME, onClickShopName );
			
			_es.addEventListener( MainMenuUIEvent.SHOW_SETUP, onShowOfficeShop );
			_es.addEventListener( MainMenuUIEvent.SHOW_COLLECTION, onShowCollection );
			_es.addEventListener( MainMenuUIEvent.SHOW_INVENTORY, onShowOfficeInventory );
			_es.addEventListener( MainMenuUIEvent.SHOW_STORY_MODE, onShowMiniMapWindow );
			//_es.addEventListener( MainMenuUIEvent.SHOW_TOOLS, onShowTools );
			//_es.addEventListener( SettingUIEvent.FULL_SCREEN_CLICK, onToggleFullScreen );
			
			_es.addEventListener( MainMenuUIEvent.SELECT_RETURN_TOOL, _onMainMenuReturnBtnPress);
			_es.addEventListener( MainMenuUIEvent.CANCEL_TOOL, _onMainMenuReturnBtnPress);
			_es.addEventListener( IsoRoomEvent.ON_GAME_FULL_SCREEN, onFullScreenGame );
			_es.addEventListener( IsoRoomEvent.ON_GAME_NORMAL_SCREEN, onNormalScreenGame );
			
		}		
		
		private function removeControllers():void 
		{
			_es.removeEventListener( FriendUIEvent.CLICK_ADD_FRIENDS, onClickAddFriends );
			_es.removeEventListener( FriendUIEvent.CLICK_SHOP_NAME, onClickShopName );
			
			_es.removeEventListener( MainMenuUIEvent.SHOW_SETUP, onShowOfficeShop );
			_es.removeEventListener( MainMenuUIEvent.SHOW_COLLECTION, onShowCollection );
			_es.removeEventListener( MainMenuUIEvent.SHOW_INVENTORY, onShowOfficeInventory );
			_es.removeEventListener( MainMenuUIEvent.SHOW_STORY_MODE, onShowMiniMapWindow );
			//_es.removeEventListener( SettingUIEvent.FULL_SCREEN_CLICK, onToggleFullScreen );
			
			_es.removeEventListener( MainMenuUIEvent.SELECT_RETURN_TOOL, _onMainMenuReturnBtnPress);
			_es.removeEventListener( MainMenuUIEvent.CANCEL_TOOL, _onMainMenuReturnBtnPress);
		}
		
		private function screenHandler (ev:FullScreenEvent):void{
			_es.dispatchEvent(new EventSceneEvent(EventSceneEvent.EVENTSCENE_UPDATEPOSTION));
		}
		
		// popup manager is the one who hold all window popup in the game
		//note: it needs to be add last to the main of the game to ensure that the window popup will appear always on top.
		private function addPopUpManager():void 
		{
			_popUpUiManager = PopUpUIManager.getInstance();
			stage.addChild( _popUpUiManager );	
			
			_popupEventManager = new PopUpManagerEvent();
			_popupEventManager.addListeners();
			
			if ( !GlobalData.instance.isTutorialDone ){				
				_tutEvent = new TutorialEvent( TutorialEvent.START_TUTORIAL );
				_es.dispatchESEvent( _tutEvent );
			}
		}
		
		private function removePopUpManager():void 
		{
			if ( _popUpUiManager != null ) {
				if ( stage.contains( _popUpUiManager ) ) {
					stage.removeChild( _popUpUiManager  );
					_popUpUiManager = null;
				}
			}
			
			if( _popupEventManager != null ){
				_popupEventManager.removeListeners();
				_popupEventManager = null;
			}
			
			_tutEvent = null;
		}
		
		
		private function addTutGuideManager():void 
		{
			_tutGuideManager = TutorialGuideManager.getInstance();
			stage.addChild( _tutGuideManager );
			//_tutGuideManager.addTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_1, 0, 0.5, 100, 110 );
			//_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_1, 1, 0.5, -500 , 0 );
			//_tutGuideManager.showTutGuide();
			//_tutGuideManager.hideTutGuide();
		}
		
		private function removeTutGuideManager():void 
		{
			if ( _tutGuideManager != null ){
				if ( stage.contains( _tutGuideManager ) ) {
					stage.removeChild( _tutGuideManager  );
					_tutGuideManager = null;
				}
			}
		}	
		
		private function onBuyOfficeObject(e:OfficeShopUIEvent):void 
		{
			_isoOffice.clearDragObject();
			_isoOffice.buyNewObject(e.obj);
		}
		
		private function onBuyOfficeItemFailed(e:ServerDataControllerEvent):void 
		{
			_isoOffice.clearDragObject();
		}
		
		private function onClickAddFriends(e:FriendUIEvent):void 
		{
			if( !_gd.isDragging ){
				_popUpUiManager.loadWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
			}
		}
		
		private function onClickShopName(e:FriendUIEvent):void 
		{
			if( !_gd.isDragging ){
				_popUpUiManager.loadWindow( WindowPopUpConfig.CHANGE_OFFICE_NAME_POP_UP   );
			}
		}
		
		private function onHideQuest(e:IsoRoomEvent):void 
		{
			_questUI.visible = false;
		}
		
		private function onShowQuest(e:IsoRoomEvent):void 
		{
			_questUI.visible = true;
		}
		
		//private function onShowTools(e:MainMenuUIEvent):void
		//{			
			//toggleFullScreen();						
		//}
		
		private function onNormalScreenGame(e:IsoRoomEvent):void 
		{
			updatePosition();
		}
		
		private function onFullScreenGame(e:IsoRoomEvent):void 
		{
			updatePosition();
		}
		
		private function onUpdateGUIPosition(e:PlayerStatusEvent):void 
		{
			_playerStatusManager.updateGUIPosition();
		}
		//private function onToggleFullScreen(e:SettingUIEvent):void 
		//{
			//toggleFullScreen();
		//}
		
		//private function onMouseMoveCheckPos(e:MouseEvent):void 
		//{
			//trace( "[SocialStar]: show xpos and ypos:", mouseX, mouseY );
		//}
	}	 
}