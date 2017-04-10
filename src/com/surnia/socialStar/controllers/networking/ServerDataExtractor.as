package com.surnia.socialStar.controllers.networking
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.utils.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.sampler.NewObjectSample;
	
	/**
	 * 
	 * Singleton Class. Access through "instance". 
	 * Extracts data from server or database and places
	 * the corresponding data to the global repository.
	 * Also allows access for batch data requests and updates. 
	 * 
	 * @author hedrick david
	 * 
	 */
	
	public class ServerDataExtractor extends EventDispatcher
	{
		
		private static var _instance:ServerDataExtractor;
		
		private var _jobLoaderQueue:Array = [];
		private var _jobTypeQueue:Array = [];
		
		/**
		 * 
		 * @return - this singleton class. 
		 * 
		 */		
		
		public static function get instance():ServerDataExtractor{
			if (_instance == null){
				_instance = new ServerDataExtractor();
				return _instance;
			} 
			return _instance;  
		}
		
		/**
		 * Updates the specified type of data.
		 *  
		 * @param updateType - the type of data to be updated. Use the GlobalData singleton instance.
		 * @param url - the link to the location of data.
		 * 
		 */		
		
		public function updateData(updateType:String, url:String):void{
			setIfTypeOfDataLoaded(updateType, false);
			_jobLoaderQueue.push(new URLLoader(new URLRequest(url)));
			var loaderMax:int = _jobLoaderQueue.length-1;
			_jobLoaderQueue[loaderMax].load;
			_jobLoaderQueue[loaderMax].addEventListener(Event.COMPLETE, onLoadComplete);
			_jobLoaderQueue[loaderMax].addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_jobTypeQueue.push(updateType);
		}
		
		/**
		 *
		 * Sets the boolean of the loaded data type to the specified value.
		 *  
		 * @param dataType - the type of data that was loaded
		 * @param value - value if loaded or not. Used in conjunction with
		 * functions that update and functions that listen for events when 
		 * data are loaded.
		 * 
		 */		
		private function setIfTypeOfDataLoaded(dataType:String, value:Boolean):void{
			switch(dataType)
			{
				case GlobalData.PLAYER_DATA:
				{
					GlobalData.instance.playerDataLoaded = value;
					break;
				}
				case GlobalData.FRIENDS_DATA:
				{
					GlobalData.instance.friendDataLoaded = value;
					break;
				}
				case GlobalData.OFFICE_DATA:
				{
					GlobalData.instance.officeDataLoaded = value;
					break;
				}
				case GlobalData.CREATECHAR_DATA:
				{
					GlobalData.instance.characterDataLoaded = value;
					break;
				}
				case GlobalData.CLASSPRICE_DATA:
				{
					GlobalData.instance.classPriceDataLoaded = value;
					break;
				}	
				case GlobalData.CHARSHOP_DATA:
				{
					GlobalData.instance.characterShopDataLoaded = value;
					break;
				}	
				case GlobalData.MAPBUILDING_DATA:
				{
					GlobalData.instance.mapBuildingDataLoaded = value;
					break;
				}
				case GlobalData.APPSETTINGS_DATA:
				{
					GlobalData.instance.appSettingsDataLoaded = value;
					break;
				}
				case GlobalData.OFFICEINVENTORY_DATA:
				{
					GlobalData.instance.officeInventoryDataLoaded = value;
					break;
				}
				case GlobalData.CLOTHESSTORE_DATA:
				{
					GlobalData.instance.clothesStoreDataLoaded = value;
					break;
				}
				case GlobalData.CLOTHESINVENTORY_DATA:
				{
					GlobalData.instance.clothesInventoryDataLoaded = value;
					break;
				}
				case GlobalData.OFFICESTATE_DATA:
				{
					GlobalData.instance.officeStateDataLoaded = value;
					break;
				}
				case GlobalData.FRIENDOFFICESTATE_DATA:
				{
					GlobalData.instance.friendOfficeStateDataLoaded = value;
					break;
				}
				case GlobalData.CHARLIST_DATA:
				{
					GlobalData.instance.characterDataLoaded = value;
					break;
				}
				case GlobalData.FRIENDCHARLIST_DATA:
				{
					GlobalData.instance.friendCharacterListDataLoaded = value;
					break;
				}
				case GlobalData.QUESTLIST_DATA:
				{
					GlobalData.instance.questlistDataLoaded = value;
					break;
				}
				case GlobalData.LEVELAPTABLE_DATA:
				{
					GlobalData.instance.levelAPTableDataLoaded = value;
					break;
				}
				case GlobalData.FRIENDROUTES_DATA:
				{
					GlobalData.instance.friendRoutesDataLoaded = value;
					break;
				}
				case GlobalData.COLLECTIONLIST_DATA:
				{
					GlobalData.instance.collectionListDataLoaded = value;
					break;
				}
				case GlobalData.MATERIALLIST_DATA:
				{
					GlobalData.instance.materialListDataLoaded = value;
					break;
				}
				case GlobalData.CHALLENGEVALUES_DATA:
				{
					GlobalData.instance.challengeValuesDataLoaded = value;
					break;
				}
			}
		}
		
		/**
		 * 
		 * @param ev - event handler when the xml loads.
		 * 
		 */		
		
		private function onLoadComplete(ev:Event):void{
			var len:int = _jobLoaderQueue.length;
			for (var x:int = 0; x<len; x++){
				if (ev.currentTarget == _jobLoaderQueue[x]){
					Logger.tracer(this, "XML being loaded: " + _jobTypeQueue[x]);
					try {
						var data:XML = new XML (ev.target.data);
					} catch (e:Error){
						Logger.tracer(this, "Error XML parsing: " + e.message + " : " + _jobTypeQueue[x]);
						// server call for error report
						
						// call for game restart
					}
					ev.target.removeEventListener(Event.COMPLETE, onLoadComplete);
					ev.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
					setDataAndDispatch(_jobTypeQueue[x], data);
					_jobLoaderQueue.splice(x,1);
					_jobTypeQueue.splice(x,1);
				}
			}
		}
		
		/**
		 * Dispatches the signal that the data has been updated and extracted 
		 * and updates the GlobalData accordingly.
		 *  
		 * @param updateType - the type of dataType.
		 * @param data - the data to be passed.
		 * 
		 */		
		
		private function setDataAndDispatch(updateType:String, data:*):void{
			switch(updateType)
			{
				case GlobalData.FRIENDS_DATA:
				{
					GlobalData.instance.friendsDataXML = data;
					parseFriendsData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.FRIENDXML_LOADED));
					Logger.tracer(this, " Friends xml data loaded");
					break;
				}
				case GlobalData.OFFICE_DATA:
				{
					GlobalData.instance.officeDataXML = data;
					parseOfficeData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.OFFICEXML_LOADED));
					Logger.tracer(this, " Office xml data loaded");
					break;
				}
				case GlobalData.PLAYER_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.playerDataXML = data;
						parsePlayerData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.PLAYERXML_LOADED));
						Logger.tracer(this, " Player xml data loaded");
					} else {
						Logger.tracer(this, "Error getting player data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.PLAYERXML_LOADED}));
					}
					break;
				}
				case GlobalData.CREATECHAR_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.characterDataXML = data;
						parseCreateCharacterData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CREATECHARXML_LOADED));
						Logger.tracer(this, " Character create xml data loaded");
					} else {
						Logger.tracer(this, "Error getting character create data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.CREATECHARXML_LOADED}));
					}
					break;
				}
				case GlobalData.CLASSPRICE_DATA:
				{
					GlobalData.instance.classPriceDataXML = data;
					parseClassPrice(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CLASSPRICEXML_LOADED));
					Logger.tracer(this, " Class price xml data loaded");
					break;
				}
				case GlobalData.CHARSHOP_DATA:
				{
					GlobalData.instance.characterShopDataXML = data;
					if (int((data as XML).attribute("c")) > 0){
						parseCharacterShopData(data);
					} else {
						GlobalData.instance.charShopBodyDataArray = [];
					}
					
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CHARSHOPXML_LOADED));
					Logger.tracer(this, " Character shop xml data loaded");
					break;
				}
				case GlobalData.CHARLIST_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.characterListDataXML = data;
						if (int((data as XML).attribute("c")) > 0){
							parseCharacterListData(data);
						} else {
							GlobalData.instance.charListDataArray = [];
						}
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CHARLISTXML_LOADED));
						Logger.tracer(this, " Character list xml data loaded");
					} else {
						Logger.tracer(this, "Error getting character list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.CHARLISTXML_LOADED}));
					}
					break;
				}
				case GlobalData.MAPBUILDING_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.mapBuildingDataXML = data;
						parseMapBuildingData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.MAPBUILDINGXML_LOADED));
						Logger.tracer(this, " Map building xml data loaded");
					} else {
						Logger.tracer(this, "Error getting map building list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.MAPBUILDINGXML_LOADED}));
					}
					break;
				}
				case GlobalData.APPSETTINGS_DATA:
				{
					GlobalData.instance.appSettingDataXML = data;
					parseAppSettingData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.APPSETTINGXML_LOADED));
					Logger.tracer(this, " App settings xml data loaded");
					break;
				}
				case GlobalData.MAPCHARLIST_DATA:
				{
					GlobalData.instance.mapCharListDataXML = data;
					parseCharListData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.MAPCHARLISTXML_LOADED));
					Logger.tracer(this, " Map character list xml data loaded");
					break;
				}
				case GlobalData.OFFICESTORE_DATA:
				{
					GlobalData.instance.officeStoreDataXML = data;
					parseOfficeStoreData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.OFFICESTOREXML_LOADED));
					Logger.tracer(this, " Office store data loaded");
					break;
				}
				case GlobalData.CLOTHESSTORE_DATA:
				{
					GlobalData.instance.clothesStoreDataXML = data;
					parseClothesStoreData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CLOTHESSTOREXML_LOADED));
					Logger.tracer(this, " Clothes store data loaded");
					break;
				}
				case GlobalData.OFFICEINVENTORY_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.officeInventoryDataXML = data;
						parseOfficeInventoryData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.OFFICEINVENTORYXML_LOADED));
						Logger.tracer(this, " Office invetory data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting office inventory data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.OFFICEINVENTORYXML_LOADED}));
					}
				}
				case GlobalData.CLOTHESINVENTORY_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.clothesInventoryDataXML = data;
						parseClothesInventoryData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CLOTHESINVENTORYXML_LOADED));
						Logger.tracer(this, " Clothes inventory xml data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting clothes inventory data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.CLOTHESINVENTORYXML_LOADED}));
					}
				}
				case GlobalData.OFFICESTATE_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){	
						GlobalData.instance.officeStateDataXML = data;
						parseOfficeStateData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.OFFICESTATEXML_LOADED));
						Logger.tracer(this, " Office state xml data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting office state data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.OFFICESTATEXML_LOADED}));
					}
				}
				case GlobalData.FRIENDOFFICESTATE_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){		
						GlobalData.instance.friendOfficeStateDataXML = data;
						parseFriendOfficeStateData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.FRIENDOFFICESTATEXML_LOADED));
						Logger.tracer(this, " Friend office state xml data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting friend office state data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.FRIENDXML_LOADED}));
					}	
				}
				case GlobalData.FRIENDCHARLIST_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){		
						GlobalData.instance.friendCharacterListDataXML = data;
						if (int((data as XML).attribute("c")) > 0){
							parseFriendCharListData(data);
						} else {
							GlobalData.instance.friendCharListDataArray = [];
						}
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.FRIENDCHARLISTXML_LOADED));
						Logger.tracer(this, " Friend character xml data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting friend character list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.FRIENDCHARLISTXML_LOADED}));
					}	
				}
				case GlobalData.QUESTLIST_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.questListDataXML = data;
						parseQuestListData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.QUESTLISTXML_LOADED));
						//TweenLite.delayedCall( GlobalData.instance.refreshRate, updateQuestXml );
						Logger.tracer(this, " Quest list data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting quest list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.QUESTLISTXML_LOADED}));
					}
				}
				case GlobalData.LEVELAPTABLE_DATA:
				{
					GlobalData.instance.levelAPTableListDataXML = data;
					parseLevelAPTableListData(data);
					setIfTypeOfDataLoaded(updateType, true);
					EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.LEVELAPTABLEXML_LOADED));
					Logger.tracer(this, " Level AP table list data loaded");
					break;
				}
				case GlobalData.FRIENDROUTES_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						if (int((data as XML).attribute("totalroutes")) > 0){
							GlobalData.instance.friendRoutesDataXML = data;
							parseFriendRoutesData(data);
							setIfTypeOfDataLoaded(updateType, true);
						}
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.FRIENDROUTESXML_LOADED));
						Logger.tracer(this, " Friend routes data loaded");
						
						break;
					} else {
						Logger.tracer(this, "Error getting friend routes data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.FRIENDROUTESXML_LOADED}));
					}
				}
				case GlobalData.COLLECTIONLIST_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.collectionListDataXML = data;
						parseCollectionListData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.COLLECTIONLISTXML_LOADED));
						Logger.tracer(this, " Collection list data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting collection list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.COLLECTIONLISTXML_LOADED}));
					}
				}
				case GlobalData.MATERIALLIST_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.materialListDataXML = data;
						parseMaterialListData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.MATERIALLISTXML_LOADED));
						Logger.tracer(this, " Material list data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting material list data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.MATERIALLISTXML_LOADED}));
					}
				}
				case GlobalData.CHALLENGEVALUES_DATA:
				{
					if ((data as XML).attribute("ret").toString() == "true"){
						GlobalData.instance.materialListDataXML = data;
						parseChallengeValuesData(data);
						setIfTypeOfDataLoaded(updateType, true);
						EventSatellite.getInstance().dispatchEvent(new SSEvent(SSEvent.CHALLENGEVALUESXML_LOADED));
						Logger.tracer(this, " Material list data loaded");
						break;
					} else {
						Logger.tracer(this, "Error getting challenge values data: " + (data as XML).attribute("reason").toString());
						trace ("Attempting to reload xml...");
						EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.XMLLOAD_ERROR, {type:SSEvent.CHALLENGEVALUESXML_LOADED}));
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the challenge value data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseChallengeValuesData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.children()){
					globalData.challengeValuesDataArray[index] = [];
					globalData.challengeValuesDataArray[index][GlobalData.CHALLENGEVALUES_TYPE] = int(xmlList.attribute("type"));
					globalData.challengeValuesDataArray[index][GlobalData.CHALLENGEVALUES_DURA] = int(xmlList.attribute("dura"));
					globalData.challengeValuesDataArray[index][GlobalData.CHALLENGEVALUES_COINCOST] = int(xmlList.attribute("coincost"));
					globalData.challengeValuesDataArray[index][GlobalData.CHALLENGEVALUES_APCOST] = int(xmlList.attribute("apcost"));
					globalData.challengeValuesDataArray[index][GlobalData.CHALLENGEVALUES_SCRIPT] = xmlList.attribute("script").toString();
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the material list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseMaterialListData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.children()){
					globalData.materialListDataArray[index] = [];
					globalData.materialListDataArray[index][GlobalData.MATERIALLIST_ID] = xmlList.attribute("id").toString();
					globalData.materialListDataArray[index][GlobalData.MATERIALLIST_NAME] = xmlList.attribute("name").toString();
					globalData.materialListDataArray[index][GlobalData.MATERIALLIST_PIC] = xmlList.attribute("pic").toString();
					globalData.materialListDataArray[index][GlobalData.MATERIALLIST_QTY] = int(xmlList.attribute("qty"));
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the collection list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseCollectionListData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.children()){
					globalData.collectionListDataArray[index] = [];
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ID] = xmlList.attribute("id").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_CATEGORY] = xmlList.attribute("categoryname").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ICON] = xmlList.attribute("icon").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_DESCRIPTION] = xmlList.attribute("desc").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_LVLREQ] = int(xmlList.attribute("reqlvl"));
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_STACK] = int(xmlList.attribute("stack"));
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_FORCECRAFT] = xmlList.attribute("forcecraft").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_REWARDCATEGORY] = xmlList.attribute("rewardcat").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_REWARDID] = xmlList.attribute("rewardid").toString();
					globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM] = [];
					var index2:int = 0;
					for each (var xmlList2:XML in xmlList.children()){
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2] = [];
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2][GlobalData.COLLECTIONLIST_ITEMID] = xmlList2.attribute("id").toString();
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2][GlobalData.COLLECTIONLIST_ITEMICON] = xmlList2.attribute("icon").toString();
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2][GlobalData.COLLECTIONLIST_ITEMCURRQUANTITY] = int(xmlList2.attribute("haveqty"));
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2][GlobalData.COLLECTIONLIST_ITEMMAXQUANTITY] = int(xmlList2.attribute("maxqty"));
						globalData.collectionListDataArray[index][GlobalData.COLLECTIONLIST_ITEM][index2][GlobalData.COLLECTIONLIST_ITEMFORCECRAFT] = xmlList2.attribute("forcecraft").toString();
						index2++;
					}
					index++;
				}
			}
		}
		
		//private function updateQuestXml():void 
		//{
		//ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData );
		//trace( "update quest xml after buying contestant ======================================================================================>>>> ^^)" );
		//}
		
		/**
		 * Parses and sets the GlobalData references of the friend routes data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */	
		
		private function parseFriendRoutesData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				globalData.totalRoute = Xml.attribute("totalroutes");
				if (int(Xml.attribute("helpcount")) > 0){
					for each (var xmlList:XML in Xml.elements("help")){
						globalData.friendRoutesHelpArray = [];
						for each (var xmlList2:XML in xmlList.children()){
							globalData.friendRoutesHelpArray[index] = [];
							globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ENTRY] = xmlList2.attribute("entry").toString();
							globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_FBID] = xmlList2.attribute("fbid").toString();
							globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_PICLINK] = xmlList2.attribute("pic").toString();
							globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_COUNT] = int(xmlList2.attribute("count"));
							
							var index2:int = 0;
							
							globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE] = [];
							
							for each (var xmlList3:XML in xmlList2.children()){
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2] = [];
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2][GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM] = xmlList3.attribute("isitem").toString();
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2][GlobalData.FRIENDROUTES_HELP_ROUTE_ID] = xmlList3.attribute("id").toString();
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2][GlobalData.FRIENDROUTES_HELP_ROUTE_POSITION] = new Point (int(xmlList3.attribute("posx")), int(xmlList3.attribute("posy")));
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2][GlobalData.FRIENDROUTES_HELP_ROUTE_ACTION] = xmlList3.attribute("action").toString();
								globalData.friendRoutesHelpArray[index][GlobalData.FRIENDROUTES_HELP_ROUTE][index2][GlobalData.FRIENDROUTES_HELP_ROUTE_ROUTEID] = xmlList3.attribute("routeid").toString();
								index2++;
							}
							index++;
						}
					}
				}
				index = 0;
				if (int(Xml.attribute("challengecount")) > 0){
					for each (xmlList in Xml.elements("challenge")){
						globalData.friendRoutesChallengeArray = [];
						for each (xmlList2 in xmlList.children()){
							globalData.friendRoutesChallengeArray[index] = [];
							globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_ENTRY] = xmlList2.attribute("entry").toString();
							globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_FBID] = xmlList2.attribute("fbid").toString();
							globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_PICLINK] = xmlList2.attribute("pic").toString();
							globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_COUNT] = int(xmlList2.attribute("count"));
							globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE] = [];
							index2 = 0;
							for each (xmlList3 in xmlList2.children()){
								globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE][index2] = [];
								globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE][index2][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHARID] = xmlList3.attribute("charid").toString();
								globalData.friendRoutesChallengeArray[index][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE][index2][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHALLENGERCHARID] = xmlList3.attribute("challengedby").toString();
								index2++;
							}
							index++;
						}
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the level ap table data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseLevelAPTableListData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in xml){
					globalData.levelAPTableDataArray[index] = [];
					globalData.levelAPTableDataArray[index][GlobalData.LEVELAPTABLE_LVL] = int(xmlList.attribute("lvl"));
					globalData.levelAPTableDataArray[index][GlobalData.LEVELAPTABLE_EXP] = int(xmlList.attribute("exp"));
					globalData.levelAPTableDataArray[index][GlobalData.LEVELAPTABLE_AP] = int(xmlList.attribute("ap"));
					globalData.levelAPTableDataArray[index][GlobalData.LEVELAPTABLE_STATMAXEXP] = int(xmlList.attribute("statmaxexp"));
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the quest list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseQuestListData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var index2:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				globalData.questListDataArray = [];
				for each (var xmlList:XML in xml){
					globalData.questListDataArray[index] = [];
					globalData.questListDataArray[index][GlobalData.QUESTLIST_ID] = xmlList.attribute("id").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_NPCTYPE] = int(xmlList.attribute("npctype"));
					globalData.questListDataArray[index][GlobalData.QUESTLIST_COMMAND] = xmlList.attribute("qcom").toString();
					//globalData.questListDataArray[index][GlobalData.QUESTLIST_CATEGORY] = xmlList.attribute("category").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_CATEGORY] = xmlList.attribute("cat").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_TITLE] = xmlList.attribute("title").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_NPCIMAGE] = xmlList.attribute("npcimage").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_NPCSCRIPT] = xmlList.attribute("npcscript").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_HINTSCRIPT] = xmlList.attribute("hintscript").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_STARPOINTREQ] = int(xmlList.attribute("rushstar"));
					globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARDNPCIMAGE] = xmlList.attribute("rewardnpcimage").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_QUESTICON] = xmlList.attribute("questicon").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_TYPE] = xmlList.attribute("type").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_TIMELIMIT] = Number(xmlList.attribute("timelimit"));
					globalData.questListDataArray[index][GlobalData.QUESTLIST_DAILYQUEST] = xmlList.attribute("dailyquest").toString();
					globalData.questListDataArray[index][GlobalData.QUESTLIST_ISNEW] = int(xmlList.attribute("isnew"));
					globalData.questListDataArray[index][GlobalData.QUESTLIST_ISACCEPTED] =xmlList.attribute("isaccepted");
					
					// index 2 for reward list is the number of rewardlist types
					globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD] = [];
					for each (var rewardList:XML in xmlList.elements("rewardlist").children()){
						globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD][index2] = [];
						globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD][index2][GlobalData.QUESTLIST_REWARD_QID] = rewardList.attribute("questid").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD][index2][GlobalData.QUESTLIST_REWARD_QUESTREWARD] = rewardList.attribute("qreward").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD][index2][GlobalData.QUESTLIST_REWARD_TYPE] = rewardList.attribute("type").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_REWARD][index2][GlobalData.QUESTLIST_REWARD_AMOUNT] = int(rewardList.attribute("amt"));
						index2++;
					}
					
					// index 2 for term list is the number of termlist instance (number of requirements per quest)
					index2 = 0;
					globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM] = [];
					for each (var termList:XML in xmlList.elements("termlist").children()){
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2] = [];
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_ID] = termList.attribute("id").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_COMMAND] = termList.attribute("termcommand").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_STATUS] = termList.attribute("status").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_AMOUNTREQUIRED] = termList.attribute("amountreq");
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_AMOUNTHAVE] = termList.attribute("amounthave");
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_OBJECTIMAGE] = termList.attribute("objectimage").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_CONDITIONTEXT] = termList.attribute("conditiontext").toString();
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_STARPOINTREQ] = int(termList.attribute("rushstar"));
						// parse the termlist function in your own terms as the contents will be variable.
						globalData.questListDataArray[index][GlobalData.QUESTLIST_TERM][index2][GlobalData.QUESTLIST_TERM_FUNCTION] = termList.attribute("func").toString();
						index2++;
					}
					index2 = 0;		
					index++;
				}
			}
		}
		
		
		/**
		 * Parses and sets the GlobalData references of the friend character list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseFriendCharListData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in xml){
					var xmlContent:XML = xmlList;
					globalData.friendCharListDataArray[index] = [];
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ID] = xmlContent.attribute("id").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_GENDER] = xmlContent.elements("gender").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_NAME] = xmlContent.elements("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_DEFINITION] = xmlContent.elements("def").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTH] = int(xmlContent.elements("health"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SING] = int(xmlContent.elements("sing"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING] = int(xmlContent.elements("acting"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ATTRACTION] = int(xmlContent.elements("attraction"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_INTELLIGENCE] = int(xmlContent.elements("intelligent"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_LEVEL] = int(xmlContent.elements("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_GRADE] = xmlContent.elements("grade").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_POPULAR] = int(xmlContent.elements("popular"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STRESS] = int(xmlContent.elements("stress"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_CONDITION] = int(xmlContent.elements("cond"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STATUS] = int(xmlContent.elements("status"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_TIMELEFT] = int(xmlContent.elements("timeleft"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ITEMENTRYID] = xmlContent.elements("timeleft").attribute("entryid").toString();
					//globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_EXPERIENCE] = int(xmlContent.elements("exp"));
					/*globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MANAGER_NPC] = xmlContent.elements("timeleft").attribute("manager").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MANAGER_LEVEL] = int(xmlContent.elements("manager").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MANAGER_NAME] = xmlContent.elements("manager").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MANAGER_NPCFBID] = xmlContent.elements("manager").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MANAGER_STATE] = xmlContent.elements("manager").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTHTRAINER_NPC] = xmlContent.elements("healthtrainer").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTHTRAINER_LEVEL] = int(xmlContent.elements("healthtrainer").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTHTRAINER_NAME] = xmlContent.elements("healthtrainer").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTHTRAINER_NPCFBID] = xmlContent.elements("healthtrainer").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_HEALTHTRAINER_STATE] = xmlContent.elements("healthtrainer").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_VOCALTRAINER_NPC] = xmlContent.elements("vocaltrainer").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_VOCALTRAINER_LEVEL] = int(xmlContent.elements("vocaltrainer").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_VOCALTRAINER_NAME] = xmlContent.elements("vocaltrainer").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_VOCALTRAINER_NPCFBID] = xmlContent.elements("vocaltrainer").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_VOCALTRAINER_STATE] = xmlContent.elements("vocaltrainer").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_PRIVATETEACHER_NPC] = xmlContent.elements("privateteacher").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_PRIVATETEACHER_LEVEL] = int(xmlContent.elements("privateteacher").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_PRIVATETEACHER_NAME] = xmlContent.elements("privateteacher").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_PRIVATETEACHER_NPCFBID] = xmlContent.elements("privateteacher").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_PRIVATETEACHER_STATE] = xmlContent.elements("privateteacher").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTINGTEACHER_NPC] = xmlContent.elements("actingteacher").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTINGTEACHER_STATE] = xmlContent.elements("actingteacher").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTINGTEACHER_NAME] = xmlContent.elements("actingteacher").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTINGTEACHER_LEVEL] = int(xmlContent.elements("actingteacher").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTINGTEACHER_NPCFBID] = xmlContent.elements("actingteacher").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STYLIST_NPC] = xmlContent.elements("stylist").attribute("npc").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STYLIST_STATE] = xmlContent.elements("stylist").attribute("empty").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STYLIST_NAME] = xmlContent.elements("stylist").attribute("name").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STYLIST_LEVEL] = int(xmlContent.elements("stylist").attribute("level"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STYLIST_NPCFBID] = xmlContent.elements("stylist").toString();*/
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_POSITION] = new Vector3D (int(xmlContent.attribute("x")),int(xmlContent.attribute("y")),0);
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_WEARINGSPECIAL] = int(xmlContent.elements("wearingspecial"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTION1] = xmlContent.elements("anim1").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTION2] = xmlContent.elements("anim2").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTION3] = xmlContent.elements("anim3").toString();
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_STATMAXEXP] = int(xmlContent.attribute("statmaxexp"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ISNEW] = int(xmlContent.elements("isnew"));
					
					//information for information popup
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SINGING_SHOUT] = int(xmlContent.elements("singing").attribute("shout"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SINGING_EMPATHY] = int(xmlContent.elements("singing").attribute("empathy"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SINGING_AUDIENCE] = int(xmlContent.elements("singing").attribute("audience"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SINGING_INSTRUMENT] = int(xmlContent.elements("singing").attribute("instrument"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_SINGING_EXPERFORMANCE] = int(xmlContent.elements("singing").attribute("experformance"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING_MUSICAL] = int(xmlContent.elements("acting").attribute("musical"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING_EMOTION] = int(xmlContent.elements("acting").attribute("emotion"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING_MIME] = int(xmlContent.elements("acting").attribute("mime"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING_COMEDY] = int(xmlContent.elements("acting").attribute("comedy"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_ACTING_ACTION] = int(xmlContent.elements("acting").attribute("action"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MODELING_GROTESQUE] = int(xmlContent.elements("modeling").attribute("grotesque"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MODELING_HOTPOSE] = int(xmlContent.elements("modeling").attribute("hotpose"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MODELING_STICKACTION] = int(xmlContent.elements("modeling").attribute("stickaction"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MODELING_BALANCE] = int(xmlContent.elements("modeling").attribute("balance"));
					globalData.friendCharListDataArray[index][GlobalData.FRIENDCHARLIST_MODELING_POWERWALKING] = int(xmlContent.elements("modeling").attribute("powerwalking"));
					
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the office state data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseFriendOfficeStateData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				globalData.friendOfficeName =  Xml.attribute("officename");
				globalData.friendOfficeStateWallID = Xml.attribute("wallid");
				globalData.friendOfficeStateTileID = Xml.attribute("tileid");
				globalData.expansion = int(Xml.attribute("expansion"));
				
				globalData.wallImageRight = globalData.absPath + Xml.attribute("wallimgr");
				globalData.wallImageLeft = globalData.absPath + Xml.attribute("wallimgl");
				globalData.wallImageLeftName = Xml.attribute("wallimglname");
				globalData.wallImageRightName = Xml.attribute("wallimgrname");
				
				globalData.tileImage = globalData.absPath + Xml.attribute("tileimg");
				globalData.tileImageName = Xml.attribute("tileimgname");
				
				
				//globalData.friendOfficeRow = Xml.attribute("rows");
				//globalData.friendOfficeColumn = Xml.attribute("cols");
				//globalData.GRID_LENGTH = int( Xml.attribute("rows") );
				//globalData.GRID_WIDTH = int( Xml.attribute("cols") );
				//globalData.friendOfficeStateWallFN = Xml.attribute("wallfn");
				//globalData.friendOfficeStateTileFN = Xml.attribute("tilefn");
				
				for each(var xmlInst:XML in Xml.children()){
					globalData.friendOfficeStateDataArray[index] = [];
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ENTRY] = xmlInst.attribute("entry").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ITEMUSED] = xmlInst.attribute("itemused").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ITEMNAME] = xmlInst.attribute("itemname").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ITEMID] = xmlInst.attribute("itemid").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_POSITION] = new Vector3D(int(xmlInst.attribute("x")),int(xmlInst.attribute("y")),int(xmlInst.attribute("z")));
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ROTATION] = int(xmlInst.attribute("rot"));
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_TYPE] = xmlInst.attribute("type").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_SUBTYPE] = xmlInst.attribute("subtype").toString();
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_ITEMFRAMENUMBER] = int(xmlInst.attribute("fn"));
					globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_DIMENSION] = new Vector3D(int(xmlInst.attribute("l")),int(xmlInst.attribute("w")),int(xmlInst.attribute("h")));
					
					if (xmlInst.attribute("type").toString() == GlobalData.ITEMCATEGORY_STAFF){
						
						globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_EMPTY] = int(xmlInst.attribute("empty"));
						//globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_NPC] = xmlInst.attribute("npc").toString();
						//globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_LEVEL] = int(xmlInst.attribute("level"));
						//globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_FBID] = xmlInst.attribute("fbid").toString();
						//globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_NPCID] = xmlInst.attribute("npcid").toString();
						globalData.friendOfficeStateDataArray[index][GlobalData.FRIENDOFFICESTATE_GENDER] = xmlInst.attribute("gender").toString();
						
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_STAFF_POS ] = xmlInst.attribute("staffpositions").toString();
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_POS_STATE ] = xmlInst.attribute("posstate").toString();
					}
					
					if (xmlInst.attribute("type").toString() == GlobalData.ITEMCATEGORY_TRAINING){
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_STRESS ] = int(xmlInst.attribute("tstress"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_DURATION ] = int(xmlInst.attribute("tdura"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_HEALTH ] = int(xmlInst.attribute("thealth"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_ACTING ] = int(xmlInst.attribute("tacting"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_ATTRACTION ] = int(xmlInst.attribute("tattraction"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_INT ] = int(xmlInst.attribute("tintelligent"));
						globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_TRAINING_SING ] = int(xmlInst.attribute("tsing"));
					}
					
					globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_REST_STRESS ] = int(xmlInst.attribute("mstress"));
					globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_REST_DURATION ] = int(xmlInst.attribute("mdura"));
					
					
					globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_ITEM_COOLDOWN ] = int(xmlInst.attribute("cooldown"));
					
					globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_SELLPRICE ] = int(xmlInst.attribute("sellprice"));
					globalData.friendOfficeStateDataArray[index][ GlobalData.FRIENDOFFICESTATE_APCOST ] = int(xmlInst.attribute("apcost"));
					
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the office state data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseOfficeStateData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				globalData.officeName = Xml.attribute("officename");
				
				globalData.officeStateWallID = Xml.attribute("wallid");
				globalData.officeStateTileID = Xml.attribute("tileid");	
				globalData.expansion = int(Xml.attribute("expansion"));
				globalData.wallImageRight = globalData.absPath + Xml.attribute("wallimgr");
				globalData.wallImageLeft = globalData.absPath + Xml.attribute("wallimgl");
				trace( "[ServerDataExtractor]: ", "len", globalData.expansion,"width",globalData.expansion  );
				globalData.tutorialMode = int( Xml.attribute("tutorialmode"));	
				
				globalData.wallImageLeftName = Xml.attribute("wallimglname");
				globalData.wallImageRightName = Xml.attribute("wallimgrname");
				
				globalData.tileImage = globalData.absPath + Xml.attribute("tileimg");
				globalData.tileImageName = Xml.attribute("tileimgname");
				
				//globalData.GRID_LENGTH = int( Xml.attribute("rows") );
				//globalData.GRID_WIDTH = int ( Xml.attribute("cols") );
				//globalData.officeStateWallFN = Xml.attribute("wallfn");
				//globalData.officeStateTileFN = Xml.attribute("tilefn");
				
				trace( "[ServerDataExtractor]: ", "len", globalData.expansion,"width",globalData.expansion  );
				
				globalData.officeStateWallFN = Xml.attribute("wallfn");
				globalData.officeStateTileFN = Xml.attribute("tilefn");
				
				globalData.tutorialMode = int( Xml.attribute("tutorialmode"));				
				
				if ( globalData.tutorialMode == 1 ){
					globalData.isTutorialDone = true;
				}else {
					globalData.isTutorialDone = false;
				}				
				
				for each(var xmlInst:XML in Xml.children()){
					globalData.officeStateDataArray[index] = [];
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ENTRY] = xmlInst.attribute("entry").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ITEMUSED] = xmlInst.attribute("itemused").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ITEMNAME] = xmlInst.attribute("itemname").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ITEMID] = xmlInst.attribute("itemid").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_POSITION] = new Vector3D(int(xmlInst.attribute("x")),int(xmlInst.attribute("y")),int(xmlInst.attribute("z")));
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ROTATION] = int(xmlInst.attribute("rot"));
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_TYPE] = xmlInst.attribute("type").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_SUBTYPE] = xmlInst.attribute("subtype").toString();
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_ITEMFRAMENUMBER] = int(xmlInst.attribute("fn"));
					globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_DIMENSION] = new Vector3D(int(xmlInst.attribute("l")),int(xmlInst.attribute("w")),int(xmlInst.attribute("h")));
					
					if (xmlInst.attribute("type").toString() == GlobalData.ITEMCATEGORY_STAFF){
						//globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_NPC] = xmlInst.attribute("npc").toString();
						//globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_LEVEL] = int(xmlInst.attribute("level"));
						//globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_FBID] = xmlInst.attribute("fbid").toString();
						//globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_NPCID] = xmlInst.attribute("npcid").toString();
						globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_EMPTY] = int(xmlInst.attribute("empty"));
						globalData.officeStateDataArray[index][GlobalData.OFFICESTATE_GENDER] = xmlInst.attribute("gender").toString();
						
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_STAFF_POS ] = xmlInst.attribute("staffpositions").toString();
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_POS_STATE ] = xmlInst.attribute("posstate").toString();
					}
					
					if (xmlInst.attribute("type").toString() == GlobalData.ITEMCATEGORY_TRAINING){
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_STRESS ] = int(xmlInst.attribute("tstress"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_DURATION ] = int(xmlInst.attribute("tdura"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_HEALTH ] = int(xmlInst.attribute("thealth"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_ACTING ] = int(xmlInst.attribute("tacting"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_ATTRACTION ] = int(xmlInst.attribute("tattraction"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_INT ] = int(xmlInst.attribute("tintelligent"));
						globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_TRAINING_SING ] = int(xmlInst.attribute("tsing"));
					}
					
					globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_REST_STRESS ] = int(xmlInst.attribute("mstress"));
					globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_REST_DURATION ] = int(xmlInst.attribute("mdura"));
					
					
					globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_ITEM_COOLDOWN ] = int(xmlInst.attribute("cooldown"));
					globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_SELLPRICE ] = int(xmlInst.attribute("sellprice"));
					
					globalData.officeStateDataArray[index][ GlobalData.OFFICESTATE_APCOST ] = int(xmlInst.attribute("apcost"));
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the clothes inventory data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseClothesInventoryData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each(var xmlInst:XML in Xml){
					var index2:int = 0;	
					for each(var xmlInst2:XML in xmlInst.children()){
						globalData.clothesInventoryDataArray[index] = []
						for each(var xmlInstType:XML in xmlInst2.children()){
							for each(var xmlInst3:XML in xmlInstType.children()){
								globalData.clothesInventoryDataArray[index][index2] = [];
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_CATEGORY] = xmlInst2.attribute("category").toString();
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_TYPE] = xmlInstType.attribute("type").toString();
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_GENDER] = xmlInst3.attribute("gender").toString();
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_ID] = xmlInst3.attribute("id").toString();
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_NAME] = xmlInst3.attribute("name").toString();
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_COINCOST] = int(xmlInst3.attribute("coincost"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_FRAMENUMBER] = int(xmlInst3.attribute("fn"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_SELLPRICE] = int(xmlInst3.attribute("sellprice"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_EXPIRE] = int(xmlInst3.attribute("expire"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_ISHOT] = int(xmlInst3.attribute("ishot"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_ISNEW] = int(xmlInst3.attribute("isnew"));
								globalData.clothesInventoryDataArray[index][index2][GlobalData.CLOTHESINVENTORY_EFFECT] = xmlInst3.attribute("eff").toString();
								index2++;
							}	
						}
						index2 = 0;
						index++;
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the office inventory data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseOfficeInventoryData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each(var xmlInst:XML in Xml){
					var index2:int = 0;	
					for each(var xmlInst2:XML in xmlInst.children()){
						globalData.officeInventoryDataArray[index] = []
						for each(var xmlInstType:XML in xmlInst2.children()){
							for each(var xmlInst3:XML in xmlInstType.children()){
								globalData.officeInventoryDataArray[index][index2] = [];
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_CATEGORY] = xmlInst2.attribute("category").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_TYPE] = xmlInstType.attribute("type").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_ID] = xmlInst3.attribute("id").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_NAME] = xmlInst3.attribute("name").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_COIN] = int(xmlInst3.attribute("coin"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_STAR] = int(xmlInst3.attribute("star"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_AP] = int(xmlInst3.attribute("ap"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_SELLPRICE] = int(xmlInst3.attribute("sellprice"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_EXPIRATION] = int(xmlInst3.attribute("expiration"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_FRAMENUMBER] = int(xmlInst3.attribute("fn"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_DESCRIPTION] = xmlInst3.attribute("descrip").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_ISHOT] = int(xmlInst3.attribute("ishot"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_ISNEW] = int(xmlInst3.attribute("isnew"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_COLLISION] = int(xmlInst3.attribute("coll"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_EFFECT] = xmlInst3.attribute("eff").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_STACKABLE] = int(xmlInst3.attribute("stackable"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_STACKMAX] = int(xmlInst3.attribute("stackmax"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_CONSUMABLE] = int(xmlInst3.attribute("consumable"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_UNLOCKLEVEL] = int(xmlInst3.attribute("unlocklevel"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_ASSIGNEDNPC] = xmlInst3.attribute("assignednpc").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_DIMENSION] = new Vector3D (int(xmlInst3.attribute("length")), int(xmlInst3.attribute("width")), int(xmlInst3.attribute("height")));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_BUILDTIME] = int(xmlInst3.attribute("buildtime"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_REWARDTYPE] = xmlInst3.attribute("rewardtype").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_REWARDVALUE] = int(xmlInst3.attribute("rewardvalue"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_TRAINING] = xmlInst3.attribute("training").toString();
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_MACHINEREWARDCOIN] = int(xmlInst3.attribute("machinerewardcoin"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_MACHINEREWARDCOOLDOWN] = int(xmlInst3.attribute("machinerewardcooldown"));
								globalData.officeInventoryDataArray[index][index2][GlobalData.OFFICEINVENTORY_ROTATABLE] = int(xmlInst3.attribute("rotatable"));
								index2++;
							}	
						}
						index2 = 0;
						index++;
					}
				}
			}
		}
		
		
		/**
		 * Parses and sets the GlobalData references of the clothes store data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseClothesStoreData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each(var xmlInst:XML in Xml){
					var index2:int = 0;	
					for each(var xmlInst2:XML in xmlInst.children()){
						globalData.clothesStoreDataArray[index] = []
						for each(var xmlInstType:XML in xmlInst2.children()){
							for each(var xmlInst3:XML in xmlInstType.children()){
								globalData.clothesStoreDataArray[index][index2] = [];
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_CATEGORY] = xmlInst2.attribute("category").toString();
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_TYPE] = xmlInstType.attribute("type").toString();
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_GENDER] = xmlInst3.attribute("gender").toString();
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_ID] = xmlInst3.attribute("id").toString();
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_NAME] = xmlInst3.attribute("name").toString();
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_COINCOST] = int(xmlInst3.attribute("coincost"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_FRAMENUMBER] = int(xmlInst3.attribute("fn"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_SELLPRICE] = int(xmlInst3.attribute("sellprice"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_EXPIRE] = int(xmlInst3.attribute("expire"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_ISHOT] = int(xmlInst3.attribute("ishot"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_ISNEW] = int(xmlInst3.attribute("isnew"));
								globalData.clothesStoreDataArray[index][index2][GlobalData.CLOTHESSTORE_EFFECT] = xmlInst3.attribute("eff").toString();
								index2++;
							}	
						}
						index2 = 0;
						index++;
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the office store data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseOfficeStoreData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each(var xmlInst:XML in Xml){
					var index2:int = 0;	
					for each(var xmlInst2:XML in xmlInst.children()){
						globalData.officeStoreDataArray[index] = []
						for each(var xmlInstType:XML in xmlInst2.children()){
							for each(var xmlInst3:XML in xmlInstType.children()){
								globalData.officeStoreDataArray[index][index2] = [];
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_CATEGORY] = xmlInst2.attribute("cat").toString();
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TYPE] = xmlInstType.attribute("type").toString();
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_ID] = xmlInst3.attribute("id").toString();
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_NAME] = xmlInst3.attribute("name").toString();
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_COIN] = int(xmlInst3.attribute("coin"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_STAR] = int(xmlInst3.attribute("star"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_SELLPRICE] = int(xmlInst3.attribute("sellprice"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_PNGOBJECTLINK] = int(xmlInst3.attribute("png"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_PNGICONLINK] = int(xmlInst3.attribute("ico"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_SWFOBJECTLINK] = int(xmlInst3.attribute("swf"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_FRAMENUMBER] = int(xmlInst3.attribute("fn"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_DESCRIPTION] = xmlInst3.attribute("desc").toString();
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_UNLOCKLEVEL] = int(xmlInst3.attribute("reqlv"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_DIMENSION] = new Vector3D (int(xmlInst3.attribute("length")), int(xmlInst3.attribute("width")), int(xmlInst3.attribute("height")));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_MACHINEREWARDCOIN] = int(xmlInst3.attribute("mrewardcoin"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_STRESS] = int(xmlInst3.attribute("tstress"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_DURATION] = int(xmlInst3.attribute("tduration"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_INT] = int(xmlInst3.attribute("tintelligent"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_ACTING] = int(xmlInst3.attribute("tacting"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_ATTRACTION] = int(xmlInst3.attribute("tattraction"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_HEALTH] = int(xmlInst3.attribute("thealth"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING_SING] = int(xmlInst3.attribute("tsing"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_REST_DURATION] = int(xmlInst3.attribute("mduration"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_REST_STRESS] = int(xmlInst3.attribute("mstress"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_STAFF_POSITIONS] = xmlInst3.attribute("staffpos").toString();
								
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_BUILDTIME] = int(xmlInst3.attribute("buildtime"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_REWARDTYPE] = xmlInst3.attribute("rewardtype").toString();
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_REWARDVALUE] = int(xmlInst3.attribute("rewardvalue"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_TRAINING] = xmlInst3.attribute("training").toString();
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_MACHINEREWARDCOOLDOWN] = int(xmlInst3.attribute("machinerewardcooldown"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_ROTATABLE] = int(xmlInst3.attribute("rotatable"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_ISHOT] = int(xmlInst3.attribute("ishot"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_ISNEW] = int(xmlInst3.attribute("isnew"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_COLLISION] = int(xmlInst3.attribute("coll"));
								globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_EFFECT] = xmlInst3.attribute("eff").toString();
								globalData.officeStoreDataArray[index][index2][ GlobalData.OFFICESTORE_APCOST ] = int(xmlInst3.attribute("apcost"));
								globalData.officeStoreDataArray[index][index2][ GlobalData.OFFICESTORE_EXP ] = int(xmlInst3.attribute("exp"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_STACKABLE] = int(xmlInst3.attribute("stackable"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_STACKMAX] = int(xmlInst3.attribute("stackmax"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_CONSUMABLE] = int(xmlInst3.attribute("consumable"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_EXPIRATION] = int(xmlInst3.attribute("expiration"));
								//globalData.officeStoreDataArray[index][index2][GlobalData.OFFICESTORE_AP] = int(xmlInst3.attribute("ap"));
								
								index2++;
							}	
						}
						index2 = 0;
						index++;
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the map character list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseCharListData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				
				for each (var xmlList:XML in Xml.children()){
					globalData.mapCharListDataArray[index] = [];
					globalData.mapCharListDataArray[index][GlobalData.MAPCHARLIST_CID] = xmlList.elements("cid").toString();
					globalData.mapCharListDataArray[index][GlobalData.MAPCHARLIST_HEADDEFINITION] = xmlList.elements("headdef").toString();
					globalData.mapCharListDataArray[index][GlobalData.MAPCHARLIST_GENDER] = int(xmlList.elements("gender"));
					globalData.mapCharListDataArray[index][GlobalData.MAPCHARLIST_LEVEL] = int(xmlList.elements("lvl"));
					globalData.mapCharListDataArray[index][GlobalData.MAPCHARLIST_EXPERIENCE] = int(xmlList.elements("exp"));
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the map building data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseMapBuildingData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var index2:int = 0;
				var index3:int = 0;
				
				var globalData:GlobalData = GlobalData.instance;
				
				globalData.mapBlueBoxPath = Xml.attribute("blueboxpath");
				globalData.mapRedFlag = Xml.attribute("redflag");
				globalData.mapLocking = Xml.attribute("lockimg");
				globalData.mapBackNorm = Xml.attribute("backnorm");
				globalData.mapBackOver = Xml.attribute("backover");
				
				for each (var xmlList:XML in Xml.children()){
					globalData.mapBuildingDataArray[index] = [];
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ID] = xmlList.attribute("id").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_NAME] = xmlList.attribute("name").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_LVREQ] = int(xmlList.attribute("lvreq"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_REQ] = xmlList.attribute("mapreq").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_STATUS] = int(xmlList.attribute("status"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_BACKGROUND] = xmlList.attribute("mapbg").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_CLOUD] = xmlList.attribute("mapcloud").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES] = [];
					index2 = 0;
					for each (var xmlList2:XML in xmlList.children()){
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2] = [];
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_ID] = xmlList2.attribute("id").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_NAME] = xmlList2.attribute("name").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_LVLREQ] = int(xmlList2.attribute("lvreq"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_REQ] = xmlList2.attribute("zonereq").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_STATUS] = int(xmlList2.attribute("status"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_NPCNAME] = xmlList2.attribute("npcname").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_NPCPNG] = xmlList2.attribute("npcpng").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_NPCOFFSET] = new Point( Number(xmlList2.attribute("npcoffsetx")), Number(xmlList2.attribute("npcoffsety")));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_ZONEOFFSET] = new Point( Number(xmlList2.attribute("zoneoffsetx")), Number(xmlList2.attribute("zoneoffsety")));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_IMG0] = xmlList2.attribute("img0").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_IMG1] = xmlList2.attribute("img1").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_IMG2] = xmlList2.attribute("img2").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS] = [];
						index3 = 0;
						for each (var xmlList3:XML in xmlList2.children()){
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3] = [];
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_ID] = xmlList3.attribute("id").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NAME] = xmlList3.attribute("name").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_LVLREQ] = int(xmlList3.attribute("lvreq"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_REQ] = xmlList3.attribute("bldgreq").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_STATUS] = int(xmlList3.attribute("status"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_BLDGPNG] = xmlList3.attribute("bldgpng").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_BLDGPNGBRIGHT] = xmlList3.attribute("bldgpngbright").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_BLDGPNGDIM] = xmlList3.attribute("bldgpngdim").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_POSITION] = new Point (Number(xmlList3.attribute("x")), Number(xmlList3.attribute("y")));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_TYPE] = int(xmlList3.attribute("type"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_DIFFICULTY] = int(xmlList3.attribute("diff"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_DURATION] = int(xmlList3.attribute("dura"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_COIN] = int(xmlList3.attribute("coin"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_AP] = int(xmlList3.attribute("ap"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_BOSSSCRIPT] = xmlList3.attribute("bossscript").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCNAME] = xmlList3.attribute("npcname").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCID] = xmlList3.attribute("npcid").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCLVL] = int(xmlList3.attribute("npclevel"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCGENDER] = xmlList3.attribute("npcgender").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCHEALTH] = int(xmlList3.attribute("npchealth"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCSING] = int(xmlList3.attribute("npcsing"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCINTELLIGENT] = int(xmlList3.attribute("npcintelligent"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCACTING] = int(xmlList3.attribute("npcacting"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCATTRACTION] = int(xmlList3.attribute("npcattraction"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_NPCBODYDEFINITION] = xmlList3.attribute("npcbodydef").toString();
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_REWARDCOIN] = int(xmlList3.attribute("rewardcoin"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_REWARDEXP] = int(xmlList3.attribute("rewardexp"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_ISBOSS] = int(xmlList3.attribute("isboss"));
							globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_MAP_ZONES][index2][GlobalData.MAPBUILDING_ZONE_BUILDINGS][index3][GlobalData.MAPBUILDING_BUILDING_CONTEST] = xmlList3.attribute("contest").toString();
							index3++;
						}
						index2++;
					}
					index++;
				}
			}
		}
		
		
		
		//Old map building parser
		
		/**
		 * Parses and sets the GlobalData references of the map building data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		/*
		private function parseMapBuildingData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.children()){
					globalData.mapBuildingDataArray[index] = [];
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ID] = xmlList.attribute("id").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_NAME] = xmlList.attribute("name").toString(); 
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_FRAMENUMBER] = int(xmlList.attribute("fn"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_POSITION] = new Vector3D (Number(xmlList.attribute("x")), Number(xmlList.attribute("y")), Number(xmlList.attribute("z"))); 
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_LVLREQ] = int(xmlList.attribute("lvlreq"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_BLDGREQ] = xmlList.attribute("buildingreq").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_CURRENTROUND] = int(xmlList.attribute("currentround"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_NPCNAME] = xmlList.attribute("npcname").toString();
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_NPCFRAMENUMBER] = int(xmlList.attribute("npcfn"));
					globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS] = [];
					var index2:int = 0;
					for each (var xmlList2:XML in xmlList.children()){
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2] = [];
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDID] = xmlList2.attribute("id").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDTYPE] = xmlList2.attribute("type").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDDIFFICULTY] = int(xmlList2.attribute("difficulty"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDORDER] = int(xmlList2.attribute("order"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDLOCK] = xmlList2.attribute("status").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDDURATION] = int(xmlList2.attribute("timeduration"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDCOIN] = int(xmlList2.attribute("coin"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDAP] = int(xmlList2.attribute("ap"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDBOSSCRIPT] = xmlList2.attribute("bossscript").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDLVLREQ] = int(xmlList2.attribute("lvlreq"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCNAME] = xmlList2.attribute("npcname").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCLVL] = int(xmlList2.attribute("npclvl"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCGENDER] = xmlList2.attribute("npcgender").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCHEALTH] = int(xmlList2.attribute("npchealth"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCSING] = int(xmlList2.attribute("npcsing"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCINTELLIGENT] = int(xmlList2.attribute("npcintelligent"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCACTING] = int(xmlList2.attribute("npcacting"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCNPCATTRACTION] = int(xmlList2.attribute("npcattraction"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCBODYDEF] = xmlList2.attribute("npcbodydef").toString();
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCISBOSS] = int(xmlList2.attribute("isboss"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCREWARDEXP] = int(xmlList2.attribute("rewardexp"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCREWARDCOIN] = int(xmlList2.attribute("rewardcoin"));
						globalData.mapBuildingDataArray[index][GlobalData.MAPBUILDING_ROUNDS][index2][GlobalData.MAPBUILDING_ROUNDNPCCHARLVLREQ] = int(xmlList2.attribute("charlvlreq"));
						index2++;
					}
					index++;
				}
			}
		}*/
		
		
		/**
		 * Parses and sets the GlobalData references of the app setting data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseAppSettingData(Xml:XML):void{
			if (Xml != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				
				globalData.appBGM = int(Xml.attribute("bgm"));
				globalData.appSFX = int(Xml.attribute("sfx"));
				globalData.appGFX = int(Xml.attribute("gfx"));
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the character list data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseCharacterListData(Xml:XML):void{
			
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in xml){
					var xmlContent:XML = xmlList;
					globalData.charListDataArray[index] = [];
					globalData.charListDataArray[index][GlobalData.CHARLIST_ID] = xmlContent.attribute("id").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_POSITION] = new Vector3D (int(xmlContent.attribute("x")),int(xmlContent.attribute("y")),0);
					globalData.charListDataArray[index][GlobalData.CHARLIST_STATMAXEXP] = int(xmlContent.attribute("statmaxexp"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_GENDER] = xmlContent.elements("gender").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_NAME] = xmlContent.elements("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_DEFINITION] = xmlContent.elements("def").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTH] = int(xmlContent.elements("health"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_SING] = int(xmlContent.elements("sing"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING] = int(xmlContent.elements("act"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ATTRACTION] = int(xmlContent.elements("attraction"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_INTELLIGENCE] = int(xmlContent.elements("intelligent"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_LEVEL] = int(xmlContent.elements("level"));
					
					globalData.charListDataArray[index][GlobalData.CHARLIST_GRADE] = xmlContent.elements("grade").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_POPULAR] = int(xmlContent.elements("popular"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_STRESS] = int(xmlContent.elements("stress"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_CONDITION] = int(xmlContent.elements("cond"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_STATUS] = int(xmlContent.elements("status"));
					
					globalData.charListDataArray[index][GlobalData.CHARLIST_TIMELEFT] = int(xmlContent.elements("status").attribute("timeleft"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ITEMENTRYID] = xmlContent.elements("status").attribute("entryid").toString();
					
					
					globalData.charListDataArray[index][GlobalData.CHARLIST_WEARINGSPECIAL] = int(xmlContent.elements("wearingspecial"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTION1] = xmlContent.elements("anim1").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTION2] = xmlContent.elements("anim2").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTION3] = xmlContent.elements("anim3").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ISNEW] = int(xmlContent.elements("isnew"));
					
					//information for information popup
					globalData.charListDataArray[index][GlobalData.CHARLIST_SINGING_SHOUT] = int(xmlContent.elements("singing").attribute("shout"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_SINGING_EMPATHY] = int(xmlContent.elements("singing").attribute("empathy"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_SINGING_AUDIENCE] = int(xmlContent.elements("singing").attribute("audience"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_SINGING_INSTRUMENT] = int(xmlContent.elements("singing").attribute("instrument"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_SINGING_EXPERFORMANCE] = int(xmlContent.elements("singing").attribute("experformance"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING_MUSICAL] = int(xmlContent.elements("acting").attribute("musical"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING_EMOTION] = int(xmlContent.elements("acting").attribute("emotion"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING_MIME] = int(xmlContent.elements("acting").attribute("mime"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING_COMEDY] = int(xmlContent.elements("acting").attribute("comedy"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTING_ACTION] = int(xmlContent.elements("acting").attribute("action"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MODELING_GROTESQUE] = int(xmlContent.elements("modeling").attribute("grotesque"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MODELING_HOTPOSE] = int(xmlContent.elements("modeling").attribute("hotpose"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MODELING_STICKACTION] = int(xmlContent.elements("modeling").attribute("stickaction"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MODELING_BALANCE] = int(xmlContent.elements("modeling").attribute("balance"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MODELING_POWERWALKING] = int(xmlContent.elements("modeling").attribute("powerwalking"));
					
					/*//globalData.charListDataArray[index][GlobalData.CHARLIST_EXPERIENCE] = int(xmlContent.elements("exp"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MANAGER_NPC] = xmlContent.elements("manager").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_MANAGER_LEVEL] = int(xmlContent.elements("manager").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_MANAGER_NAME] = xmlContent.elements("manager").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_MANAGER_NPCFBID] = xmlContent.elements("manager").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_MANAGER_STATE] = xmlContent.elements("manager").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTHTRAINER_NPC] = xmlContent.elements("healthtrainer").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTHTRAINER_LEVEL] = int(xmlContent.elements("healthtrainer").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTHTRAINER_NAME] = xmlContent.elements("healthtrainer").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTHTRAINER_NPCFBID] = xmlContent.elements("healthtrainer").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_HEALTHTRAINER_STATE] = xmlContent.elements("healthtrainer").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_VOCALTRAINER_NPC] = xmlContent.elements("vocaltrainer").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_VOCALTRAINER_LEVEL] = int(xmlContent.elements("vocaltrainer").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_VOCALTRAINER_NAME] = xmlContent.elements("vocaltrainer").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_VOCALTRAINER_NPCFBID] = xmlContent.elements("vocaltrainer").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_VOCALTRAINER_STATE] = xmlContent.elements("vocaltrainer").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_PRIVATETEACHER_NPC] = xmlContent.elements("privateteacher").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_PRIVATETEACHER_LEVEL] = int(xmlContent.elements("privateteacher").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_PRIVATETEACHER_NAME] = xmlContent.elements("privateteacher").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_PRIVATETEACHER_NPCFBID] = xmlContent.elements("privateteacher").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_PRIVATETEACHER_STATE] = xmlContent.elements("privateteacher").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTINGTEACHER_NPC] = xmlContent.elements("actingteacher").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTINGTEACHER_STATE] = xmlContent.elements("actingteacher").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTINGTEACHER_NAME] = xmlContent.elements("actingteacher").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTINGTEACHER_LEVEL] = int(xmlContent.elements("actingteacher").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_ACTINGTEACHER_NPCFBID] = xmlContent.elements("actingteacher").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_STYLIST_NPC] = xmlContent.elements("stylist").attribute("npc").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_STYLIST_STATE] = xmlContent.elements("stylist").attribute("empty").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_STYLIST_NAME] = xmlContent.elements("stylist").attribute("name").toString();
					globalData.charListDataArray[index][GlobalData.CHARLIST_STYLIST_LEVEL] = int(xmlContent.elements("stylist").attribute("level"));
					globalData.charListDataArray[index][GlobalData.CHARLIST_STYLIST_NPCFBID] = xmlContent.elements("stylist").toString();*/
					
					index++;
					
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the character shop data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseCharacterShopData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.child("body").children()){
					globalData.charShopBodyDataArray[index] = [];
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_TYPE] = xmlList.attribute("type").toString();
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_ID] = xmlList.attribute("id").toString();
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_NAME] = xmlList.attribute("name").toString();
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_COIN] = int(xmlList.attribute("coin"));
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_CASH] = int(xmlList.attribute("cash"));
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_FRAMENUM] = int(xmlList.attribute("fn"));
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_DESCRIPTION] = xmlList.attribute("descrip").toString();
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_HOT] = int(xmlList.attribute("hot"));
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_NEW] = int(xmlList.attribute("new"));
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_EFFECT] = xmlList.attribute("eff").toString();
					globalData.charShopBodyDataArray[index][GlobalData.CHARSHOP_GENDER] = xmlList.attribute("gender").toString();
					index++;
				}
				index = 0;
				for each (xmlList in Xml.child("cloth").children()){
					globalData.charShopClothDataArray[index] = []
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_TYPE] = xmlList.attribute("type").toString();
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_ID] = xmlList.attribute("id").toString();
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_NAME] = xmlList.attribute("name").toString();
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_COIN] = int(xmlList.attribute("coin"));
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_CASH] = int(xmlList.attribute("cash"));
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_FRAMENUM] = int(xmlList.attribute("fn"));
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_DESCRIPTION] = xmlList.attribute("descrip").toString();
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_HOT] = int(xmlList.attribute("hot"));
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_NEW] = int(xmlList.attribute("new"));
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_EFFECT] = xmlList.attribute("eff").toString();
					globalData.charShopClothDataArray[index][GlobalData.CHARSHOP_GENDER] = xmlList.attribute("gender").toString();
					index++;
				}								
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the Character data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseCreateCharacterData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in xml){
					globalData.characterDataArray[index] = [];
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_PREMIUM] = Boolean(xmlList.attribute("premium"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_GENDER] = xmlList.elements("gender").toString();
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_DEFINITION] = xmlList.elements("def").toString();
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_NAME] = xmlList.elements("name").toString();
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_HEALTH] = int(xmlList.elements("health"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_SING] = int(xmlList.elements("sing"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_ACTING] = int(xmlList.elements("acting"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_ATTRACTION] = int(xmlList.elements("attraction"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_INTELLIGENCE] = int(xmlList.elements("intelligent"));
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_GRADE] = xmlList.elements("grade").toString();
					globalData.characterDataArray[index][GlobalData.CREATECHARACTER_SIGNATURE] = xmlList.elements("siggy").toString();
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the class price data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseClassPrice(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in xml){
					globalData.classPriceDataArray[index] = [];
					globalData.classPriceDataArray[index][GlobalData.CLASSPRICE_TYPE] = xmlList.elements("name").toString();
					globalData.classPriceDataArray[index][GlobalData.CLASSPRICE_TICKETREQ] = int(xmlList.elements("coin"));
					globalData.classPriceDataArray[index][GlobalData.CLASSPRICE_COINREQ] = int(xmlList.elements("ticket"));
					globalData.classPriceDataArray[index][GlobalData.CLASSPRICE_RANK] = int(xmlList.elements("rank"));
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the player data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parsePlayerData(Xml:XML):void{
			if (Xml != null){
				var globalData:GlobalData = GlobalData.instance;
				globalData.randMin = Number(Xml.attribute("randmin"));
				globalData.randMax = Number(Xml.attribute("randmax"));
				globalData.pFbid = Xml.elements("fbid").toString();
				globalData.pFname = Xml.elements("fbname").toString();
				globalData.pCoin = int(Xml.elements("coin"));
				globalData.coinLimit = int(Xml.elements("coinlimit"));
				globalData.pSp = int(Xml.elements("starpoint"));
				globalData.starPointLimit = int(Xml.elements("starlimit"));
				globalData.pAp = int(Xml.elements("ap"));
				globalData.actionPointLimit = int(Xml.elements("aplimit"));
				globalData.pNAp = int(Xml.elements("apnext"));
				globalData.pLvl = int(Xml.elements("lv"));
				globalData.levelLimit = int(Xml.elements("lvlimit"));
				globalData.pExp = int(Xml.elements("exp"));
				globalData.experienceLimit = int(Xml.elements("explimit"));
				globalData.pRSExp = int(Xml.elements("redstar"));
				globalData.pRSLvl = Math.floor(globalData.pRSExp / 100);
				globalData.pBSExp = int(Xml.elements("blackstar"));
				globalData.pBSLvl = Math.floor(globalData.pBSExp / 100);
				globalData.pChAmt = int(Xml.elements("charhired"));
				globalData.characterLimit = int(Xml.elements("charlimit"));
				//globalData.pId = Xml.elements("pid").toString();
				//globalData.appBGM = int(Xml.elements("bgm"));
				//globalData.appSFX = int(Xml.elements("sfx"));
				//globalData.appGFX = int(Xml.elements("gfx"));
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the friends data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseFriendsData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				for each (var xmlList:XML in Xml.children()){
					globalData.friendsDataArray[index] = [];
					globalData.friendsDataArray[index][GlobalData.FRIEND_OWN] = xmlList.attribute("me").toString();
					globalData.friendsDataArray[index][GlobalData.FRIEND_HELPINGENERGY] = int(xmlList.attribute("he"));
					globalData.friendsDataArray[index][GlobalData.FRIEND_FBID] = xmlList.attribute("fbid").toString();
					globalData.friendsDataArray[index][GlobalData.FRIEND_LEVEL] = int(xmlList.attribute("lvl"));
					globalData.friendsDataArray[index][GlobalData.FRIEND_NAME] = xmlList.attribute("name").toString();
					globalData.friendsDataArray[index][GlobalData.FRIEND_PICLINK] = xmlList.attribute("pic").toString();
					index++;
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the store data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseStoreData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var xml:XMLList = Xml.children();
				var globalData:GlobalData = GlobalData.instance;
				var xmlContent:XMLList = Xml.children();
				for (var x:int = 0; x<xmlContent.length(); x++){
					var xmlInst:XML = xmlContent[x];
					for each (var prod:XML in xmlInst.children()){					
						globalData.storeDataArray[index] = [];
						globalData.storeDataArray[index][GlobalData.STORE_CATEGORYNAME] = xmlInst.attribute("name").toString();
						globalData.storeDataArray[index][GlobalData.STORE_CATEGORYSOURCE] = xmlInst.attribute("source").toString();
						globalData.storeDataArray[index][GlobalData.STORE_PRODUCTNAME] = prod.attribute("name").toString();
						globalData.storeDataArray[index][GlobalData.STORE_PRODUCTPRICECOIN] = int(prod.attribute("pricecoin"));
						globalData.storeDataArray[index][GlobalData.STORE_PRODUCTPRICECREDIT] = int(prod.attribute("pricecredit"));
						globalData.storeDataArray[index][GlobalData.STORE_PRODUCTTYPE] = int(prod.attribute("type"));
						globalData.storeDataArray[index][GlobalData.STORE_PRODUCTDESCRIPTION] = prod.attribute("description").toString();
						index++;
					}
				}
			}
		}
		
		/**
		 * Parses and sets the GlobalData references of the office data.
		 *  
		 * @param Xml - the xml data to be parsed.
		 * 
		 */		
		
		private function parseOfficeData(Xml:XML):void{
			if (Xml.children() != null){
				var index:int = 0;
				var globalData:GlobalData = GlobalData.instance;
				globalData.officeName = Xml.attribute("name");
				
				for each (var xmlInst:XML in Xml.children()){
					var xml:XML = xmlInst;
					globalData.officeTileDataArray[index] = [];
					globalData.officeTileDataArray[index][GlobalData.OFFICE_POSITION] = new Vector3D (int(xml.attribute("x")), int(xml.attribute("y")), int(xml.attribute("z")));
					globalData.officeTileDataArray[index][GlobalData.OFFICE_FRAMENUMBER] = int(xml.attribute("fn"));
					globalData.officeTileDataArray[index][GlobalData.OFFICE_CATEGORY] = xml.attribute("cat").toString();
					globalData.officeTileDataArray[index][GlobalData.OFFICE_COLLISION] = int(xml.attribute("coll"));
					globalData.officeTileDataArray[index][GlobalData.OFFICE_ROTATION] = int(xml.attribute("rot"));
					globalData.officeTileDataArray[index][GlobalData.OFFICE_DIMENSION] = new Vector3D (int(xml.attribute("length")), int(xml.attribute("width")), int(xml.attribute("height")));
					index++;
				}
			}
		}
		
		/**
		 * Logs the error when the XML fails to load.
		 * 
		 * @param ev - event handler for the xml error.
		 * 
		 */		
		
		private function onLoadError(ev:IOErrorEvent):void{
			var len:int = _jobLoaderQueue.length;
			for (var x:int = 0; x<len; x++){
				if (ev.target == _jobLoaderQueue[x]){
					Logger.tracer(this, "Error loading XML file: " + _jobTypeQueue[x]);	
				}
			}
		}
		
	}
}