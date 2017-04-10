package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.data.WorldMapModel;
	import flash.geom.Point;
	/**
	 * ...
	 * @author df
	 */
	public class ZoneDetail 
	{
		public var id:String
		public var zoneName:String;
		public var zoneNameNPC:String;
		
		public var zoneOverURL:String;
		public var zoneOutURL:String;	
		public var zoneZoomURL:String;	
		
		public var posX:int;
		public var posY:int;
		
		public var zoneFlagURL:String;
		public var zonePopupURL:String;
		public var zoneBossURL:String;
		
		public var zoneBossX:int;
		public var zoneBossY:int;
		
		public var zoneStatus:int;
		public var zoneReq:String;
		public var zoneLvlReq:int;
		//building data		
		public var arrayLvlDetail:Array = [];	
		public var arrayIsBoss:Array = [];	
		public var arrayBldgReq:Array = [];
		public var arrayBldgType:Array = [];	
		
		public var arrayBuildingID:Array = [];
		public var arrayBuildingName:Array = [];
		
		public var arrayBuildingMode:Array = [];	
		
		public var arrayBuildingURL:Array = [];
		public var arrayBuildingDimURL:Array = [];
		public var arrayBuildingBrightURL:Array = [];	
		
		public var arrayBuildingX:Array = [];
		public var arrayBuildingY:Array = [];
		public var arrayBuildingZ:Array = [];	
		
		public var arrayBuildingData:Array = [];
		public var mapBuildingArray:Array = [];		
		public var pointBuilding:Point = new Point;	
		
		public var lockURL:String;	
		
		private var _gd:GlobalData = GlobalData.instance;
		public function ZoneDetail(status:int = 0, req:String = null, lvlReq:int = 0, overURL:String = null, outURL:String = null, zoomURL:String = null, X:int = 0, Y:int = 0, zoneId:String = null, nameZone:String = null, nameNPC:String = null, zoneBuildingData:Array = null, popupURL:String = null, bossURL:String = null, bossX:int = 0, bossY:int = 0, flagURL:String = null) 
		{
			id		 = zoneId;
			zoneName = nameZone;
			zoneNameNPC	= nameNPC;
			
			zoneFlagURL	= flagURL;
			zoneOverURL	= overURL;
			zoneOutURL	= outURL;
			zoneZoomURL = zoomURL;
			
			posX		= X;
			posY		= Y;
			
			zoneStatus	= status;
			zoneReq		= req;
			zoneLvlReq	= lvlReq;
			
			zonePopupURL = popupURL;
			zoneBossURL	 = bossURL;
			zoneBossX	 = bossX;
			zoneBossY	 = bossY;

			mapBuildingArray	= zoneBuildingData;	
			
			lockURL = WorldMapModel.ABSOLUTE_PATH + _gd.mapLocking
			fillMapData();			
		}		
		
		private function fillMapData():void 
		{
			
			
			for (var i:int = 0; i < mapBuildingArray.length; i++ ) {
				arrayLvlDetail[i] = new LevelDetail;
				
				arrayBldgType[i]	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_TYPE];
				arrayBldgReq[i]		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_REQ];						
				
				arrayLvlDetail[i].npcID			= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCID];
				arrayLvlDetail[i].npcSing		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCSING];
				arrayLvlDetail[i].npcIntelligent= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCINTELLIGENT];
				arrayLvlDetail[i].npcHealth		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCHEALTH];
				arrayLvlDetail[i].npcActing		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCACTING];
				arrayLvlDetail[i].npcAttraction = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCATTRACTION];
				
				
				arrayLvlDetail[i].npcDefinition	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCBODYDEFINITION];				
				
				arrayLvlDetail[i].npcGender		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCGENDER];
				
				//trace(this, "RETURN arrayLvlDetail[i].npcGender:", mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCGENDER]);
				
				arrayLvlDetail[i].npcLvlNPC		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCLVL];
				arrayLvlDetail[i].npcNameNPC		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NPCNAME];				
				
				arrayLvlDetail[i].lvlRewardCoin	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_REWARDCOIN];
				arrayLvlDetail[i].lvlRewardExp	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_REWARDEXP];	
				
				arrayLvlDetail[i].lvlAP			= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_AP];
				arrayLvlDetail[i].lvlBossScript	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_BOSSSCRIPT]
				arrayLvlDetail[i].lvlCoin		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_COIN];
				arrayLvlDetail[i].lvlDifficulty	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_DIFFICULTY];
				arrayLvlDetail[i].lvlDuration	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_DURATION];
				arrayLvlDetail[i].lvlLevReq		= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_LVLREQ];	
				
				arrayLvlDetail[i].lvlProgram	= mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_CONTEST];		
				pointBuilding	  = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_POSITION];
				
				arrayBuildingID[i]	 = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_ID];
				arrayBuildingName[i] = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_NAME];
				arrayIsBoss[i]		 = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_ISBOSS];
				
				arrayBuildingURL[i]  		= _gd.absPath + mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_BLDGPNG];
				arrayBuildingDimURL[i] 		= _gd.absPath + mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_BLDGPNGDIM];
				arrayBuildingBrightURL[i]   = _gd.absPath + mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_BLDGPNGBRIGHT];				
				
				arrayBuildingX[i] = pointBuilding.x;//50 * (i + 1);
				arrayBuildingY[i] = pointBuilding.y;//50 * (i+1);
				arrayBuildingZ[i] = 0;
				
				arrayBuildingMode[i] = mapBuildingArray[i][GlobalData.MAPBUILDING_BUILDING_STATUS];	
				
				arrayBuildingData[i] = new BuildingDetail(arrayBuildingURL[i],arrayBuildingDimURL[i],arrayBuildingBrightURL[i], arrayBuildingX[i] , arrayBuildingY[i], arrayBuildingZ[i], arrayBuildingName[i], arrayBuildingID[i], arrayBuildingMode[i], arrayIsBoss[i], arrayLvlDetail[i], lockURL); 
			}			
		}	
		
		public function nullAllInstances():void {
			for (var i:int = 0; i < mapBuildingArray.length; i++ ) {
				arrayLvlDetail[i] = null;
				
				arrayBldgType[i]	= null;
				arrayBldgReq[i]		= null;							
				pointBuilding	 	= null;
				
				arrayBuildingID[i]	 = null;
				arrayBuildingName[i] = null;
				arrayIsBoss[i]		 = null;
				
				arrayBuildingURL[i]  		= null;
				arrayBuildingDimURL[i] 		= null;
				arrayBuildingBrightURL[i]   = null;			
				
				arrayBuildingX[i] = null;
				arrayBuildingY[i] = null;
				arrayBuildingZ[i] = null;
				
				arrayBuildingMode[i] = null;
				
				arrayBuildingData[i] = null;
			}
		}
	}

}