package
{
	import caurina.transitions.Tweener;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.utils.Logger;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.utils.getDefinitionByName;
	import mx.core.ByteArrayAsset;
	
	
	
	
	/**
	 * 
	 * Game preloader. Remeber to use this as a
	 * factory class with the main app.
	 * 
	 * @author hedrick david
	 * 
	 */	
	
	
	public class SocialStarLoader extends MovieClip
	{
		
		[Embed(source="../lib/Preloader01.swf", mimeType="application/octet-stream")]
		private var Preloader01Class:Class;
		
		[Embed(source="../lib/Preloader02.swf", mimeType="application/octet-stream")]
		private var Preloader02Class:Class;
		
		[Embed(source="../lib/Preloader03.swf", mimeType="application/octet-stream")]
		private var Preloader03Class:Class;
		
		private var _socialStarMC:MovieClip;
		private var _flashVars:Object;
		private var _loader:Loader;
		private var _byteArray:ByteArrayAsset;
		private var _loaderMC:MovieClip;
		private var _preloader:Sprite;
		private var _dataLoadingDone:Boolean = false;
		private var _loadingCrt:int = 0;
		private var _isOnline:Boolean = false;
		private var _totalXML:int = 12;		
		private var _xmlTriesArray:Array = [];
		private var _xmlLinks:XMLLinkData = XMLLinkData.instance;
		private var _xmlLoadingLimit:int = 3;
		private var _lastPercentLoaded:Number = 0;
		private var _loaderScaleX:Number = 0;
		private var _debugMode:Boolean = false;
		private var _gd:GlobalData = GlobalData.instance;
		//private var _fontManager:FontManager;
		/**
		 * 
		 * Constructor. Loads the swf and initializes loader info and other necessary 
		 * display objects.
		 * 
		 */		
		
		public function SocialStarLoader()
		{
			//_fontManager = FontManager.getInstance();			
			//_fontManager.loadSwfFont();
			
			Logger.tracer( this, "socialStarLoader testing WTF!!!!======================>>" );
			// Security initialize
			trace ("Loader starter...");
			
			/*
			if ( XMLLinkData.mainLink == "https://1.234.2.179/socialstardev/" ) {
				Security.loadPolicyFile("https://1.234.2.179/crossdomain.xml");
			}else if ( XMLLinkData.mainLink == "https://1.234.2.179/socialstardev/" ) {
				Security.loadPolicyFile("https://202.124.129.14/crossdomain.xml");
			}else if ( XMLLinkData.mainLink == "https://surniabeta.com/socialstardev/" ) {
				Security.loadPolicyFile("https://surniabeta.com/crossdomain.xml");
			}*/
			
			//https://202.124.129.14/socialstars/
			Security.loadPolicyFile(_gd.domain + "crossdomain.xml" );
			
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("1.234.2.179");
			Security.allowDomain("http://www.facebook.com");
			Security.allowDomain("http://apps.facebook.com");
			Security.allowDomain("http://graph.facebook.com");
			Security.allowDomain("202.124.129.14");
			Security.allowDomain("https://surniabeta.com");
			Security.allowDomain("https://surniabeta.com/socialstardev/");
			Security.allowDomain( _gd.absPath + "offices/questlist");
			Security.allowDomain("https://1.234.2.179/socialstardev/");
			//https://fbcdn-profile-a.akamaihd.net/
			Security.allowDomain("https://202.124.129.14/socialstars/");
			
			// remove or comment when in release
			Security.allowDomain("localhost");
		
			stop();
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			// will be used as the main container of the application
			_socialStarMC = new MovieClip();
			addChild(_socialStarMC);
			_preloader = new Sprite();
			addChild(_preloader);
			//randPreloader();
			randPreloader();
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderComplete, false, 0, true);
			_loader.loadBytes(_byteArray);
			//trace (loaderInfo.bytesLoaded/loaderInfo.bytesTotal);
			_flashVars = LoaderInfo(stage.loaderInfo).parameters;
			
			
			var runningOn:String = Capabilities.playerType;
			
			if( runningOn != 'StandAlone' ){
				_isOnline = true;
				trace( "online mode..." );
			}else {
				_isOnline = false;
				trace( "stand alone mode..." );
			}			
			
			populateTriesArray();
		}
		
		private function populateTriesArray():void{
			for (var x:int = 0; x<_totalXML; x++){
				_xmlTriesArray[x] = 0;
			}
		}
		
		private function loadPrerequisiteData():void 
		{
			trace ("Server data update calls started...");
			var runningOn:String = Capabilities.playerType;
			trace( "[SocialStarLoader]: check capabilities", runningOn );
			
			if (_isOnline == true) {
				trace( "gd.abspath ==>", _gd.absPath );
				trace( "check links aptable :", XMLLinkData.instance.onlineLevelAPTableListData );
				trace( "check links fiendsdata :", XMLLinkData.instance.onlineFriendsData );
				trace( "check links playerData:", XMLLinkData.instance.onlinePlayerData );
				trace( "check links online charlist :", XMLLinkData.instance.onlineCharListData );
				trace( "check links online map building :", XMLLinkData.instance.onlineMapBuildingData);
				
				ServerDataExtractor.instance.updateData(GlobalData.LEVELAPTABLE_DATA, XMLLinkData.instance.onlineLevelAPTableListData );
				ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, XMLLinkData.instance.onlineFriendsData );
				ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, XMLLinkData.instance.onlinePlayerData );
				//ServerDataExtractor.instance.updateData(GlobalData.CREATECHAR_DATA, XMLLinkData.instance.onlineCharHireData);
				ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, XMLLinkData.instance.onlineCharListData );
				ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, XMLLinkData.instance.onlineMapBuildingData);
				ServerDataExtractor.instance.updateData(GlobalData.OFFICESTORE_DATA, XMLLinkData.instance.onlineOfficesStoreData);
				//ServerDataExtractor.instance.updateData(GlobalData.OFFICEINVENTORY_DATA, XMLLinkData.instance.onlineOfficesInventoryData);
				//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESSTORE_DATA, XMLLinkData.instance.onlineCharShopData);
				//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESINVENTORY_DATA, XMLLinkData.instance.onlineCharactersInventory);
				ServerDataExtractor.instance.updateData(GlobalData.OFFICESTATE_DATA, XMLLinkData.instance.onlineOfficeStateData);
				ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData);
				ServerDataExtractor.instance.updateData(GlobalData.FRIENDROUTES_DATA, XMLLinkData.instance.onlineFriendRoutesData);
				ServerDataExtractor.instance.updateData(GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.onlineCollectionListData);
				ServerDataExtractor.instance.updateData(GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.onlineMaterialListData);
				ServerDataExtractor.instance.updateData(GlobalData.CHALLENGEVALUES_DATA, XMLLinkData.instance.onlineChallengeValuesData);
				addDataListeners();
			} else {
				ServerDataExtractor.instance.updateData(GlobalData.LEVELAPTABLE_DATA, XMLLinkData.instance.offlineLevelAPListData);
				ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, XMLLinkData.instance.offlineFriendsData);
				ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, XMLLinkData.instance.offlinePlayerData);
				//ServerDataExtractor.instance.updateData(GlobalData.CREATECHAR_DATA, XMLLinkData.instance.offlineCharHireData);
				ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, XMLLinkData.instance.offlineCharListData);
				ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, XMLLinkData.instance.offlineMapBuildingData);
				ServerDataExtractor.instance.updateData(GlobalData.OFFICESTORE_DATA, XMLLinkData.instance.offlineOfficesStoreData);
				//ServerDataExtractor.instance.updateData(GlobalData.OFFICESTORE_DATA, "http://1.234.2.179/socialstardev/public/tests/andrew/officeShop1.xml");
				//ServerDataExtractor.instance.updateData(GlobalData.OFFICEINVENTORY_DATA, XMLLinkData.instance.offlineOfficesInventoryData);
				//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESSTORE_DATA, XMLLinkData.instance.offlineCharShopData);
				//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESINVENTORY_DATA, XMLLinkData.instance.offlineCharactersInventory);
				ServerDataExtractor.instance.updateData(GlobalData.OFFICESTATE_DATA, XMLLinkData.instance.offlineOfficeStateData);
				ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.offlineQuestListData);
				ServerDataExtractor.instance.updateData(GlobalData.FRIENDROUTES_DATA, XMLLinkData.instance.offlineFriendRouteData);
				ServerDataExtractor.instance.updateData(GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.offlineCollectionListData);
				ServerDataExtractor.instance.updateData(GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.offlineMaterialListData);			
				ServerDataExtractor.instance.updateData(GlobalData.CHALLENGEVALUES_DATA, XMLLinkData.instance.offlineChallengeValuesData);
				addDataListeners();
			}
		}
		
		/**
		 * 
		 * Adds event listeners to listen when data category is loaded.  dispatchESEvent SSEvent.FRIENDXML_LOADED,
		 *  
		 */		
		
		public function addDataListeners():void {
			trace('\n SocialStarLoader loaded xml files');
			EventSatellite.getInstance().addEventListener(SSEvent.LEVELAPTABLEXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.PLAYERXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.CREATECHARXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.CHARLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.MAPBUILDINGXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICESTOREXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICEINVENTORYXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.CLOTHESSTOREXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.CLOTHESINVENTORYXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICESTATEXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.QUESTLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDROUTESXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.COLLECTIONLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.MATERIALLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.CHALLENGEVALUESXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.XMLLOAD_ERROR, onListenerError);
		}
		
		/**
		 * 
		 * Removes event listeners to listen when data category is loaded. 
		 *  
		 */		
		
		public function removeListeners():void {
			trace('\n SocialStarLoader loaded xml files');
			EventSatellite.getInstance().removeEventListener(SSEvent.LEVELAPTABLEXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.FRIENDXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.PLAYERXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.CREATECHARXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.CHARLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.MAPBUILDINGXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.OFFICESTOREXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.OFFICEINVENTORYXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.CLOTHESSTOREXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.CLOTHESINVENTORYXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.OFFICESTATEXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.QUESTLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.FRIENDROUTESXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.COLLECTIONLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.MATERIALLISTXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.CHALLENGEVALUESXML_LOADED, onListenerLoaded);
			EventSatellite.getInstance().removeEventListener(SSEvent.XMLLOAD_ERROR, onListenerError);
		}
		
		public function setUpdateData (type:String, link:String):void{
			if (_isOnline == true){
				ServerDataExtractor.instance.updateData(type, link);
			} else {
				ServerDataExtractor.instance.updateData(type, link);
			}
		}
		
		public function onListenerError(ev:SSEvent):void{
			var type:String = ev.params.type;
			switch(type)
			{
				case SSEvent.FRIENDXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.FRIENDS] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.FRIENDXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.FRIENDXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.FRIENDS] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.FRIENDS] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.PLAYERXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.PLAYER] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.PLAYERXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.PLAYERXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.PLAYER] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.PLAYER] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					} 
					break;
				}
				case SSEvent.CREATECHARXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.CREATECHAR] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.CREATECHARXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.CREATECHARXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.CREATECHAR] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.CREATECHAR] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.CHARLISTXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.CHARLIST] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.CHARLISTXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.CHARLISTXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.CHARLIST] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.CHARLIST] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.MAPBUILDINGXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.MAPBUILDING] >= _xmlLoadingLimit){
						ServerDataExtractor.instance.updateData(SSEvent.MAPBUILDINGXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.MAPBUILDINGXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.MAPBUILDING] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.MAPBUILDING] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.OFFICESTOREXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.OFFICESTORE] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.OFFICESTOREXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.OFFICESTOREXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.OFFICESTORE] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.OFFICESTORE] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.OFFICEINVENTORYXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.OFFICEINVENTORY] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.OFFICEINVENTORYXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.OFFICEINVENTORYXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.OFFICEINVENTORY] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.OFFICEINVENTORY] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.CLOTHESSTOREXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.CLOTHESSTORE] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.CLOTHESSTOREXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.CLOTHESSTOREXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.CLOTHESSTORE] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.CLOTHESSTORE] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.CLOTHESINVENTORYXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.CLOTHESINVENTORY] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.CLOTHESINVENTORYXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.CLOTHESINVENTORYXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.CLOTHESINVENTORY] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.CLOTHESINVENTORY] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.OFFICESTATEXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.OFFICESTATE] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.OFFICESTATEXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.OFFICESTATEXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.OFFICESTATE] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.OFFICESTATE] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.QUESTLISTXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.QUESTLIST] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.QUESTLISTXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.QUESTLISTXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.QUESTLIST] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.QUESTLIST] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}	
				case SSEvent.LEVELAPTABLEXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.LEVELAPTABLE] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.LEVELAPTABLEXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.LEVELAPTABLEXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.LEVELAPTABLE] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.LEVELAPTABLE] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}	
				case SSEvent.FRIENDROUTESXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.FRIENDROUTES] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.FRIENDROUTESXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.FRIENDROUTESXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.FRIENDROUTES] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.FRIENDROUTES] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}	
				case SSEvent.COLLECTIONLISTXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.COLLECTIONLIST] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.COLLECTIONLISTXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.COLLECTIONLISTXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.COLLECTIONLIST] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.COLLECTIONLIST] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.MATERIALLISTXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.MATERIALLIST] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.MATERIALLISTXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.MATERIALLISTXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.MATERIALLIST] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.MATERIALLIST] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
				case SSEvent.CHALLENGEVALUESXML_LOADED:
				{
					if (_xmlTriesArray[GlobalData.CHALLENGEVALUES] >= _xmlLoadingLimit) {
						ServerDataExtractor.instance.updateData(SSEvent.CHALLENGEVALUESXML_LOADED, _xmlLinks.getOnOffLinks(SSEvent.CHALLENGEVALUESXML_LOADED, _isOnline));
						_xmlTriesArray[GlobalData.CHALLENGEVALUES] += 1;
						trace (type + ": Tried for " + _xmlTriesArray[GlobalData.CHALLENGEVALUES] + "times...");
					} else {
						trace ("loading limit exceeded for loading xml type: " + type);
					}
					break;
				}
			}
		}
		
		/**
		 * 
		 * @param ev - event handler for loaded xml data.
		 * 
		 */		
		
		public function onListenerLoaded(ev:SSEvent):void{
			switch(ev.type)
			{
				case SSEvent.FRIENDXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.FRIENDXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.FRIENDS] += 1;
					break;
				}
				case SSEvent.PLAYERXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.PLAYERXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					_xmlTriesArray[GlobalData.PLAYER] += 1;
					trace("loadedXML's: " + _loadingCrt);
					break;
				}
				case SSEvent.CREATECHARXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.CREATECHARXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.CREATECHAR] += 1;
					break;
				}
				case SSEvent.CHARLISTXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.CHARLISTXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.CHARLIST] += 1;
					break;
				}
				case SSEvent.MAPBUILDINGXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.MAPBUILDINGXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.MAPBUILDING] += 1;
					break;
				}
				case SSEvent.OFFICESTOREXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.OFFICESTOREXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.OFFICESTORE] += 1;
					break;
				}
				case SSEvent.OFFICEINVENTORYXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.OFFICEINVENTORYXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.OFFICEINVENTORY] += 1;
					break;
				}
				case SSEvent.CLOTHESSTOREXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.CLOTHESSTOREXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.CLOTHESSTORE] += 1;
					break;
				}
				case SSEvent.CLOTHESINVENTORYXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.CLOTHESINVENTORYXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.CLOTHESINVENTORY] += 1;
					break;
				}
				case SSEvent.OFFICESTATEXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.OFFICESTATEXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.OFFICESTATE] += 1;
					break;
				}
				case SSEvent.QUESTLISTXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.QUESTLISTXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.QUESTLIST] += 1;
					break;
				}
				case SSEvent.LEVELAPTABLEXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.LEVELAPTABLEXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.LEVELAPTABLE] += 1;
					break;
				}
				case SSEvent.FRIENDROUTESXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.FRIENDROUTESXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.FRIENDROUTES] += 1;
					break;
				}
				case SSEvent.COLLECTIONLISTXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.COLLECTIONLISTXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.COLLECTIONLIST] += 1;
					break;
				}
				case SSEvent.MATERIALLISTXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.MATERIALLISTXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.MATERIALLIST] += 1;
					break;
				}
				case SSEvent.CHALLENGEVALUESXML_LOADED:
				{
					EventSatellite.getInstance().removeEventListener(SSEvent.CHALLENGEVALUESXML_LOADED, onListenerLoaded);
					_loadingCrt++;
					trace("loadedXML's: " + _loadingCrt);
					_xmlTriesArray[GlobalData.CHALLENGEVALUES] += 1;
					break;
				}	
			}
			// adjust the scale
			var amountToAdd:Number = round(.25 / _totalXML, 2);
			_loaderScaleX += amountToAdd;
			Tweener.addTween(_loaderMC.preloaderBar.loaderBar, {scaleX: round(_loaderScaleX,2), time: .4});
			if (_debugMode){
				Logger.tracer( this,"Using root loaderInfo - bytesLoaded: " + root.loaderInfo.bytesLoaded + " / bytesTotal: " + root.loaderInfo.bytesTotal);
				Logger.tracer( this,"_loaderScaleX: " + round (_loaderScaleX, 2));
				Logger.tracer( this,"scaleX: " +  _loaderMC.preloaderBar.loaderBar.scaleX);
			}
			//Logger.tracer( this,"Using root loaderInfo - bytesLoaded: " + root.loaderInfo.bytesLoaded + " / bytesTotal: " + root.loaderInfo.bytesLoaded);
			// enables the init function.
			if (_loadingCrt >= _totalXML){
				_dataLoadingDone = true;
			}else {
				_dataLoadingDone = false;
			}
		}
		
		/**
		 * 
		 * Adds to display the loaded preloader and initializes
		 * the necessary attributes.
		 * 
		 * @param ev - event listener for the context loader info.
		 * 
		 */
		
		private function onLoaderComplete(ev:Event):void{			
			//FLASHVARS CODE			
			var varName:String;
			var  myFlashVar:String;
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			//var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters.abspath;
			for (varName in paramObj){
				myFlashVar = String(paramObj[varName]);
				trace( "myFlashVar", myFlashVar , "varName", varName );
				
				if ( varName == "abspath" ){
					_gd.absPath = myFlashVar;
				}else if ( varName == "domain" ) {
					_gd.domain = myFlashVar;
				}else if ( varName == "screenWidth" ) {
					_gd.screenWidth = int( myFlashVar );
				}else if ( varName == "screenHeight" ) {
					_gd.screenHeight = int( myFlashVar );
				}else if ( varName == "offsetWidth" ) {
					_gd.offsetWidth = int( myFlashVar );
				}else if ( varName == "offsetHeight" ) {
					_gd.offsetHeight = int( myFlashVar );
				}
			}
			
			//if (myFlashVar == null){
				//_gd.absPath = XMLLinkData.mainLink;
			//}
			
			Logger.tracer( this,"onloaderComplete==================================>>"  );
			trace ("LoaderMC collected...");
			_loaderMC = MovieClip(_loader.content);
			_preloader.addChild(_loaderMC);
			_loaderMC.stop();
			_loaderMC.preloaderText.text = "Loading Social Star...";
			_loaderMC.preloaderText.mouseEnabled = false;
			_loaderMC.preloaderBar.loaderBar.scaleX = 0;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			addEventListener(Event.ENTER_FRAME, onFrame);			
			
			if ( _gd.isDebug ){
				trace( "[SocialStarLoader]: is in debug we will used default values" );
				if( _gd.islocal ){
					//_gd.absPath = "https://202.124.129.14/socialstarsrez/";
					_gd.absPath = "https://202.124.129.14/socialstars/";
					_gd.domain = "https://202.124.129.14/";
					_gd.offsetWidth = 1600;
					_gd.offsetHeight = 900;
					_gd.screenWidth = 1600;
					_gd.screenHeight = 900;
				}else {
					_gd.absPath = "https://surniabeta.com/socialstardev/";
					_gd.domain = "https://surniabeta.com/";
					_gd.offsetWidth = 1600;
					_gd.offsetHeight = 900;
					_gd.screenWidth = 1600;
					_gd.screenHeight = 900;
				}
			}			
			
			trace( "[SocialStarLoader]: check values offsetWidth", _gd.offsetWidth, "offsetHeight", _gd.offsetHeight, "screenWidth", _gd.screenWidth, "screenHeight", _gd.screenHeight  );
			XMLLinkData.instance.updateLinkData();
			loadPrerequisiteData();
		}
		
		private function loadProgress(ev:ProgressEvent):void {
			updatePreloader();
			//Logger.tracer( this,"Using progress loaderInfo - bytesLoaded: " + root.loaderInfo.bytesLoaded + " / bytesTotal: " + root.loaderInfo.bytesTotal);
			//Tweener.addTween(_loaderMC.preloaderBar.loaderBar, {time:.2, onUpdate:onLoaderUpdate});
			//trace ("frame triggered");
			//Logger.tracer( this,"frame triggered" );
			//Logger.tracer( this,"Using progres event - bytesLoaded: " + ev.bytesLoaded + " / bytesTotal: " + ev.bytesTotal);
			//Logger.tracer( this,"Using root loaderInfo - bytesLoaded: " + root.loaderInfo.bytesLoaded + " / bytesTotal: " + root.loaderInfo.bytesLoaded);
			//Logger.tracer( this,"scaleX: " +  _loaderMC.preloaderBar.loaderBar.scaleX);
			
			//trace (Number (percentLoaded) + " : " + Number(_lo
			//_loaderMC.preloaderBar.loaderBar.scaleX = percentLoaded;
			//_loaderMC.preloaderBar.loaderBar.scaleX = root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal;
			//trace (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal);
		}
		
		private function updatePreloader():void{
			var percentLoaded:Number = round((root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal)* .75, 2);
			var incrementValue:Number = round(percentLoaded - _lastPercentLoaded, 2);
			//scaleBar.scaleX += incrementValue;
			_loaderScaleX += incrementValue;
			Tweener.addTween(_loaderMC.preloaderBar.loaderBar,  {scaleX:round (_loaderScaleX, 2), time: .4});
			if (_debugMode){
				Logger.tracer( this, "percentLoaded: " + percentLoaded + "  " + "incrementValue: " + incrementValue);
				Logger.tracer( this,"_loaderScaleX: " + round (_loaderScaleX, 2));
				Logger.tracer( this,"scaleX: " + _loaderMC.preloaderBar.loaderBar.scaleX);
			}
			//Logger.tracer( this,"Using root loaderInfo - bytesLoaded: " + root.loaderInfo.bytesLoaded + " / bytesTotal: " + root.loaderInfo.bytesTotal);
			_lastPercentLoaded = percentLoaded;
		}
		
		/**
		 * 
		 * Initializes the main program when
		 * all the frames has been loaded.
		 * 
		 * @param ev -  frame event handler 
		 * 
		 */
		
		private function onFrame(ev:Event):void {
			//Logger.tracer( this,"onFrame==================================>>"  );
			//Logger.tracer( this,"framesLoaded: " + framesLoaded + " / totalFrames: " + totalFrames);	
			if (framesLoaded == totalFrames){
				//trace ("Loading Complete...");
				//Logger.tracer( this,"Loading complete==================================>>"  );
				updatePreloader();
				if (_dataLoadingDone == true){
					
					loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
					removeEventListener(Event.ENTER_FRAME, onFrame);
					nextFrame();
					init();
					//Logger.tracer( this,"call init n ==================================>>"  );
				}
			} /*else {
				//Tweener.addTween(_loaderMC.preloaderBar.loaderBar, {time:.2, onUpdate:onLoaderUpdate});
				//trace ("frame triggered");
				Logger.tracer( this,"frame triggered"  );
				Logger.tracer( this,"bytesLoaded: " + loaderInfo.bytesLoaded + " / bytesTotal: " + loaderInfo.bytesTotal);
				var percentLoaded:Number = round(loaderInfo.bytesLoaded/loaderInfo.bytesTotal, 2);
				var scaleBar:Sprite = _loaderMC.preloaderBar.loaderBar; 
				TweenLite.to(scaleBar, .4, {scaleX:Number(percentLoaded)});
				Logger.tracer( this,"scaleX: " +  _loaderMC.preloaderBar.loaderBar.scaleX);
				//trace (Number (percentLoaded) + " : " + Number(_loaderMC.preloaderBar.loaderBar.scaleX));
				//_loaderMC.preloaderBar.loaderBar.scaleX = percentLoaded;
				//_loaderMC.preloaderBar.loaderBar.scaleX = root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal;
				//trace (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal);
			}*/
		}
		
		private function round(value:Number, precision:int):Number{
			var decimal:Number = Math.pow(10, precision);
			return Math.round(decimal * value) / decimal;
		}
		
		private function onLoaderUpdate ():void{	
			
		}
		
		/**
		 * 
		 * Generates a random number based on the number of 
		 * preloader instances.
		 * 
		 */
		
		private function randPreloader ():void{
			var rand:int = Math.random() * 2.99;
			switch(rand)
			{
				case 0:
				{
					_byteArray = new Preloader01Class();
					break;
				}
				case 1:
				{
					_byteArray = new Preloader02Class();
					break;
				}
				case 2:
				{
					_byteArray = new Preloader03Class();
					break;
				}
			}
		}
		
		/**
		 *
		 * Initializes the main class after all frames has 
		 * been loaded. 
		 * 
		 */		
		
		private function init():void {			
			// The class name may vary
			Logger.tracer( this, "load init!!!!!!!!!!!!!!!!!!!!!=================>>" );
			removeListeners();
			var mainClass:Class = Class(getDefinitionByName("SocialStar"));
			if(mainClass){
				var app:Object = new mainClass();
				_socialStarMC.addChild(app as DisplayObject);
				setPreloaderMessage("Starting game...");
				//_loaderMC.preloaderBar.loaderBar.scaleX = 1;
				TweenLite.to(_loaderMC.preloaderBar.loaderBar, .4, {scaleX:1});
				TweenLite.to(_loaderMC.preloaderText, .5, {y: 650, alpha:0, delay:1, onComplete:removePreloader});
				TweenLite.to(_loaderMC.preloaderBar, .5, {y: 700, alpha:0, delay:1});
				TweenLite.to(_loaderMC, .5, {alpha:0, delay:1});
				app.applicationStart(_socialStarMC);
			}
		}
		
		public function callme():void 
		{
			trace( "[SS preloader]:........................................................................." );
		}
		
		/**
		 *
		 * Removes the preloader interface after loading. 
		 * 
		 */		
		
		private function removePreloader():void{
			var parent:DisplayObjectContainer = _loaderMC.parent;
			parent.removeChild(_loaderMC);
			_loaderMC = null;
		}
		
		/**
		 * 
		 * Sets the display text of the preloader.
		 * 
		 * @param message - the message to be displayed
		 * above the loader.
		 * 
		 */
		
		private function setPreloaderMessage(message:String):void{
			_loaderMC.preloaderText.text = message;
		}
	}
}