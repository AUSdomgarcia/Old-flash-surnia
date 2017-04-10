package com.surnia.socialStar.views.display
{
	/* ------------------------
	* Default Flash Libraries
	-------------------------*/
	
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.ui.settingUI.events.SettingUIEvent;
	
	import com.fluidLayout.FluidObject;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.contestantinformation.event.ContestantInformationEvent;
	import com.surnia.socialStar.ui.cursor.Cursor;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.InventoryEvent;
	import com.surnia.socialStar.ui.popUI.tooltip.MiniTooltipManager;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.crew.event.CrewEvent;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.FriendInteractionManager;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.ui.popUI.views.staff.event.StaffEvent;
	import com.surnia.socialStar.utils.ai.Grid;
	import com.surnia.socialStar.utils.stringUtilManager.StringUtilManager;
	import com.surnia.socialStar.views.display.IsoFloorObject.IsoFloorObject;
	import com.surnia.socialStar.views.isoItems.DropItemManager;
	import com.surnia.socialStar.views.isoItems.DropItems;
	import com.surnia.socialStar.views.isoItems.config.DropItemManagerConfig;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	import com.surnia.socialStar.views.nodes.CharacterNodeManager;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	import com.surnia.socialStar.views.ringCommand.RingCommand;
	import com.surnia.socialStar.views.ringCommand.events.RingCommandEvent;
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	/******************************************************************************************************************************************************
	 VARIABLE DECLARATIONS
	 *******************************************************************************************************************************************************/
	public class IsoRoom extends MovieClip
	{
		/* ---------------
		* ISO PROPERTIES
		------------------ */
		private var _view:IsoView;
		private var _gridScene:IsoScene;
		private var _scene:IsoScene;
		private var _box:IsoBox;
		private var _grid:IsoGrid;
		private var _dragPt:Pt;
		
		/*-------------------------
		* OBJECTS
		-------------------------*/
		private var OBJECT_MOVING:Boolean = false;
		private var OBJECT_COLLISSION:Boolean = false;
		private var SPACE_COLLISSION:Boolean = false;
		private var _characterAction:String = "";
		private var _popUIManager:PopUpUIManager;
		
		/*-----------------------------------
		* Iso Room Objects temporary chunks
		------------------------------------*/
		private var objectsAry:Array = new Array();
		private var _currentObject:Object = new Object();
		public var _dragObject:IsoSprite;
		private var _lastPosX:int;
		private var _lastPosY:int;
		private var _activeObject:IsoSprite;
		
		/* --------------------
		* FOR EVENT SATELLITE
		--------------------- */
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;
		
		/*-------------------
		* CHARACTERS
		---------------------*/
		//protected var pathGrid:Grid;
		//protected var isoSprite:IsoSprite;
		
		private var _dropItemManager:DropItemManager;
		private var dropItems:DropItems;
		
		//new
		private var _characterNodeManager:CharacterNodeManager;
		private var _gd:GlobalData = GlobalData.instance;
		private var _cursor:Cursor;
		
		/* ---------------
		* ISO FLOOR
		------------------ */
		private var _floorMngr:IsoFloorsManager;
		private var _wallsMngr:IsoWallsManager;
		
		/* ---------------
		* ZOOM MANAGER
		------------------ */
		private var _zoomMngr:ZoomManager;
		
		/* ---------------
		* PAN MANAGER
		------------------ */
		private var _panMngr:PanManager;
		
		// friend interaction
		private var _friendInteractionManager:FriendInteractionManager;
		
		private var _trainRestChar:CharacterNode;
		
		//ring command
		private var _ringCommand:RingCommand;
		private var _imageExtractor:ImageExtractor;
		private var _bgImg:BackgroundImage;
		private var _tooltipManager:MiniTooltipManager;
		
		//new 010112012
		private var _isShownNotification:Boolean;
		// event managers
		//private var _popupEventManager:PopUpManagerEvent;
		
		/*********************************************************************************************************************************************
		 |	CONSTRUCTOR
		 *********************************************************************************************************************************************/
		public function IsoRoom():void
		{		
			//initialize();
		}
		
		/*********************************************************************************************************************************************
		 |	INITIALIZATIONS
		 *********************************************************************************************************************************************/
		public function initialize():void
		{			
			_sdc = ServerDataController.getInstance();
			_popUIManager = PopUpUIManager.getInstance();
			initEventSatellite();
			//initPopupEventManager();			

			initIsoView();
			initGridIsoScene();
			initIsoScene();
			initIsoGrids();
			initPathGrid();
			initWallFloor();
			initZoomManager();
			initPanManager();
			initCharacterNodeManager();			
			addStageListeners();
			addRingCommand();
			extractInventoryData();			
			initTooltipManager();
			addDropManager();
			//setAllFloorsSelected();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;			
		}
		
		public function destroy():void 
		{
			_sdc = null;
			removeRingCommand();
			_popUIManager = null;
			clearEventSatellite();
			clearOfficeObjects();			
			clearIsoScene();
			clearIsoGrid();
			clearGridIsoScene();
			clearPathGrid();
			clearFloorWall();
			clearZoomManager();
			clearPanManager();
			clearCharacterNodeManager();
			clearStageListener();
			clearDropManager();
		}
		
		/*---------------------------------------------------------------------------Methods------------------------------------------------------------------*/
		
		//private function initPopupEventManager():void{
			//_popupEventManager = new PopUpManagerEvent();
			//_popupEventManager.addListeners();
		//}
		
		//private function removePopUpEventManager():void 
		//{			
			//_popupEventManager.removeListeners();
			//_popupEventManager = null;
		//}
		
		private function addDropManager():void 
		{
			_dropItemManager = DropItemManager.getInstance();
			_dropItemManager.init( _view, _scene, stage );
			stage.addChild( _dropItemManager );
		}
		
		private function clearDropManager():void 
		{
			if ( _dropItemManager != null ) {
				if ( this.contains( _dropItemManager ) ) {
					this.removeChild( _dropItemManager );
					_dropItemManager = null;
				}
			}
		}
		
		private function extractInventoryData():void
		{
			var runingOn:String = Capabilities.playerType;
			if (runingOn != 'StandAlone')
			{
				if (!_gd.inventoryItemDataLoaded)
				{			
					_sdc.getInventoryList();
				}
			}
			
			if (!_gd.inventoryThumbImagesLoaded)
			{
				_imageExtractor = ImageExtractor.getInstance();
				_imageExtractor.extractXml();
			}
		}		
		
		private function initIsoView():void
		{
			_view = new IsoView();			
			normalScreenIsoView();
		}
		
		private function normalScreenIsoView():void 
		{			
			
			var runningOn:String = Capabilities.playerType;
			trace( "[IsoRoom]: check capabilities", runningOn );
			//PlugIn when 1/2			
			
			if( runningOn != 'StandAlone' ){				
				_view.setSize(_gd.offsetWidth, _gd.offsetHeight );
				trace( "[ IsoRoom ]online mode..." );
			}else{				
				//_view.setSize(760, 630);			
				_view.setSize(1600, 900);
				trace( "stand alone mode..." );
			}			
			
			_view.clipContent = true;
			_view.centerOnPt(new Pt(200, 200, 0));			
			addChild(_view);
			
			_view.x = 0;
			_view.y = 0;
			
			_bgImg = new BackgroundImage();
			
			_view.backgroundContainer.addChild(_bgImg);
			_view.rangeOfMotionTarget = _bgImg;
			
			/* Apply the alignment to the background */
			var bgParam = {
				x:0,
				y:0,
				offsetX: 0,
				offsetY: 0
			}
			new FluidObject(_view,bgParam);
			
			_view.backgroundContainer.addChild(_bgImg);
			_view.rangeOfMotionTarget = _bgImg;	
		}
		
		private function fullScreenISoView():void 
		{				
			var runningOn:String = Capabilities.playerType;
			
			if( runningOn != 'StandAlone' ){				
				_view.setSize(_gd.screenWidth, _gd.screenHeight );				
			}else{				
				_view.setSize(1600, 900 );
			}			
			
			_view.clipContent = true;			
			_view.centerOnPt(new Pt( 200, 200, 0));
			addChild(_view);		
			
			/* Apply the alignment to the background */ //FluidObject
			var viewParam = {
				x:0,
				y:0,
				offsetX: 0,
				offsetY: 0
			}
			new FluidObject(_view,viewParam );
			
			_view.backgroundContainer.addChild(_bgImg);
			_view.rangeOfMotionTarget = _bgImg;	
		}
		
		private function clearIsoView():void 
		{
			if ( _bgImg != null ) {
				if ( _view.contains( _bgImg ) ) {
					_view.removeChild( _bgImg );
					_bgImg = null;
				}
			}
			
			if ( _view != null ) {
				if ( this.contains( _view ) ) {
					this.removeChild( _view );
					_view = null;
				}
			}		
		}
		
		private function initGridIsoScene():void
		{
			_gridScene = new IsoScene();
			_gridScene.hostContainer = this;
			_view.addScene(_gridScene);
		}
		
		private function clearGridIsoScene():void 
		{
			//if ( _gridScene != null ) {
				//if ( _view.contains( _gridScene ) ) {
					_view.removeScene( _gridScene );					
					_gridScene = null;
				//}
			//}
		}
		
		private function initIsoScene():void
		{
			_scene = new IsoScene();
			_scene.hostContainer = this;
			_view.addScene(_scene);
			addEventListener( Event.ENTER_FRAME, onRenderIsoRoom );
		}		
		
		private function clearIsoScene():void 
		{
			if ( _scene != null ) {
				//if ( _view.contains( _scene ) ) {
					_view.removeScene( _scene );
					_scene = null;
				//}
			}
			
			removeEventListener( Event.ENTER_FRAME, onRenderIsoRoom );
		}
		
		private function initIsoGrids():void
		{
			_grid = new IsoGrid();
			_grid.showOrigin = false;
			// switched to expansion
			_grid.setGridSize(_gd.expansion, _gd.expansion, 0);
			_grid.cellSize = _gd.CELL_SIZE;
			_gridScene.addChild(_grid);
		}
		
		private function clearIsoGrid():void 
		{
			if ( _grid != null ) {
				if ( _gridScene.contains( _grid ) ) {
					_gridScene.removeChild( _grid );
					_grid = null;
				}
			}
		}
		
		public function initPathGrid():void
		{		
			/*pathGrid = new Grid( _gd.GRID_LENGTH, _gd.GRID_WIDTH );
			trace( "[ ISOROOM ]: INIT GRID PATH", _gd.GRID_LENGTH, _gd.GRID_WIDTH , "friendView", _gd.friendView, "npcview", _gd.npcView  );*/
			//initWallFloor();
			
			// replaced the old way of determining grid length and width by the expansion variable
			_gd.pathGrid = new Grid( _gd.expansion, _gd.expansion );
			trace( "[ ISOROOM ]: INIT GRID PATH", _gd.expansion, _gd.expansion , "friendView", _gd.friendView, "npcview", _gd.npcView  );
		}
		
		private function clearPathGrid():void 
		{
			_gd.pathGrid = null;
		}
		
		private function initZoomManager():void
		{
			_zoomMngr = new ZoomManager(_view);
		}
		
		private function clearZoomManager():void 
		{
			_zoomMngr.removeListeners();
			_zoomMngr = null;
		}
		
		private function initPanManager():void
		{
			_panMngr = new PanManager(stage, _view);
		}
		
		private function initTooltipManager():void{
			_tooltipManager = MiniTooltipManager.instance;
			_gd.stage.addChild(_tooltipManager);
		}
		
		private function clearPanManager():void 
		{
			_panMngr.removeListeners();
		}
		
		/*---------------------------------------------------
		| Initialize Office Items like floor tiles and walls
		---------------------------------------------------*/
		public function initWallFloor():void
		{
			_floorMngr = new IsoFloorsManager(_scene , stage, _gd.pathGrid );
			_wallsMngr = new IsoWallsManager(_scene , stage );			
		}
		
		public function clearFloorWall():void 
		{
			_floorMngr.deleteFloors();
			_wallsMngr.deleteWalls();
		}		
		
		/*---------------------------------------------
		| Add Stage Listeners
		---------------------------------------------*/
		private function addStageListeners():void
		{
			_view.backgroundContainer.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundClick);
		}
		
		private function clearStageListener():void 
		{
			_view.backgroundContainer.removeEventListener(MouseEvent.MOUSE_DOWN, onBackgroundClick);
		}
		
		private function initEventSatellite():void
		{			
			_es = EventSatellite.getInstance();
			_es.addEventListener(ServerDataControllerEvent.HIRE_STAFF_COMPLETE, onHireStaffComplete);
			_es.addEventListener(InventoryEvent.SET_OFFICE_INVENTORY_ITEM, onSetOfficeInventoryItem);			
			_es.addEventListener(ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE, onShopItemBuyComplete);
			_es.addEventListener(ServerDataControllerEvent.REGISTER_OFFICE_ITEM_POS_COMPLETE, onShopItemRegistrationComplete);
			_es.addEventListener(CrewEvent.CLOSE, onCrewViewClose);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_CLICK, onCharacterClicked);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_PROGRESSBAREVENTDONE, onCharacterProgressDone);			
			
			//quest events						
			_es.addEventListener(IsoRoomEvent.ON_CLICK_FLOOR, onFloorClick);
			
			//new			
			_es.addEventListener(IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN, onStopPaning);			
			_es.addEventListener(IsoRoomEvent.ON_CLICK_WALL, onStopPaning);			
			
			//new ring command event
			_es.addEventListener(RingCommandEvent.ON_MOVE_OFFICE_OBJECT, onMoveOfficeObject);
			_es.addEventListener(RingCommandEvent.ON_DROP_OFFICE_OBJECT, onDropOfficeItemObject);
			_es.addEventListener(RingCommandEvent.ON_ROTATE_OFFICE_OBJECT, onRotateOfficeItemObject);
			_es.addEventListener(RingCommandEvent.ON_SELL_OFFICE_OBJECT, onSellOfficeItemObject);
			_es.addEventListener(RingCommandEvent.ON_PUT_TO_INVENTORY, onPutOfficeItemToInventory );
			
			// ring command listeners
			_es.addEventListener(RingCommandEvent.ON_STOP_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_CHEER_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_FAST_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_FIRE_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_PLAY_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_ACTION1_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_ACTION1_LOCK_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_ACTION2_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_ACTION2_LOCK_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_REST_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_SHOW_CONTESTANT_INFO, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_TRAIN_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_PUT_TO_INVENTORY_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_SHOP_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_MOVE_CONTESTANT, onContestantRingCommands);
			_es.addEventListener(RingCommandEvent.ON_STOP_RESTING_CONTESTANT, onContestantRingCommands);
			
			// listen when ring command has been removed
			_es.addEventListener(RingCommandEvent.ON_REMOVE_RING_COMMAND, onRingCommandRemoved);
			
			//new external image loading
			_es.addEventListener(ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE, onOfficeThumbImageLoadedComplete);
			_es.addEventListener(ServerDataControllerEvent.INVENTORY_DATA_LOAD_COMPLETE, onInventoryItemDataLoaded);			
			
			//_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTOBJECTROUTEREWARD, onShowFriendInteractionReward );
			//ON_DROP_REWARDS
			
			// check for when the characters or objects have been loaded
			_es.addEventListener(SSEvent.CHECK_OFFICECHARSTATE, checkOfficeCharState);
			
			//new loading heirarchy
			_es.addEventListener(IsoRoomEvent.ON_SET_OFFICE_ROOM_OBJECT_COMPLETE, onSetMyOfficeObjectComplete );
			_es.addEventListener(IsoRoomEvent.ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE, onSetFriendOfficeObjectComplete);			
			
			//test minigame data
			_es.addEventListener( ServerDataControllerEvent.ON_SET_MINIGAME_DATA_COMPLETE, onLoadMiniGame );
			_es.addEventListener( ServerDataControllerEvent.ON_SET_MINI_GAME_DATA_STORY_MODE_COMPLETE, onLoadMiniGameStoryMode );
			//_es.addEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_DATA_COMPLETE, onShowMiniGameData );			
			
			_es.addEventListener( PopUIEvent.ON_LOAD_SUB_WINDOW, onLoadSubWindow );
			_es.addEventListener( PopUIEvent.ON_LOAD_WINDOW, onLoadWindow );
			
			//test minigame
			//_es.addEventListener( ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_COMPLETE, onSetMiniGameResultComplete );
			
			//new on room expanded
			_es.addEventListener( IsoRoomEvent.ON_ROOM_TILE_EXPANDED, onRoomTileExpanded );				
			
			_es.addEventListener( IsoRoomEvent.ON_GAME_FULL_SCREEN, onFullScreenMode );
			_es.addEventListener( IsoRoomEvent.ON_GAME_NORMAL_SCREEN, onNormalScreenMode );			
			_es.addEventListener( SettingUIEvent.FULL_SCREEN_CLICK, onToggleFullScreen );
		}																														
		
		
		private function clearEventSatellite():void
		{			
			_es = EventSatellite.getInstance();
			_es.removeEventListener(ServerDataControllerEvent.HIRE_STAFF_COMPLETE, onHireStaffComplete);
			_es.removeEventListener(InventoryEvent.SET_OFFICE_INVENTORY_ITEM, onSetOfficeInventoryItem);			
			_es.removeEventListener(ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE, onShopItemBuyComplete);
			_es.removeEventListener(ServerDataControllerEvent.REGISTER_OFFICE_ITEM_POS_COMPLETE, onShopItemRegistrationComplete);
			_es.removeEventListener(CrewEvent.CLOSE, onCrewViewClose);
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_CLICK, onCharacterClicked);
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_PROGRESSBAREVENTDONE, onCharacterProgressDone);			
			
			//quest events						
			_es.removeEventListener(IsoRoomEvent.ON_CLICK_FLOOR, onFloorClick);
			
			//new			
			_es.removeEventListener(IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN, onStopPaning);			
			_es.removeEventListener(IsoRoomEvent.ON_CLICK_WALL, onStopPaning);			
			
			//new ring command event
			_es.removeEventListener(RingCommandEvent.ON_MOVE_OFFICE_OBJECT, onMoveOfficeObject);
			_es.removeEventListener(RingCommandEvent.ON_DROP_OFFICE_OBJECT, onDropOfficeItemObject);
			_es.removeEventListener(RingCommandEvent.ON_ROTATE_OFFICE_OBJECT, onRotateOfficeItemObject);
			_es.removeEventListener(RingCommandEvent.ON_SELL_OFFICE_OBJECT, onSellOfficeItemObject);
			_es.removeEventListener(RingCommandEvent.ON_PUT_TO_INVENTORY, onPutOfficeItemToInventory );
			
			// ring command listeners
			_es.removeEventListener(RingCommandEvent.ON_STOP_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_CHEER_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_FAST_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_FIRE_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_PLAY_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_ACTION1_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_ACTION1_LOCK_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_ACTION2_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_ACTION2_LOCK_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_REST_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_SHOW_CONTESTANT_INFO, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_TRAIN_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_PUT_TO_INVENTORY_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_SHOP_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_MOVE_CONTESTANT, onContestantRingCommands);
			_es.removeEventListener(RingCommandEvent.ON_REMOVE_RING_COMMAND, onRingCommandRemoved);
			_es.removeEventListener(RingCommandEvent.ON_STOP_RESTING_CONTESTANT, onContestantRingCommands);
			
			//new external image loading
			_es.removeEventListener(ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE, onOfficeThumbImageLoadedComplete);
			_es.removeEventListener(ServerDataControllerEvent.INVENTORY_DATA_LOAD_COMPLETE, onInventoryItemDataLoaded);			
			
			//_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTOBJECTROUTEREWARD, onShowFriendInteractionReward );
			//ON_DROP_REWARDS
			
			// check for when the characters or objects have been loaded
			_es.removeEventListener(SSEvent.CHECK_OFFICECHARSTATE, checkOfficeCharState);
			
			//new loading heirarchy
			_es.removeEventListener(IsoRoomEvent.ON_SET_OFFICE_ROOM_OBJECT_COMPLETE, onSetMyOfficeObjectComplete );
			_es.removeEventListener(IsoRoomEvent.ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE, onSetFriendOfficeObjectComplete);			
			
			//test minigame data
			_es.removeEventListener( ServerDataControllerEvent.ON_SET_MINIGAME_DATA_COMPLETE, onLoadMiniGame );
			//_es.removeEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_DATA_COMPLETE, onShowMiniGameData );			
			
			_es.removeEventListener( PopUIEvent.ON_LOAD_SUB_WINDOW, onLoadSubWindow );
			_es.removeEventListener( PopUIEvent.ON_LOAD_WINDOW, onLoadWindow );
			
			//test minigame
			//_es.removeEventListener( ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_COMPLETE, onSetMiniGameResultComplete );
			
			//new on room expanded
			_es.removeEventListener( IsoRoomEvent.ON_ROOM_TILE_EXPANDED, onRoomTileExpanded );				
		}
		
		private function initFriendInteractionManager():void{
			_friendInteractionManager = new FriendInteractionManager(_scene, _view, _characterNodeManager.getAllCharNodes(), objectsAry);
			_friendInteractionManager.init();
		}
		
		private function checkOfficeCharState(ev:SSEvent):void{
			if (_gd.charactersLoaded && _gd.objectsLoaded){
				initFriendInteractionManager();
			}
		}
		
		private function onRingCommandRemoved (ev:RingCommandEvent):void{
			
			if ( _gd.lastCharacterClicked != null){
				var charNode:CharacterNode = _gd.lastCharacterClicked;
				if (charNode.action != GlobalData.CHARACTER_ACTION_MOVE && charNode.tempRandStop && !charNode.resting && charNode.action != GlobalData.CHARACTER_ACTION_TRAINING){
					_characterNodeManager.movement.startRandomMovementPerCharacter(charNode);
					charNode = null;
				}
			}
			//trace ("listening for ring command remove event");
		}
		
		private function onContestantRingCommands(ev:RingCommandEvent):void
		{
			trace ("ring command executed");
			var isoObject:IsoObject = getOfficeObjectData(_dragObject);
			var selectedCharNode:CharacterNode = _characterNodeManager.selectedCharNode;
			switch (ev.type)
			{
				case RingCommandEvent.ON_STOP_CONTESTANT: 
				{
					selectedCharNode.tempRandStop = false;
					//_characterNodeManager.stopRandomMovementPerCharacter(selectedCharNode);
					break;
				}
				case RingCommandEvent.ON_SOOTHE_CONTESTANT:
				{
					_characterNodeManager.action.setCharacterInteractionOnClick(selectedCharNode);
					break;
				}
				case RingCommandEvent.ON_CHEER_CONTESTANT: 
				{
					_characterNodeManager.action.setCharacterInteractionOnClick(selectedCharNode);
					_characterNodeManager.action.setFriendCharacterInteractionOnClick(selectedCharNode);
					break;
				}
				case RingCommandEvent.ON_FIRE_CONTESTANT: 
				{					
					var  charNode:CharacterNode = _characterNodeManager.selectedCharNode; 					
					if( charNode != null ){
						_sdc.fireCharacter(charNode.charID);
						_characterNodeManager.removeSingleCharacterFromList(charNode.charID);
						_characterNodeManager.selectedCharNode = null;
					}
					break;
				}
				case RingCommandEvent.ON_ACTION1_CONTESTANT: 
				{
					
					break;
				}
				case RingCommandEvent.ON_ACTION1_LOCK_CONTESTANT: 
				{
					
					break;
				}
				case RingCommandEvent.ON_ACTION2_CONTESTANT: 
				{
					
					break;
				}
				case RingCommandEvent.ON_ACTION2_LOCK_CONTESTANT: 
				{
					
					break;
				}
				case RingCommandEvent.ON_SHOW_CONTESTANT_INFO: 
				{
					// old avatar
					//selectedCharNode.showAvatarUI();
					_popUIManager.loadWindow(WindowPopUpConfig.CONTESTANT_INFORMATION_WINDOW);
					_es.dispatchEvent(new ContestantInformationEvent(ContestantInformationEvent.SHOW_INFOWINDOW, {charId:_characterNodeManager.selectedCharNode.charID}));
					break;
				}
				case RingCommandEvent.ON_TRAIN_CONTESTANT: 
				{
					// old training, placed in object selection
					/*if (_dragObject)
					{
						if (isoObject != null)
						{
							if (isoObject.type == GlobalData.ITEMCATEGORY_TRAINING && _characterAction != "" && _characterNodeManager.selectedCharNode.selected)
							{
								if (_characterNodeManager.characterTraining(isoObject, _characterAction))
								{
									_dragObject = null;
								}
							}
						}
					}*/
					deselectAllObjects();
					selectAllTrainingObject();
					_trainRestChar = _characterNodeManager.selectedCharNode;
					_trainRestChar.selected = true;
					break;
				}
				case RingCommandEvent.ON_PUT_TO_INVENTORY_CONTESTANT: 
				{
					if ( _dragObject == null ){						
						var  charNode:CharacterNode = _characterNodeManager.selectedCharNode; 					
						if ( charNode != null ){
							_sdc.placeCharToInventory( charNode.charID  );							
							_characterNodeManager.removeSingleCharacterFromList(charNode.charID);
							_characterNodeManager.selectedCharNode = null;
						}						
					}					
					break;
				}
				case RingCommandEvent.ON_FAST_CONTESTANT: 
				{
					
					break;
				}
				case RingCommandEvent.ON_MOVE_CONTESTANT: 
				{
						_floorMngr.floorsSelectable = true;
						selectedCharNode.tempRandStop = true;
						selectedCharNode.action = GlobalData.CHARACTER_ACTION_MOVE;
						_characterNodeManager.movement.stopRandomMovementPerCharacter(selectedCharNode);
						_characterNodeManager.characterMoved = selectedCharNode;
					break;
				}
				case RingCommandEvent.ON_STOP_RESTING_CONTESTANT: 
				{
					//_characterNodeManager.stop
					_characterNodeManager.action.stopRestingCharacter(selectedCharNode);
					break;
				}
				case RingCommandEvent.ON_REST_CONTESTANT:
				{
					/*if (_dragObject)
					{
						if (isoObject != null)
						{
							if (isoObject.type == GlobalData.ITEMCATEGORY_MACHINE && isoObject.subType == GlobalData.ITEMTYPE_MACHINE_REST && _characterNodeManager.selectedCharNode.selected && !_characterNodeManager.selectedCharNode.resting)
							{
								if (_characterNodeManager.characterRest(isoObject))
								{
									_dragObject = null;
								}
							}
						}
					}*/
					deselectAllObjects();
					selectAllRestObject();
					_trainRestChar = _characterNodeManager.selectedCharNode;
					_trainRestChar.selected = true;
					break;
				}
				case RingCommandEvent.ON_PLAY_CONTESTANT: 
				{
					_characterNodeManager.movement.startRandomMovementPerCharacter(selectedCharNode);
					selectedCharNode.tempRandStop = true;
					break;
				}
				case RingCommandEvent.ON_SHOP_CONTESTANT:
				{
					_popUIManager.loadWindow(WindowPopUpConfig.CHARSHOP_WINDOW);
					break;
				}
			}			
		}
		
		private function onCharacterProgressDone(ev:CharacterNodeEvent):void
		{
			clearAllSelectionAndAttr();
		}
		
		private function onCrewViewClose(ev:CrewEvent):void
		{
			_panMngr.stopPan();
		}
		
		private function onCharacterClicked(ev:CharacterNodeEvent):void
		{
			var charid:String = _characterNodeManager.selectedCharNode.charID;
			var tut:TutorialEvent = new TutorialEvent(TutorialEvent.CLICK_CONTESTANT);
			var charNode:CharacterNode = _characterNodeManager.selectedCharNode;
			var charData:Array = _gd.getCharDataOnCharID(charid);
			
			_es.dispatchESEvent(tut);
			_characterNodeManager.selection.deselectAll();
			// set character to idle

			if (charid != null)
			{
				trace("charid check1:", charid);
				GlobalData.instance.currentCharId = charid;
			}
			else
			{
				trace("charid check2:", charid);
			}
			_panMngr.stopPan();
			
			if (!_gd.friendView)
			{
				// select character for training
				if (!charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED)){
					charNode.selected;
				}
				
				var ringCommandEvent:RingCommandEvent = new RingCommandEvent(RingCommandEvent.ON_SHOW_RING_COMMAND);
				var obj:Object = new Object();
				var commands:Array = [];
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);
				
				// Soothing
				/*if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY))
				{
				commands.push(GlobalData.COMMAND_SOOTHE);
				}*/
				
				if (charNode.action == GlobalData.CHARACTER_ACTION_RESTING){
					// Avatar UI
					commands.push(GlobalData.COMMAND_INFO);
					
					// buy speed points
					//commands.push(GlobalData.COMMAND_FAST);
					
					// stop resting
					//commands.push(GlobalData.COMMAND_STOP_RESTING);
				
				}else if (charNode.action == GlobalData.CHARACTER_ACTION_TRAINING){
					// Avatar UI
					commands.push(GlobalData.COMMAND_INFO);						
				} else {
					commands.push(GlobalData.COMMAND_INFO);
					
					// training command
					if (!charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED)){
						commands.push(GlobalData.COMMAND_TRAINING);
					}
					// StressDown
					if (charNode.stressLevel > 0){
						commands.push(GlobalData.COMMAND_REST);
					}
					
					/*if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED))
					{	
						commands.push(GlobalData.COMMAND_CHEER);
					}*/
					
					// avatar shop
					commands.push(GlobalData.COMMAND_SHOP);
					
					// scrapped
					/*if (!_gd.friendView && charData[GlobalData.CHARLIST_WEARINGSPECIAL] == 1){
						// action 1
						if (charData[GlobalData.CHARLIST_ACTION1] != ""){
							commands.push(GlobalData.COMMAND_ACTION1_LOCK);
						} else {
							commands.push(GlobalData.COMMAND_ACTION1);			
						}
						
						// action2
						if (charData[GlobalData.CHARLIST_ACTION2] != ""){
							commands.push(GlobalData.COMMAND_ACTION2_LOCK);
						} else {
							commands.push(GlobalData.COMMAND_ACTION2);
						}
					}*/
					
					// random movement
					if (charNode.randomMode && charNode.tempRandStop)
					{
						commands.push(GlobalData.COMMAND_STOP);
					}
					else
					{
						commands.push(GlobalData.COMMAND_PLAY);
					}
					
					commands.push(GlobalData.COMMAND_MOVE_CONTESTANT);
					
					commands.push(GlobalData.COMMAND_FIRE);
					commands.push(GlobalData.COMMAND_INVENTORY_CONTESTANT );
				} 
				
				// old training mechanics
				/*if (_dragObject)
				{
					if (isoObject != null)
					{
						if (isoObject.type == GlobalData.ITEMCATEGORY_TRAINING && _characterAction != "" && _characterNodeManager.selectedCharNode.selected)
						{
							commands.push(GlobalData.COMMAND_TRAINING);
						}
						else if (isoObject.type == GlobalData.ITEMCATEGORY_MACHINE && isoObject.subType == GlobalData.ITEMTYPE_MACHINE_REST && _characterNodeManager.selectedCharNode.selected && !_characterNodeManager.selectedCharNode.resting)
						{
							commands.push(GlobalData.COMMAND_REST);
						}
					}
				}	*/			

				// stop and start random movement
				/*if (charNode.randomMode)
				{
					commands.push(GlobalData.COMMAND_STOP);
				}
				else
				{
					commands.push(GlobalData.COMMAND_PLAY);
				}*/
				
				obj.commands = commands;
				_es.dispatchESEvent(ringCommandEvent, obj);
				//_sdc.soothChar( charid, _gd.myFbId );
			}else {
				//_sdc.soothChar( charid, _gd.selectedFriendFbId );
				ringCommandEvent = new RingCommandEvent(RingCommandEvent.ON_SHOW_RING_COMMAND);
				obj = new Object();
				commands = [];
				isoObject = getOfficeObjectData(_dragObject);
				
				// StressDown
				if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED))
				{
					trace ("cheered");
					commands.push(GlobalData.COMMAND_CHEER);
				}
				commands.push(GlobalData.COMMAND_INFO);
				obj.commands = commands;
				
				_es.dispatchESEvent(ringCommandEvent, obj);
				trace ("dispatched command");
				//_sdc.soothChar( charid, _gd.myFbId );				
				
				if( _gd.isChallenge ){
					_gd.selectedFriendCid = charid;
					_popUIManager.loadWindow( WindowPopUpConfig.CONTESTANT_SELECION_WINDOW );
					trace( "[ISoRoom]: allow to challenge" );
				}else {
					trace( "[ISoRoom]: not allow to challenge" );
				}
			}
			_characterNodeManager.movement.stopRandomMovementPerCharacter(charNode);
		}
		
		private function onBackgroundClick(ev:MouseEvent):void
		{
			if (_gd.currentInterAction != "move" && _gd.currentInterAction != "buy" && _gd.currentInterAction != "set" && _dragObject != null )
			{
				_characterNodeManager.hideAvatarUI();
				clearAllSelectionAndAttr();
				_dragObject = null;
			}
			
			// remove selected
			_characterNodeManager.selection.deselectAll();
			delectAllOfficeObject();
		}
		
		private function initCharacterNodeManager():void
		{
			_characterNodeManager = new CharacterNodeManager(_scene, _view, objectsAry);
			_characterNodeManager.init();
		}
		
		private function clearCharacterNodeManager():void 
		{
			if (  _characterNodeManager != null ) {
				_characterNodeManager.removeAllCharacters();
				_characterNodeManager.removeCharacterListeners();
				_characterNodeManager = null;				
			}
		}
		
		private function initFloors():void
		{
			//if ( _floorMngr  == null ){
				_floorMngr = new IsoFloorsManager(_scene , stage, _gd.pathGrid);
				_wallsMngr = new IsoWallsManager(_scene ,stage);
			//}else {
				//_floorMngr.deleteFloors();
				//_floorMngr = new IsoFloorsManager(_scene ,stage  );
			//}		
		}	
		
		private function initWalls():void
		{
			//if ( _wallsMngr  == null ) {
				
			//}else {
				//_wallsMngr.deleteWalls();
				//_wallsMngr = new IsoWallsManager(_scene ,stage );
			//}
		}	
		
		public function addObject(obj:IsoObjectData):void
		{
			if (obj != null)
			{
				if (_dragObject != null)
				{
					_scene.removeChild(_dragObject);
				}
				
				var isoObject:IsoObject = new IsoObject(obj as IsoObjectData);				
				isoObject.instance.moveTo(isoObject.position.x * _gd.CELL_SIZE, isoObject.position.y * _gd.CELL_SIZE, isoObject.position.z);
				isoObject.x = isoObject.position.x * _gd.CELL_SIZE;
				isoObject.y = isoObject.position.y * _gd.CELL_SIZE;
				isoObject.z = isoObject.position.z;
				
				_scene.addChild(isoObject.instance);
				isoObject.showBubble();
				objectsAry.push(isoObject);
				
				if (isoObject.position.x >= 0 && isoObject.position.y >= 0)
				{
					if (isoObject.subType != "window"){
						_gd.pathGrid.setWalkable(isoObject.position.x, isoObject.position.y, false);
						_floorMngr.updatePathGrid(_gd.pathGrid);
					}
				}
				
				putToTile(isoObject.instance);
				isoObject.instance.addEventListener(MouseEvent.CLICK, onSelectOfficeObject);				
				_scene.render();
			}
		}
		
		public function buyNewObject(obj:*):void
		{
			if (_dragObject != null)
			{
				_scene.removeChild(_dragObject);
			}
			
			var isoObject:IsoObject = new IsoObject(obj as IsoObjectData);
			
			if( isoObject != null && isoObject.instance != null ){
				_scene.addChild(isoObject.instance);
				addChild(isoObject);
				_dragObject = isoObject.instance;
				
				//for udating player cash or star
				//if (isoObject.coin != 0)
				//{
					//_sdc.setPlayerCoin(-isoObject.coin);
				//}
				//
				//if (isoObject.star != 0)
				//{
					//_sdc.setStarPoint(-isoObject.star);
				//}
				
				trace("check data isoObject eid", isoObject.entryid, "id", isoObject.id);
				objectsAry.push(isoObject);			
				_gd.currentInterAction = "buy";			
				isoObject.moving = true;			
				addEventListener(Event.ENTER_FRAME, onDragOfficeObject , false, 0, true );
				isoObject.instance.addEventListener(MouseEvent.CLICK, onSelectOfficeObject);			
				_scene.render();
			}
		}
		
		/*--------------------------------------------------------------------
		|	PUBLIC METHOD FOR UPDATING CHARACTER SPRITE DEFINITIONS
		--------------------------------------------------------------------*/
		private function clearAllSelectionAndAttr():void
		{
			if( _dragObject == null ){
				_gd.currentInterAction = "";
				_characterAction = "";
				deselectAllObjects();
				_characterNodeManager.selection.deselectAll();
			}
		}
		
		private function deselectAllObjects():void
		{
			for (var i:int = 0; i < objectsAry.length; i++)
			{
				objectsAry[i].deselected();
			}
		}
		
		private function addRingCommand():void
		{
			_ringCommand = new RingCommand();
			_popUIManager.addChild(_ringCommand);
		}
		
		private function removeRingCommand():void
		{
			if (_ringCommand != null)
			{
				if (_popUIManager.contains(_ringCommand))
				{
					_popUIManager.removeChild(_ringCommand);
					_ringCommand = null;
				}
			}
		}	
		
		private function expandAndUpdateRoom():void 
		{			
			initPathGrid();
			_gd.officeId = _gd.myFbId;
			_sdc.updateHomeViewData();
			_sdc.updateMyCharlist();					
		}
		
		private function loadMinigame():void {
			trace( "[ISOROOM]: load MiniGame.......................... now!! >>" );			
			_popUIManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );								
			_sdc.loadMiniGame( GlobalData.instance.selectionProgram );
		}
		
		/*---------------------------------------------------------------------------Setters------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Getters------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		
		/******************************************************************************************************************************************
		 |	EVENT HANDLERS
		 *******************************************************************************************************************************************/
		private function onFloorClick(e:IsoRoomEvent):void
		{
			if( _gd.currentInterAction != "move" && _gd.currentInterAction != "buy" && _gd.currentInterAction != "set" && _dragObject != null  )
			{
				var floor:IsoFloorObject = e.target as IsoFloorObject; 
				_panMngr.stopPan();
				_characterNodeManager.hideAvatarUI();
				clearAllSelectionAndAttr();
				delectAllOfficeObject();
				deselectAllObjects();
				_dragObject = null;
			}
			var floor:IsoFloorObject = e.obj as IsoFloorObject; 
			
			// remove selected
			_characterNodeManager.selection.deselectAll();
			delectAllOfficeObject();
			
			// for character move
			if (_gd.pathGrid.getWalkable(floor.xPos / _gd.CELL_SIZE, floor.yPos / _gd.CELL_SIZE)){
				if (floor.selected && _characterNodeManager.characterMoved.action == GlobalData.CHARACTER_ACTION_MOVE){
					_floorMngr.floorsSelectable = false;
					floor.selected = false;
					
					var characterMoved:CharacterNode = _characterNodeManager.characterMoved;
					_characterNodeManager.movement.setCharacterPath(characterMoved, floor.xPos / _gd.CELL_SIZE, floor.yPos / _gd.CELL_SIZE);
				}
			}
		}
		
		private function updateOfficeObjectGridXY(_target:IsoSprite):void
		{
			var isoObject:IsoObject = getOfficeObjectData(_target);
			
			for (var i:int = 0; i < objectsAry.length; i++)
			{
				if (_target == objectsAry[i].instance)
				{
					objectsAry[i].x = _target.x;
					objectsAry[i].y = _target.y;
					objectsAry[i].gridX = _target.x / _gd.CELL_SIZE;
					objectsAry[i].gridY = _target.y / _gd.CELL_SIZE;
					// switched to expansion
					if (( objectsAry[i].gridX >= 0 && objectsAry[i].gridY >= 0) && (objectsAry[i].gridX < _gd.expansion && objectsAry[i].gridY < _gd.expansion) && _gd.pathGrid.getWalkable(objectsAry[i].gridX, objectsAry[i].gridY))
					{	
						if ( isoObject.type == "machine" && isoObject.subType == "income" ) {
							if ( objectsAry[i].gridX == 0 || objectsAry[i].gridY == 0 ) {
								_gd.isValidSpace = true;
								objectsAry[i].isValidSpace(true);
							}else {
								_gd.isValidSpace = false;
								objectsAry[i].isValidSpace(false);
							}
						}else if ( isoObject.subType == "window" || isoObject.subType == "door" ) {
							if ( objectsAry[i].gridX == 0 || objectsAry[i].gridY == 0 ) {
								_gd.isValidSpace = true;
								objectsAry[i].isValidSpace(true);
							}else {
								_gd.isValidSpace = false;
								objectsAry[i].isValidSpace(false);
							}
						}else {
							_gd.isValidSpace = true;
							objectsAry[i].isValidSpace(true);
						}
					}else{																		
						_gd.isValidSpace = false;
						objectsAry[i].isValidSpace(false);						
					}
					//trace("update gridX gridY", objectsAry[i].gridX, objectsAry[i].gridY, "isValid", _gd.isValidSpace, "current interaction", _gd.currentInterAction, "isDragging", _gd.isDragging);
					break;
				}
			}
		}
		
		private function getOfficeObjectData(_target:IsoSprite):IsoObject
		{
			var isoSpriteObj:IsoObject;
			for (var i:int = 0; i < objectsAry.length; i++)
			{
				if (_target == objectsAry[i].instance)
				{
					isoSpriteObj = objectsAry[i];
					break;
				}
			}
			return isoSpriteObj;
		}
		
		private function getObjectTile(_target:IsoSprite):IsoSprite
		{
			var _tile:IsoSprite;
			for (var i:int = 0; i < _floorMngr.floors_array.length; i++)
			{
				if (_floorMngr.floors_array[i].x == _target.x && _floorMngr.floors_array[i].y == _target.y)
				{
					_tile = _floorMngr.floors_array[i].instance;
				}
			}
			return _tile;
		}
		
		private function removeOfficeItemObject(isoSprite:IsoSprite):void
		{
			var isoObject:IsoObject;
			var len:uint = objectsAry.length;
			
			for (var i:int = 0; i < len; i++)
			{
				if (objectsAry[i].instance == isoSprite)
				{
					trace("found office item to remove1");
					if (objectsAry[i].instance != null)
					{
						isoObject = objectsAry[i];
						trace("found item to remove2");
						if (_scene.contains(objectsAry[i].instance))
						{
							_scene.removeChild(objectsAry[i].instance);
							objectsAry[i].instance = null;
							objectsAry.splice(i, 1);
							isoObject = null;
							isoSprite = null;
							_dragObject = null;
							break;
						}
					}
				}
			}
		}
		
		private function delectAllOfficeObject():void
		{
			var isoObject:IsoObject;
			var len:uint = objectsAry.length;
			
			for (var i:int = 0; i < len; i++)
			{
				isoObject = objectsAry[i];
				isoObject.deselected();
			}
		}
		
		//new
		private function setObjectView(entryid:String):void
		{
			trace("see===== entryid================>>>", entryid);
			for (var i:int = 0; i < objectsAry.length; i++)
			{
				trace("entr id search", entryid);
				if (entryid == objectsAry[i].entryid)
				{
					objectsAry[i].showDeskStaff();
					objectsAry[i].addObjectInteraction();
					trace("[ isoRoom  ] setView hire staff..................................");
					break;
				}
			}
			trace("see end ===== entryid================>>>", entryid);
		}
		
		public function rotateOfficeObject(instance:IsoSprite):void
		{
			trace("[ on rotate office object]:=========================>", instance);
			var len:uint = objectsAry.length;
			
			for (var i:int = 0; i < len; i++)
			{
				if (objectsAry[i].instance == instance)
				{
					var isoSprite:IsoObject = objectsAry[i];
					trace("object to rotate", isoSprite.type, "subtype", isoSprite.subType);
					isoSprite.rotate();
					updateOfficeObjectGridXY( isoSprite.instance );					
					_sdc.registerOfficeItemPosition(isoSprite.entryid, isoSprite.gridX, isoSprite.gridY, isoSprite.z, isoSprite.rotation, "rotate");
					break;
				}
			}
		}
		
		// EVENT HANDLER IF OBJECT ITEM IS BOUGHT
		private function onShopItemBuyComplete(e:ServerDataControllerEvent):void
		{
			if( _dragObject != null ){
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);
				if (_gd.isTutorialDone)
				{					
					_dropItemManager.dropItem( DropItemManagerConfig.EXP, isoObject.x, isoObject.y, isoObject.z , null, null, isoObject.exp );
				}else {
					trace( "[IsoRoom]: check type tut =======================================>>>1", isoObject.type );
					if ( isoObject.type == "staff" ) {
						trace( "[IsoRoom]: check type tut ======================================>>>2", isoObject.type );
						var tutEvent:TutorialEvent = new TutorialEvent(TutorialEvent.PLACE_STAFF);
						_es.dispatchESEvent(tutEvent);
					}
				}
				trace('*******************************BUYING ITEM ' + e.obj.entryid) + ' SUCCESSFUL*******************************';
				isoObject.entryid = e.obj.entryid;
				//addEventListener(Event.ENTER_FRAME, onDragOfficeObject , false, 0, true );
				trace("isoObject registration phase!! x", isoObject.x, "y", isoObject.y, "z", isoObject.z, "rot", isoObject.rotation, "entryid", isoObject.entryid);
				ServerDataController.getInstance().registerOfficeItemPosition(isoObject.entryid, isoObject.gridX, isoObject.gridY, isoObject.z, isoObject.rotation, "buy");
			}
		}
		
		// EVENT HANDLER IF OBJECT ITEM IS REGISTERED ON THE DATABASE
		private function onShopItemRegistrationComplete(e:ServerDataControllerEvent):void
		{
			var len:uint = objectsAry.length;
			for (var j:int = 0; j < len; j++)
			{
				if (objectsAry[j].entryid == e.obj.entryid)
				{
					var isoObject:IsoObject = objectsAry[j];
					isoObject.updateData(e.obj);
					
					if (e.obj.met == "buy")
					{
						isoObject.showBubble();
						isoObject.addObjectInteraction();
					}
					else if (e.obj.met == "move")
					{
						trace("regiser complete adding interaction............");
						isoObject.addObjectInteraction();
					}
					else if (e.obj.met == "rotate")
					{
						trace("regiser complete adding interaction............");
						isoObject.addObjectInteraction();
					}
					
					isoObject.updateTrainingArea();
					_gd.pathGrid.setWalkable(isoObject.gridX, isoObject.gridY, false);
					_floorMngr.updatePathGrid(_gd.pathGrid);
					
					//if ( isoObject.type == "staff" ) {
						//trace( "[IsoRoom]: check type tut ====>>>", isoObject.type );
						//var tutEvent:TutorialEvent = new TutorialEvent(TutorialEvent.PLACE_STAFF);
						//_es.dispatchESEvent(tutEvent);
					//}
					
					trace('*******************************REGISTRATION SUCCESSFUL*******************************');
					break;
				}
			}
			
			_dragObject = null;
		}
		
		
		private function removeToTile(target:IsoObject):void
		{
			_gd.pathGrid.setWalkable(target.gridX, target.gridY, true );	
			_floorMngr.updatePathGrid(_gd.pathGrid);
		}
		// REMOVE OBJECT FROM TILE'S COORDINATE
		//private function removeToTile(_target:IsoSprite):void
		//{
			//if (_target != null)
			//{
				//for (var i:int = 0; i < _floorMngr.floors_array.length; i++)
				//{
					//if (_target.x == _floorMngr.floors_array[i].x && _target.y == _floorMngr.floors_array[i].y)
					//{
						//_floorMngr.floors_array[i].occupied = 0;						
						//pathGrid.setWalkable(Math.floor(_target.x / _gd.CELL_SIZE), Math.floor(_target.y / _gd.CELL_SIZE), true);
					//}
				//}
				//_scene.render();
			//}
		//}
		
		// PUT OBJECT TO TILE'S COORDINATE
		private function putToTile(_target:IsoSprite):void
		{
			if (_target != null)
			{
				for (var i:int = 0; i < _floorMngr.floors_array.length; i++)
				{
					if (_target.x == _floorMngr.floors_array[i].x && _target.y == _floorMngr.floors_array[i].y)
					{
						//if (_floorMngr.floors_array[i].occupied == 0)
						//{
						_target.container.alpha = 1;
						_floorMngr.floors_array[i].occupied = 1;
						_gd.pathGrid.setWalkable(Math.floor(_target.x / _gd.CELL_SIZE), Math.floor(_target.y / _gd.CELL_SIZE), false);
						_floorMngr.updatePathGrid(_gd.pathGrid);
						break;
						//}
					}
				}
				_scene.render();
			}
		}	
		
		private function updateObjectRotation(_target:IsoSprite):void
		{
			if (_target != null)
			{
				var isoObject:IsoObject = getOfficeObjectData(_target);
				if (isoObject.subType == 'door' || isoObject.subType == 'window')
				{
					for (var i:int = 0; i < _wallsMngr.walls_array.length; i++)
					{
						if (_target.x == _wallsMngr.walls_array[i].instance.x && _target.y == _wallsMngr.walls_array[i].instance.y)
						{
							trace('found a match rotation');
							var _name:String = _wallsMngr.walls_array[i].name;
							var _i:int = _name.indexOf('_');
							var _slicedName:String = _name.slice(0, _i);
							switch (_slicedName)
							{
								case 'left':
									trace('LEFT WALL');
									//_target.container.scaleX = 1;
									isoObject.flip( false );
									break;
								case 'right':
									trace('RIGHT WALL');
									//_target.container.scaleX = -1;
									isoObject.flip( true );
									break;
							}
						}
					}
				}
			}
		}
		
		public function clearDragObject():void
		{
			if (_dragObject != null){
				_dragObject = null;
			}
			_gd.currentInterAction = "";
		}
		
		public function removeDragObject():void
		{
			trace( "remove drag object.................>>>>>>>>>1" );			
			//if (_gd.currentInterAction == "move")
			//{
				trace( "remove drag object.................>>>>>>>>>2" );
				if (_dragObject != null)
				{					
					trace( "remove drag object.................>>>>>>>>>3" );
					removeOfficeItemObject(_dragObject);
					_dragObject = null;
					_gd.currentInterAction = "";
					_gd.isDragging = false;
					trace( "remove drag object.................>>>>>>>>>4" );
				}				
			//}
		}
		
		/*---------------------------
		* mouse pointer functions
		-----------------------------*/
		
		public function createCursor(type:String):void
		{
			//_gd.currentInterAction = type;			
			if (_cursor == null)
			{
				_cursor = new Cursor();
				addChild(_cursor);
			}
			_cursor.showCursor(type);
		}
		
		public function removeCursor():void
		{
			_gd.currentInterAction = "";			
			if (_cursor != null)
			{
				if (this.contains(_cursor))
				{
					this.removeChild(_cursor);
					_cursor = null;
				}
			}
		}		
		
		public function clearOfficeObjects():void
		{
			var len:int = objectsAry.length;
			
			for (var i:int = 0; i < len; i++)
			{
				if (objectsAry[i].instance != null)
				{
					if (_scene.contains(objectsAry[i].instance))
					{
						objectsAry[i].destroy();
						_scene.removeChild(objectsAry[i].instance);
						objectsAry[i].instance = null;						
					}
				}
			}
			
			objectsAry = new Array();
			_scene.render();
		}
		
		private function onHireStaffComplete(e:ServerDataControllerEvent):void
		{
			trace(" [ isoRoom ] set view entry id", e.obj.entryid);
			_es.dispatchESEvent(new StaffEvent(StaffEvent.HIRED_NPC, {entryID: String(e.obj.entryid)}));
			setObjectView(e.obj.entryid);
		}	
		
		private function onSetOfficeInventoryItem(e:InventoryEvent):void
		{
			trace("[IsoRoom]on SetOfficeInventoryItem.........................................................");			
			var isoObject:IsoObject = new IsoObject(e.obj as IsoObjectData);
			_scene.addChild(isoObject.instance);
			isoObject.showBubble();
			
			_dragObject = isoObject.instance;
			trace("check data isoObject eid", isoObject.entryid, "id", isoObject.id);
			objectsAry.push(isoObject);
			
			_gd.currentInterAction = "set";
			isoObject.moving = true;
			_characterAction = "";
			_characterNodeManager.selection.deselectAll();
			deselectAllObjects();
			delectAllOfficeObject();
			_characterNodeManager.selection.deselectAll();
			isoObject.removeObjectInterAction();
			addEventListener(Event.ENTER_FRAME, onDragOfficeObject , false, 0, true );
			isoObject.instance.addEventListener(MouseEvent.CLICK, onSelectOfficeObject);
			_scene.render();			
		}	
		
		private function onStopPaning(e:IsoRoomEvent):void
		{
			_panMngr.stopPan();
		}
		
		private function onMoveOfficeObject(e:RingCommandEvent):void
		{
			//hgd
			if (_dragObject != null){
				var isoObject:IsoObject;
				isoObject = getOfficeObjectData(_dragObject);
			}
			//createCursor( "move" );
			trace("on click office object to interact onMOve 1...............>>>", _gd.currentInterAction , "isUsed",isoObject.isUsed  );
			if ( _dragObject != null && _gd.currentInterAction != "move" && _gd.currentInterAction != "buy" && _gd.currentInterAction != "set" && !isoObject.isUsed ){
				trace("onMOve 2................................>>>");				
				
				//if ( isoObject.subType == GlobalData.ITEMTYPE_MACHINE_INCOME ){					
				//}				
				
				_characterAction = "";
				_characterNodeManager.selection.deselectAll();
				deselectAllObjects();
				_gd.currentInterAction = "move";
				
				if (!_gd.friendView)
				{
					if (!isoObject.moving)
					{
						delectAllOfficeObject();
						_characterNodeManager.selection.deselectAll();
						
						isoObject.removeObjectInterAction();
						_sdc.placeToInvetory(isoObject.entryid);
						//removeToTile(isoObject.instance);
						removeToTile(isoObject);
						//pathGrid.setWalkable(isoObject.gridX, isoObject.gridY, true );
						isoObject.moving = true;
						//addEventListener(MouseEvent.MOUSE_MOVE, onDragOfficeObject);
						
						// remove the staff tag 
						if (isoObject.type == "staff"){
							isoObject.removeCurrentWalkable();
						}
						
						addEventListener(Event.ENTER_FRAME, onDragOfficeObject , false, 0, true );
						trace("moving click cmd move", isoObject.moving, "item entry", isoObject.entryid , "_gd.currentInterAction", _gd.currentInterAction );
					}
				}
			}
		}
		
		private function onSelectOfficeObject(e:ProxyEvent):void
		{
			
			trace("select office object......................>>");
			var currentSelected:IsoSprite = e.target as IsoSprite;
			
			//condition for click isoObject while you are still draging someobject
			if ( _gd.currentInterAction == "move" || _gd.currentInterAction == "set" )
			{
				var newIsoObject:IsoObject = getOfficeObjectData(currentSelected);
				var oldIsoObject:IsoObject = getOfficeObjectData(_dragObject);
				
				if( newIsoObject != null && oldIsoObject != null ){
					if (newIsoObject.entryid == oldIsoObject.entryid)
					{
						//_dragObject = e.target as IsoSprite;
						_dragObject = newIsoObject.instance;
					}else {
						//do nothing
						_dragObject = oldIsoObject.instance;
					}
				}else {
					//do nothing
					_dragObject = currentSelected;
				}
			}else {
				_dragObject = currentSelected;
				//_dragObject = e.target as IsoSprite;
			}			
			
			
			if( _gd.currentInterAction != "move" &&  _gd.currentInterAction != "set" && _gd.currentInterAction != "buy" ){
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);			
				//isoObject.activateProgressbar();			
				
				if (isoObject.type == "machine" && isoObject.subType == "rest")
				{
					if (_trainRestChar != null){
						if (_gd.currentIsoObject.select)
						{
							//_characterNodeManager.selectAllWithoutStatus(true);
							if (_characterNodeManager.action.characterRest(isoObject))
							{
								_dragObject = null;
								var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
								_es.dispatchESEvent( ringCommandEvent );
							}
						}
					}
					
					deselectAllObjects();
					_characterNodeManager.selection.deselectAll();
					
				}
				
				else if (isoObject.type == "training") // OBJECT TYPE : TRAINING
				{
					trace( "[ISoRoom]: select training object", _gd.currentInterAction );
					
					var trimName:String = StringUtilManager.getStringAndNumber( isoObject.name )
					trace( "[IsoRoom] isoObject name", isoObject.name , "trim", trimName );
					_sdc.getScene( "training_" + trimName + "_start" );
					
					var ifObjectHasTrainingInteraction:Boolean = false;
					switch (isoObject.subType)
					{
						case "health":
							ifObjectHasTrainingInteraction = true;
							break;
						case "intelligent": 
							ifObjectHasTrainingInteraction = true;
							break;
						case "acting": 
							ifObjectHasTrainingInteraction = true;
							break;
						case "sing": 
							ifObjectHasTrainingInteraction = true;
							break;
						case "attraction": 
							ifObjectHasTrainingInteraction = true;
							break;
						default: 
							ifObjectHasTrainingInteraction = false;
							break;
					}
					
					if (ifObjectHasTrainingInteraction)
					{
						_gd.currentInterAction = "_characterAction";
						
						var _action:String = isoObject.subType;
						
						switch (_action)
						{
							case "health": 
								_action = GlobalData.PLAYER_MOTIONSTRENGTH;
								break;
							
							case "intelligent": 
								_action = GlobalData.PLAYER_MOTIONINTEL;
								break;
							
							case "acting": 
								_action = GlobalData.PLAYER_MOTIONACTING;
								break;
							
							case "sing": 
								_action = GlobalData.PLAYER_MOTIONSINGING;
								break;
							
							case "attraction": 
								_action = GlobalData.PLAYER_MOTIONATTRACT;
								break;
							
							default: 
								_action = "";
								break;
						}
						
						trace('\nCHARACTER ACTION : ' + _characterAction);
						_characterNodeManager.hideAvatarUI();
						_characterAction = _action;
						if (_trainRestChar != null){
							if (_gd.currentIsoObject.select)
							{
								//_characterNodeManager.selectAllWithoutStatus();
								if (_characterNodeManager.action.characterTraining(isoObject, _characterAction))
								{
									_dragObject = null;
									var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
									_es.dispatchESEvent( ringCommandEvent );
								}
							}
						}
						deselectAllObjects();
						
						_characterNodeManager.selection.deselectAll();			
						_gd.currentInterAction = "";				
					}
				}
			}			
		}
		
		private function selectAllTrainingObject():void{
			var len:int = objectsAry.length;
			
			for (var x:int = 0; x<len; x++){
				var obj:IsoObject = objectsAry[x];
				if (obj.type == GlobalData.ITEMCATEGORY_TRAINING){
					obj.selected();
				}
			}
		}
		
		private function selectAllRestObject():void{
			var len:int = objectsAry.length;
	
			for (var x:int = 0; x<len; x++){
				var obj:IsoObject = objectsAry[x];
				if (obj.type == GlobalData.ITEMCATEGORY_MACHINE && obj.subType == GlobalData.ITEMTYPE_MACHINE_REST){
					obj.selected();
				}
			}
		}
		
		private function onDragOfficeObject(e:Event):void
		{			
			//trace( "[IsoRoom]: onDragNow _dragObject ", _dragObject, "_gd.currentInterAction" , _gd.currentInterAction  );			
			if (	( _dragObject != null && _gd.currentInterAction == "move") 
					|| (_dragObject != null && _gd.currentInterAction == "buy") 
					|| (_dragObject != null && _gd.currentInterAction == "set")
				)
			{
				//trace( "[ISoRoom]:  Draging object!!! 1" );
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);
				
				if (getOfficeObjectData(_dragObject).moving)
				{
					//trace( "[ISoRoom]:  Draging object!!! 2" );
					deselectAllObjects();
					var pt:Pt
					if ( isoObject.subType == "window" ) {
						if( isoObject.rotation == 0 ){
							pt = _view.localToIso(new Point( stage.mouseX + 30 , stage.mouseY + 60 ));
						}else {
							pt = _view.localToIso(new Point( stage.mouseX - 30 , stage.mouseY + 60 ));
						}
					}else if ( isoObject.subType == "door" ) {
						if( isoObject.rotation == 0 ){
							pt = _view.localToIso(new Point(stage.mouseX + 25 , stage.mouseY + 60 ));
						}else {
							pt = _view.localToIso(new Point(stage.mouseX - 25 , stage.mouseY + 60 ));
						}						
					}else {
						//pt = _view.localToIso(new Point(stage.mouseX, stage.mouseY + 15));
						//pt = _view.localToIso(new Point( ( stage.mouseX - 17.50 ) , stage.mouseY ) );
						pt = _view.localToIso(new Point(stage.mouseX, stage.mouseY));
					}
					
					_dragObject.moveTo(Math.floor(pt.x / _gd.CELL_SIZE) * _gd.CELL_SIZE, Math.floor(pt.y / _gd.CELL_SIZE) * _gd.CELL_SIZE, GlobalData.ISO_DRAG_OBJECT_DEPTH );					
					updateObjectRotation(_dragObject);
					_scene.render();
					updateOfficeObjectGridXY(_dragObject);
					_gd.isDragging = true;		
					
					
				}
			}
		}
		
		private function onDropOfficeItemObject(e:RingCommandEvent):void
		{
			trace("[ IsoRoom ]:Drop office Object here1........ isDraging", _gd.isDragging);
			if ((_dragObject != null && _gd.currentInterAction == "move") || (_dragObject != null && _gd.currentInterAction == "buy") || (_dragObject != null && _gd.currentInterAction == "set"))
			{
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);
				if (isoObject.moving)
				{
					trace("[ IsoRoom ]:Drop office Object here2........ isDraging", _gd.isDragging);
					if (_gd.isValidSpace)
					{
						trace("isoobject place successfully gridX", isoObject.gridX, "gridY", isoObject.gridY);
						_characterNodeManager.updateObjectArray(objectsAry);
						if( isoObject.subType == "door" || isoObject.subType == "window" ){
							_dragObject.moveTo(isoObject.x, isoObject.y, GlobalData.ISO_WALL_DOOR_DEPTH );
						}else {
							_dragObject.moveTo(isoObject.x, isoObject.y, GlobalData.ISO_OBJECT_DEPTH );
						}
						
						isoObject.moving = false;						
						putToTile(isoObject.instance);
						
						if (_gd.currentInterAction == "buy")
						{
							if (isoObject.coin != 0)
							{
								_sdc.setPlayerCoin(-isoObject.coin);
							}
							
							if (isoObject.star != 0)
							{
								_sdc.setStarPoint(-isoObject.star);
							}
							_sdc.buyItem(isoObject.id);
						}
						else{
							_sdc.registerOfficeItemPosition(isoObject.entryid, isoObject.gridX, isoObject.gridY, isoObject.z, isoObject.rotation, "move");														
						}
						if (isoObject.type == "staff"){
							isoObject.setWalkable();
						}
						_gd.isDragging = false;
						_gd.currentInterAction = "";
						//removeEventListener(MouseEvent.MOUSE_MOVE, onDragOfficeObject);
						removeEventListener(Event.ENTER_FRAME, onDragOfficeObject );
						trace( "[IsoRoom] remove OnDragOfficeObject enter frame=========================>" );
					}					
				}
			}
		}	
		
		private function onRotateOfficeItemObject(e:RingCommandEvent):void
		{
			if (!_gd.friendView)
			{
				if (_dragObject != null)
				{
					//createCursor( "rotate" );
					var isoObject:IsoObject = getOfficeObjectData(_dragObject);					
					delectAllOfficeObject();
					_characterNodeManager.selection.deselectAll();
					isoObject.removeObjectInterAction();
					rotateOfficeObject(isoObject.instance);
					removeCursor();
				}
			}
		}
		
		private function onSellOfficeItemObject(e:RingCommandEvent):void
		{
			if (_dragObject != null)
			{				
				var isoObject:IsoObject = getOfficeObjectData(_dragObject);
				if (!_gd.friendView && isoObject.isUsed == 0 /*&& isoObject.type != "staff"*/ )
				{
					trace( "[ISOROOM] sell isoObject sell price", isoObject.sellPrice );
					_sdc.setPlayerCoin( isoObject.sellPrice );
					
					//createCursor( "sell" );
					//removeToTile(isoObject.instance);
					removeToTile(isoObject);
					removeOfficeItemObject(isoObject.instance);
					_sdc.sellItem(isoObject.entryid);
					_characterNodeManager.selection.deselectAll();
					removeCursor();
					_dragObject = null;						
				}
			}
		}
		
		private function onOfficeThumbImageLoadedComplete(e:ImageExtractorEvent):void
		{
			_gd.inventoryThumbImagesLoaded = true;
		}
		
		private function onInventoryItemDataLoaded(e:ServerDataControllerEvent):void
		{
			_gd.inventoryItemDataLoaded = true;
		}		
		
		//private function onShowFriendInteractionReward(e:FriendInteractionEvent):void 
		//{			
			//trace( "[isoroom] show friend interact reward", e.params.isoObject.x, e.params.isoObject.y, e.params.isoObject.z  );
			//_dropItemManager.dropItem( DropItemManagerConfig.COIN, e.params.isoObject.x, e.params.isoObject.y, e.params.isoObject.z );			
		//}
		
		private function onSetMyOfficeObjectComplete(e:IsoRoomEvent):void 
		{			
			_characterNodeManager.updateObjectArray(objectsAry);
			if ( !_gd.isCharacterForcedUpdated ){
				_gd.isCharacterForcedUpdated = true;
				_characterNodeManager.onCharlistUpdate();
				//_characterNodeManager.startRandomMovement();	
			}
			
			_gd.npcView = false;
			_gd.friendView = false;

			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_SHOW_QUEST );
			_es.dispatchESEvent( isoRoomEvent );			
			
			trace( "[IsoRoom]: set my office complete.......................... myFbid", GlobalData.instance.myFbId );
			//get minigame data result
			_sdc.getMiniGameResult();
			_sdc.checkInviteFriends();
			
			if ( stage.displayState == StageDisplayState.NORMAL ) {
				normalScreenIsoView();
			}else {
				fullScreenISoView();
			}
			
			var runningOn:String = Capabilities.playerType;			
			if ( runningOn != 'StandAlone' && !_isShownNotification ) {
				_sdc.showNotification();
				_isShownNotification = true;
			}
			
			TweenLite.delayedCall( GlobalData.WINDOW_DELAY_TIME, removeDialogueWindow );
		}
		
		private function removeDialogueWindow():void 
		{
			_popUIManager.removeWindow( WindowPopUpConfig.DIALOGUE_WINDOW  );
			TweenLite.killDelayedCallsTo = removeDialogueWindow;
			
			if ( _gd.isChallenge ) {
				var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
				popUpUIEvent.obj.msg = GameDialogueConfig.SELECT_CONTESTANT_TO_CHALLENGE;
				_es.dispatchESEvent( popUpUIEvent );
			}
		}
		
		private function onSetFriendOfficeObjectComplete(e:IsoRoomEvent):void 
		{			
			_characterNodeManager.updateObjectArray(objectsAry);
			//_characterNodeManager.removeAllCharacters();	
			
			if ( _gd.isNpcTabSelected ){
				_gd.npcView = true;
				_gd.friendView = false;
				//_sdc.updateNpcCharlist();
				trace( "[IsoRoom]: load npc===========================>>>" );
			}else {
				_gd.npcView = false;
				_gd.friendView = true;
				//_sdc.updateFriendCharlist(GlobalData.instance.selectedFriendFbId);
			}		
			
			_sdc.updatePlayerHelpingEnergy( _gd.selectedFriendFbId );
			trace( _gd.pHE );
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_HIDE_QUEST );
			_es.dispatchESEvent( isoRoomEvent );
			
			if( _gd.npcView ){
				_sdc.questVisitFriendNpc( null );
			}else {
				_sdc.questVisitFriendNpc( _gd.selectedFriendFbId );
			}			
			
			if ( stage.displayState == StageDisplayState.NORMAL ) {
				normalScreenIsoView();
			}else {
				fullScreenISoView();
			}
			
			TweenLite.delayedCall( GlobalData.WINDOW_DELAY_TIME, removeDialogueWindow );
		}	
		
		private function onLoadMiniGame(e:ServerDataControllerEvent):void 
		{
			loadMinigame();			
		}
		
		private function onLoadMiniGameStoryMode(e:ServerDataControllerEvent):void 
		{
			loadMinigame();
		}
		
		private function onLoadWindow(e:PopUIEvent):void 
		{
			var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
			_es.dispatchESEvent( ringCommandEvent );
		}
		
		private function onLoadSubWindow(e:PopUIEvent):void 
		{
			var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
			_es.dispatchESEvent( ringCommandEvent );
		}
		
		private function onRoomTileExpanded(e:IsoRoomEvent):void
		{
			expandAndUpdateRoom();
		}
		
		private function onRenderIsoRoom(e:Event):void 
		{
			_scene.render();
			//trace( "[IsoRoom]: rendering..." ); fullscreen
		}
		
		private function onPutOfficeItemToInventory(e:RingCommandEvent):void 
		{			
			trace( "[IsoRoom]: put to inventory now 1" );
			if (_dragObject != null /*&& _characterNodeManager.selectedCharNode == null*/ ){
				var isoObject:IsoObject;
				isoObject = getOfficeObjectData(_dragObject);
				trace( "[IsoRoom]: put to inventory now 2" );
				
				if (  _gd.currentInterAction != "move" && _gd.currentInterAction != "buy" && _gd.currentInterAction != "set" && !isoObject.isUsed ) {
					trace( "[IsoRoom]: put to inventory now 3" );
					_characterAction = "";
					_characterNodeManager.selection.deselectAll();
					deselectAllObjects();				
					_gd.currentInterAction = "";
					
					if (!_gd.friendView)
					{
						trace( "[IsoRoom]: put to inventory now 4" );
						if (!isoObject.moving)
						{
							delectAllOfficeObject();
							_characterNodeManager.selection.deselectAll();
							
							isoObject.removeObjectInterAction();
							_sdc.placeToInvetory(isoObject.entryid);							
							removeToTile(isoObject);
							removeDragObject();
							trace( "[IsoRoom]: put to inventory now 5" );
						}
					}
				}				
			}		
		}
		
		private function onNormalScreenMode(e:IsoRoomEvent):void 
		{
			normalScreenIsoView();
		}
		
		private function onFullScreenMode(e:IsoRoomEvent):void 
		{
			fullScreenISoView();
		}
		
		private function onToggleFullScreen(e:SettingUIEvent):void 
		{
			if ( stage.displayState == StageDisplayState.NORMAL ) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				fullScreenISoView();
			}else {
				stage.displayState = StageDisplayState.NORMAL;
				normalScreenIsoView();
			}
		}
	}
}