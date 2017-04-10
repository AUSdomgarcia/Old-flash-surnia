package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.views 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.CharacterPanel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.MapManager;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.ZoneManager;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.data.WorldMapModel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author df
	 */	
	public class WorldMapView extends Sprite
	{	
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES/CONSTANTS
		 * ----------------------------------------------------------------------------------------------------------*/
		private var _model:WorldMapModel;		
		private var _zoneManager:ZoneManager;
		private var _mapManager:MapManager
		private var _callbackBuilding:Function;
		private var _callbackZone:Function;	
		private var _callbackClose:Function;
		private var _characterPanel:CharacterPanel;
		
		private var _gd:GlobalData;
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;
		private var _popUpUiManager:PopUpUIManager;
		
		private var _npcLevel:int;
		private var _npcActing:int;
		private var _npcAttraction:int;
		private	var _npcHealth:int;
		private	var _npcIntelligent:int;
		private	var _npcSing:int;
		private	var _npcGender:String;
		private	var _npcName:String;
		private	var _rivalDefinition:String;
		
		private var _dur:int;
		private var _bossMinigameDef:String;
		private var _program:String;
		
		private var _w:int;
		private var _h:int;
		
		public var objData:Object; 		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function WorldMapView(callbackClose:Function = null, callbackZone:Function = null, callbackBuilding:Function = null, model:WorldMapModel = null) 
		{
			_model		= model;	
			
			_callbackClose		= callbackClose;
			_callbackBuilding	= callbackBuilding;
			_callbackZone		= callbackZone;			
			_model.addEventListener(WorldMapEvent.DATA_LOAD_COMPLETE, onAllDataLoadComplete);			
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/				
		private function initialization():void 
		{
			objData	= new Object;
			
			_gd 	= GlobalData.instance;
			_sdc  	= ServerDataController.getInstance();
			_es 	= EventSatellite.getInstance();	
			_popUpUiManager = PopUpUIManager.getInstance();
			
			_mapManager 	= new MapManager(_model.mapDetail, _callbackClose,  _callbackZone, selectBuilding);	
			_mapManager.setSize(_w, _h);
		}	
		
		public function setSize(w:int, h:int):void {
			_w = w;
			_h = h;			
		}
		
		private function display():void 
		{			
			//test map				
			addChild(_mapManager);	
			
		}	
		
		private function showMap():void 
		{
			_mapManager.showMap(_model.mapDetail[0].mapID);			
		}
		
		public function nullAllInstances():void {
			if (_mapManager != null) {
				_mapManager.nullAllInstances();
				if (this.contains(_mapManager)) {
					removeChild(_mapManager);
				}				
				_mapManager = null;
			}
			trace("CLEAN", this);
		}	
		
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
			
		}	
		
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
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onAllDataLoadComplete(e:WorldMapEvent):void 
		{
			trace(this, "RETURN ALL DATA UI READY FOR DISPLAY");
			
			var _zoneDetail:Array = _model.zoneDetail;			
			
			initialization();
			display();
			showMap();			
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALLBACK SELECT BUILDING
		 * ----------------------------------------------------------------------------------------------------------*/
		public function selectBuilding(params:Object):void {
			objData = params;
			/*
			if (objData != null) {
			
				trace(this, "RETURN zoneID:", objData.zoneID);
				
				trace(this, "RETURN buildingID:",objData.buildingID);
				trace(this, "RETURN buildingName:",objData.buildingName);
				trace(this, "RETURN buildingStatus:",objData.buildingStatus);
				
				trace(this, "RETURN posX:",objData.posX);
				trace(this, "RETURN posY:",objData.posY);
				trace(this, "RETURN posZ:",objData.posZ);
				
				trace(this, "RETURN buildingURL:",objData.buildingURL);
				trace(this, "RETURN buildingDimURL:",objData.buildingDimURL);
				trace(this, "RETURN buildingBrightURL:", objData.buildingBrightURL);
				
				trace(this, "RETURN lvlProgram:", objData.lvlProgram);
					
				trace(this, "RETURN lvlAP:",objData.lvlAP);				
				trace(this, "RETURN lvlCoin:", objData.lvlCoin);
				trace(this, "RETURN lvlBossScript:",objData.lvlBossScript);
				trace(this, "RETURN lvlDuration:", objData.lvlDuration);				
				trace(this, "RETURN lvlDifficulty:", objData.lvlDifficulty);
				
				trace(this, "RETURN lvlLevReq:",objData.lvlLevReq);
				trace(this, "RETURN lvlRewardCoin:",objData.lvlRewardCoin);
				trace(this, "RETURN lvlRewardExp:",objData.lvlRewardExp);
				
				trace(this, "RETURN npcSing:",objData.npcSing);
				trace(this, "RETURN npcActing:",objData.npcActing);
				trace(this, "RETURN npcAttraction:",objData.npcAttraction);
				trace(this, "RETURN npcHealth:",objData.npcHealth);
				trace(this, "RETURN npcIntelligent:",objData.npcIntelligent);
				
				trace(this, "RETURN npcDefinition:",objData.npcDefinition);
				trace(this, "RETURN npcGender:",objData.npcGender);
				
				trace(this, "RETURN npcLvlNPC:",objData.npcLvlNPC);
				trace(this, "RETURN npcNameNPC:", objData.npcNameNPC);
				
				trace(this, "RETURN npcNameNPC:", objData.buildingIsBoss);				
			}	
			*/
			
			objData.minigameBossDef = _bossMinigameDef;
			
			displayCharacterPanel();					
		}
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
			
			_characterPanel.x = (_w / 2) - (_characterPanel.width/2); 
			_characterPanel.y = (_h / 2) - (_characterPanel.height/2); 				
			
			//set constant rival definition 			
			setSelectionPanel();
		}		
		
		//SET CHARACTER SELECTION PANEL DATA
		private function setSelectionPanel():void {	
			_npcLevel 		= objData.npcLvlNPC;
			_npcActing		= objData.npcActing;
			_npcAttraction	= objData.npcAttraction;
			_npcHealth		= objData.npcHealth;
			_npcIntelligent = objData.npcIntelligent;
			_npcSing		= objData.npcSing;
			_npcGender		= objData.npcGender;;
			_npcName		= objData.npcNameNPC;						
			_dur			= objData.lvlDuration;
			
			_program		= objData.lvlProgram;
			_rivalDefinition = objData.npcDefinition;						
			
			_characterPanel.setMode(CharacterPanel.CHALLENGE_STORY_MODE);		
			_characterPanel.setGameProgram(_program);				
			
			_characterPanel.setBossScript(objData.lvlBossScript);	
			_characterPanel.setPlayerAP(objData.lvlAP);
			_characterPanel.setGameTime(objData.lvlDuration);
			_characterPanel.setPlayerCoin(objData.lvlCoin);	
			
			_rivalDefinition = objData.npcDefinition;
			
			//USED IN MINIGAME BOSS DEFINITION
			_bossMinigameDef = _rivalDefinition + "-" + _program;
			
			//SET BOSS 0-STANDARD NPC OR 1-BOSS NPC
			if (objData.buildingIsBoss == "0") {
				_characterPanel.setRivalStat(_npcLevel, _npcActing, _npcAttraction, _npcHealth, _npcIntelligent, _npcSing, _npcGender, _npcName, String(_rivalDefinition));				
			}
			else {
				_characterPanel.setBossStat(int(_rivalDefinition),_npcLevel, _npcActing, _npcAttraction, _npcHealth, _npcIntelligent, _npcSing, _npcName, .7, .7);				
			}			
		}
		
		//LOADING MINIGAME
		private function callMinigame(characterStat:Object):void {	
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
			
			
			objData.charName		=characterStat.charName;
			objData.charLevel		=characterStat.charLevel;
			objData.charExp			=characterStat.charExp;
			objData.charGender		=characterStat.charGender;
			objData.charCondition	=characterStat.charCondition;
			objData.charGrade		=characterStat.charGrade;
			objData.definition		=characterStat.definition;
			objData.charPopular		=characterStat.charPopular;
			objData.charStress		=characterStat.charStress;
			objData.charHealth		=characterStat.charHealth;
			objData.charSing		=characterStat.charSing;
			objData.charIntelligence=characterStat.charIntelligence;
			objData.charActing		=characterStat.charActing;
			objData.charAttraction	=characterStat.charAttraction;			
			
			
			objData.charID = characterStat.charID;
			
			_callbackBuilding(objData);	
			
		}
	}
}