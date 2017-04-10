package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	/**
	 * ...
	 * @author df
	 */
	public class MapDetail 
	{
		public var mapID:String;
		public var mapName:String;
		public var mapURL:String
		public var mapSkyURL:String;
		
		public var buttonOutURL:String;
		public var buttonOverURL:String;
		
		public var arrayZoneData:Array
		public function MapDetail(btnNormalURL:String = null, btnOverURL:String = null, worldMapURL:String = null, worldMapID:String = null, worldMapName:String = null, worldMapSkyURL:String = null, zoneData:Array = null) 
		{
			mapID		= worldMapID;
			mapName		= worldMapName;
			mapURL		= worldMapURL;			
			mapSkyURL	= worldMapSkyURL;
			
			buttonOutURL	= btnNormalURL;
			buttonOverURL	= btnOverURL;
			
			arrayZoneData	= zoneData;			
		}
		
	}

}