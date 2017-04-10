package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain 
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.data.WorldMapModel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.views.WorldMapView;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	/**
	 * ...
	 * @author df
	 */
	 [SWF(backgroundColor="0xec9900")]
	public class WorldMapMain extends Sprite
	{
		
		
		private var _model:WorldMapModel;
		private var _view:WorldMapView;		
		
		private var _w:int;
		private var _h:int;
		
		private var _gd:GlobalData;				
		private var _sdc:ServerDataController;
		private var _popUpUiManager:PopUpUIManager;
		
		//public static const GAME_WIDTH:int 	=  GameConfig.GAME_WIDTH;
		//public static const GAME_HEIGHT:int =  GameConfig.GAME_HEIGHT;
		
		//WorldMapMain.GAME_WIDTH
		public function WorldMapMain()
		{				
			trace(this, "RETURN TEST: 68707666022181!!!");			
			//init();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{			
			nullAllInstances();
		}
		
		public function init():void {
			initialization();			 
			display();					
		}		
		
		private function initialization():void 
		{
			_gd = GlobalData.instance;			
			_sdc  = ServerDataController.getInstance();
			_popUpUiManager = PopUpUIManager.getInstance();	
			
			_model = new WorldMapModel;
			_view = new WorldMapView(closeMap, selectZone, selectBuilding, _model);	
			
			
			if (stage.displayState == StageDisplayState.NORMAL) {
				trace(this, "RETURN _gd.offsetWidth/ _gd.offsetHeight:", _gd.offsetWidth, _gd.offsetHeight, stage.displayState);
				setSize(_gd.offsetWidth, _gd.offsetHeight + 60);
			}else {
				trace(this, "RETURN _gd.screenWidth/ _gd.screenHeight:", _gd.screenWidth, _gd.screenHeight, stage.displayState);
				setSize(_gd.screenWidth, _gd.screenHeight + 60);
			}	
			
		}		
		
		
		private function display():void
		{
			addChild(_view);
		}
		
		public function setSize(w:int, h:int):void {
			_w = w;
			_h = h;			
			
			if (_view != null) {
				_view.setSize(_w, _h);			
			}
		}
		
		public function nullAllInstances():void {
			if (_view != null) {
				_view.nullAllInstances();
				if (this.contains(_view)) {
					removeChild(_view);
				}
				_view = null;
			}
			
			if (_model != null) {
				_model.nullAllInstances();
				_model = null
			}			
			trace("CLEAN", this);
		}
		
		//CALLBACK CLOSE MAP
		private function closeMap():void {
			trace(this, "RETURN CLOSE MAP:");
			dispatchEvent(new WorldMapEvent(WorldMapEvent.GAME_CLOSE));
		}
		
		//CALLBACK SELECT ZONE
		private function selectZone(objData:Object):void {
			trace(this, "RETURN ZONE CLICK!");
		}
		
		//CALLBACK SELECT BUILDING
		private function selectBuilding(objData:Object):void {			
			if (objData != null) {
				//BUILDING DATA
				trace(this, "RETURN zoneID:", objData.zoneID);	
				
				trace(this, "RETURN buildingID:", objData.buildingID );			
				trace(this, "RETURN buildingName:",objData.buildingName);
				trace(this, "RETURN buildingStatus:",objData.buildingStatus);
				
				trace(this, "RETURN posX:",objData.posX);
				trace(this, "RETURN posY:",objData.posY);
				trace(this, "RETURN posZ:",objData.posZ);
				
				trace(this, "RETURN buildingURL:",objData.buildingURL);
				trace(this, "RETURN buildingDimURL:",objData.buildingDimURL);
				trace(this, "RETURN buildingBrightURL:", objData.buildingBrightURL);			
				
				trace(this, "RETURN buildingIsBoss:", objData.buildingIsBoss);
			
				//ROUND LEVEL DATA
				trace(this, "RETURN lvlProgram:", objData.lvlProgram);
				
				trace(this, "RETURN lvlAP:",objData.lvlAP);				
				trace(this, "RETURN lvlCoin:", objData.lvlCoin);
				
				trace(this, "RETURN lvlDifficulty:", objData.lvlDifficulty);
				trace(this, "RETURN lvlBossScript:",objData.lvlBossScript);
				trace(this, "RETURN lvlDuration:",objData.lvlDuration);
				trace(this, "RETURN lvlLevReq:", objData.lvlLevReq);
				
				trace(this, "RETURN lvlRewardCoin:",objData.lvlRewardCoin);
				trace(this, "RETURN lvlRewardExp:", objData.lvlRewardExp);			
				
				//NPC DATA
				trace(this, "RETURN npcID:",objData.npcID);
				trace(this, "RETURN npcSing:",objData.npcSing);
				trace(this, "RETURN npcActing:",objData.npcActing);
				trace(this, "RETURN npcAttraction:",objData.npcAttraction);
				trace(this, "RETURN npcHealth:",objData.npcHealth);
				trace(this, "RETURN npcIntelligent:", objData.npcIntelligent);
				
				trace(this, "RETURN npcDefinition:",objData.npcDefinition);
				trace(this, "RETURN npcGender:",objData.npcGender);
				
				trace(this, "RETURN npcLvlNPC:",objData.npcLvlNPC);
				trace(this, "RETURN npcNameNPC:", objData.npcNameNPC);
				
				trace(this, "RETURN minigameBossDef:", objData.minigameBossDef);
				trace(this, "RETURN npcID:", objData.npcID);
				
				//PLAYER CHARACTER DATA				
				trace(this, " RETURN charName : ", objData.charName);
				trace(this, " RETURN charLevel : ", objData.charLevel);
				trace(this, " RETURN charExp : ", objData.charExp);
				trace(this, " RETURN charGender :", objData.charGender);		
				trace(this, " RETURN charCondition :", objData.charCondition);
				trace(this, " RETURN charGrade :", objData.charGrade);
				
				trace(this, " RETURN definition :", objData.definition);
				trace(this, " RETURN charPopular :", objData.charPopular);
				trace(this, " RETURN charStress :", objData.charStress);
				trace(this, " RETURN charHealth :", objData.charHealth);
				trace(this, " RETURN charSing :", objData.charSing);
				trace(this, " RETURN charIntelligence :", objData.charIntelligence);
				trace(this, " RETURN charActing :", objData.charActing);
				trace(this, " RETURN charAttraction :", objData.charAttraction);
			
				trace(this, "RETURN charID:", objData.charID);
				trace(this, "RETURN npcID:", objData.npcID);
				
				_gd.selectionProgram = objData.lvlProgram;
				_sdc.setMiniGameDataStoryMode( objData.charID, objData.buildingID );
				//_sdc.setMiniGameData( objData.npcID, "npc_" + objData.npcNameNPC , _gd.selectionProgram , objData.lvlDuration ); 
				_popUpUiManager.removeWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );					
				
			}
		}
		
	}

}