package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.data 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.BuildingComponent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.BuildingDetail;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.LevelDetail;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.MapDetail;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components.ZoneDetail;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author df
	 */
	public class WorldMapModel extends Sprite
	{		
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES/CONSTANTS
		 * ----------------------------------------------------------------------------------------------------------*/
		
		public static const ABSOLUTE_PATH:String = "https://202.124.129.14/socialstars/";
		public var rawBuildingData:Array = [];
		public var rawZoneData:Array = [];
		
		public var mapLenght:int = 1;	
		public var zoneLenght:int = 2;
		
		public var zoneDetail:Array = [];
		
		public var mapDetail:Array = [];	
		
		public	var mapZoneArray:Array = [];
		public	var mapBuildingArray:Array = [];	
		
		public	var mapID:Array = [];
		public	var mapName:Array = [];
		public	var mapLvReq:Array = [];
		public	var mapURL:Array = [];
		public	var mapSkyURL:Array = [];			
		public	var mapZone:Array = [];		
		
		//zone data		
		public var zoneID:Array = [];	
		public var zoneName:Array = [];
		public var zoneNameNPC:Array = [];
		
		public var zoneOverURL:Array = [];		
		public var zoneOutURL:Array = [];	
		public var zoneZoomURL:Array = [];
		
		public var zoneX:Array = [];
		public var zoneY:Array = [];
		
		public var zoneStatus:Array = [];
		public var zoneReq:Array = [];
		public var zoneLvlReq:Array = [];
		
		public var zonePopup:Array = [];
		public var zoneBoss:Array = [];
		public var zoneBossX:Array = [];
		public var zoneBossY:Array = [];	
		
		public var flagURL:String;	
		public var buttonOutURL:String;
		public var buttonOverURL:String;
		
		public var pointZone:Point = new Point;
		public	var pointBoss:Point = new Point;
			
		private var _loadCtr:int = 0;
		private var _loadTotal:int = 3;
		
		private var _gd:GlobalData = GlobalData.instance;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function WorldMapModel()
		{		
			//for test only
			//_gd.absPath = WorldMapModel.ABSOLUTE_PATH;
			
			extractData();				
		}
		
		private function extractData():void 
		{
			ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, XMLLinkData.instance.onlineMapBuildingData);
			EventSatellite.getInstance().addEventListener(SSEvent.MAPBUILDINGXML_LOADED, onXMLLoadedBuildingData);	
		}
		
		private function onXMLLoadedBuildingData(e:SSEvent):void 
		{			
			EventSatellite.getInstance().removeEventListener(SSEvent.MAPBUILDINGXML_LOADED, onXMLLoadedBuildingData);
			fillMapData();	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/		
		
		private function fillMapData():void {				
			
			buttonOutURL	= _gd.absPath + _gd.mapBackNorm;
			buttonOverURL	= _gd.absPath + _gd.mapBackOver;			
			
			for (var i:int = 0; i < GlobalData.instance.mapBuildingDataArray.length; i++ ) {				
				
				mapID[i]	 = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ID];
				mapName[i] 	 = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_NAME];	
				mapLvReq[i]	 = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_LVREQ]; //add
				mapURL[i]	 = _gd.absPath + GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_BACKGROUND];
				mapSkyURL[i] = _gd.absPath + GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_CLOUD];
				
				mapZone		 = _gd.getMinimapZoneData(mapID[i]);			
				
				fillMapZone(mapZone);
				mapDetail[i] = new MapDetail(buttonOutURL, buttonOverURL, mapURL[i], mapID[i], mapName[i],mapSkyURL[i], zoneDetail);
			}				
			dispatchEvent(new WorldMapEvent(WorldMapEvent.DATA_LOAD_COMPLETE));					
		}	
		
		public function clearZoneArray():void {
			for (var i:int = zoneDetail.length; i > 0; i-- ) {
				zoneDetail.pop();
			}
		}
		
		public function nullAllInstances():void {
			
			for (var i:int = 0; i < mapZoneArray.length; i++ ) {				
				
				pointZone	 = null;
				pointBoss 	 = null;
				
				zoneID[i]	= null;
				zoneName[i] = null;
				
				zoneNameNPC[i] =  null;
				
				zoneOutURL[i]  = null;
				zoneOverURL[i] = null;			
				zoneZoomURL[i] = null;			
				
				zoneX[i] = null;
				zoneY[i] = null;	
				
				zonePopup[i] = null;
				zoneBoss[i]  = null;
				
				zoneBossX[i] = null;
				zoneBossY[i] = null;					
				
				zoneDetail[i].nullAllInstances();
				zoneDetail[i] = null;
			}				
			
			for (var j:int = 0; j < GlobalData.instance.mapBuildingDataArray.length; j++ ) {				
				
				mapID[j]	 = null;
				mapName[j] 	 = null;	
				mapLvReq[j]	 = null;
				mapURL[j]	 = null;
				mapSkyURL[j] = null;
				
				mapZone		 = null;						
				mapDetail[j] = null;
			}	
			
		}
		
		private function fillMapZone(zoneArray:Array):void 
		{			
			mapZoneArray = zoneArray;			
			
			
			clearZoneArray();
			flagURL		= _gd.absPath + _gd.mapRedFlag;					
			for (var i:int = 0; i < mapZoneArray.length; i++ ) {					
				pointZone	 = mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_ZONEOFFSET];
				pointBoss 	 = mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_NPCOFFSET];
				
				zoneID[i]	= mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_ID];
				zoneName[i] = mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_NAME];
				
				zoneNameNPC[i] =  mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_NPCNAME];
				
				zoneOutURL[i]  = _gd.absPath + mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_IMG0];
				zoneOverURL[i] = _gd.absPath + mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_IMG1];			
				zoneZoomURL[i] = _gd.absPath + mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_IMG2];			
				
				zoneX[i] = pointZone.x;
				zoneY[i] = pointZone.y;			
				
				zoneStatus[i]	= mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_STATUS];
				zoneReq[i]		= mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_REQ];
				zoneLvlReq[i]	= mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_LVLREQ];
				
				zonePopup[i] = _gd.absPath + _gd.mapBlueBoxPath;
				zoneBoss[i]  = _gd.absPath + mapZoneArray[i][GlobalData.MAPBUILDING_ZONE_NPCPNG];
				
				zoneBossX[i] = pointBoss.x; //=0;
				zoneBossY[i] = pointBoss.y;	//=0;				
				
				mapBuildingArray	= _gd.getMinimapBuildingData(zoneID[i]);					
				zoneDetail[i] = new ZoneDetail(zoneStatus[i], zoneReq[i], zoneLvlReq[i], zoneOverURL[i],zoneOutURL[i], zoneZoomURL[i],zoneX[i],zoneY[i], zoneID[i], zoneName[i],zoneNameNPC[i], mapBuildingArray, zonePopup[i], zoneBoss[i], zoneBossX[i], zoneBossY[i], flagURL);
				
			}				
		}	
	}
}