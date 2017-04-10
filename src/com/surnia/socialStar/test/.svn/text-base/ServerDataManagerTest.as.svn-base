package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.playerStatus.PlayerStatusManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.system.Security;
	import flash.text.TextField;

	
	[SWF (height = "630", width="760")]
	public class ServerDataManagerTest extends Sprite
	{
		private var _playerStatusManager:PlayerStatusManager;
		private var _testTextField:Array = [];
		private var _testinglink:TextField;
		
		public function ServerDataManagerTest()
		{
			Security.loadPolicyFile("crossdomain.xml");
			Security.allowDomain("202.124.129.14");
			Security.allowDomain("localhost");
			if (stage){
				init();
			} else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init (ev:Event = null):void{
			//ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, "http://1.234.2.179/socialstardev/players/ui");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICE_DATA, "http://1.234.2.179/socialstardev/data/officeui");
			//ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, "http://202.124.129.14/surnia/data/fl/default");
			//ServerDataExtractor.instance.updateData(GlobalData.STORE_DATA, "http://202.124.129.14/surnia/data/storeitems");
			//ServerDataExtractor.instance.updateData(GlobalData.STORE_DATA, "testXML/storeitems.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICE_DATA, "testXML/officeui.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, "testXML/playerui.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CREATECHAR_DATA, "testXML/createchar.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, "testXML/fl.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CLASSPRICE_DATA, "testXML/potentialclassprice.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CHARSHOP_DATA, "http://1.234.2.179/socialstardev/data/charitems");
			//ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, "testXML/charlistCharShop.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.APPSETTINGS_DATA, "testXML/settings.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, "testXML/bldgs.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.MAPCHARLIST_DATA, "testXML/mapcharlist.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICESHOP_DATA, "http://1.234.2.179/socialstardev/data/officeshop");
			//ServerDataExtractor.instance.updateData(GlobalData.CHARSHOP_DATA, "testXML/charitems.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, "testXML/charlist.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICESTORE_DATA, "testXML/officestore.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICEINVENTORY_DATA, "testXML/officeinventory.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICEINVENTORY_DATA, "testXML/officeinventory.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESSTORE_DATA, "testXML/clothesstore.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.CLOTHESINVENTORY_DATA, "testXML/clothesinventory.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.OFFICESTATE_DATA, "testXML/charlist.xml");
			//ServerDataExtractor.instance.updateData(GlobalData.LEVELAPTABLE_DATA, XMLLinkData.instance.offlineLevelAPListData);
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDROUTES_DATA, XMLLinkData.instance.offlineFriendRouteData);
			addListeners();
		}
		
		private function addListeners():void{
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDXML_LOADED, onDataLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICEXML_LOADED, onDataLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.PLAYERXML_LOADED, onDataLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.STOREXML_LOADED, onDataLoaded);
		}
		
		private function onDataLoaded(ev:SSEvent):void{
			var xml:XML;
			switch(ev.type)
			{
				case SSEvent.FRIENDXML_LOADED:
				{
					xml = GlobalData.instance.friendsDataXML;
					trace("friendXML: " +  xml);
					break;
				}
				case SSEvent.OFFICEXML_LOADED:
				{
					xml = GlobalData.instance.officeDataXML;
					trace("officeXML: " +  xml);
					break;
				}
				case SSEvent.PLAYERXML_LOADED:
				{
					xml = GlobalData.instance.playerDataXML;
					trace("playerXML: " +  xml);
					break;
				}
				case SSEvent.CREATECHARXML_LOADED:
				{
					xml = GlobalData.instance.characterDataXML;
					trace("characterXML: " +  xml);
					break;
				}
				case SSEvent.CLASSPRICEXML_LOADED:
				{
					xml = GlobalData.instance.classPriceDataXML;
					trace("classPriceXML: " +  xml);
					break;
				}
				default:
				{
					break;
				}
			}	
		}
	}
}