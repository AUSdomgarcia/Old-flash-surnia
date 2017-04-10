package com.surnia.socialStar.data
{
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	
	/**
	 * 
	 * @author Hedrick David
	 * 
	 */
	
	public class XMLLinkData
	{
		private static var _instance:XMLLinkData;
		private var _gd:GlobalData = GlobalData.instance;
		
		//korean server
		//public static var mainLink:String = "https://1.234.2.179/socialstardev/"; 
		//https://surniabeta.com/socialstardev/
		//public static var mainLink:String = "https://surniabeta.com/socialstardev/"; 
		
		//local server
		//https://202.124.129.14/socialstars/
		//public static var mainLink:String = "https://202.124.129.14/socialstars/";
		//public static var mainLink:String = "https://202.124.129.14/socialstarsrez/"; 
		
		//public var mainLink:String;
		
		/**
		 * Online Links
		 */
		
		public var onlineFriendsData:String = _gd.absPath + "players/fl";
		public var onlinePlayerData:String = _gd.absPath + "players/ui";
		public var onlineCharHireData:String = _gd.absPath + "characters/create";
		public var onlineCharListData:String = _gd.absPath + "characters/charlist";
		public var onlineMapBuildingData:String = _gd.absPath + "buildings/all";
		public var onlineOfficesStoreData:String = _gd.absPath + "offices/shop";
		public var onlineOfficesInventoryData:String = _gd.absPath + "offices/inventory";
		public var onlineCharShopData:String = _gd.absPath + "public/data/charactershop.xml";
		public var onlineCharactersInventory:String = _gd.absPath + "characters/inventory";
		public var onlineOfficeStateData:String = _gd.absPath + "offices/state";
		public var onlineQuestListData:String = _gd.absPath + "quests/questlist";
		public var onlineLevelAPTableListData:String = _gd.absPath + "game/lvlap";
		public var onlineFriendRoutesData:String = _gd.absPath + "offices/getroutes";
		public var onlineCollectionListData:String = _gd.absPath + "offices/collectionlist";
		public var onlineMaterialListData:String = _gd.absPath + "offices/materiallist";
		public var onlineChallengeValuesData:String = _gd.absPath + "characters/challengevalues";
		
		/**
		 * Offline Links
		 */
		
		public var offlineFriendsData:String = "testXML/fl.xml";
		public var offlinePlayerData:String = "testXML/playerui.xml";
		public var offlineCharHireData:String = "testXML/createchar.xml";
		public var offlineCharListData:String = "testXML/charlist.xml";
		public var offlineMapBuildingData:String = "testXML/bldgs.xml";
		public var offlineOfficesStoreData:String = "testXML/officeshop.xml";
		public var offlineOfficesInventoryData:String = "testXML/officeinventory.xml";
		public var offlineCharShopData:String = "testXML/clothesstore.xml";
		public var offlineCharactersInventory:String = "testXML/clothesinventory.xml";
		public var offlineOfficeStateData:String = "testXML/officestate.xml";
		public var offlineQuestListData:String = "testXML/questlist.xml";
		public var offlineLevelAPListData:String = "testXML/lvlap.xml";
		public var offlineFriendRouteData:String = "testXML/friendroutes.xml";
		public var offlineCollectionListData:String = "testXML/collectionlist.xml";
		public var offlineMaterialListData:String = "testXML/materiallist.xml";
		public var offlineChallengeValuesData:String = "testXML/challengevalues.xml";
		
		public static function get instance():XMLLinkData{
			if (_instance == null){
				_instance = new XMLLinkData();
				return _instance;
			} else {
				return _instance;
			}
		}
		
		public function getOnOffLinks (type:String, isOnline:Boolean):String{
			switch(type)
			{
				case SSEvent.FRIENDXML_LOADED:
				{
					if (isOnline){
						return onlineFriendsData;
					} else {
						return offlineFriendsData;
					}
					break;
				}
				case SSEvent.PLAYERXML_LOADED:
				{
					if (isOnline){
						return onlinePlayerData;
					} else {
						return offlinePlayerData;
					}
					break;
				}
				case SSEvent.CREATECHARXML_LOADED:
				{
					if (isOnline){
						return onlineCharHireData;
					} else {
						return offlineCharHireData;
					}
					break;
				}
				case SSEvent.CHARLISTXML_LOADED:
				{
					if (isOnline){
						return onlineCharListData;
					} else {
						return offlineCharListData;
					}
					break;
				}
				case SSEvent.MAPBUILDINGXML_LOADED:
				{
					if (isOnline){
						return onlineMapBuildingData;
					} else {
						return offlineMapBuildingData;
					}
					break;
				}
				case SSEvent.OFFICESTOREXML_LOADED:
				{
					if (isOnline){
						return onlineOfficesStoreData;
					} else {
						return offlineOfficesStoreData;
					}
					break;
				}
				case SSEvent.OFFICEINVENTORYXML_LOADED:
				{
					if (isOnline){
						return onlineOfficesInventoryData;
					} else {
						return offlineOfficesInventoryData;
					}
					break;
				}
				case SSEvent.CLOTHESSTOREXML_LOADED:
				{
					if (isOnline){
						return onlineCharShopData;
					} else {
						return offlineCharShopData;
					}
					break;
				}
				case SSEvent.CLOTHESINVENTORYXML_LOADED:
				{
					if (isOnline){
						return onlineCharactersInventory;
					} else {
						return offlineCharactersInventory;
						
					}
					break;
				}
				case SSEvent.OFFICESTATEXML_LOADED:
				{
					if (isOnline){
						return onlineOfficeStateData;
					} else {
						return offlineOfficeStateData;
					}
					break;
				}	
				case SSEvent.QUESTLISTXML_LOADED:
				{
					if (isOnline){
						return onlineQuestListData;
					} else {
						return offlineQuestListData;
					}
					break;
				}
				case SSEvent.LEVELAPTABLEXML_LOADED:
				{
					if (isOnline){
						return onlineLevelAPTableListData;
					} else {
						return offlineLevelAPListData;
					}
					break;
				}
				case SSEvent.FRIENDROUTESXML_LOADED:
				{
					if (isOnline){
						return onlineFriendRoutesData;
					} else {
						return offlineFriendRouteData;
					}
					break;
				}
				case SSEvent.COLLECTIONLISTXML_LOADED:
				{
					if (isOnline){
						return onlineCollectionListData;
					} else {
						return offlineCollectionListData;
					}
					break;
				}
				case SSEvent.MATERIALLISTXML_LOADED:
				{
					if (isOnline){
						return onlineMaterialListData;
					} else {
						return offlineMaterialListData;
					}
					break;
				}
				case SSEvent.CHALLENGEVALUESXML_LOADED:
				{
					if (isOnline){
						return onlineChallengeValuesData;
					} else {
						return offlineChallengeValuesData;
					}
					break;
				}
			} 
			return "";
		}
		
		public function updateLinkData():void 
		{
			onlineFriendsData = _gd.absPath + "players/fl";
			onlinePlayerData = _gd.absPath + "players/ui";
			onlineCharHireData = _gd.absPath + "characters/create";
			onlineCharListData = _gd.absPath + "characters/charlist";
			onlineMapBuildingData = _gd.absPath + "buildings/all";
			onlineOfficesStoreData = _gd.absPath + "offices/shop";
			onlineOfficesInventoryData = _gd.absPath + "offices/inventory";
			onlineCharShopData = _gd.absPath + "public/data/charactershop.xml";
			onlineCharactersInventory = _gd.absPath + "characters/inventory";
			onlineOfficeStateData = _gd.absPath + "offices/state";
			onlineQuestListData = _gd.absPath + "quests/questlist";
			onlineLevelAPTableListData = _gd.absPath + "game/lvlap";
			onlineFriendRoutesData = _gd.absPath + "offices/getroutes";
			onlineCollectionListData = _gd.absPath + "offices/collectionlist";
			onlineMaterialListData = _gd.absPath + "offices/materiallist";
			onlineChallengeValuesData = _gd.absPath + "characters/challengevalues";
		}
	}
}