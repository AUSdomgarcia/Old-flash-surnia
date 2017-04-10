package com.surnia.socialStar.ui.popUI.views.miniMap.views
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	//import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.CharacterPanel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.BtnComp;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.Building;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.PopupRound;
	import com.surnia.socialStar.ui.popUI.views.miniMap.data.MiniMapModel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class MiniMapView extends Sprite
	{	
		//POPUP CLASS CONSTANTS			
		private static const POPUP_ROUND:int = 0;
		
		//add map Layer
		private var _mapLayer:Sprite;
		private var _entityLayer:Sprite;	
		
		//active building
		private var _activeBuilding:MovieClip;		
	
		//textfield
		private var txtTime:Array = [];
		private var hrWork:int = 5;
		private var minWork:int = 00;
		//Player DATA
		private var _playerID:String;
		private var _playerName:String;
		private var _playerLevel:int;;
		
		//Building DATA
		private var _building:Array = [];			
		private var _map:MovieClip;			
	
		private var _popup:PopupRound;
		
		private var mDown:Boolean = false;			
		private var isMapOver:Boolean = false;
		//locate last and new coordinate for map dragging
		private var posX:int;
		private var posY:int;
		private var lastX:int;
		private var lastY:int;
		private var newX:int;
		private var newY:int;		
		private var lastMapX:int;
		private var lastMapY:int;
		//last location of building
		private var locX:int;
		private var locY:int;		
		
		private var _parent:Sprite;
		private var _model:MiniMapModel;
		
		//main parent class
		private var _mainParent:Sprite;
		private var _backMC:BtnComp;		
		
		private var _mouseX:int;
		private var _mouseY:int;
		
		private var _stage:Stage;
		
		//Game frame number selected
		private var _program:String;
		private var _bossScript:String;
		private var _ap:int;
		private var _dur:int;
		private var _coin:int;	
		
		private var _levelReq:int;
		
		public var _npcIsBoss:int;
		public var _npcRewardCoin:int;
		public var _npcRewardExp:int;
	
		
		private var _npcDef:String;
		private var _npcActing:int;
		private var _npcHealth:int;
		private var _npcIntelligent:int;
		private var _npcLevel:int;
		private var _npcName:String;
		private var _npcAttraction:int;
		private var _npcSing:int;
		private var _npcGender:String;
		
		private var _bossFN:int;
		private var _isBossBattle:Boolean = false;
		
		private var _characterPanel:CharacterPanel;
		private var _charDefinition:String = "0100010101010101010101010101010101010101030303030303030303030303030303030303030303030303030303030303030303030303030303030101010101010101010101010101010101010101F160386D2C2CED8A4B792E2EFADCCCDB967C59A8632B3C2C595E38253025C67A64C67A64682C2DD06953DAE3C544453A000000000000000000000000000000000000";
		private var _rivalDefinition:String = "0100010101010101010101010101010101010101030303030303030303030303030303030303030303030303030303030303030303030303030303030101010101010101010101010101010101010101F160386D2C2CED8A4B792E2EFADCCCDB967C59A8632B3C2C595E38253025C67A64C67A64682C2DD06953DAE3C544453A000000000000000000000000000000000000";
		
		private var txtTest:TextField ;
		private var activeGame:MovieClip;			
		
		//TEXT FORMAT		
		private	var tf:TextFormat = new TextFormat;
		private	var gf:GlowFilter = new GlowFilter(0xFFCCCCCC, 1.0, 6, 6, 50);
		private var _gd:GlobalData;	
		
		//NEW EDITED BY JC
		//private var _miniGameEvent:MiniGameEvent;	
		private var _es:EventSatellite;
		private var _jsManager:JsManager;
		private var _sdc:ServerDataController;
		private var _popUpUiManager:PopUpUIManager;
	
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MiniMapView(stage:Stage, mainParent:Sprite, model:MiniMapModel)
		{		
			_stage = stage;
			_mainParent = mainParent;
			_model = model;	
			
			prepareControllers();
			intialization();			
			
			_model.addEventListener(MapEvent.LOAD_COMPLETE, onLoadComplete );		
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}	
		
		private function onRemove(e:Event):void {	
			trace("REMOVE :", this)
			nullAllInstances();
		}
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS	
		 * ----------------------------------------------------------------------------------------------------------*/		
		private function  prepareControllers():void 
		{
			_sdc  = ServerDataController.getInstance();
			_popUpUiManager = PopUpUIManager.getInstance();
			_es = EventSatellite.getInstance();	
			_gd = GlobalData.instance;
		}	
		
		private function intialization():void {						
			testDisplay();
		} 
		
		//SWITCH MAP BACKGROUND ANIMATION
		private function switchMapAnimation(val:Boolean = true):void {
			trace(this, "RETURN _mapLayer:",_mapLayer, " _map:",_map, " _backMC:",_backMC);
			if (_map != null) {
				if(_mapLayer != null){
					if(_mapLayer.contains(_map)){
						_mapLayer.removeChild(_map);
					}
				}
			}
			
			if (val == true) {				
				_map = _model._map;
				if(_backMC != null){
					_backMC.addListeners();
				}
				addListenerBuilding();
			}
			else {				
				_map = _model._mapNoAnim;				
				//TweenPlugin.activate([BlurFilterPlugin]);
				//TweenLite.to(_map, 1, {blurFilter:{blurX:10, blurY:10}});	
				if(_backMC != null){
					_backMC.removeListeners();
				}
			}	
			if (_mapLayer != null) {
				if(_map !=null){
					_mapLayer.addChild(_map);
				}
			}
			
		}	
		
		//SET GAME AND POPUP			
		private function addPopup():void {
			_popup = new PopupRound(this);			
			addPopupListeners();	
		}
		
		//POPUP CONTEST LISTENERS			
		private function addPopupListeners():void {		
			this.addEventListener(MapEvent.GAME_SELECT, onGameSelect);			
			this.addEventListener(MapEvent.POPUP_CLOSE, onPopupClose);
		}		
		
		//ADD BUILDINGS ON WORLD MAP		
		public function addBuilding(building:Array):void{			
			_building = building;	
		
			for (var i:int = 0; i < _building.length; i++ ) {				
				_entityLayer.addChild(_building[i]);			
			}	
			updateWorldMap();
			
			//add reference			
			switchMapAnimation(true);
			//addListenerBuilding();
		}	
		
		//SET PLAYER DATA	STATIC (TEST)		 
		public function setPlayerData():void {					
			_playerID 	= _model.playerID;
			_playerName = _model.playerName;
			_playerLevel = _model.playerLevel;	
		}		
		
		//DISPLAY MAP LAYER			
		private function displayMap():void {	
			//close button
			_backMC = new BtnComp(_model.close, _mainParent);			
			_backMC.buttonMode = true;
			_backMC.x = 678;
			_backMC.y = 585;	
			_backMC.gotoAndStop(1);
			
			//new instance layer
			_mapLayer = new Sprite;	
			_entityLayer = new Sprite;
			
			//add closebutton
			_entityLayer.addChild(_backMC);			
			
			addChild(_mapLayer);
			addChild(_entityLayer);								
			
			//test
			//_mapLayer.addEventListener(MouseEvent.MOUSE_MOVE, onMapMouseMove);
			//_mapLayer.addEventListener(MouseEvent.MOUSE_OUT, onMapMouseOut);
			//_mapLayer.addEventListener(MouseEvent.MOUSE_OVER, onMapMouseOver);
		}			
		
		private function testDisplay():void {
			//display ONLINE or OFFLINE
			
			txtTest = new TextField;
			txtTest.text =  _model.status;
			txtTest.width = 300;		
			addChild(txtTest);			
		}		
		
		//DISPLAY WARNING IF BUILDING NOT ACTIVE			
		private function displayWarning(building:Building):void {
			var txt:TextField = new TextField;
			var txtMC:MovieClip = new MovieClip;
			
			txt.selectable = false;
			txt.x = building.building.x - ((building.width /2) + (txt.width/2));
			txt.y = building.building.y;		
					
			txtMC.addChild(txt);
			_entityLayer.addChild(txtMC);
			
			tf.font = "Arial Bold";
			tf.bold = true;
			tf.size = 24;
			tf.color = 0xFFFFFF;
			
			txt.defaultTextFormat = tf;				
			txt.width = 410;
			txt.height = Number(tf.size + 5);
			txt.text = "You cannot challenge a contest yet!";			
			txt.filters = [gf];
			
			txtMC.alpha = 0;
			TweenLite.to(txtMC, 2, {
				y:-50, 
				alpha:1, 
				ease:Back.easeOut,
				onComplete: function():void {
					TweenLite.to(txtMC, .5, { 
						alpha:0, 
						onComplete: function():void {
							if (_entityLayer != null) {
								if(txtMC!=null){
									_entityLayer.removeChild(txtMC);							
								}
							}							
						}					
					} );					
				}					
			});
			
			if (txt.x < 0) {
				txt.x = 0;
			}
			if (txt.x + txt.width > GameConfig.GAME_WIDTH ) {
				
				txt.x = GameConfig.GAME_WIDTH  - txt.width;
			}			
		}			
		
		//ADD BUILDING LISTENRS (MOUSEHOVER, MOUSEOUT, MOUSECLICK)			
		public function addListenerBuilding():void {			
			for (var i:int = 0; i < _building.length; i++ ) {				
				_building[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				_building[i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				_building[i].addEventListener(MouseEvent.CLICK, onMouseClick);							
			}				
		}		
		
		//REMOVE BUILDING LISTENERS (MOUSECLICK)		 
		public function removeListenerBuilding():void{
			for(var i:int = 0; i < _building.length; i++ ){								
				_building[i].removeEventListener(MouseEvent.CLICK, onMouseClick);	
				_building[i].removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				_building[i].removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}			
		}
		
		//GET BUILDING ID
		public function getActiveBuildingID():String {
			var buildingID:String;
			for (var i:int = 0; i <  _building.length; i++ ) {
				if (_activeBuilding == _building[i].building ||  _activeBuilding == _building[i].buildingRed || _activeBuilding == _building[i].buildingGray) {
					buildingID = _building[i].id;
					trace(this, "ACTIVE DATA ", buildingID );
				}
			}				
			return buildingID;
		}		
		
		//UPDATE WORLD MAP DISPLAY		
		private function updateWorldMap():void {			
			for (var i:int = 0; i < _building.length; i++ ) {				
				//CHECK THE CURRENT BUILDING ROUND CONTEST
				var onClearBuilding:Boolean = checkReqComplete(_building[i].nameBuilding);
				//CHECK THE BUILDING REQ ROUND CONTEST PROGRESS IS COMPLETE
				var onClearReq:Boolean = checkReqComplete(_building[i].buildingReq);	
				
				//if (_building[i].lvlreq <= _playerLevel && onClearReq == true) {
				if (onClearReq == true) {
					if(onClearBuilding == false){
						_building[i].switchNormal();	
					}
					else {
						_building[i].switchFinished();
					}
				}
				else {
					_building[i].switchLocked();
				}
			}
		}		
		
		private function checkReqComplete(buildingNameReq:String):Boolean {
			var onComplete:Boolean = false;				
			for (var i:int = 0; i < _building.length; i++ ) {
				if (_building[i].nameBuilding == buildingNameReq) {
					if (_building[i].roundLenght == _building[i].roundFinishTotal) {
					//if (_building[i].roundLenght == _building[i].roundFinishTotal || _building[i].roundLenght == _building[i].currentGameFN ) {					
						onComplete = true;
						_building[i].clear = true;
					}
				}				
			}		
			
			if (buildingNameReq == "") {
				onComplete = true;
			}				
			return onComplete;
		}
		
		//MAP LAYER LISTENER (MAP GRAGGING, NOT IMPLEMENTED YET)
		private function addListenersMap():void{
			//listeners for map dragging
			_mapLayer.addEventListener(MouseEvent.MOUSE_DOWN, onMapMouseDown);
			_mapLayer.addEventListener(MouseEvent.MOUSE_UP,onMapMouseUp);				
		}				
		
		//UPDATE FOR MAP DRAGGING (REQUIRED STAGE, NOT IMPLEMENTED YET)			
		public function onUpdate():void {				
			if(mDown == true ){	
				
				newX = _stage.mouseX;
				newY = _stage.mouseY;
				
				posX =  newX - lastX;
				posY =  newY - lastY;				
				
				_mapLayer.x = posX;	
				
				if(posX > GameConfig.GAME_WIDTH - _mapLayer.width && lastMapX + posX <= 0){
					//_mapLayer.x = lastMapX + posX;
				}
				
				if(lastMapY + posY > _stage.stageHeight - _mapLayer.height && lastMapY + posY <= 0){
					_mapLayer.y =  lastMapY + posY;
				}
				
				if(_stage.mouseX < 0 || _stage.mouseX > _stage.stageWidth || _stage.mouseY < 0 || stage.mouseY > _stage.stageHeight ){					
					mDown = false;
				}
			}		
		}				
		
		//NULL ALL INSTANCES		
		public function nullAllInstances():void {
			trace("CLEAN ----------------------------------------------------------------------------------------:", this)
			removeListenerBuilding();
			
			//null textformat
			if (tf != null) {
				tf = null;			
			}
			// null glowfilter
			if (gf != null) {
				gf = null;			
			}
			
			//null characterPanel
			if (_characterPanel != null) {	
				_characterPanel.nullAllInstances(); 
				removeChild(_characterPanel);
				_characterPanel = null;				
			}			
			
			//null _popup
			if (_popup != null) {					
				//_popup.remove();
				//_popup = null;				
			}
			
			if (_backMC != null) {
				if(_entityLayer.contains(_backMC)){
					_entityLayer.removeChild(_backMC);	
					_backMC = null;
				}
			}		
			
			if (txtTest != null) {
				if (this.contains(txtTest)) {
					removeChild(txtTest);
					txtTest = null;
				}
			}
			
			if (_mapLayer != null) {
				if (this.contains(_mapLayer)) {
					removeChild(_mapLayer);
					_mapLayer = null;
				}
			}
			
			if (_entityLayer != null) {
				if (this.contains(_entityLayer)) {
					removeChild(_entityLayer);
					_entityLayer = null;
				}
			}		
		}		
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALL BACK 
		 * ----------------------------------------------------------------------------------------------------------*/		
		//WHEN SELECTED A CHARACTER IN CHARACTER SELECTION PANEL
		private function onSelectCharacter(e:CharacterPanelEvent):void {				
			//remove character panel
			if (_characterPanel != null) {
				if (this.contains(_characterPanel)) {
					_characterPanel.nullAllInstances();
					removeChild(_characterPanel);
					_characterPanel = null;					
				}
			}
			
			//set tuorial
			var X:int, Y:int;						
			X = 0;
			Y = 0;
			
			//CALL MINIGAME
			//onCloseCharPanel();
			callMinigame(e.params);				
		}
		
		//CLOSE CHARACTER SELECTION PANEL
		private function onCloseCharPanel(e:CharacterPanelEvent):void {
			//remove character panel
			if (_characterPanel != null) {
				if (this.contains(_characterPanel)) {
					_characterPanel.nullAllInstances();
					removeChild(_characterPanel);
					_characterPanel = null;
					trace(this, "REMOVE CHARACTER PANEL ON CLOSE",_characterPanel );
				}
			}	
			switchMapAnimation(true);
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLER	
		 * ----------------------------------------------------------------------------------------------------------*/
		//ON LOAD COMPLETE		
		private function onLoadComplete(e:MapEvent):void {	
			displayMap();				
			trace(this, "displayMap LOAD COMPLETE!!")
			setPlayerData();
			trace(this, "setPlayerData LOAD COMPLETE!!")			
			addPopup();
			trace(this, "add all Popup COMPLETE!!")
			addBuilding(_model.building);	
			trace(this, "BUILDING LOAD COMPLETE!!")
			//addListenersMap();	
			
			//test display
			testDisplay();
		}			
		
		//BUILDING ICON ANIMATIONS	(ON MOUSE OVER)		
		private function onMouseOver(e:MouseEvent):void {
			locX = e.target.x;
			locY = e.target.y;		
			
			for (var i:int = 0; i < _building.length; i++ ) {	
				if(MovieClip(e.target) == _building[i].buildingLock){
					TweenLite.to(_building[i].buildingLock, 10, { x: e.target.x - 5, y: e.target.y - 5, scaleX:1.1, scaleY:1.1, useFrames:true } );			
				}
				
				if (MovieClip(e.target) == _building[i].building || MovieClip(e.target) == _building[i].buildingGray) {
					if(_building[i].lockStatus == false){
						TweenLite.to(MovieClip(e.target), 10, { x: e.target.x - 5, y: e.target.y - 5, scaleX:1.1, scaleY:1.1, useFrames:true } );
					}
				}
			}
		}
		
		//BUILDING ICON ANIMATIONS	(ON MOUSE OUT)
		private function onMouseOut(e:MouseEvent):void {
			
			for (var i:int = 0; i < _building.length; i++ ) {				
				if (MovieClip(e.target) == _building[i].building || MovieClip(e.target) == _building[i].buildingGray) {
					TweenLite.to(MovieClip(e.target), 10, { x:_building[i].X , y:_building[i].Y, scaleX:1, scaleY:1, useFrames:true } );
				}		
				
				if (MovieClip(e.target) == _building[i].buildingLock) {
					TweenLite.to(MovieClip(e.target), 10, { x:_building[i].lockX , y:_building[i].lockY, scaleX:1, scaleY:1, useFrames:true } );
				}
			}
		}	
		
		//ON BUILDING CLICK		
		private function onMouseClick(e:MouseEvent):void {				
			_activeBuilding = MovieClip(e.target);				
			
			for (var i:int = 0; i < _building.length; i++ ) {
				//search active building in array			
				if (_activeBuilding == _building[i].building ||  _activeBuilding == _building[i].buildingLock || _activeBuilding == _building[i].buildingGray) {	
					
					if (MovieClip(e.target) == _building[i].buildingLock) {
						TweenLite.to(MovieClip(e.target), 10, { x:_building[i].lockX , y:_building[i].lockY, scaleX:1, scaleY:1, useFrames:true } );
					}
					else {
						TweenLite.to(MovieClip(e.target), 10, { x:_building[i].X , y:_building[i].Y, scaleX:1, scaleY:1, useFrames:true } );
					}					
					
					if (_building[i].lockStatus ==  false) {							
						trace(this, "CLICKED BUILDING NAME/CONTAINER/GAME :", _building[i].currentGameFN , " " , _building[i].container, " " , _building[i].roundContest);
						
						//set gameFN = all game type frame numbers available in building round contest
						//set currentGameFN = specific current round						
						_popup.setContestData(_building[i], _playerLevel);
						
						//SET NPC
						//_popup.setNPC(_building[i].npcFN);
						//DISPLAY POPUP
						_popup.show(_entityLayer, (GameConfig.GAME_WIDTH /2)- (_popup.width /2) , (GameConfig.GAME_HEIGHT  /2)-(_popup.height /2));						
						removeListenerBuilding();					
					}else {
						displayWarning(_building[i]);
					}						
				}				
			}			
		}	
		
		//CLICK CLOSE POPUP
		private function onPopupClose(e:MapEvent):void {
			//addListenerBuilding();		
			switchMapAnimation(true);
			_popup.remove();
		}	
		
		//LISTENER WHEN SELECT A GAME			
		private function onGameSelect(e:MapEvent):void {			
			_program		 = e.params.result;	
			_bossScript  = e.params.bossScript;
			
			_ap			 = e.params.ap;
			_dur		 = e.params.dur;
			_coin 		 = e.params.coin;						
			trace(this, "SELECTED GAME FN in POPUPROUND:", _program, " BOSS SCRIPT:", _bossScript);	
			
			_levelReq	 = e.params.levelReq;
			
			_npcDef		 = e.params.npcDef;
			_npcName	 = e.params.npcName;
			_npcLevel	 = e.params.npcLevel;
			_npcGender	 = e.params.npcGender;
			
			_npcSing	 = e.params.npcSing;
			_npcHealth	 = e.params.npcHealth;
			_npcActing	 = e.params.npcActing;
			_npcAttraction	= e.params.npcAttraction;
			_npcIntelligent	= e.params.npcIntelligent;
			
			_bossFN		  = e.params.bossFN - 1;
			_isBossBattle = e.params.bossBattle;
			
			_npcIsBoss	  = e.params.npcIsBoss;
			_npcRewardCoin= e.params.npcRewardCoin;
			_npcRewardExp = e.params.npcRewardExp;		
			
			trace(this, "RETURN ROUND DATA _npcGender:",_npcGender," _npcName:",_npcName, " _npcLevel:", _npcLevel, " _npcSing:",_npcSing, " _npcHealth:",_npcHealth, " _npcActing:",_npcActing, " _npcAttraction:",_npcAttraction, " _npcIntelligent:",_npcIntelligent, " _levelReq:",_levelReq, "_npcDef:", _npcDef);
			
			//remove popupround
			_popup.remove();
			//switch to stop map animation
			switchMapAnimation(false);
			_popup.removeListenersChallenger();				
			displayCharacterPanel();			
		}			
		
		
		private function setGender(gender:String = "Male"):int {			
			var genderNum:int = 0;
			if (gender == "Male") {
				genderNum = 0;
			}
			else {
				genderNum = 1;
			}			
			return genderNum;
			
			trace(this, "RETURN genderNum:", genderNum);
		}
		
		//LISTERS FOR MAP DRAGGING (REQUIRED STAGE, NOT IMPLEMENTED YET)			 
		private function onMapMouseDown(e:MouseEvent):void{	
			mDown = true;				
			//record last mouse coordinate
			lastX = _mouseX; 
			lastY = _mouseY;		
		}
		
		private function onMapMouseUp(e:MouseEvent):void{
			mDown = false;
			//record last map coordinate
			lastMapX = _mapLayer.x;
			lastMapY = _mapLayer.y;
		}	
		
		private function onMapMouseMove(e:MouseEvent):void {				
			//record the current mouse coordinate
			_mouseX = e.localX;
			_mouseY = e.localY;			
			onUpdate();
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHOD FOR CHARACTER SELECTION AND MINIGAME DATA
		 * ----------------------------------------------------------------------------------------------------------*/		
		
		//DISPLAY CHARACTER SELECTION PANEL
		private function displayCharacterPanel():void {	
			//remove character panel
			if (_characterPanel != null) {
				if (this.contains(_characterPanel)) {
					_characterPanel.nullAllInstances();
					removeChild(_characterPanel);
					_characterPanel = null;
						trace(this, "REMOVE CHARACTER PANEL ON INSTANTIATION",_characterPanel );
				}
			}
			_characterPanel = new CharacterPanel();	
			addChild(_characterPanel);
			
			_es.addEventListener(CharacterPanelEvent.PANEL_CLOSE, onCloseCharPanel)
			_es.addEventListener(CharacterPanelEvent.CHARACTER_SELECT, onSelectCharacter)
			
			_characterPanel.x = (GameConfig.GAME_WIDTH / 2) - (_characterPanel.width/2); 
			_characterPanel.y = (GameConfig.GAME_HEIGHT / 2) - (_characterPanel.height/2); 				
			
			//set constant rival definition 			
			setSelectionPanel();
		}
		
		//SET CHARACTER SELECTION PANEL DATA
		private function setSelectionPanel():void {			
			_characterPanel.setMode(CharacterPanel.CHALLENGE_STORY_MODE);		
			_characterPanel.setGameProgram(_program);
			_characterPanel.setBossScript(_bossScript);	
			_characterPanel.setPlayerAP(_ap);
			_characterPanel.setGameTime(_dur);
			_characterPanel.setPlayerCoin(_coin);	
			
			_rivalDefinition = _npcDef;			
			//SET BOSS 0-STANDARD NPC OR 1-BOSS NPC
			if (_npcIsBoss == 0) {
				_characterPanel.setRivalStat(_npcLevel, _npcActing, _npcAttraction, _npcHealth, _npcIntelligent, _npcSing, _npcGender, _npcName, _rivalDefinition);				
			}
			else {
				_characterPanel.setBossStat(_bossFN,_npcLevel, _npcActing, _npcAttraction, _npcHealth, _npcIntelligent, _npcSing, _npcName, .7, .7);				
			}	
		}
		
		//LOADING MINIGAME
		private function callMinigame(characterStat:Object):void {
			//switchMapAnimation(true);
			var _rivalGender:int = setGender(_npcGender);
			trace(this, "RETURN charGender:",characterStat.charGender);
			
			/*
			 *SELECTED CHARACTER DEFINITION AND STAT
			 */
			trace(this, " RETURN charName : ", characterStat.charName);
			trace(this, " RETURN charLevel : ", characterStat.charLevel);
			trace(this, " RETURN charExp : ", characterStat.charExp);
			trace(this, " RETURN charGender :", characterStat.charGender);		
			trace(this, " RETURN charCondition :", characterStat.charCondition);
			trace(this, " RETURN charGrade :", characterStat.charGrade);
			
			trace(this, " RETURN definition :", characterStat.definition);
			trace(this, " RETURN charPopular :", characterStat.charPopular);
			trace(this, " RETURN charStress :", characterStat.charStress);
			trace(this, " RETURN charHealth :", characterStat.charHealth);
			trace(this, " RETURN charSing :", characterStat.charSing);
			trace(this, " RETURN charIntelligence :", characterStat.charIntelligence);
			trace(this, " RETURN charActing :", characterStat.charActing);
			trace(this, " RETURN charAttraction :", characterStat.charAttraction);
			trace(this, " RETURN charID :", characterStat.charID );
			
			/*
			 * RIVAL/BOSS STAT SETTINGS
			 */
			
			//SELECTED GAME FRAME NUMBER IN POPUP ROUND CONTEST
			//selectionProgram
			trace(this, "RETURN _program :", _program);
			//BOSS NPC SCRIPT
			trace(this, "RETURN _bossScript :", _bossScript);
			//GAME COST AP
			trace(this, "RETURN _ap:", _ap);
			//GAME TIME DURATION SECONDS
			trace(this, "RETURN _dur:", _dur);
			//GAME COST COIN
			trace(this, "RETURN _coin:", _coin);
			//ROUND LEVEL REQUIREMENT
			trace(this, "RETURN _levelReq:", _levelReq);			
			
			//CHECKER IF BOSS RETURN 0-STANDARD NPC OR 1-BOSS NPC
			trace(this, "RETURN _npcIsBoss:", _npcIsBoss);
			//NPC BOSS TYPE
			trace(this, "RETURN _bossFN:", _bossFN);	
			
			//NPC BODY DEFINITION
			trace(this, "RETURN _npcDef:",_npcDef);
			//NPC NAME
			trace(this, "RETURN _npcName:", _npcName);
			//NPC LEVEL
			trace(this, "RETURN _npcLevel:", _npcLevel);
			//NPC GENDER
			trace(this, "RETURN _rivalGender:", _rivalGender);
			//NPC SING
			trace(this, "RETURN _npcSing:", _npcSing);
			//NPC HEALTH
			trace(this, "RETURN _npcHealth:",_npcHealth);
			//NPC ACTING
			trace(this, "RETURN _npcActing:",_npcActing);
			//NPC ATTRACTION
			trace(this, "RETURN _npcAttraction:",_npcAttraction);
			//NPC INTELLIGENT
			trace(this, "RETURN _npcIntelligent:", _npcIntelligent);
			//REWARD COIN
			trace(this, "RETURN _npcRewardCoin:", _npcRewardCoin);
			//REWARD EXP
			trace(this, "RETURN _npcRewardExp:", _npcRewardExp);
			
			//CALL SERVER DATA CONTROLLER LOAD MINIGAME							
			trace( "[loadMiniGame]:....................show me minigame!!!!!!!!!!!!!!!!!!!!!!!!!!! " );		
			
			_gd.selectionProgram = _program;
			_sdc.setMiniGameData( characterStat.charID, "npc_" + _npcName , _gd.selectionProgram , _dur );
			_popUpUiManager.removeWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );	
		}
	}
}