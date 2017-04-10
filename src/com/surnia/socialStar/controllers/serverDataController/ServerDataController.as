﻿package com.surnia.socialStar.controllers.serverDataController
{
	//import com.adobe.serialization.json.JSON;
	//import com.adobe.utils.IntUtil;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.loading.ImageLoader;
	import com.surnia.socialStar.controllers.EventSatellite;	
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.controllers.imageLoader.ImageLoaders;
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import com.surnia.socialStar.data.QuestRewardData;
	import com.surnia.socialStar.data.RewardData;
	import com.surnia.socialStar.data.SceneData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.data.contestantData.ContestantData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemCharData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemDressData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemPowerData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemStructureData;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	import com.surnia.socialStar.utils.base64.Base64;
	import com.surnia.socialStar.utils.dataManager.DataManager;
	import com.surnia.socialStar.utils.dataManager.events.DataManagerEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import flash.geom.Vector3D;
	import flash.system.Capabilities;	
	
	/**
	 * ...
	 * @author JC
	 */
	public class ServerDataController
	{
		/*---------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		private static var _instance:ServerDataController;
		private var _globalData:GlobalData;
		private var _sdcEvent:ServerDataControllerEvent;
		private var _es:EventSatellite;
		private var _xmlExtractor:XMLExtractor;
		//private var xml:XML;
		
		private var _playerStatusEvent:PlayerStatusEvent;
		private var _jsManager:JsManager;
		private var _dialogue:DialogueEvent;
		private var _popUIManager:PopUpUIManager;
		
		private var _myContestant:ContestantData;
		private var _friendContestant:ContestantData;
		
		//new event scne
		private var _imageLoader:ImageLoaders;
		private var _eventSceneImageCount:int;
		private var _eventSceneImageSet:Array;
		private var _sceneData:SceneData;
		private var _gd:GlobalData = GlobalData.instance;
		
		private var _imageStorage:ImageStorage;
		private var _holder:MovieClip;
		private var _ssiImageCnt:int;
		private var _gImageLoader:ImageLoader;
		
		private var _sceneXml:XML;
		private var _sceneTracker:int;
		
		/*---------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		public function ServerDataController(enforcer:SingletonEnforcer)
		{
			init();
		}
		
		public static function getInstance():ServerDataController
		{
			if (ServerDataController._instance == null)
			{
				ServerDataController._instance = new ServerDataController(new SingletonEnforcer());
			}
			return ServerDataController._instance;
		}
		
		/*---------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		
		private function init():void
		{
			trace("init ..... server data Controller..............");
			_es = EventSatellite.getInstance();
			_globalData = GlobalData.instance;
			_jsManager = JsManager.getInstance();
			_popUIManager = PopUpUIManager.getInstance();
			_imageLoader = ImageLoaders.getInstance();
			
			_es.addEventListener(SSEvent.PLAYERXML_LOADED, onPlayerXmlLoaded);
			//_es.addEventListener(PopUIEvent.VISIT_TO_HELP_FRIEND, onUpdateVisitFriendView);
			//_es.addEventListener(PopUIEvent.VISIT_TO_CHALLENGE_FRIEND, onUpdateChallengeFriendView);
		}
		
		public function endTutorial():void
		{
			//http://1.234.2.179/socialstardev/offices/tutorialdone updateCharlist(
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onDoneTutorialComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onDoneTutorialFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/tutorialdone");
		}
		
		//get stress data from server
		//WI BOX
		public function stressDownByItem(cid:String, entryid:String = "pEDvBjPmN8BaFO7491IQ"):void
		{
			if (!_globalData.friendView)
			{
				// added and changed the value input to that of the objects ap cost
				var objectData:Array = _gd.getOfficeStateDataByEntryID(entryid);
				setPlayerActionPoints(-objectData[GlobalData.OFFICESTATE_APCOST]);
				var machineArr:Array = _globalData.getOfficeStateDataByEntryID(entryid);
				var stress:int = machineArr[GlobalData.OFFICESTATE_REST_STRESS];
				
				if (_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] - stress > 0)
				{
					_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] -= stress;
				}
				else
				{
					_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] -= _globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS];
				}
			}
			else
			{
				if (_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] > 0)
				{
					machineArr = _globalData.getFriendOfficeStateDataByEntryID(entryid);
					stress = machineArr[GlobalData.FRIENDOFFICESTATE_REST_STRESS];
					_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] -= stress;
				}
				else
				{
					_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] = 0;
				}
			}
			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onStressDownCharByItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onStressDownCharByItemFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/stressdown/" + cid + "/item/" + entryid);
			trace("[ SDC ] stressDownByItem............................................");
		}
		
		public function stressDownByClick(cid:String, fbid:String):void
		{
			trace("[SDC] stress down character _gd.myFbId: ", _globalData.myFbId + "_gd.selectedFriendFbId" + _globalData.selectedFriendFbId);
			trace("[SDC] stress down character check 2====>>> _gd.myFbId: ", GlobalData.instance.myFbId + "_gd.selectedFriendFbId" + GlobalData.instance.selectedFriendFbId);
			if (!_globalData.friendView)
			{
				setPlayerActionPoints(-1);
				if (_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] > 0)
				{
					_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] -= 10;
				}
				else
				{
					_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] = 0;
				}
			}
			else
			{
				if (_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] <= 100)
				{
					_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] -= 10;
				}
				else
				{
					_globalData.getFriendCharDataOnCharID(cid)[GlobalData.FRIENDCHARLIST_STRESS] = 0;
				}
			}
			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onStressDownCharByClickComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onStressDownCharByClickFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/stressdown/" + cid + "/neighbor/" + fbid);
			trace("[ SDC ] stressDownByClick............................................");
		}
		
		//soothing with item
		//for cry
		private function soothMyChar(cid:String, entryid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSoothMyCharComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSoothMyCharFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/soothitem/" + cid + "/" + entryid);
			trace("[ SDC ] soothing mychar.................................................");
			//http://1.234.2.179/socialstardev/characters/soothitem/charid/entryid
		}
		
		//sooth
		//- stress //dual me and my friends clicking
		public function soothChar(cid:String, fbid:String):void
		{
			//http://1.234.2.179/socialstardev/characters/sooth/charid/neighbor/fbid
			trace(_gd.absPath + "characters/sooth/" + cid + "/neighbor/" + fbid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSoothCharComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSoothCharFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/sooth/" + cid + "/neighbor/" + fbid);
		}
		
		// + stress
		public function startTrain(cid:String, entryid:String, trainingObj:Object, rush:String = "0"):void
		{
			setOfficeObjectInUsed(entryid, 1);
			setQuickCharDataByCharID(cid, trainingObj);
			// added and changed the value input to that of the objects ap cost
			var objectData:Array = _gd.getOfficeStateDataByEntryID(entryid);
			setPlayerActionPoints(-objectData[GlobalData.OFFICESTATE_APCOST]);
			trace("[SDC ]: start training link", _gd.absPath + "offices/starttraining/" + entryid + "/" + cid + "/" + rush);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onStartTrainComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onStartTrainFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/starttraining/" + entryid + "/" + cid + "/" + rush);
		}
		
		public function setOfficeObjectInUsed(entryid:String, val:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetOfficeObjectInUsedComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetOfficeObjectInUsedFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/itemusage/" + entryid + "/" + val);
		}
		
		public function buyUpdateWallTile(id:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUpdateTileWallComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUpdateTileWallFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/applytile/" + id);
			trace("[SDC]: buyUpdateWalltile: ", _gd.absPath + "offices/applytile/" + id);
		}
		
		public function endTrain(cid:String, x:int, y:int, z:int = 1):void
		{
			trace("[SDC]: End Training link: ", _gd.absPath + "offices/endtraining/" + cid + "/" + x + "/" + y + "/" + z);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onEndTrainComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onEndTrainFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/endtraining/" + cid + "/" + x + "/" + y + "/" + z);
		}
		
		public function cryChar(cid:String):void
		{
			trace("[ SDC ]:", _gd.absPath + "characters/cry/" + cid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCryCharComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCryCharFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/cry/" + cid);
		}
		
		public function setPlayerCoin(val:int):void
		{
			trace("val tobe calc!!!!!!!!!", val, " _globalData.pCoin:  ", _globalData.pCoin);
			if (_globalData.pCoin > 0)
			{
				trace("2nd catch!................", val, "_globalData.pCoin", _globalData.pCoin);
				var checker:int = val * -1;
				if (checker <= _globalData.pCoin)
				{
					trace("_globalData.pCoin b4", _globalData.pCoin);
					_globalData.pCoin += val;
					trace("_globalData.pCoin after", _globalData.pCoin);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_COIN_CHANGE);
					_es.dispatchESEvent(_sdcEvent);
					
					if (_globalData.pCoin <= 500)
					{
						coinDepleted();
					}
				}
				else
				{
					coinDepleted();
				}
			}
			else
			{
				coinDepleted();
				trace("1st trap!!!!!!", val, "_globalData.pCoin", _globalData.pCoin);
			}
		}
		
		public function updatePlayerCoin(val:int):void
		{
			_globalData.pCoin = val;
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_COIN_CHANGE);
			_es.dispatchESEvent(_sdcEvent);
		}
		
		public function updatePlayerAp(val:int):void
		{
			_globalData.pAp = val;
			if (_globalData.pAp <= _globalData.actionPointLimit)
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE);
				_es.dispatchESEvent(_sdcEvent, _globalData.pAp);
			}
		}
		
		public function setOfficeName(officename:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetOfficeNameComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetOfficeNameFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/renameoffice/" + officename);
			trace("[ SDC ] setting office name............................................");
		}
		
		public function setStarPoint(val:int):void
		{
			if (_globalData.pSp <= 0)
			{
				coinDepleted();
			}
			else
			{
				trace("_globalData.pCoin b4", _globalData.pSp);
				_globalData.pSp += val;
				trace("_globalData.pCoin after", _globalData.pSp);
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_STAR_POINT_CHANGE);
				_es.dispatchESEvent(_sdcEvent);
			}
		}
		
		public function setRedStarPoint(val:int):void
		{
			_globalData.pRSExp += val;
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_REDSTAR_CHANGE);
			var obj:Object = new Object();
			obj.te = _globalData.pRSExp;
			obj.ae = val;
			_es.dispatchESEvent(_sdcEvent, obj);
		
		}
		
		public function setBlackStarPoint(val:int):void
		{
			_globalData.pBSExp += val;
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_BLACKSTAR_CHANGE);
			var obj:Object = new Object();
			obj.te = _globalData.pBSExp;
			obj.ae = val;
			_es.dispatchESEvent(_sdcEvent, obj);
		}
		
		public function setPlayerExperience(val:int):void
		{
			trace("_globalData.pExp b4", _globalData.pExp);
			_globalData.pExp += val;
			trace("_globalData.pExp after", _globalData.pExp);
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_EXPERIENCE_CHANGE);
			
			var obj:Object = new Object();
			obj.te = _globalData.pExp;
			obj.ae = val;
			_es.dispatchESEvent(_sdcEvent, obj);
		}
		
		public function setPlayerLevel(val:int):void
		{
			trace("_globalData.pLvl b4", _globalData.pLvl);
			_globalData.pLvl += val;
			
			if (_globalData.pLvl >= _globalData.levelLimit)
			{
				_globalData.pLvl = _globalData.levelLimit;
			}
			
			trace("_globalData.pLvl after", _globalData.pLvl);
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_LEVEL_CHANGE);
			_es.dispatchESEvent(_sdcEvent, _globalData.pLvl);
		}
		
		public function setPlayerActionPoints(val:int):void
		{
			trace("_globalData.pAp b4", _globalData.pAp);
			
			_globalData.pAp += val;
			trace("_globalData.pAp after", _globalData.pAp);
			
			if (_globalData.pAp <= _globalData.actionPointLimit)
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE);
				_es.dispatchESEvent(_sdcEvent, _globalData.pAp);
			}
		}
		
		public function setBgm(val:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSettingXMLExtractionComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSettingXMLExtractionFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "data/settings/bgm/" + val);
		}
		
		public function updateAp():void
		{
			if (_globalData.pAp <= 0)
			{
				actionPointDepleted();
			}
			else
			{
				_xmlExtractor = new XMLExtractor();
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUpdateAPComplete);
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUpdateAPFailed);
				_xmlExtractor.extractXmlData(_gd.absPath + "players/ap");
			}
		}
		
		private function onUpdateAPFailed(e:XMLExtractorEvent):void
		{
			trace("update ap Failed!!!!!!!!!!!!");
		}
		
		private function onUpdateAPComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			trace("update ap Complete", "current ap", xml);
			if (xml != null)
			{
				if (xml.@ret == "false")
				{
					trace("show pop up here that sayin there's an error in accessing game ap data");
				}
				else
				{
					trace("successfully add ap!.............. cap see: ", xml.@cap);
					_globalData.pAp = int(xml.@cap);
					if (_globalData.pAp <= _globalData.actionPointLimit)
					{
						_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE);
						_es.dispatchESEvent(_sdcEvent, _globalData.pAp);
					}
				}
			}
			else
			{
				trace("Error null update ap xml..................................");
			}
		}
		
		private function actionPointDepleted():void
		{
			_playerStatusEvent = new PlayerStatusEvent(PlayerStatusEvent.AP_DEPLETED);
			_es.dispatchESEvent(_playerStatusEvent);
		}
		
		private function coinDepleted():void
		{
			_playerStatusEvent = new PlayerStatusEvent(PlayerStatusEvent.COIN_DEPLETED);
			_es.dispatchESEvent(_playerStatusEvent);
			trace("coin dplete!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
		
		private function starPointDepleted():void
		{
			_playerStatusEvent = new PlayerStatusEvent(PlayerStatusEvent.STARPOINT_DEPLETED);
			_es.dispatchESEvent(_playerStatusEvent);
		}
		
		public function updateCharShopData():void
		{
			ServerDataExtractor.instance.updateData(GlobalData.CHARSHOP_DATA, _gd.absPath + "characters/shop");
		}
		
		public function updateAppSettingData():void
		{
			ServerDataExtractor.instance.updateData(GlobalData.APPSETTINGS_DATA, _gd.absPath + "data/settings");
		}
		
		//use datamanager when you don't need an reply xml		
		public function buyItem(itemId:String):void
		{
			var url:String = _gd.absPath + "offices/buy/" + itemId;
			var dataManager:DataManager = new DataManager();
			dataManager.sendRequestVariables(url);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_COMPLETE, onCompleteBuy);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_FAILED, onFailedBuy);
		}
		
		public function buyConsumableItem(itemid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onBuyConsumableItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onBuyConsumableItemFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/buyconsumable/" + itemid);
			trace("[ SDC ] on buy consumable item link: ", _gd.absPath + "offices/buyconsumable/" + itemid);
			////202.124.129.14/socialstars/offices/buyconsumable/itemid
		}
		
		public function checkIfOwnItem(itemid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckIfOwnItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckIfOwnItemFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/itemexists/" + itemid);
			trace("[ SDC ] check if own item link: ", _gd.absPath + "offices/itemexists/" + itemid);
			//https://202.124.129.14/socialstars/offices/itemexists/itemid
		}
		
		public function sellItem(entryId:String, inventorySell:Boolean = false):void
		{
			if (inventorySell)
			{
				addDialoguePopUp(true);
			}
			
			var url:String = _gd.absPath + "offices/sell/" + entryId;
			trace("[ SDC ] sell: link", url);
			
			var dataManager:DataManager = new DataManager();
			dataManager.sendRequestVariables(url);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_COMPLETE, onCompleteSell);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_FAILED, onFailedSell);
		}
		
		private function addDialoguePopUp(sub:Boolean = false):void
		{
			if (sub)
			{
				_popUIManager.loadSubWindow(WindowPopUpConfig.DIALOGUE_WINDOW, 0, 0, true, 0, 0);
				_dialogue = new DialogueEvent(DialogueEvent.SERVER_CALL_DIALOGUE);
				_es.dispatchEvent(_dialogue);
			}
			else
			{
				_popUIManager.loadWindow(WindowPopUpConfig.DIALOGUE_WINDOW, 0, 0, true, 0, 0);
				_dialogue = new DialogueEvent(DialogueEvent.SERVER_CALL_DIALOGUE);
				_es.dispatchEvent(_dialogue);
			}
		}
		
		public function sellDress(entryId:String):void
		{
			addDialoguePopUp(true);
			var url:String = _gd.absPath + "characters/sell/" + entryId;
			trace("[ SDC ] sell dress: link ", url);
			
			var dataManager:DataManager = new DataManager();
			dataManager.sendRequestVariables(url);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_COMPLETE, onDressSellComplete);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_FAILED, onDressSellFailed);
		}
		
		public function usePowerItem(entryId:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUsedPowerItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUsedPowerItemFailed);

			_xmlExtractor.extractXmlData(_gd.absPath + "offices/usepoweritem/" + entryId);

			trace("[ SDC ] using power up ............................................");
		}
		
		public function getInventoryList():void
		{
			trace("[SDC]: getInventorylist!....................................................................");
			var url:String = _gd.absPath + "offices/megainventory";
			var dataManager:DataManager = new DataManager();
			dataManager.sendRequestVariables(url);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_COMPLETE, onInventoryListComplete);
			dataManager.addEventListener(DataManagerEvent.DATA_MANAGER_FAILED, onInventoryListFailed);
		}
		
		//contest
		//"contestName"/0/0/0/id/gamehistory
		//building id 
		public function setReward(contestName:String = "runningman", ap:String = "10", coin:String = "10", xp:String = "5", opponetCharId:String = "LbkQHiF74RxYmzik45sAwwHl5HG2VJguqmssCsfuAKQSoMzWkghY5WOVMbQsi8dcjoNCVtTad6HFDbdAoAtoYzs82nxbIoyCzjFO", charId:String = "v6NbQf8fdDwtfzhF7fjB4Tsg7TDLuOjNRwjH1yAfIrUcXPhkSzF8GQ8Kf5kVum9CgskXEDW6F9yxyU3k9cCXuMPw44A2mYPOnCc", winner:String = "user", gameHistory:Array = null, buildingId:String = "1"):void
		{
			trace("mini game send data", "name", contestName, "ap", ap, "coin", coin, "xp", xp, "oppId", opponetCharId, "charId", charId, "winner", winner, "buildiD", buildingId, "gameHistory", gameHistory);
			
			addDialoguePopUp();
			//test
			
			var miniGameEvent:ServerDataControllerEvent = new ServerDataControllerEvent(ServerDataControllerEvent.MINI_GAME_DATA_SENT_COMPLETE);
			_es.dispatchESEvent(miniGameEvent);
			
			//http://1.234.2.179/socialstardev/minigame/update/[gamename]/[endap]/[endcoin/[endexp]/[oppcid]/[cid]/[winner]/[gh]
			//contestName = "runningman";
			//ap = "10";
			//coin = "10";
			//exp = "5";
			//opponetCharId = "LbkQHiF74RxYmzik45sAwwHl5HG2VJguqmssCsfuAKQSoMzWkghY5WOVMbQsi8dcjoNCVtTad6HFDbdAoAtoYzs82nxbIoyCzjFO";
			//charId = "v6NbQf8fdDwtfzhF7fjB4Tsg7TDLuOjNRwjH1yAfIrUcXPhkSzF8GQ8Kf5kVum9CgskXEDW6F9yxyU3k9cCXuMPw44A2mYPOnCc";
			//winner = "user";
			
			//trace( "see reward", contestName, ap, coin, exp, opponentFbId, gameHistory  );		
			
			var data:Array = new Array();
			var gameHistory:Array = new Array();
			var toJson:Array = new Array();
			
			var obj:Object;
			var states:Array = ["hit", "miss"];
			var leaders:Array = ["user", "ai"];
			var rnd:int = (Math.random() * 2) + 1;
			var prop:Array = ["name", "state", "xp", "ap", "coin", "leader"];
			
			for (var i:int = 0; i < 5; i++)
			{
				obj = new Object();
				obj.name = contestName;
				obj.ap = ap;
				obj.coin = coin;
				obj.xp = xp;
				obj.oppid = opponetCharId;
				obj.charid = charId;
				obj.winner = winner;
				obj.gamehistory = gameHistory;
				obj.buildingId = buildingId;
				//rnd = Math.floor( Math.random() * 2 );
				//obj.state = states[ rnd ];
				//rnd = Math.floor( Math.random() * 2 );
				//obj.leader = leaders[ rnd ];
				gameHistory.push(obj);
			}
		
			//var ghJson:String = JSON.encode( gameHistory);
			//trace( "see json", ghJson );
			//
			//var b64:String =  Base64.encode( ghJson );
			//trace( "see 64", b64 );
			//
			//var basePath:String = "http://1.234.2.179/socialstardev/minigame/update/" + contestName + "/" +  ap + "/" +  coin + "/" +  xp + "/" + opponetCharId + "/" +  charId + "/" + winner + "/" +  b64;
			//trace( "basePath", basePath );
			//
			//_xmlExtractor = new XMLExtractor(  );
			//_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onRewardComplete );
			//_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onRewardFailed ); 
			//_xmlExtractor.extractXmlData( basePath );
		
			//var filePath : String = “http://test.com/upload/l_0,0157 e9761d#.jpg”;
			//var encodedPath : String = escape(filePath);
			//trace(encodedPath); //This equals “http://test.com/upload/l_0%2C0157%20%20e9761d%23.jpg”
		
			//var urlEncoded:String = escape( b64 );
			//trace( "urlencoded", b64 );
		
			//data[ 'name' ] = gameHistory[ 0 ].name;
			//data[ 'state' ] = gameHistory[ 1 ].state;
			//data[ 'xp' ] = gameHistory[ 2 ].exp;
			//data[ 'ap' ] = gameHistory[ 3 ].ap;
			//data[ 'coin' ] = gameHistory[ 4 ].coin;
			//data[ 'leader' ] = gameHistory[ 5 ].coin;
		
			//_variables.data = JSON.encode( data);
		
			//var data:Array = new Array();
			//data[ 'name' ] = gameHistory[ 0 ].name;
			//data[ 'state' ] = gameHistory[ 1 ].state;
			//data[ 'exp' ] = gameHistory[ 2 ].exp;
			//data[ 'ap' ] = gameHistory[ 3 ].ap;
			//data[ 'coin' ] = gameHistory[ 4 ].coin;
			//data[ 'leader' ] = gameHistory[ 4 ].leader; // ai / user
		
			//_variables.data = JSON.encode( data);
		
			//var gh:Array =  new Array();
			//
			//every time
			//var obj:Object = new Object();
			//obj.name = "";
			//obj.state = "";
			//obj.xp = "";
			//obj.ap = "";
			//obj.coin = "";
			//gh.push( obj );
		
			//var filePath : String = “http://test.com/upload/l_0,0157 e9761d#.jpg”;
			//var encodedPath : String = escape(filePath);
			//trace(encodedPath); //This equals “http://test.com/upload/l_0%2C0157%20%20e9761d%23.jpg”
		}
		
		public function callNewSpeed(newsType:String):void
		{
			addDialoguePopUp();
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onNewSpeedExtractComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onNewSpeedExtractFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/newsfeed/" + newsType);
		}
		
		public function updateApTimer():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onApTimerUpdateComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onApTimerUpdateFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "players/apnext");
		}
		
		//new		
		public function updateMapBuildingData():void
		{
			//ServerDataExtractor.instance.updateData( GlobalData.MAPBUILDING_DATA, _gd.absPath + "buildings/all" );
			ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, _gd.absPath + "buildings/allnew");
		}
		
		public function updatePlayerUIData():void
		{
			ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, _gd.absPath + "players/ui");
		}
		
		private function wallPostRequestAp():void
		{
			addDialoguePopUp();
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onWallPostReqComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onWallPostReqFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "callback/askap");
		}
		
		public function expandOffice(itemId:String):void
		{
			addDialoguePopUp();
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onOfficeExpandedComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onOfficeExpandedFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/expand/" + itemId);
		}
		
		public function updateFriendVisitViewData(fbId:String):void
		{
			//GlobalData.instance.isChallenge = false;
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDOFFICESTATE_DATA, _gd.absPath + "offices/state/" + fbId);
		}
		
		public function updateNPCVisitViewData():void
		{
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDOFFICESTATE_DATA, _gd.absPath + "offices/state/npc");
			trace("[ SDC ]: call show npc office................................link", _gd.absPath + "offices/state/npc");
		}
		
		public function updateNpcCharlist():void
		{
			//https://202.124.129.14/socialstars/characters/charlist/npc
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDCHARLIST_DATA, _gd.absPath + "characters/charlist/npc");
			trace("[ SDC ] update my NPC charlist...................");
		}
		
		public function updateFriendChallengeViewData(fbId:String):void
		{
			//GlobalData.instance.isChallenge = true;
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDOFFICESTATE_DATA, _gd.absPath + "offices/state/" + fbId);
			trace("[SDC]: loading friend office view challenge link:", _gd.absPath + "offices/state/" + fbId);
		}
		
		public function updateHomeViewData():void
		{
			GlobalData.instance.isChallenge = false;
			ServerDataExtractor.instance.updateData(GlobalData.OFFICESTATE_DATA, XMLLinkData.instance.onlineOfficeStateData);
			trace("[SDC]: returning home link", XMLLinkData.instance.onlineOfficeStateData);
		}
		
		public function updateFriendCharlist(fbId:String):void
		{
			//http://1.234.2.179/socialstardev/characters/charlist
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDCHARLIST_DATA, XMLLinkData.instance.onlineCharListData + "/" + fbId);
			trace("[ SDC ] update my Friend charlist...................");
		}
		
		public function updateMyCharlist():void
		{
			//http://1.234.2.179/socialstardev/characters/charlist
			GlobalData.instance.charListDataArray = [new Array()];
			ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, XMLLinkData.instance.onlineCharListData);
			var tutEvent:TutorialEvent = new TutorialEvent(TutorialEvent.HIRE_CONTESTANT);
			_es.dispatchESEvent(tutEvent);
			trace("[ SDC ] update my own charlist...................contestant has been hired ^^)");
		}
		
		/**
		 *
		 * @param	entryID
		 * @param	xPos
		 * @param	yPos
		 * @param	zPos
		 * @param	rot
		 * @param	met - buy,rotate,move
		 */
		
		public function registerOfficeItemPosition(entryID:String, xPos:Number, yPos:Number, zPos:Number, rot:Number, met:String, gender:int = 0):void
		{
			//var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.TUT_REGISTER_OFFICE_ITEM );
			//_es.dispatchESEvent( tutEvent );			
			dropCoin(entryID, 100);
			
			trace("[ SDC ]: registerOffice item position", _gd.absPath + "offices/position/" + entryID + "/" + xPos + "/" + yPos + "/" + zPos + "/" + rot + "/" + met + "/" + gender);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onRegisterOfficeItemPositionComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onRegisterOfficeItemPositionFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/position/" + entryID + "/" + xPos + "/" + yPos + "/" + zPos + "/" + rot + "/" + met + "/" + gender);
			//1.234.2.179/socialstardev/offices/position/[entryid]/[newx]/[newy]/[newz]/[newrot]
		}
		
		public function askFriend(ap:Boolean = false, coin:Boolean = false):void
		{
			var req:String;
			
			if (ap)
			{
				req = "wallpost/askap";
			}
			else if (coin)
			{
				req = "wallpost/askcoin";
			}
			else
			{
				req = "wallpost/askap";
			}
			
			/*
			   nfcaller('wallpost/askap')
			   nfcaller('wallpost/askcoin')
			 */
			
			_jsManager = JsManager.getInstance();
			//_jsManager.callJs( method, params );
			_jsManager.callJs("nfcaller", req);
		
			//reqcaller('requestpost/staffinvite/entryid_position_0_fbid')
		}
		
		public function hireFriendStaff(entryid:String, position:String, fbid:String):void
		{
			_jsManager = JsManager.getInstance();
			_jsManager.execJs("reqcaller", 'requestpost/staffinvite/' + entryid + "_" + position + "_0_" + fbid);
			trace("[SDC]: hire friends staff", "reqcaller", 'requestpost/staffinvite/' + entryid + "_" + position + "_0_" + fbid);
		}
		
		public function hireFriendCrew(position:String, charid:String):void
		{
			_jsManager = JsManager.getInstance();
			_jsManager.execJs("reqcaller", 'requestpost/crewinvite/' + position + "_" + charid);
			trace("[SDC]: hire friends Crew", "reqcaller", "reqcaller", 'requestpost/crewinvite/' + position + "_" + charid);
			//reqcaller('requestpost/crewinvite/position_charid')
		}
		
		public function postVictoryReward(qid:String):void
		{
			_jsManager = JsManager.getInstance();
			//nfcaller('wallpost/questfeed/qid')
			_jsManager.execJs("nfcaller", 'wallpost/questfeed/' + qid);
			trace("[SDC]: postVictoryReward===========================>", "nfcaller", 'wallpost/questfeed/' + qid);
			//reqcaller('requestpost/crewinvite/position_charid')
		}
		
		public function callJsko():void
		{
			_jsManager = JsManager.getInstance();
			_jsManager.addCallBackJS("newsfeedalias", "");
		}
		
		public function newsFeedCallBack(success:int):void
		{
			if (success == 1)
			{
				trace("[ SDC ]newsfeed success............");
			}
			else
			{
				trace("[ SDC ]newsfeed failed............");
			}
		}
		
		public function refreshGame():void
		{
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			_jsManager = JsManager.getInstance();
			//_jsManager.callJs("oopsy", "");
			//_jsManager.callJs("window.location.reload");
			//window.location.reload()
			trace("[ SDC ]there's a data sync error in server the game will  be reload............................................");
		}
		
		public function dropCoin(entryid:String, coin:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onDropCoinComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onDropCoinFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/droppick/" + entryid + "/" + coin + "/amount/buy");
			//http://1.234.2.179/socialstardev/offices/droppick/entryid/coin,ap,redstar,blackstar/amount/sell,buy,touch/friendfbid
			//http://1.234.2.179/socialstardev/offices/droppick/entryid/coin/amount/buy
		}
		
		//new 
		public function visitNpc():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onVisitNpcComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onVisitNpcFailed);
			//http://1.234.2.179/socialstardev/offices/state/npc
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/state/npc");
		}
		
		public function getGridWidthLength(fbid:String = ""):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetGridWidthLengthComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetGridWidthLengthFailed);
			//http://1.234.2.179/socialstardev/offices/currentrowcol/fbid
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/currentrowcol/" + fbid);
			trace("[SDC] getting width and length link", _gd.absPath + "offices/currentrowcol/" + fbid);
		}
		
		//position - boss,cleaner,fireman,hr
		//0 - friend , 1 - npc		
		public function hireStaff(entryid:String, position:String, npcFriend:int):void
		{
			addDialoguePopUp();
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onHireStaffComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onHireStaffFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/staffhire/" + entryid + "/" + position + "/" + npcFriend);
			trace("[ SDC ] hiring staff now calling link..", _gd.absPath + "offices/staffhire/" + entryid + "/" + position + "/" + npcFriend);
		}
		
		public function hireCrew(crewPos:String, charId:String, npc:Boolean):void
		{
			addDialoguePopUp();
			
			if (!npc)
			{
				_xmlExtractor = new XMLExtractor();
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onHireCrewComplete);
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onHireCrewFailed);
				_xmlExtractor.extractXmlData(_gd.absPath + "characters/crewcheck/" + crewPos + "/" + charId);
				//http://1.234.2.179/socialstardev/characters/crewcheck/crewPos/charId
				trace("Crew staff.........................");
			}
			else
			{
				_xmlExtractor = new XMLExtractor();
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onHireCrewNpcComplete);
				_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onHireCrewNpcFailed);
				_xmlExtractor.extractXmlData(_gd.absPath + "characters/crewnpc/" + charId + "/" + crewPos);
				//http://1.234.2.179/socialstardev/characters/crewnpc/cid/position
				trace("hire Crew NPC staff.........................crew pos", crewPos, "charid", charId);
			}
		}
		
		public function saveCharDefinition(charid:String, definition:String):void
		{
			addDialoguePopUp(false);
			trace("[SDC]: saving char def...............................................", charid, definition);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSaveCharDefComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSaveCharDefFailed);
			trace("[SDC]: saving char def link...............................................", _gd.absPath + "characters/modifydna/" + charid + "/" + definition);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/modifydna/" + charid + "/" + definition);
			//http://1.234.2.179/socialstardev/characters/modifydna/cid/dna
		}
		
		public function fireCharacter(charid:String):void
		{
			//addDialoguePopUp(true);
			trace("[SDC]: fire character...............................................", charid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onFireCharComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onFireCharFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/fire/" + charid);
			trace("[SDC]: Fire char link...............................................", _gd.absPath + "characters/fire/" + charid);
			
			removeCharFromIsoRoom(charid);
		}
		
		public function removeCharFromIsoRoom(cid:String):void
		{
			if (!_globalData.friendView)
			{
				
				var len:int = _globalData.charListDataArray.length;
				
				for (var i:int = 0; i < len; i++)
				{
					if (_globalData.charListDataArray[i][GlobalData.CHARLIST_ID] == cid)
					{
						trace("[SDC] removing char to isoroom len before splice", _globalData.charListDataArray.length);
						_globalData.charListDataArray.splice(i, 1);
						trace("[SDC] remove character due to put to inventory action!!!!");
						trace("[SDC] removing char to isoroom len after splice", _globalData.charListDataArray.length);
						break;
					}
				}
				
			}
		}
		
		public function fireCrew(charid:String, position:String):void
		{
			//positions
			//manager	healthtrainer	vocaltrainer	privateteacher	actingteacher	stylist
			//http://1.234.2.179/socialstardev/characters/crewfire/charid/position			
			trace("[SDC]: fire crew...............................................", charid, position);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onFireCrewComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onFireCrewFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/crewfire/" + charid + "/" + position);
			trace("[SDC]: Fire crew link...............................................", _gd.absPath + "characters/crewfire/" + charid + "/" + position);
			addDialoguePopUp();
		}
		
		private function extactInventoryJsonData(data:*):void
		{
			//trace( "data complete...", JSON.decode( _loader.data ).name, JSON.decode( _loader.data ).last  );
			trace("[extract json SDC]: InventoryList...................................................................");
			//var obj:Object = JSON.decode(data);
			var obj:Object = JSON.parse(data);
			
			trace("sse bol:", obj[0]);
			
			var found:String = obj[0];
			
			trace("sse2 bol:", found);
			var c:int;
			
			GlobalData.instance.inventoryContestant = new Array();
			GlobalData.instance.inventoryStructure = new Array();
			GlobalData.instance.inventoryDress = new Array();
			GlobalData.instance.inventoryPower = new Array();
			
			for each (var e:*in obj)
			{
				if (found == "true")
				{
					for (var l:*in e)
					{
						if (e[l] != null)
						{
							if (e[l].itemtype == "character")
							{
								var itemCharData:ItemCharData = new ItemCharData();
								itemCharData.cid = e[l].cid;
								itemCharData.pid = e[l].pid;
								itemCharData.health = int(e[l].health);
								itemCharData.sing = int(e[l].sing);
								itemCharData.intelligent = int(e[l].intelligent);
								itemCharData.acting = int(e[l].acting);
								itemCharData.attraction = int(e[l].attraction);
								itemCharData.cname = e[l].cname;
								itemCharData.cgender = e[l].gender;
								itemCharData.clvl = int(e[l].clvl);
								//itemCharData.cexp = int(e[l].cexp);
								itemCharData.grade = int(e[l].grade);
								itemCharData.popular = int(e[l].popular);
								itemCharData.stress = int(e[l].stress);
								itemCharData.cond = e[l].cond;
								//itemCharData.aid = e[l].aid;
								//itemCharData.bodyid = e[l].bodyid;
								itemCharData.stored = e[l].stored;
								itemCharData.bodydef = e[l].bodydef;
								itemCharData.itemtype = e[l].itemtype;
								//trace( "char pid", l, e[ l ].pid );
								//trace( "char cid", l, e[ l ].cid );
								//trace( "char health", l, e[ l ].health );
								//trace( "char sing", l, e[ l ].sing );
								GlobalData.instance.inventoryContestant.push(itemCharData);
								
							}
							
							if (e[l].itemtype == "dress")
							{
								var itemDressData:ItemDressData = new ItemDressData();
								itemDressData.itemid = e[l].itemid;
								itemDressData.itemname = e[l].itemname;
								itemDressData.coincost = int(e[l].coincost);
								itemDressData.starcost = int(e[l].starcost);
								itemDressData.img = e[l].img;
								itemDressData.swf = e[l].swf;
								itemDressData.fn = e[l].fn;
								itemDressData.typ = e[l].typ;
								itemDressData.subtype = e[l].subtype;
								itemDressData.descrip = e[l].descrip;
								itemDressData.sellprice = int(e[l].sellprice);
								itemDressData.expirestamp = int(e[l].expirestamp);
								itemDressData.ishot = e[l].ishot;
								itemDressData.isnew = e[l].isnew;
								itemDressData.eff = e[l].eff;
								itemDressData.gender = e[l].gender;
								itemDressData.def = e[l].def;
								itemDressData.entry = e[l].entry;
								itemDressData.itemtype = e[l].itemtype;
								GlobalData.instance.inventoryDress.push(itemDressData);
									//trace( "dress itemid", l, e[ l ].itemid );
									//trace( "dress itemname", l, e[ l ].itemname );
							}
							
							if (e[l].itemtype == "power")
							{
								var itemPowerData:ItemPowerData = new ItemPowerData();
								itemPowerData.itemid = e[l].iid;
								itemPowerData.itemname = e[l].itemname;
								itemPowerData.typ = e[l].typ;
								itemPowerData.subtype = e[l].subtype;
								itemPowerData.coincost = int(e[l].coincost);
								itemPowerData.starcost = int(e[l].starcost);
								//itemPowerData.apcost = int(e[l].apcost);
								itemPowerData.sellprice = int(e[l].sellprice);
								//itemPowerData.expiration = int(e[l].expiration);
								//itemPowerData.swf = e[l].swf;
								//itemPowerData.fn = e[l].fn;
								//itemPowerData.library = e[l].library;
								itemPowerData.descrip = e[l].descrip;
								//itemPowerData.ishot = e[l].ishot;
								//itemPowerData.isnew = e[l].isnew;
								//itemPowerData.coll = e[l].coll;
								//itemPowerData.eff = e[l].eff;
								//itemPowerData.stackable = e[l].stackable;
								//itemPowerData.stackmax = e[l].stackmax;
								//itemPowerData.consumable = e[l].consumable;
								itemPowerData.unlocklevel = int(e[l].lvreq);
								//itemPowerData.assignednpc = e[l].assignednpc;
								//itemPowerData.dimension = e[l].dimension;
								//itemPowerData.buildtime = int(e[l].buildtime);
								//itemPowerData.rewardvalue = int(e[l].rewardvalue);
								//itemPowerData.training = e[l].training;
								//itemPowerData.trainingtime = int(e[l].trainingtime);
								//itemPowerData.machinerewardexp = int(e[l].machinerewardexp);
								//itemPowerData.machinerewardcoin = int(e[l].machinerewardcoin);
								//itemPowerData.machinerewardcooldown = int(e[l].machinerewardcooldown);
								//itemPowerData.rotatable = e[l].rotatable;
								itemPowerData.png = e[l].png;
								//itemPowerData.stafflist = e[l].stafflist;
								//itemPowerData.qty = int(e[l].qty);
								itemPowerData.entry = e[l].entry;
								itemPowerData.itemtype = e[l].itemtype;
								GlobalData.instance.inventoryPower.push(itemPowerData);
							}
							
							if (e[l].itemtype == "office")
							{
								var itemStructureData:ItemStructureData = new ItemStructureData();
								itemStructureData.itemid = e[l].iid;
								itemStructureData.itemname = e[l].itemname;
								itemStructureData.typ = e[l].typ;
								itemStructureData.subtype = e[l].subtype;
								itemStructureData.coincost = int(e[l].coincost);
								itemStructureData.starcost = int(e[l].starcost);
								itemStructureData.apcost = int(e[l].apcost);
								itemStructureData.exp = int(e[l].exp);
								itemStructureData.sellprice = int(e[l].sellprice);
								//itemStructureData.expiration = int(e[l].expiration);
								itemStructureData.swf = e[l].swf;
								//itemStructureData.fn = e[l].fn;
								itemStructureData.library = e[l].library;
								itemStructureData.descrip = e[l].descrip;
								//itemStructureData.eff = e[l].eff;								
								itemStructureData.unlocklevel = int(e[l].lvreq);
								
								//positions scouter
								itemStructureData.assignednpc = e[l].assignednpc;
								
								//npc or friendfbid
								itemStructureData.state = e[l].state;
								
								//itemStructureData.dimension = e[l].dimension;
								itemStructureData.sizeX = e[l].size_x;
								itemStructureData.sizeY = e[l].size_y;
								itemStructureData.layer = e[l].layer;
								itemStructureData.png = e[l].png;
								
								itemStructureData.entry = e[l].entry;
								itemStructureData.itemtype = e[l].itemtype;
								itemStructureData.duration = int(e[l].duration);
								itemStructureData.stress = int(e[l].stress);
								
								//trace( "office itemid", l, e[ l ].itemid );
								//trace( "office itemname", l, e[ l ].itemname );
								
								GlobalData.instance.inventoryStructure.push(itemStructureData);
							}
						}
						else
						{
							trace("null no item in inventory");
						}
					}
				}
				else
				{
					trace("detect false.............. no inventory");
				}
			}
			//trace( "contestant inventory data", GlobalData.instance.inventoryContestant );
			//trace( "Dress inventory data", GlobalData.instance.inventoryDress );
			//trace( "power inventory data", GlobalData.instance.inventoryPower );
			//trace( "Structure inventory data", GlobalData.instance.inventoryStructure );
			
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.INVENTORY_DATA_LOAD_COMPLETE);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
		}
		
		public function placeToInvetory(entryId:String):void
		{
			trace("[SDC]: place to inventory...............................................", entryId);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onPlaceToInventoryComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onPlaceToInventoryFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/toinventory/" + entryId);
			trace("[SDC]: place to inventory link...............................................", _gd.absPath + "offices/toinventory/" + entryId);
		}
		
		public function placeCharToInventory(cid:String):void
		{
			trace("[SDC]: place char to inventory...............................................", cid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onPlaceCharToInventoryComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onPlaceCharToInventoryFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/toinventory/" + cid);
			trace("[SDC]: place char to inventory link...............................................", _gd.absPath + "characters/toinventory/" + cid);
			//http://1.234.2.179/socialstardev/characters/toinventory/cid
			
			removeCharFromIsoRoom(cid);
		}
		
		public function placeCharToOffice(cid:String):void
		{
			addDialoguePopUp(true);
			trace("[SDC]: place char to office...............................................", cid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onPlaceCharToOfficeComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onPlaceCharToOfficeFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/tooffice/" + cid);
			trace("[SDC]: place char to office link...............................................", _gd.absPath + "characters/tooffice/" + cid);
		}
		
		public function setCharDataByCharID(xml:XML):void
		{
			var globalData:GlobalData = GlobalData.instance;
			var charlistArray:Array = globalData.charListDataArray;
			var len:int = charlistArray.length;
			for (var x:int = 0; x < len; x++)
			{
				var characterID:String = charlistArray[x][GlobalData.CHARLIST_ID];
				if (characterID == xml.@cid)
				{
					// stress="55" health="1800" sing="1610" intelligent="1700" acting="2000" attraction="1900" cond="normal"
					trace("[SDC]: char updates before======>", globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS], globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH], globalData.charListDataArray[x][GlobalData.CHARLIST_SING], globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE], globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING], globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION], globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION]);
					
					trace("updated data from server", xml.@stress, xml.@health, xml.@sing, xml.@intelligent, xml.@acting, xml.@attraction, xml.@cond);
					
					globalData.charListDataArray[x][GlobalData.CHARLIST_LEVEL] = int(xml.@clvl);
					globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS] = int(xml.@stress);
					globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH] = int(xml.@health);
					globalData.charListDataArray[x][GlobalData.CHARLIST_SING] = int(xml.@sing);
					globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE] = int(xml.@intelligent);
					globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING] = int(xml.@acting);
					globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION] = int(xml.@attraction);
					globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION] = int(xml.@cond);
					
					trace("[SDC] char updated after======>", globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS], globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH], globalData.charListDataArray[x][GlobalData.CHARLIST_SING], globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE], globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING], globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION], globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION]);
					trace("[ SDC ]: char cid", xml.@cid, "has been updated........................................................");
					break;
				}
			}
		}
		
		public function setQuickCharDataByCharID(cid:String, trainObj:Object):void
		{
			var globalData:GlobalData = GlobalData.instance;
			var charlistArray:Array = globalData.charListDataArray;
			var len:int = charlistArray.length;
			for (var x:int = 0; x < len; x++)
			{
				var characterID:String = charlistArray[x][GlobalData.CHARLIST_ID];
				if (characterID == cid)
				{
					// stress="55" health="1800" sing="1610" intelligent="1700" acting="2000" attraction="1900" cond="normal"
					trace("[SDC]:quick char updates before======>", globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS], globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH], globalData.charListDataArray[x][GlobalData.CHARLIST_SING], globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE], globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING], globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION], globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION]);
					
					if (_globalData.getCharDataOnCharID(cid)[GlobalData.CHARLIST_STRESS] < 100)
					{
						globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS] = int(trainObj.stress);
					}
					else
					{
						globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS] = 100;
					}
					
					globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH] = int(trainObj.health);
					globalData.charListDataArray[x][GlobalData.CHARLIST_SING] = int(trainObj.sing);
					globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE] = int(trainObj.intelligent);
					globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING] = int(trainObj.acting);
					globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION] = int(trainObj.attraction);
					globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION] = int(trainObj.cond);
					
					trace("[SDC] quick char updated after======>", globalData.charListDataArray[x][GlobalData.CHARLIST_STRESS], globalData.charListDataArray[x][GlobalData.CHARLIST_HEALTH], globalData.charListDataArray[x][GlobalData.CHARLIST_SING], globalData.charListDataArray[x][GlobalData.CHARLIST_INTELLIGENCE], globalData.charListDataArray[x][GlobalData.CHARLIST_ACTING], globalData.charListDataArray[x][GlobalData.CHARLIST_ATTRACTION], globalData.charListDataArray[x][GlobalData.CHARLIST_CONDITION]);
					break;
				}
			}
		}
		
		public function updateQuestData(qid:String, qtid:String):void
		{
			//1.234.2.179/socialstardev/quests/questupdate/qid/qtid			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUpdateQuestDataComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUpdateQuestDataFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/questupdate/" + qid + "/" + qtid);
			trace("[ SDC ]: update quest data link", _gd.absPath + "quests/questupdate/" + qid + "/" + qtid);
		}
		
		public function endQuestData(qid:String):void
		{
			//http://1.234.2.179/socialstardev/quests/questend/qid
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onEndQuestDataComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onEndQuestDataFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/questend/" + qid);
		}
		
		public function loadMiniGame(gameMode:String):void
		{
			//getMiniGameData( _globalData.currentCharId, _globalData.currentFriendCharId );			
			_jsManager = JsManager.getInstance();
			_jsManager.execJs("minigameLoader", gameMode);
		}
		
		public function showNotification():void
		{
			//getMiniGameData( _globalData.currentCharId, _globalData.currentFriendCharId );			
			_jsManager = JsManager.getInstance();
			_jsManager.execJs("showNotification");
		}
		
		public function wallPostLevelUp():void
		{
			trace("[SDC]: call wall post level up wall post story: ", "nfcaller", "wallpost/levelup/1373812866");
			_jsManager = JsManager.getInstance();
			_jsManager.execJs("nfcaller", "wallpost/levelup/1373812866");
		}
		
		public function addNeighbor():void
		{
			//_jsManager.execJs("inviteFriend", "");			
			_jsManager.execJs("reqcaller", "requestpost/friendinvite" + "___" + "1");
		}
		
		/**
		 *
		 * @param	fbid
		 * @param	energy  -1, -2, +1, +5
		 */
		
		public function updatePlayerHelpingEnergy(fbid:String, energy:String = ""):void
		{
			//http://1.234.2.179/socialstardev/players/helpenergy/700186557/
			trace("[SDC]: update helping energy link", _gd.absPath + "players/helpenergy/" + fbid + "/" + energy);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUpdateHelpingEnergyComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUpdateHelpingEnergyFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "players/helpenergy/" + fbid + "/" + energy);
			
			if (energy != null && energy != "")
			{
				_globalData.pHE += int(energy);
			}
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE);
			_es.dispatchESEvent(_sdcEvent);
		}
		
		/**
		 *
		 * @param	type - ap,redstar,blackstar,pexp
		 * @param	val
		 */
		
		public function pickReward(type:String, val:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onPickRewardComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onPickRewardFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/dropitems/" + type + "/" + val);
			trace("[SDC] ON PICK REWARD CALL LINK: ", _gd.absPath + "offices/dropitems/" + type + "/" + val);
		}
		
		public function getCompleteQuestData(qid:String):void
		{
			//http: //1.234.2.179/socialstardev/quests/rewardinfo/qid
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetEndQuestDataComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetEndQuestDataFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/rewardinfo/" + qid);
			trace("[SDC] get Complete Quest Data link: ", _gd.absPath + "quests/rewardinfo/" + qid);
		}
		
		public function clickContestantForAddStats(cid:String, trainingObj:Object):void
		{
			//1.234.2.179/socialstardev/characters/chartrainer/cid/amt=1
			setQuickCharDataByCharID(cid, trainingObj);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onAddContestantStatComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onAddContestantStatFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/chartrainer/" + cid);
			trace("[SDC] click contestant for stats link: ", _gd.absPath + "characters/chartrainer/" + cid);
		}
		
		public function setMiniGameDataStoryMode(mycid:String, buildingId:String):void
		{
			trace("[SDC] seting up minigame story mode data link", _gd.absPath + "game/contestsetminigame/" + mycid + "/" + buildingId);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetMiniGameDataStoryModeComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetMiniGameDataStoryModeFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/contestsetminigame/" + mycid + "/" + buildingId);
		}
		
		public function setMiniGameData(mycid:String, friendCid:String, selectionProgram:String, duration:int):void
		{
			trace("[SDC] seting up minigame data link", _gd.absPath + "game/minigamedata/" + mycid + "/" + friendCid + "/" + selectionProgram + "/" + duration);
			//http://1.234.2.179/socialstardev/game/minigamedata/yourcid/friendcid			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetMiniGameDataComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetMiniGameDataFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/minigamedata/" + mycid + "/" + friendCid + "/" + selectionProgram + "/" + duration);
			//_xmlExtractor.extractXmlData(_gd.absPath + "game/getminigamedata");
		}
		
		public function getMiniGameData():void
		{
			trace("[SDC] geting up minigame data link", _gd.absPath + "game/getminigamedata");
			//http://1.234.2.179/socialstardev/game/minigamedata/yourcid/friendcid			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetMiniGameDataComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetMiniGameDataFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/getminigamedata");
		}
		
		public function getRandomContestantFromFriend(friendFbid:String):void
		{
			trace("[SDC] get random friend contestant link", _gd.absPath + "minigame/getfriendcharrandom/" + friendFbid);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetRandomContestantFromFriendComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetRandomContestantFromFriendFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "minigame/getfriendcharrandom/" + friendFbid);
			//http://202.124.129.14/socialstars/minigame/getfriendcharrandom/friendfbid
		}
		
		public function getFriendContestant(fbid:String, cid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetFriendContestantComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetFriendContestantFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "minigame/getfriendcontestant/" + fbid + "/" + cid);
			trace("[SDC] getFriendContestant link", _gd.absPath + "minigame/getfriendcontestant/" + fbid + "/" + cid);
		}
		
		public function checkIfStillConnected():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckIfConnectedComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckIfConnectedFailed );
			_xmlExtractor.extractXmlData( _gd.absPath + "/game/isconnected" );
			trace("[SDC] check if still connected link", _gd.absPath + "/game/isconnected" );
		}				
	
		public function setContestantFromNewToOld(cid:String):void
		{
			//http://1.234.2.179/socialstardev/game/minigamedata/yourcid/friendcid			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetContestantFromNewToOldComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetContestantFromNewToOldFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/oldcharacter/" + cid);
			trace("[SDC]: set contestant from new to old link", _gd.absPath + "characters/oldcharacter/" + cid);
			//https://202.124.129.14/socialstars/characters/oldcharacter/cid
		}
		
		public function saveGender(gender:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSaveGenderComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSaveGenderFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/staffsetgender/entryid/" + gender);
		}
		
		//public function checkForOwnItem(itemid:String):void
		//{
		//_xmlExtractor = new XMLExtractor();
		//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckOwnItemComplete);
		//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckOwnItemFailed);
		//_xmlExtractor.extractXmlData( _gd.absPath + "offices/hasitemid/" + itemid );
		//}
		
		public function clickFriendOfficeItem(friendFbid:String, entryid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onClickedFriendOfficeItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onClickedFriendOfficeItemFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/neighbortouchitem/" + friendFbid + "/" + entryid);
			//https://202.124.129.14/socialstars/offices/neighbortouchitem/friend_fbid/entryid
		}
		
		public function challengeFriendContestant(mycid:String, friendcid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onChallengeFriendContestantComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onChallengeFriendContestantFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/challenge/" + mycid + "/" + friendcid);
			trace("challenging friend contestant link", _gd.absPath + "characters/challenge/" + mycid + "/" + friendcid);
			//https://202.124.129.14/socialstars/characters/challenge/yourcid/friendcid
		}
		
		/*
		   public function visitNeighborQuest(fbid:String = ""):void
		   {
		   _xmlExtractor = new XMLExtractor();
		   _xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onQuestVisitNeighborComplete);
		   _xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onQuestVisitNeighborFailed);
		
		   if (fbid == "")
		   {
		   _xmlExtractor.extractXmlData(_gd.absPath + "quests/questfriendvisit/npc");
		   }
		   else
		   {
		   _xmlExtractor.extractXmlData(_gd.absPath + "quests/questfriendvisit/" + fbid);
		   }
		   trace("challenging friend contestant link", _gd.absPath + "quests/questfriendvisit/" + fbid);
		   //202.124.129.14/socialstars/quests/questfriendvisit/fbid or npc
		   }
		 */
		
		public function questTrain(entryid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onQuestTrainingComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onQuestTrainingFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/training/" + entryid);
			trace("[SDC]: quest train link", _gd.absPath + "quests/training/" + entryid);
		}
		
		public function questStressDownByClickContestant(fbid:String = null):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onQuestStressDownByClickContestantComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onQuestStressDownByClickContestantFailed);
			
			if (fbid != null)
			{
				_xmlExtractor.extractXmlData(_gd.absPath + "quests/stressdown/" + fbid);
				trace("challenging friend contestant link", _gd.absPath + "quests/stressdown/" + fbid);
			}
			else
			{
				_xmlExtractor.extractXmlData(_gd.absPath + "quests/stressdown/npc");
				trace("challenging friend contestant link", _gd.absPath + "quests/stressdown/npc");
			}
		}
		
		public function questStressDownByClickItem(entryid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onQuestStressDownByClickItemComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onQuestStressDownByClickItemFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/stressdownitem/" + entryid);
			trace("challenging friend contestant link", _gd.absPath + "quests/stressdownitem/" + entryid);
		}
		
		public function questVisitFriendNpc(fbid:String = null):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onQuestVisitFriendNpcComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onQuestVisitFriendNpcFailed);
			
			if (fbid != null)
			{
				_xmlExtractor.extractXmlData(_gd.absPath + "quests/visitfriendnpc/" + fbid);
				trace("[ SDC ]:quest visit friend", _gd.absPath + "quests/visitfriendnpc/" + fbid);
			}
			else
			{
				_xmlExtractor.extractXmlData(_gd.absPath + "quests/visitfriendnpc/npc");
				trace("[ SDC ]:quest visit friend NPC", _gd.absPath + "quests/visitfriendnpc/npc");
			}
		}
		
		public function setOldToNewQuest(qid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetOldToNewQuestComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetOldToNewQuestFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/oldquest/" + qid);
			trace("[SDC]: setting new quest to old link", _gd.absPath + "quests/oldquest/" + qid);
		}
		
		public function routeChallenge(friendfbid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onRouteChallengeComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onRouteChallengeFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/routechallege/" + friendfbid);
			trace("[SDC]: route Challenge link", _gd.absPath + "offices/routechallege/" + friendfbid);
			//https://202.124.129.14/socialstars/offices/routechallege/friendfbid			
		}
		
		public function routeHelp(friendfbid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onRouteHelpComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onRouteHelpFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/routehelp/" + friendfbid);
			trace("[SDC]: route help link", _gd.absPath + "offices/routehelp/" + friendfbid);
			//https://202.124.129.14/socialstars/offices/routehelp/friendfbid
		}
		
		// 0 or 1 , singing, acting, modeling
		public function setMiniGameResult(val:int, mode:String, npcName:String, percentage:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetMiniGameResultComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetMiniGameResultFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/setquestcontestresult/" + val + "/" + mode + "/" + npcName + "/" + percentage);
			trace("[SDC]: set minigame result", _gd.absPath + "quests/setquestcontestresult/" + val + "/" + mode + "/" + npcName + "/" + percentage);
		}
		
		public function getMiniGameResult():void
		{
			trace("[SDC]: get minigame result link to be call:", _gd.absPath + "quests/getquestcontestresult");
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetMiniGameResultComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetMiniGameResultFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/getquestcontestresult");
			//https://202.124.129.14/socialstars/quests/getquestcontestresult
		}
		
		public function setOfficeItemUsage(entryid:String, fbid:String = ""):void
		{
			// hgd added the costing of helping energy and ap when collecting items
			if (!_gd.friendView)
			{
				var objectData:Array = _gd.getOfficeStateDataByEntryID(entryid);
				setPlayerActionPoints(-objectData[GlobalData.OFFICESTATE_APCOST]);
			}
			else
			{
				if (fbid != "")
				{
					updatePlayerHelpingEnergy(fbid, "-1");
				}
			}
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSetOfficeItemUsageComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSetOfficeItemUsageFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/machineusage/" + entryid);
			trace("[SDC]: set office item usage", _gd.absPath + "offices/machineusage/" + entryid);
			//https://202.124.129.14/socialstars/offices/machineusage/entryid
		}
		
		public function getScene(triger:String):void
		{
			// quest_[questcommand]_start
			//quest_[questcommand]_end
			//training_[itemname]_start
			//training_[itemname]_end
			//levelup_x / levelup_any
			//buyingitem_[itemname]
			//contest_[npcname] 
			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetSceneComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetSceneFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/eventscenelist/" + triger);
			trace("[SDC]: on Get Scene link:", _gd.absPath + "game/eventscenelist/" + triger);
			//https://202.124.129.14/socialstars/game/eventscenelist/buyingitem_booklv0
		}
		
		public function updateQuestXML(online:Boolean):void
		{
			if (online)
			{
				ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData);
			}
			else
			{
				ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.offlineQuestListData);
			}
		}
		
		private function loadEventSceneImageSet():void
		{
			trace( "[SDC] loadEventScene ImageSet!!" );
			// npc image
			if (_imageLoader.getImage(_eventSceneImageSet[_eventSceneImageCount].id, _eventSceneImageSet[_eventSceneImageCount].url) != null)
			{
				pushNpcSceneImage();
			}			
			_imageLoader.addEventListener(ImageLoaderEvent.IMAGE_LOADED, onEventSceneImageLoaded);
		}
		
		public function finishEventSceme(eventid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onFinishEventSceneComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onFinishEventSceneFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/eventscenecomplete/" + eventid);
			trace("[SDC]: on finish Event Scene link:", _gd.absPath + "game/eventscenecomplete/" + eventid);
			//https://202.124.129.14/socialstars/game/eventscenecomplete/eventid
		}
		
		public function claimCollection(collectiongroupid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onClaimCollectionComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onClaimCollectionFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/claimcollection/" + collectiongroupid);
			trace("[SDC]: ON CLAIM COLLECTION link:", _gd.absPath + "offices/claimcollection/" + collectiongroupid);
			//https://202.124.129.14/socialstars/offices/claimcollection/collectiongroupid
		}
		
		public function buyMaterial(collectionitemid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onBuyMaterialComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onBuyMaterialFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/buymaterial/" + collectionitemid);
			trace("[SDC]: ON BUY MATERIAL link:", _gd.absPath + "offices/buymaterial/" + collectionitemid);
			//https://202.124.129.14/socialstars/offices/buymaterial/collectionitemid
		}
		
		public function askMaterial(itemid:String):void
		{
			//nfcaller('wallpost/askmaterial/itemid')
			_jsManager.execJs("nfcaller", "wallpost/askmaterial/" + itemid);
		}
		
		//ssi test
		private function pushNpcSceneImage():void
		{
			trace( "[SDC] push loaded EventScene ImageSet!!" );
			_sceneData.npcImage.push(_imageLoader.getImage(_eventSceneImageSet[_eventSceneImageCount].id));
			_eventSceneImageCount++;
			var len:int = _eventSceneImageSet.length;
			if (_eventSceneImageCount < len)
			{
				trace( "[SDC] loaded another EventScene ImageSet!!" );
				loadEventSceneImageSet();
			}
			else
			{
				trace( "[SDC] start loading ssi images=============>>!!" );
				_ssiImageCnt = 0;				
				loadSSI();
				
				//load ssi here				
				//done loading image set
				
				//_globalData.sceneData = _sceneData;
				//_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_SCENE_COMPLETE);
				//_es.dispatchESEvent(_sdcEvent);
				//trace("[SDC]: ON GET SCENE BUY Complete true reason", "names", _globalData.sceneData.npcName, "script", _globalData.sceneData.script, "npcImage", _globalData.sceneData.npcImage, "eventid", _sceneData.id, "_globalData.hasScript", _globalData.sceneData.hasScript, "_globalData.sceneData.hasSsi", _globalData.sceneData.hasSsi, "_globalData.sceneData.hasNpcImage", _globalData.sceneData.hasNpcImage);
				//_imageLoader.removeEventListener(ImageLoaderEvent.IMAGE_LOADED, onEventSceneImageLoaded);
			}
		}
		
		private function loadSSI():void
		{
			trace( "[SDC] loading ssi images 1 =============>>!!ssi id: ", _sceneData.ssiid[ _ssiImageCnt ], "ssi", _sceneData.ssi[ _ssiImageCnt ] );
			_imageStorage = ImageStorage.getInstance();
			var found:Boolean = _imageStorage.search( _sceneData.ssiid[ _ssiImageCnt ] );
			if ( found ){					
				var image:Bitmap = _imageStorage.getImage( _sceneData.ssiid[ _ssiImageCnt ] );
				_sceneData.ssiImage.push( image );
				trace( "[SDC] loaded  ssi images pushing=============>>!!" );
				_ssiImageCnt++;
			
				var len:int = _sceneData.ssi.length;				
				if ( _ssiImageCnt < len ) {
					trace( "[SDC]: load another ssi" );
					loadSSI();
				}else {
					addScene();					
				}
			}else {
				trace( "[SDC] loading ssi images 2 =============>>!! ssi id: ", _sceneData.ssiid[ _ssiImageCnt ], "ssi", _sceneData.ssi[ _ssiImageCnt ] );
				var config:ImageLoaderVars = new ImageLoaderVars();
				_holder = new MovieClip();
				config.container(_holder);
				config.onComplete(_completeHandler);
				config.onProgress(_progressHandler);
				config.onIOError(_ioErrorHandler);
				config.onFail(_failHandler);
				config.autoDispose(true);
				config.name(_sceneData.ssiid[ _ssiImageCnt ]);
				_gImageLoader = new ImageLoader( _sceneData.ssi[ _ssiImageCnt ], config);
				_gImageLoader.load();
			}
		}
		
		public function acceptQuest(questid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onAcceptQuestComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onAcceptQuestFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/questaccepted/" + questid);
			trace("[SDC]: ON BUY MATERIAL link:", _gd.absPath + "quests/questaccepted/" + questid);
			//https://202.124.129.14/socialstars/quests/questaccepted/qid
		}
		
		public function updateCharPosition(cid:String, xPos:int, yPos:int):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onUpdateCharPositionComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onUpdateCharPositionFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/changecharpos/" + cid + "/" + xPos + "/" + yPos);
			trace("[SDC]: ON updatePositionContestant link:", _gd.absPath + "characters/changecharpos/" + cid + "/" + xPos + "/" + yPos);
			//cid,ret,x,y,reason 
			//202.124.129.14/socialstars/characters/changecharpos/charid/x/y
		}
		
		public function stopMachine(cid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onStopMachineComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onStopMachineFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/stopmachine/" + cid);
			trace("[SDC]: onStopMachine link:", _gd.absPath + "characters/stopmachine/" + cid);
			//202.124.129.14/socialstars/characters/stopmachine/charid
		}
		
		public function reportError(reason:String):void
		{
			//var encodedUrl:String = escape( url );
			var base64encodedReason:String = Base64.encode(reason);
			
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onReportErrorComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onReportErrorFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/reporterror/" + base64encodedReason);
			trace("[SDC]: on report error link:", _gd.absPath + "game/reporterror/" + base64encodedReason);
			//http://202.124.129.14/socialstars/game/reporterror/base64encodedReason
			
			//showErrorMessage();
		}
		
		public function buyWall(id:String):void
		{
			buyUpdateWallTile(id);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onBuyWallComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onBuyWallFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/wallpics/" + id);
			trace("[SDC]: onBuyWall link:", _gd.absPath + "offices/wallpics/" + id);
		}
		
		public function buyTile(id:String):void
		{
			buyUpdateWallTile(id);
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onBuyTileComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onBuyTileFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "offices/itempics/" + id);
			trace("[SDC]: onBuyWall link:", _gd.absPath + "offices/itempics/" + id);
			//https://202.124.129.14/socialstars/offices/itempics/D5GMAiDOWZnB7bbSHIjR
		}
		
		public function machineCollect(entryId:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onMachineCollectComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onMachineCollectFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "quests/machinecollect/" + entryId);
			trace("[SDC]: machineCollect link:", _gd.absPath + "quests/machinecollect/" + entryId);
		}
		
		public function checkBoughtClothes():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckBoughtComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckBoughtFailed);
			_xmlExtractor.extractXmlData( _gd.absPath + "characters/getboughtitems" );
			trace("[SDC]: on Check Bought Clothes link:", _gd.absPath + "characters/getboughtitems");
		}
		
		public function checkWearingClothes():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckWearingClotheComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckWearingClotheFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "/characters/getwornitems");
			trace("[SDC]: on checkWearingClothes link:", _gd.absPath + "/characters/getwornitems");
			//https://202.124.129.14/socialstars/characters/getwornitems
		}
		
		public function checkInviteFriends():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckInviteFriendsComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckInviteFriendsFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "game/invitedcount");
			trace("[SDC]: on check Invite Friends link:", _gd.absPath + "game/invitedcount");
			//https://202.124.129.14/socialstars/game/invitedcount
		}
		
		public function checkHelpChallenge(cid:String):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, checkHelpChallengeComplete);
			_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, checkHelpChallengeFailed);
			_xmlExtractor.extractXmlData(_gd.absPath + "characters/charexists/" + cid);
			trace("[SDC]: on checkHelpChallenge link:", _gd.absPath + "characters/charexists/" + cid);
		}
		
		
		public function checkCharCount():void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onCheckCharCountComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onCheckCharCountFailed );
			_xmlExtractor.extractXmlData( _gd.absPath + "/characters/charcount" );
			trace("[SDC] checkCharCount link", _gd.absPath + "/characters/charcount" );
		}
		
		public function loadMyOfficeData():void 
		{				
			_popUIManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0, 0 );	
			_dialogue = new DialogueEvent( DialogueEvent.HOME_DIALOGUE );
			_es.dispatchEvent( _dialogue );			
			
			_gd.officeStateDataArray = [new Array()];			
			_gd.officeId = _gd.myFbId;
			updateHomeViewData();			
			updateMyCharlist();		
		}
		
		public function showErrorMessage():void 
		{	
			var runingOn:String = Capabilities.playerType;			
			if (runingOn != 'StandAlone')
			{
				var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
				popUpUIEvent.obj.msg = GameDialogueConfig.SERVER_SYNC_ERROR;
				_es.dispatchESEvent( popUpUIEvent );			
			}
		}
		
		public function getVisitingReward( fbid:String ):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetVisitingRewardComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetVisitingRewardFailed );
			_xmlExtractor.extractXmlData( _gd.absPath + "players/helpenergyreward/" + fbid );
			trace("[SDC] getVisitingReward link", _gd.absPath + "players/helpenergyreward/" + fbid );
		}		
		
		public function postVisitingReward( fbid:String ):void
		{
			_xmlExtractor = new XMLExtractor();
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onPostVisitingRewardComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onPostVisitingRewardFailed );
			_xmlExtractor.extractXmlData( _gd.absPath + "fbrequest/postfivehelp/" + fbid );
			trace("[SDC] postVisitingReward link", _gd.absPath + "fbrequest/postfivehelp/" + fbid );
		}		
		
		/*---------------------------------------------------------------------------Setters----------------------------------------------------------------*/
		public function set myContestant(value:ContestantData):void
		{
			_myContestant = value;
		}
		
		public function set friendContestant(value:ContestantData):void
		{
			_friendContestant = value;
		}
		
		/*---------------------------------------------------------------------------Getters----------------------------------------------------------------*/
		public function get myContestant():ContestantData
		{
			return _myContestant;
		}
		
		public function get friendContestant():ContestantData
		{
			return _friendContestant;
		}
		
		/*---------------------------------------------------------------------------EventHandlers----------------------------------------------------------*/
		
		private function onRegisterOfficeItemPositionFailed(e:XMLExtractorEvent):void
		{
			trace("onRegisterOfficeItemPositionFailed");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.REGISTER_OFFICE_ITEM_POS_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("fail");
		}
		
		private function onRegisterOfficeItemPositionComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("[SDC]:register complete method", xml.@met);
					trace("onRegisterOfficeItemPositionComplete", xml);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.REGISTER_OFFICE_ITEM_POS_COMPLETE);
					
					var globalData:GlobalData = GlobalData.instance;
					var obj:Object = new Object();
					var x:int = int(xml.@x);
					var y:int = int(xml.@y);
					var z:int = int(xml.@z);
					var rot:int = int(xml.@rot);
					var met:String = xml.@met;
					
					trace("rot", rot, "xml.@rot", xml.@rot);
					
					obj.entryid = xml.@entry;
					obj.met = met;
					obj.l = x;
					obj.w = y;
					obj.h = z;
					obj.x = x * globalData.CELL_SIZE;
					obj.y = y * globalData.CELL_SIZE;
					obj.z = z;
					obj.rot = rot;
					
					_es.dispatchESEvent(_sdcEvent, obj);
					trace("register item........complete..............................................!!!!!!!!!!!!!!!!! hedrick");
					
					getInventoryList();
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				}
				else
				{
					trace("register item........failed..............................................!!!!!!!!!!!!!!!!! hedrick");
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					reportError("fail");
				}
			}
			else
			{
				trace("register item........complete..............................................!!!!!!!!!!!!!!!!! hedrick");
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			}
		}
		
		private function onSettingXMLExtractionFailed(e:XMLExtractorEvent):void
		{
			_xmlExtractor.removeEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onSettingXMLExtractionFailed);
			trace("failed xml.........................");
		}
		
		private function onSettingXMLExtractionComplete(e:XMLExtractorEvent):void
		{
			_xmlExtractor.removeEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onSettingXMLExtractionComplete);
			var xml:XML = _xmlExtractor.xml;
			trace("xml extraction successfull....", xml);
			
			var appBgm:String = xml.@bgm;
			var appSfx:String = xml.@sfx;
			var appGfx:String = xml.@gfx;
			
			GlobalData.instance.appBGM = int(appBgm);
			GlobalData.instance.appSFX = int(appSfx);
			GlobalData.instance.appGFX = int(appGfx);
			
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SETTINGS_CHANGE);
			_es.dispatchESEvent(_sdcEvent);
			trace("bgx", appBgm, "sfx", appSfx, "appgfx", appGfx);
		}
		
		//private function onEndTrainingFailed(e:XMLExtractorEvent):void
		//{
			//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onEndTrainingComplete);
			//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onEndTrainingFailed);
			//_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
		//}
		//
		//private function onEndTrainingComplete(e:XMLExtractorEvent):void
		//{
			//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onEndTrainingComplete);
			//_xmlExtractor.addEventListener(XMLExtractorEvent.XML_EXTRACTION_FAILED, onEndTrainingFailed);
			//_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
		//}
		
		private function onFailedBuy(e:DataManagerEvent):void
		{
			trace("failed buy");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.BUY_OFFICE_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onCompleteBuy(e:DataManagerEvent):void
		{
			var xml:XML = XML(e.obj);
			if (xml != null)
			{
				trace("xml entry id", xml.@entryid, xml.@ret);
				if (xml.@ret == "true")
				{
					var obj:Object = new Object();
					obj.entryid = xml.@entryid;
					obj.itemid = xml.@itemid;
					obj.qf = xml.@qf;
					
					trace("[SDC] on buy complete successful!.......... see ", "ret" + xml.@ret, "entryid", xml.@entryid, "itemid", xml.@itemid, "own", xml.@own, "qf", xml.@qf, "typ", xml.@typ, "itemname", xml.@itemname);
					
					var valid:Boolean = false;
					if (xml.@typ == "staff")
					{
						trace("[SDC] check own", xml.@own, "type", xml.@typ);
						if (xml.@own == "0")
						{
							valid = true;
						}
						else
						{
							valid = false;
						}
					}
					else
					{
						valid = true;
					}
					
					trace("[SDC] check valid", valid);
					
					if (valid)
					{
						_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE);
						_es.dispatchESEvent(_sdcEvent, obj);
						
						var isoObjectData:IsoObjectData = _globalData.extactData(null, obj.itemid);
						trace("[SDC]: OnCompleteBUy check name", isoObjectData.name);
						var newOfficeData:Array = new Array();
						newOfficeData[GlobalData.OFFICESTATE_ENTRY] = obj.entryid;
						newOfficeData[GlobalData.OFFICESTATE_ITEMUSED] = 0;
						newOfficeData[GlobalData.OFFICESTATE_ITEMNAME] = isoObjectData.name;
						newOfficeData[GlobalData.OFFICESTATE_ITEMID] = isoObjectData.id;
						newOfficeData[GlobalData.OFFICESTATE_POSITION] = new Vector3D(int(isoObjectData.position.x), int(isoObjectData.position.y), int(isoObjectData.position.z));
						newOfficeData[GlobalData.OFFICESTATE_ROTATION] = isoObjectData.rotation;
						newOfficeData[GlobalData.OFFICESTATE_TYPE] = isoObjectData.type;
						newOfficeData[GlobalData.OFFICESTATE_SUBTYPE] = isoObjectData.subType;
						newOfficeData[GlobalData.OFFICESTATE_ITEMFRAMENUMBER] = isoObjectData.fn;
						newOfficeData[GlobalData.OFFICESTATE_DIMENSION] = new Vector3D(int(isoObjectData.l), int(isoObjectData.w), int(isoObjectData.h));
						newOfficeData[GlobalData.OFFICESTATE_STAFF_POS] = isoObjectData.stafflist;
						newOfficeData[GlobalData.OFFICESTATE_POS_STATE] = isoObjectData.state;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_STRESS] = isoObjectData.stress;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_DURATION] = isoObjectData.duration;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_HEALTH] = isoObjectData.health;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_ACTING] = isoObjectData.acting;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_ATTRACTION] = isoObjectData.attraction;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_INT] = isoObjectData.intelligence;
						newOfficeData[GlobalData.OFFICESTATE_TRAINING_SING] = isoObjectData.sing;
						newOfficeData[GlobalData.OFFICESTATE_REST_STRESS] = isoObjectData.machineStress;
						newOfficeData[GlobalData.OFFICESTATE_REST_DURATION] = isoObjectData.machineDuration;
						newOfficeData[GlobalData.OFFICESTATE_APCOST] = isoObjectData.apcost;
						
						_globalData.officeStateDataArray.push(newOfficeData);
						
						_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_COIN_CHANGE);
						_es.dispatchESEvent(_sdcEvent);
						
						getScene("buyingitem_" + xml.@itemname);
						
						_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					}
				}
				else
				{
					trace("buying office item failed...........................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.BUY_OFFICE_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.BUY_OFFICE_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("buying failed xml error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				reportError("null");
			}
		}
		
		private function onFailedSell(e:DataManagerEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_OFFICE_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("sell failed...............................................................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onCompleteSell(e:DataManagerEvent):void
		{
			var xml:XML = XML(e.obj);
			
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("sell complete...............................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.OFFICE_INVENTORY_CHANGE);
					_es.dispatchESEvent(_sdcEvent);
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_OFFICE_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_COIN_CHANGE);
					_es.dispatchESEvent(_sdcEvent);
					getInventoryList();
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_OFFICE_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("sell failed...............................................");
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					reportError("fail");
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_OFFICE_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("sell failed...............................................");
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				reportError("null");
			}
		}
		
		private function onNewSpeedExtractFailed(e:XMLExtractorEvent):void
		{
			trace("newSpeed extracted Failed.....................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onNewSpeedExtractComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = _xmlExtractor.xml;
			_jsManager.callJs("newsfeed", xml.@nf);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			trace("newSpeed extracted complete.....................");
		}
		
		private function onApTimerUpdateFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.AP_TIMER_UPDATED_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			//SYNC HERE POPUP
			reportError("epicfail");
		}
		
		private function onApTimerUpdateComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = _xmlExtractor.xml;
			var runingOn:String = Capabilities.playerType;
			
			if (runingOn != 'StandAlone')
			{
				trace("AP UPDATE RETURN", xml.@apn);
				GlobalData.instance.pNAp = xml.@apn;
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.AP_TIMER_UPDATED);
				_es.dispatchESEvent(_sdcEvent);
				
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			}
		}
		
		private function onRewardFailed(e:XMLExtractorEvent):void
		{
			var miniGameEvent:ServerDataControllerEvent = new ServerDataControllerEvent(ServerDataControllerEvent.MINI_GAME_DATA_SENT_FAILED);
			_es.dispatchESEvent(miniGameEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			trace("xml reward failed.................................................. ");
			reportError("epicfail");
		}
		
		private function onRewardComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = _xmlExtractor.xml;
			trace("xml reward successfulll...............................................");
			//trace( "xml reward successfulll................................................ ^^) ", xml );
			
			if (xml.@ret == "true")
			{
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					//updatePlayerUIData();
			}
			else
			{
				refreshGame();
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("Error: call sync Error here!....");
				reportError("null");
			}
		}
		
		private function onPlayerXmlLoaded(e:SSEvent):void
		{
			updateMapBuildingData();
		}
		
		private function onWallPostReqFailed(e:XMLExtractorEvent):void
		{
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			trace("wall post failed................................");
			reportError("epicfail");
		}
		
		private function onWallPostReqComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = _xmlExtractor.xml;
			//var obj:Object = JSON.decode(xml);
			var obj:Object = JSON.parse(xml);
			
			for (var prop:*in obj)
			{
				trace("see", prop, obj[prop]);
			}
			
			if (prop == "ret" && obj[prop] == "true")
			{
				_jsManager = JsManager.getInstance();
				_jsManager.callJs("makerequest", "1_Ask%20AP_askap");
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			}
		}
		
		private function onOfficeExpandedFailed(e:XMLExtractorEvent):void
		{
			trace("xml expansion epic Failed!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.OFFICE_EXPANDED_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onOfficeExpandedComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					/*_globalData.GRID_WIDTH = int(xml.@rows);
					 _globalData.GRID_LENGTH = int(xml.@cols);*/
					// expansion used
					_globalData.expansion = int(xml.@rows);
					_globalData.expansion = int(xml.@cols);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.OFFICE_EXPANDED_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					trace("[SDC]: expand room complete reason true", xml.reason, xml.@rows, xml.@cols);
				}
				else
				{
					trace("game is running offline expansion failed!!!!!!!!!!!!!!!!!!");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.OFFICE_EXPANDED_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					trace("[SDC]: expand room failed reason false", xml.reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.OFFICE_EXPANDED_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: expand room failed null");
				reportError("null");
			}
		}
		
		//private function onUpdateChallengeFriendView(e:PopUIEvent):void
		//{
		//if ( !_globalData.npcView ){
		//updateFriendChallengeViewData(GlobalData.instance.selectedFriendFbId);
		//updateFriendCharlist(GlobalData.instance.selectedFriendFbId);
		//}else {
		//GlobalData.instance.isChallenge = true;
		//updateNPCVisitViewData();
		//updateNpcCharlist();
		//}			
		//}
		
		//private function onUpdateVisitFriendView(e:PopUIEvent):void
		//{
		//if ( !_globalData.isNpcTabSelected ){				
		//updateFriendVisitViewData(GlobalData.instance.selectedFriendFbId );
		//updateFriendCharlist(GlobalData.instance.selectedFriendFbId);
		//}else {
		//GlobalData.instance.isChallenge = false;
		//updateNPCVisitViewData();
		//updateNpcCharlist();
		//}
		//}
		
		private function onHireStaffFailed(e:XMLExtractorEvent):void
		{
			trace("[ SDC ] buy Hire Staff EPic Failed!.............................");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_STAFF_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			//refreshGame();
			reportError("epicfail");
		}
		
		private function onHireStaffComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("[SDC ] Hire buy Staff complete! complete true reason", xml.@reason);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_STAFF_COMPLETE);
					var obj:Object = new Object();
					obj.entryid = xml.@entryid;
					_es.dispatchESEvent(_sdcEvent, obj);
					
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				}
				else
				{
					trace("[SDC ] Hire buy Staff failed! false reason", xml.@reason);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_STAFF_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					//refreshGame();
					reportError(xml.@reason);
				}
			}
			else
			{
				//trace("Hire Staff Failed!.......................................................");
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_STAFF_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("[SDC ] Hire buy Staff failed! null");
				//refreshGame();
				reportError("null");
			}
		}
		
		private function onHireCrewFailed(e:XMLExtractorEvent):void
		{
			trace("hire crew Staff Failed!.......................................................");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_CREW_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			refreshGame();
			reportError("epicfail");
		}
		
		private function onHireCrewComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("hire Crew Npc Staff complete!.......................................................");
					
					//need from res charid, crewPosition
					//todo: update global data for charlist , crew										
					
					var charId:String = xml.@cid;
					var crewPos:String = xml.@position;
					var charData:Array = GlobalData.instance.getCharDataOnCharID(charId);
					// obsolete data
					/*switch (crewPos)
					   {
					   case "manager":
					   charData[GlobalData.CHARLIST_MANAGER_NPC] = "false";
					   charData[GlobalData.CHARLIST_MANAGER_STATE] = "false";
					   break;
					
					   case "healthtrainer":
					   charData[GlobalData.CHARLIST_HEALTHTRAINER_NPC] = "false";
					   charData[GlobalData.CHARLIST_HEALTHTRAINER_STATE] = "false";
					   break;
					
					   case "vocaltrainer":
					   charData[GlobalData.CHARLIST_VOCALTRAINER_NPC] = "false";
					   charData[GlobalData.CHARLIST_VOCALTRAINER_STATE] = "false";
					   break;
					
					   case "privateteacher":
					   charData[GlobalData.CHARLIST_PRIVATETEACHER_NPC] = "false";
					   charData[GlobalData.CHARLIST_PRIVATETEACHER_STATE] = "false";
					   break;
					
					   case "actingteacher":
					   charData[GlobalData.CHARLIST_ACTINGTEACHER_NPC] = "false";
					   charData[GlobalData.CHARLIST_ACTINGTEACHER_STATE] = "false";
					   break;
					
					   case "stylist":
					   charData[GlobalData.CHARLIST_STYLIST_NPC] = "false";
					   charData[GlobalData.CHARLIST_STYLIST_STATE] = "false";
					   break;
					
					   default:
					   trace("[ SDC ]: error crew pos not found!!..... ");
					   break;
					 }*/
					
					trace("hire Crew Staff complete!.......................................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_CREW_COMPLETE);
					var obj:Object = new Object();
					_es.dispatchESEvent(_sdcEvent);
					
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					
				}
				else
				{
					trace("hire Crew Staff Failed!.......................................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_CREW_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					refreshGame();
					reportError(xml.@reason);
				}
			}
			else
			{
				trace("hire crew Staff Failed!.......................................................");
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HIRE_CREW_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				refreshGame();
				reportError("null");
			}
		}
		
		private function onHireCrewNpcFailed(e:XMLExtractorEvent):void
		{
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			trace("hire Crew Staff NPC Failed!.......................................................");
			reportError("epicfail");
		}
		
		private function onHireCrewNpcComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("hire Crew Npc Staff complete!.......................................................");
					//need from res charid, crewPosition
					//todo: update global data for charlist , crew										
					
					var charId:String = xml.@cid;
					var crewPos:String = xml.@position;
					var charData:Array = GlobalData.instance.getCharDataOnCharID(charId);
					
					/*switch (crewPos)
					   {
					   case "manager":
					   charData[GlobalData.CHARLIST_MANAGER_NPC] = "true";
					   charData[GlobalData.CHARLIST_MANAGER_STATE] = "false";
					   break;
					
					   case "healthtrainer":
					   charData[GlobalData.CHARLIST_HEALTHTRAINER_NPC] = "true";
					   charData[GlobalData.CHARLIST_HEALTHTRAINER_STATE] = "false";
					   break;
					
					   case "vocaltrainer":
					   charData[GlobalData.CHARLIST_VOCALTRAINER_NPC] = "true";
					   charData[GlobalData.CHARLIST_VOCALTRAINER_STATE] = "false";
					   break;
					
					   case "privateteacher":
					   charData[GlobalData.CHARLIST_PRIVATETEACHER_NPC] = "true";
					   charData[GlobalData.CHARLIST_PRIVATETEACHER_STATE] = "false";
					   break;
					
					   case "actingteacher":
					   charData[GlobalData.CHARLIST_ACTINGTEACHER_NPC] = "true";
					   charData[GlobalData.CHARLIST_ACTINGTEACHER_STATE] = "false";
					   break;
					
					   case "stylist":
					   charData[GlobalData.CHARLIST_STYLIST_NPC] = "true";
					   charData[GlobalData.CHARLIST_STYLIST_STATE] = "false";
					   break;
					
					   default:
					   trace("[ SDC ]: error crew pos not found!!..... ");
					   break;
					 }*/
					
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				}
				else
				{
					trace("hire Crew Staff NPC Failed!.......................................................");
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					reportError("fail");
				}
			}
			else
			{
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("hire Crew Npc Staff complete!.......................................................");
				reportError("null");
			}
		}
		
		private function onDropCoinFailed(e:XMLExtractorEvent):void
		{
			trace("drop coin failed.....................................");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.DROP_COIN_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("epicfail");
		}
		
		private function onDropCoinComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("drop coin succesfull.....................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.DROP_COIN_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					trace("drop coin failed.....................................");
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.DROP_COIN_FAILED);
					_es.dispatchESEvent(_sdcEvent);
						//reportError( xml.@reason );
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.DROP_COIN_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("drop coin failed.....................................");
				reportError("null");
			}
		}
		
		private function onSaveCharDefFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SAVE_CHAR_DEFINITION_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("save char def failed..................................................... epic failed!!");
			reportError("epicfail");
		}
		
		private function onSaveCharDefComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SAVE_CHAR_DEFINITION_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					
					//to do update charlist xml here.............................
					//update charlist
					updateMyCharlist();
					checkBoughtClothes();
					checkWearingClothes();
					trace("save char def success.....................................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SAVE_CHAR_DEFINITION_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("save char def failed..................................................... ret false reason: ", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SAVE_CHAR_DEFINITION_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("save char def failed..................................................... null");
				reportError("null");
			}
		}
		
		private function onFireCharFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CHAR_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			trace("Fire char failed.....................................................");
			reportError("epicfail");
		}
		
		private function onFireCharComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CHAR_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					//to do update charlist xml here.............................
					//update charlist
					//updateMyCharlist();
					trace("Fire char success.....................................................");
					getInventoryList();
					checkCharCount();
						//updateMyCharlist();
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CHAR_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					trace("Fire char failed..................................................... ret false reason: ", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CHAR_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("Fire char failed..................................................... null");
				reportError("null");
			}
		}
		
		private function onFireCrewFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CREW_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("Fire crew failed.....................................................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onFireCrewComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CREW_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					//to do update charlist xml here.............................
					//update charlist
					//updateMyCharlist();
					getInventoryList();
					trace("Fire crew complete.....................................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CREW_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("Fire crew failed..................................................... ret false reason: ", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.FIRE_CREW_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("Fire crew failed..................................................... null");
				reportError("null");
			}
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
		}
		
		private function onInventoryListFailed(e:DataManagerEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.INVENTORY_DATA_LOAD_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]:inventory list Failed..............................................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onInventoryListComplete(e:DataManagerEvent):void
		{
			//extractJsonEncodedData( _loader.data );
			extactInventoryJsonData(e.obj);
			trace("[ SDC ]:inventory list complete..............................................");
			//reportError( xml.@reason );
		}
		
		private function onPlaceToInventoryFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_TO_INVENTORY_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]:place to inventory Failed..............................................");
			reportError("epicfail");
			//refreshGame();
		}
		
		private function onPlaceToInventoryComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					getInventoryList();
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_TO_INVENTORY_COMPLETE);
					var obj:Object = new Object();
					obj.entryid = xml.@entry;
					_es.dispatchESEvent(_sdcEvent, obj);
					trace("[ SDC ]:place to inventory Complete..............................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_TO_INVENTORY_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]:place to inventory Failed.............................................. false", xml.@reason);
					reportError(xml.@reason);
						//refreshGame();
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_TO_INVENTORY_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]:place to inventory Failed.............................................. null ");
				reportError("null");
					//refreshGame();
			}
		}
		
		private function onPlaceCharToInventoryFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_INVENTORY_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]:place Char to inventory Failed..............................................");
			reportError("epicfail");
		}
		
		private function onPlaceCharToInventoryComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					getInventoryList();
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_INVENTORY_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]:place Char to inventory Complete..............................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_INVENTORY_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]:place Char to inventory Failed..............................................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_INVENTORY_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]:place Char to inventory Failed..............................................null");
				reportError("null");
			}
		}
		
		private function onPlaceCharToOfficeFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_OFFICE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]:place Char to OFFICE Failed..............................................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onPlaceCharToOfficeComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_OFFICE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					getInventoryList();
					updateMyCharlist();
					trace("[ SDC ]:place Char to OFFICE Complete..............................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_OFFICE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					trace("[ SDC ]:place Char to OFFICE Failed..............................................reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLACE_CHAR_TO_OFFICE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("[ SDC ]:place Char to OFFICE Failed.............................................. null");
				reportError("null");
			}
		
			//_popUIManager.removeWindow( WindowPopUpConfig.DIALOGUE_WINDOW );
		}
		
		private function onDressSellFailed(e:DataManagerEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_DRESS_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("sell dress failed..............................................");
			_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			reportError("epicfail");
		}
		
		private function onDressSellComplete(e:DataManagerEvent):void
		{
			var xml:XML = XML(e.obj);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					getInventoryList();
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_DRESS_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("sell dress complete...............................................");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_DRESS_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
					trace("sell dress failed...............................................false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SELL_DRESS_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				_popUIManager.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
				trace("sell dress failed..............................................null");
				reportError("null");
			}
		}
		
		private function onStressDownCharByItemFailed(e:XMLExtractorEvent):void
		{
			trace("[ SDC ]: stressDowmCharBYitem epic failed............................");
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("epicfail");
		}
		
		private function onStressDownCharByItemComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]: stressDowmCharBYitem complete true reason.......", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]: stressDowmCharBYitem failed false reason.......", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]: stressDowmCharBYitem  failed null............................");
				reportError("null");
			}
		}
		
		private function onStressDownCharByClickFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_CLICK_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: stress down contestant by clicking cheer epic fail");
			reportError("epicfail");
		}
		
		private function onStressDownCharByClickComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_CLICK_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					
					trace("[SDC]: stress down contestant by clicking cheer complete", xml.@reason);
					
					if (!_globalData.npcView)
					{
						if (!_globalData.friendView)
						{
							questStressDownByClickContestant(_globalData.myFbId);
							trace("[SDC]: stress down contestant by clicking cheer complete  my character view", xml.@reason);
						}
						else
						{
							questStressDownByClickContestant(_globalData.selectedFriendFbId);
							trace("[SDC]: stress down contestant by clicking cheer complete  my friend character view", xml.@reason);
						}
					}
					else
					{
						questStressDownByClickContestant(null);
						trace("[SDC]: stress down contestant by clicking cheer complete npc view", xml.@reason);
					}
						//updatePlayerHelpingEnergy( _globalData.selectedFriendFbId, "-1" );
						//to do for npc click contestant
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_CLICK_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: stress down contestant by clicking cheer  fail false", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.STRESS_DOWN_CHAR_BY_CLICK_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: stress down contestant by clicking cheer  fail null");
				reportError("null");
			}
		}
		
		private function onSoothCharFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: sooth neighbor reason : null............................");
			reportError("epicfail");
		}
		
		private function onSoothCharComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
						//ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData );
						//update quest xml
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: sooth neighbor reason : false..........................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: sooth neighbor reason : null............................");
				reportError("null");
			}
		}
		
		private function onCryCharFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.CRY_CHAR_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("cry char epic failed reason:.........................");
			reportError("epicfail");
		}
		
		private function onCryCharComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.CRY_CHAR_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.CRY_CHAR_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("cry char failed false reason:.........................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.CRY_CHAR_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("cry char failed null reason:.........................");
				reportError("null");
			}
		}
		
		private function onStartTrainFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.START_TRAIN_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ sdc ] onStart Train epic failed.........................");
			reportError("epicfail");
		}
		
		private function onStartTrainComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.START_TRAIN_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					updateAp();
					trace("[ sdc ] onStart Train Complete Complete:......................... true", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.START_TRAIN_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ sdc ] onStart Train failed reason:..... false", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.START_TRAIN_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC ]onStart Train failed null");
				reportError("null");
			}
		}
		
		private function onEndTrainFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TRAIN_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]end training epic failed..................");
			reportError("epicfail");
		}
		
		private function onEndTrainComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					// rewardid,rewardqty,rewardpic
					trace("[ SDC ]end training Complete......true reason", xml.@reason, "rewardid", xml.@rewardid, "rewardpic", xml.@rewardpic, "exp", xml.@exp , "coinreward",xml.@coinreward, "ccoin", xml.@ccoin );
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TRAIN_COMPLETE);
					_sdcEvent.obj.id = xml.@rewardid;
					_sdcEvent.obj.url = xml.@rewardpic;
					_sdcEvent.obj.x = xml.@x;
					_sdcEvent.obj.y = xml.@y;
					_sdcEvent.obj.z = xml.@z;
					_sdcEvent.obj.cid = xml.@cid;
					_sdcEvent.obj.exp = int(xml.@exp);
					_sdcEvent.obj.coinreward = int(xml.@coinreward);
					trace("[SDC ] check exp 1st ", _sdcEvent.obj.exp);					
					_es.dispatchESEvent(_sdcEvent);
					
					
					setPlayerCoin( int(xml.@coinreward)  );
					updatePlayerCoin( int( xml.@ccoin ) );
					setCharDataByCharID(xml);
					questTrain(_globalData.currentIsoObject.entryid);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TRAIN_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]end training failed......false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TRAIN_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]end training failed......null reason");
				reportError("null");
			}
		}
		
		private function onSoothMyCharFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_BY_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]SOOTH MY CHAR failed...... EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onSoothMyCharComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_BY_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]SOOTH MY CHAR Complete...... true reason ", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_BY_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]SOOTH MY CHAR failed...... false reason ", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SOOTH_CHAR_BY_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]SOOTH MY CHAR failed...... null reason ");
				reportError("null");
			}
		}
		
		private function onSetOfficeNameFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SET_OFFICE_NAME_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]SET OFFICE NAME Failed.....................");
			reportError("epicfail");
		}
		
		private function onSetOfficeNameComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SET_OFFICE_NAME_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]SET OFFICE NAME COMPLETE.....................true reason", xml.@reason, "officename", xml.@officename);
					GlobalData.instance.officeName = xml.@officename;
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SET_OFFICE_NAME_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]SET OFFICE NAME Failed.....................false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.SET_OFFICE_NAME_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]SET OFFICE NAME Failed.....................null reason");
				reportError("null");
			}
		}
		
		private function onUsedPowerItemFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.USED_POWER_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[ SDC ]USE POWER ITEM Failed.....................EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onUsedPowerItemComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.USED_POWER_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]USE POWER ITEM complete.....................true reason", xml.@reason);
					updatePlayerCoin(int(xml.@coin));
					updatePlayerAp(int(xml.@ap));
					getInventoryList();
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.USED_POWER_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[ SDC ]USE POWER ITEM Failed.....................false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.USED_POWER_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[ SDC ]USE POWER ITEM Failed.....................null");
				reportError("null");
			}
		}
		
		private function onDoneTutorialFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TUTORIAL_IS_FAILED);
			_es.dispatchESEvent(_sdcEvent);
		}
		
		private function onDoneTutorialComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TUTORIAL_IS_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TUTORIAL_IS_FAILED);
					_es.dispatchESEvent(_sdcEvent);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_TUTORIAL_IS_FAILED);
				_es.dispatchESEvent(_sdcEvent);
			}
		}
		
		private function onUpdateQuestDataFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.UPDATE_QUEST_DATA_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: update quest data epic failed");
			reportError("epicfail");
		}
		
		private function onUpdateQuestDataComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					var obj:Object = new Object();
					obj.qtid = xml.@qtid;
					obj.ret = true;
					obj.done = xml.@done;
					obj.qid = xml.@qid;
					obj.qcmd = xml.@qcmd;
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.UPDATE_QUEST_DATA_COMPLETE);
					_es.dispatchESEvent(_sdcEvent, obj);
					trace("[sdc]: update quest data complete true reason", xml.@reason, "qtid", xml.@qtid, "ret", xml.@ret, "qid", xml.@qid, "done", xml.@done, "qcmd", xml.@qcmd);
						//call domz method here
						//updateQuest( qtid, ret );
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.UPDATE_QUEST_DATA_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: update quest data epic failed false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.UPDATE_QUEST_DATA_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: update quest data  failed null");
				reportError("null");
			}
		}
		
		private function onEndQuestDataFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_QUEST_DATA_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: update quest data epic failed");
			reportError("epicfail");
		}
		
		private function onEndQuestDataComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_QUEST_DATA_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: update quest data  true reason=====================>>>", xml.@reason);
					
						//update
						//quest data xml here
						//update dhomz quesr xml here call domz methods
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_QUEST_DATA_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: update quest data  false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.END_QUEST_DATA_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: update quest data  null");
				reportError("null");
			}
		}
		
		private function onUpdateHelpingEnergyFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HELPING_ENERGY_UPDATE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: UPDATE HELPING ENERGY EPIC FAILED");
			reportError("epicfail");
		}
		
		private function onUpdateHelpingEnergyComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_globalData.pHE = int(xml.@he);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HELPING_ENERGY_UPDATE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: UPDATE HELPING ENERGY Complete true reason", xml.@reason, "from server he", xml.@he);
					
					if( _globalData.pHE == 0  && _gd.showVisitingReward ){
						_popUIManager.loadSubWindow( WindowPopUpConfig.THANKS_FOR_VISITING_WINDOW );
						trace( "[ SDC show thanks for visiting window ]" );
					}
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HELPING_ENERGY_UPDATE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: UPDATE HELPING ENERGY FAILED false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.HELPING_ENERGY_UPDATE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: UPDATE HELPING ENERGY FAILED null");
				reportError("null");
			}
		}
		
		private function onPickRewardFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PICK_REWARD_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: ON PICK REWARD EPIC FAILED");
			reportError("ON PICK REWARD EPIC FAILED");
		}
		
		private function onPickRewardComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PICK_REWARD_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON PICK REWARD complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PICK_REWARD_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON PICK REWARD FAILED false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PICK_REWARD_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON PICK REWARD FAILED null");
				reportError("ON PICK REWARD FAILED null");
			}
		}
		
		private function onGetEndQuestDataFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_END_QUEST_DATA_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: ON GET END QUEST DATA EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onGetEndQuestDataComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace( "[SDC] check rewards", xml.rewards  );
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_END_QUEST_DATA_COMPLETE);				
					
					var obj:Object = new Object();
					obj.pexp = xml.@pexp;
					obj.coin = xml.@coin;
					obj.npcscript = xml.@npcscript;
					obj.script = xml.script;
					
					var questRewardData:QuestRewardData;
					var rewards = new Array();
					
					for (var m:int = 0; m < xml.rewards.reward.length(); m++) 
					{
						questRewardData = new QuestRewardData();
						questRewardData.id = xml.rewards.reward[ m ].@id;
						questRewardData.type = xml.rewards.reward[ m ].@type;
						questRewardData.material = xml.rewards.reward[ m ].@material;
						questRewardData.label = xml.rewards.reward[ m ].@lbl;
						questRewardData.quantity = int( xml.rewards.reward[ m ].@qty);
						questRewardData.image = xml.rewards.reward[ m ].@img;						
						rewards.push( questRewardData );						
					}
					
					obj.rewards = rewards;
					
					_es.dispatchESEvent(_sdcEvent, obj);				
					
					trace("[sdc]: ON GET END QUEST DATA  complete true REASON", xml.@reason, xml.@pexp, xml.@coin);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_END_QUEST_DATA_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON GET END QUEST DATA  FAILED FALSE REASON", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_END_QUEST_DATA_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON GET END QUEST DATA  FAILED FALSE REASON null ");
				reportError("null");
			}
		}
		
		private function onAddContestantStatFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ADD_CONTESTANT_STAT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on add contestant stat DATA EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onAddContestantStatComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					setCharDataByCharID(xml);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ADD_CONTESTANT_STAT_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on add contestant stat DATA true	reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ADD_CONTESTANT_STAT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on add contestant stat DATA FALSE	reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ADD_CONTESTANT_STAT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on add contestant stat DATA null");
				reportError("null");
			}
		}
		
		private function onSetOfficeObjectInUsedFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_OBJECT_IN_USED_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on set office object in used epic FAIL");
			reportError("epicfail");
		}
		
		private function onSetOfficeObjectInUsedComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_OBJECT_IN_USED_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set office object in used epic complte true", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_OBJECT_IN_USED_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set office object in used epic FAIL false", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_OBJECT_IN_USED_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on set office object in used epic FAIL null");
				reportError("null");
			}
		}
		
		private function onUpdateTileWallFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_WALL_TILE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: ON update wall tile epic fail!!==================>");
			reportError("epicfail");
		}
		
		private function onUpdateTileWallComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_WALL_TILE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON update wall tile true complete reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_WALL_TILE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON update wall tile false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_WALL_TILE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON update wall tile null");
				reportError("null");
			}
		}
		
		private function onSaveGenderFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SAVE_GENDER_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on save gender epic fail");
			reportError("epicfail");
		}
		
		private function onSaveGenderComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SAVE_GENDER_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on save gender complete reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SAVE_GENDER_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on save gender fail false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SAVE_GENDER_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: [sdc]: on save gender fail null");
				reportError("null");
			}
		}
		
		private function onGetGridWidthLengthFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_WIDTH_HEIGHT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on GET GRIDXY EPIC FAILED.............................");
			
			//set default
			/*_globalData.GRID_WIDTH = 10;
			 _globalData.GRID_LENGTH = 10;*/
			_globalData.expansion = 10;
			reportError("epicfail");
		}
		
		private function onGetGridWidthLengthComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					/*_globalData.GRID_WIDTH = int( xml.rows );
					 _globalData.GRID_LENGTH = int( xml.cols );*/
					// switched to expansion
					_globalData.expansion = int(xml.rows);
					_globalData.expansion = int(xml.cols);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_WIDTH_HEIGHT_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on GET GRIDXY COMPLETE..................... reason", xml.@reason, "rows", xml.@rows, "cols", xml.@cols);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_WIDTH_HEIGHT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on GET GRIDXY failed false..................... reason", xml.@reason);
					
					//set default
					/*_globalData.GRID_WIDTH = 10;
					 _globalData.GRID_LENGTH = 10;*/
					_globalData.expansion = 10;
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_WIDTH_HEIGHT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on GET GRIDXY failed null.............................");
				
				//set default
				/*_globalData.GRID_WIDTH = 10;
				 _globalData.GRID_LENGTH = 10;*/
				_globalData.expansion = 10;
				reportError("null");
			}
		}
		
		private function onVisitNpcFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_VISIT_NPC_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on VISIT NPC EPIC FAIL.............................");
			reportError("epicfail");
		}
		
		private function onVisitNpcComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_VISIT_NPC_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on VISIT NPC complete true reason............", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_VISIT_NPC_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on VISIT NPC failed false reason............", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_VISIT_NPC_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on VISIT NPC failed NULL.............................");
				reportError("null");
			}
		}
		
		private function onClickedFriendOfficeItemFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLICK_FRIEND_OFFICE_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on CLICK FRIEND OFFICE ITEM EPIC FAIL.............................");
			reportError("epicfail");
		}
		
		private function onClickedFriendOfficeItemComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLICK_FRIEND_OFFICE_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on CLICK FRIEND OFFICE ITEM complete..........reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLICK_FRIEND_OFFICE_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on CLICK FRIEND OFFICE ITEM false FAIL..........reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLICK_FRIEND_OFFICE_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on CLICK FRIEND OFFICE ITEM null FAIL.............................");
				reportError("null");
			}
		}
		
		private function onChallengeFriendContestantFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on CHALLENGE FRIEND CONTESTANT EPIC FAILED.............................");
			reportError("epicfail");
		}
		
		private function onChallengeFriendContestantComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on CHALLENGE FRIEND CONTESTANT complete reason....", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on CHALLENGE FRIEND CONTESTANT failed false reason....", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on CHALLENGE FRIEND CONTESTANT failed null.............................");
				reportError("null");
			}
		}
		
		private function onQuestTrainingFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_TRAIN_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on quest train epic failed.............................");
			reportError("epicfail");
		}
		
		private function onQuestTrainingComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_TRAIN_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest train complete.........reason", xml.@reason, "qid", xml.@qid, "qtid", xml.@qtid);
					updateQuestData(xml.@qid, xml.@qtid);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_TRAIN_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest train failed false.........reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_TRAIN_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on quest train failed null.............................");
				reportError("null");
			}
		}
		
		private function onQuestStressDownByClickContestantFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on quest stress down by click contestant epic fail.............................");
			reportError("epic fail");
		}
		
		private function onQuestStressDownByClickContestantComplete(e:XMLExtractorEvent):void
		{
			//var xml:XML = _xmlExtractor.xml;
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest stress down by click contestant  complete reason.....", xml.@reason, "qid", xml.@qid, "qtid", xml.@qtid);
					updateQuestData(xml.@qid, xml.@qtid);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest stress down by click contestant  fail reason false.....", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on quest stress down by click contestant  fail null......................");
				reportError("null");
			}
		}
		
		private function onQuestStressDownByClickItemFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on quest stress down by click item epic fail.............................");
			reportError("epicfail");
		}
		
		private function onQuestStressDownByClickItemComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest stress down by click item complete reason...........", xml.@reason, "qid", xml.@qid, "qtid", xml.@qtid);
					updateQuestData(xml.@qid, xml.@qtid);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest stress down by click item failed false reason...........", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on quest stress down by click item failed null.............................");
				reportError("null");
			}
		}
		
		private function onQuestVisitFriendNpcFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_VISIT_FRIEND_NPC_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on quest visit friend npc epic fail!");
			reportError("[sdc]: on quest visit friend npc epic fail!");
		}
		
		private function onQuestVisitFriendNpcComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_VISIT_FRIEND_NPC_COMPLETE);
					//when done == 1 has qid and qtid, else 0 not done
					if (xml.@done == "1")
					{
						_sdcEvent.obj.qf = xml.@qf;
						_sdcEvent.obj.qid = xml.@qid;
						_sdcEvent.obj.qtid = xml.@qtid;
							//updateQuestData(xml.@qid, xml.@qtid);
					}
					else
					{
						_sdcEvent.obj.qf = "none";
						_sdcEvent.obj.qid = "none";
						_sdcEvent.obj.qtid = "none";
					}
					
					trace("[sdc]: on quest visit friend npc comlete reason................", xml.@reason, "qf", xml.@qf, "qid", xml.@qid, "qtid", xml.@qtid, "done", xml.@done);
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_VISIT_FRIEND_NPC_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on quest visit friend npc fail false reason................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_QUEST_VISIT_FRIEND_NPC_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on quest visit friend npc fail null.............................");
				reportError("null");
			}
		}
		
		private function onSetOldToNewQuestFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OLD_TO_NEW_QUEST_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on SET OLD TO NEW QUEST EPIC FAIL.............................");
			reportError("epic fail");
		}
		
		private function onSetOldToNewQuestComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OLD_TO_NEW_QUEST_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on SET OLD TO NEW QUEST complete true.............................reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OLD_TO_NEW_QUEST_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on SET OLD TO NEW QUEST FAIL false.............................reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OLD_TO_NEW_QUEST_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on SET OLD TO NEW QUEST FAIL null.............................");
				reportError("null");
			}
		}
		
		private function onRouteChallengeFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on ROUTE CHALLENGE EPIC FAIL.............................");
			reportError("epicfail");
		}
		
		private function onRouteChallengeComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					ServerDataExtractor.instance.updateData(GlobalData.FRIENDROUTES_DATA, XMLLinkData.instance.onlineFriendRoutesData);
					trace("[sdc]: on ROUTE CHALLENGE complete.............................", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on ROUTE CHALLENGE FAIL false.............................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on ROUTE CHALLENGE FAIL null.............................");
				reportError("null");
			}
		}
		
		private function onRouteHelpFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_HELP_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on ROUTE help EPIC FAIL.............................");
			reportError("epicfail");
		}
		
		private function onRouteHelpComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_HELP_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					ServerDataExtractor.instance.updateData(GlobalData.FRIENDROUTES_DATA, XMLLinkData.instance.onlineFriendRoutesData);
					trace("[sdc]: on ROUTE Help complete true.............................", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_HELP_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on ROUTE Help FAIL false.............................", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ROUTE_HELP_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on ROUTE Help FAIL null.............................");
				reportError("null");
			}
		}
		
		private function onGetRandomContestantFromFriendFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: ON GET RANDOM FRIEND CONTESTANT EPIC FAIL.............................");
			reportError("epicfail");
		}
		
		private function onGetRandomContestantFromFriendComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("[sdc]: ON GET RANDOM FRIEND CONTESTANT complete true...............REASON", xml.@reason);
					trace("[sdc]: data get: ", xml.@fbid, xml.@cid, xml.@name, xml.@lvl, xml.@gender, xml.@health, xml.@sing, xml.@intelligent, xml.@acting, xml.@attraction, xml.@bodydef);
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_COMPLETE);
					var contestant:ContestantData = new ContestantData();
					contestant.fbid = xml.@fbid;
					contestant.cid = xml.@cid;
					contestant.name = xml.@name;
					contestant.lvl = int(xml.@lvl);
					contestant.gender = xml.@gender;
					contestant.health = int(xml.@health);
					contestant.sing = int(xml.@sing);
					contestant.intelligent = int(xml.@intelligent);
					contestant.acting = int(xml.@acting);
					contestant.attraction = int(xml.@attraction);
					contestant.bodydef = xml.@bodydef;
					_sdcEvent.contestantData = contestant;
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON GET RANDOM FRIEND CONTESTANT FAILED FALSE...............REASON", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON GET RANDOM FRIEND CONTESTANT FAILED NULL.............................");
				reportError("null");
			}
		}
		
		private function onSetMiniGameDataFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_DATA_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: ON SET MINI GAME DATA EPIC FAIL.............................");
		}
		
		private function onSetMiniGameDataComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_DATA_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON SET MINI GAME DATA complete true............................reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_DATA_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON SET MINI GAME DATA FAIL false............................reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_DATA_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON SET MINI GAME DATA FAIL NULL.............................");
				reportError("null");
			}
		}
		
		private function onGetMiniGameDataFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_DATA_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on get mini  game data EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onGetMiniGameDataComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					var myContestant:ContestantData = new ContestantData();
					myContestant.fbid = xml.@yourfbid;
					myContestant.cid = xml.@yourcid;
					myContestant.name = xml.@yourcharname;
					myContestant.lvl = int(xml.@yourcharlvl);
					myContestant.gender = xml.@yourchargender;
					myContestant.health = int(xml.@yourcharhealth);
					myContestant.sing = int(xml.@yourcharsing);
					myContestant.intelligent = int(xml.@yourcharintelligent);
					myContestant.acting = int(xml.@yourcharacting);
					myContestant.attraction = int(xml.@yourcharattraction);
					myContestant.bodydef = xml.@yourcharbodydef;
					myContestant.stress = xml.@yourcharstress;
					myContestant.popularity = xml.@yourcharpopularity;
					myContestant.gamediff = xml.@gamediff;
					myContestant.gameMode = xml.@gamemode;
					myContestant.isPlayer = true;
					myContestant.duration = xml.@duration;
					_myContestant = myContestant;
					
					var friendContestant:ContestantData = new ContestantData();
					friendContestant.fbid = xml.@friendfbid;
					friendContestant.cid = xml.@friendcid;
					friendContestant.name = xml.@friendcharname;
					friendContestant.lvl = int(xml.@friendcharlvl);
					friendContestant.gender = xml.@friendchargender;
					friendContestant.health = int(xml.@friendcharhealth);
					friendContestant.sing = int(xml.@friendcharsing);
					friendContestant.intelligent = int(xml.@friendcharintelligent);
					friendContestant.acting = int(xml.@friendcharacting);
					friendContestant.attraction = int(xml.@friendcharattraction);
					friendContestant.bodydef = xml.@friendcharbodydef;
					friendContestant.stress = xml.@friendcharstress;
					friendContestant.popularity = xml.@friendcharpopularity;
					friendContestant.isPlayer = false;
					_friendContestant = friendContestant;
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_DATA_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON GET MINIGAME DATA complete reason", xml.@reason)
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_DATA_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: ON GET MINIGAME DATA fail false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_DATA_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: ON GET MINIGAME DATA fail false reason null");
				reportError("null");
			}
		}
		
		private function onSetContestantFromNewToOldFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_CONTESTANT_FROM_NEW_TO_OLD_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on set Contestant from new to old epic fail");
			reportError("epicfail");
		}
		
		private function onSetContestantFromNewToOldComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_CONTESTANT_FROM_NEW_TO_OLD_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set Contestant from new to old complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_CONTESTANT_FROM_NEW_TO_OLD_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set Contestant from new to old fail false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_CONTESTANT_FROM_NEW_TO_OLD_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on set Contestant from new to old fail null");
				reportError("null");
			}
		}
		
		private function onSetMiniGameResultFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on set MINIGAME DATA RESULT epic fail");
			reportError("epicfail");
		}
		
		private function onSetMiniGameResultComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set MINIGAME DATA RESULT complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on set MINIGAME DATA RESULT failed false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINIGAME_RESULT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on set MINIGAME DATA RESULT failed null");
				reportError("null");
			}
		}
		
		private function onGetMiniGameResultFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[sdc]: on get MINIGAME DATA RESULT epic fail");
			reportError("epicfail");
		}
		
		private function onGetMiniGameResultComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_COMPLETE);
					trace("[SDC] check win", xml.@win);
					if (xml.@win == "1")
					{
						//_globalData.currentRewardData = new RewardData();
						//_globalData.currentRewardData.coin = int(xml.@coin);
						//_globalData.currentRewardData.ap = int(xml.@ap);
						//_globalData.currentRewardData.exp = int(xml.@exp);
						//_globalData.currentRewardData.win = int(xml.@win);
						//_globalData.currentRewardData.collection = xml.@collection;
						//_globalData.currentRewardData.collectionpath = xml.@collectionpath;
						//_globalData.currentRewardData.npcname = xml.@npcname;
						_sdcEvent.obj.win = int(xml.@win);
						_sdcEvent.obj.qf = xml.@qf;
						
						trace("[sdc]: on get MINIGAME DATA RESULT complete true reason for the win", xml.@reason, "coin", xml.@coin, "exp", xml.@exp, "ap", xml.@ap, "collection", xml.@collection, "path", xml.@collectionpath, "npcname", xml.@npcname, "win", xml.@win);
							getScene( "contest_" + xml.@npcname );
					}
					else
					{
						trace("[sdc]: on get MINIGAME DATA RESULT complete true reason but loose", xml.@reason, "coin", xml.@coin, "exp", xml.@exp, "ap", xml.@ap, "collection", xml.@collection, "path", xml.@collectionpath, "npcname", xml.@npcname, "win", xml.@win);
						_sdcEvent.obj.qf = "none";
						//_globalData.currentRewardData = null;
					}
					
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[sdc]: on get MINIGAME DATA RESULT fail false reason", xml.@reason);
					//reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[sdc]: on get MINIGAME DATA RESULT fail null");
				reportError("null");
			}
			
			ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, XMLLinkData.instance.onlineMapBuildingData);
		}
		
		private function onSetOfficeItemUsageFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_ITEM_USAGE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: on Set OFFICE item usage failed epic fail");
			reportError("epicfail");
		}
		
		private function onSetOfficeItemUsageComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_OBJECT_IN_USED_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: on Set OFFICE item usage complete reason", xml.@reason);
					
					var energy:int = int( xml.@he );
					//==========================
					if ( energy >= 0 )
					{
						_globalData.pHE = energy;
					}
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE);
					_es.dispatchESEvent(_sdcEvent);						
					//==============================
					//call for quest atm usage
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_ITEM_USAGE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: on Set OFFICE item usage failed false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_OFFICE_ITEM_USAGE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: on Set OFFICE item usage failed null");
				reportError("null");
			}
		}
		
		private function onGetSceneFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_SCENE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON GET SCENE BUY EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onGetSceneComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					//trace("check scene data:", xml, "scene", xml.scene.script[0].@npcimage, "eventid", xml.scene.@id, "trigger", xml.scene.@trigger);
					//trace( "[SDC] eventid 0 check ==>", xml.scene[ 0 ].@id );
					//trace( "[SDC] eventid 1 check ==>", xml.scene[ 1 ].@id );
					//trace( "[SDC] eventid 2 check ==>", xml.scene[ 2 ].@id );
					//quest_start
					//quest_end
					//training_start
					//training_end
					//levelup
					//buyingitem
					//contest
					
					_sceneTracker = 0;
					_sceneXml = xml;
					
					/*
					_sceneData = new SceneData();
					_sceneData.id = xml.scene.@id;
					_sceneData.trigger = xml.scene.@trigger;
					
					_eventSceneImageSet = new Array();
					var eventScneObj:Object;
					
					for (var i:int = 0; i < xml.scene.script.length(); i++)
					{
						eventScneObj = new Object();
						eventScneObj.url = xml.scene.script[i].@npcimageurl;
						eventScneObj.id = xml.scene.script[i].@npcimage;
						eventScneObj.script = xml.scene.script[i].@script;
						eventScneObj.ssi = xml.scene.script[i].@ssi;
						eventScneObj.ssiid = xml.scene.script[i].@ssiid;
						eventScneObj.name = xml.scene.script[i].@npcname;
						_sceneData.hasScript = int(xml.scene.script[i].@hasscript);
						_sceneData.hasNpcImage = int(xml.scene.script[i].@hasimage);
						_sceneData.hasSsi = int(xml.scene.script[i].@hasssi);
						//_sceneData.eventSceneImageSet.push( eventScneObj );
						_eventSceneImageSet.push(eventScneObj);
						_sceneData.script.push(eventScneObj.script);
						_sceneData.npcName.push(eventScneObj.name);
						_sceneData.ssi.push( _gd.absPath + eventScneObj.ssi );
						_sceneData.ssiid.push( eventScneObj.ssiid );						
						trace("[SDC] _sceneData.ssiid", eventScneObj.ssiid, "eventScneObj.name", eventScneObj.name, "eventScneObj.script", eventScneObj.script);						
					}
					
					_eventSceneImageCount = 0;
					loadEventSceneImageSet();
					*/
					extractScene();
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_SCENE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON GET SCENE BUY FAIL false reason", xml.@reason);
					//reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_SCENE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON GET SCENE BUY FAIL null");
				reportError("null");
			}
		}
		
		
		private function extractScene():void 
		{
			trace( "[SDC]: extracting scene index: ", _sceneTracker );
			_sceneData = new SceneData();
			_sceneData.id = _sceneXml.scene[ _sceneTracker ].@id;
			_sceneData.trigger = _sceneXml.scene[ _sceneTracker ].@trigger;
			
			_eventSceneImageSet = new Array();
			var eventScneObj:Object;
			
			for (var i:int = 0; i < _sceneXml.scene[ _sceneTracker ].script.length(); i++)
			{
				eventScneObj = new Object();
				eventScneObj.url = _sceneXml.scene[ _sceneTracker ].script[i].@npcimageurl;
				eventScneObj.id = _sceneXml.scene[ _sceneTracker ].script[i].@npcimage;
				eventScneObj.script = _sceneXml.scene[ _sceneTracker ].script[i].@script;
				eventScneObj.ssi = _sceneXml.scene[ _sceneTracker ].script[i].@ssi;
				eventScneObj.ssiid = _sceneXml.scene[ _sceneTracker ].script[i].@ssiid;
				eventScneObj.name = _sceneXml.scene[ _sceneTracker ].script[i].@npcname;
				_sceneData.hasScript = int(_sceneXml.scene[ _sceneTracker ].script[i].@hasscript);
				_sceneData.hasNpcImage = int(_sceneXml.scene[ _sceneTracker ].script[i].@hasimage);
				_sceneData.hasSsi = int(_sceneXml.scene[ _sceneTracker ].script[i].@hasssi);				
				_eventSceneImageSet.push(eventScneObj);
				_sceneData.script.push(eventScneObj.script);
				_sceneData.npcName.push(eventScneObj.name);
				_sceneData.ssi.push( _gd.absPath + eventScneObj.ssi );
				_sceneData.ssiid.push( eventScneObj.ssiid );						
				trace("[SDC] scene index ", _sceneTracker, "scene id", _sceneData.id , "_sceneData.ssiid", eventScneObj.ssiid, "eventScneObj.name", eventScneObj.name, "eventScneObj.script", eventScneObj.script);
			}
			
			_eventSceneImageCount = 0;
			loadEventSceneImageSet();
		}
		
		private function onEventSceneImageLoaded(e:ImageLoaderEvent):void
		{
			if (e.obj.id != null && e.obj.id != "" && e.obj != null)
			{
				if (e.obj.id == _eventSceneImageSet[_eventSceneImageCount].id)
				{
					pushNpcSceneImage();
				}
				else
				{
					trace("[SDC]: loaded different image its supposed for eventScene iMage");
				}
			}
		}
		
		private function onFinishEventSceneFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_FINISH_EVENT_SCENE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON FINISH EVENT SCENE EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onFinishEventSceneComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_FINISH_EVENT_SCENE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON FINISH EVENT SCENE complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_FINISH_EVENT_SCENE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON FINISH EVENT SCENE FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_FINISH_EVENT_SCENE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON FINISH EVENT SCENE FAIL null");
				reportError("null");
			}
		}
		
		private function onClaimCollectionFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLAIM_COLLECTION_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON CLAIM COLLECTION EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onClaimCollectionComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLAIM_COLLECTION_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON CLAIM COLLECTION complete true reason", xml.@reason);
					ServerDataExtractor.instance.updateData(GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.onlineMaterialListData);
					ServerDataExtractor.instance.updateData(GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.onlineCollectionListData);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLAIM_COLLECTION_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON CLAIM COLLECTION FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CLAIM_COLLECTION_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON CLAIM COLLECTION FAIL null ");
				reportError("null");
			}
		}
		
		private function onBuyMaterialFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_MATERIAL_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON buy material EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onBuyMaterialComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_MATERIAL_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					ServerDataExtractor.instance.updateData(GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.onlineMaterialListData);
					ServerDataExtractor.instance.updateData(GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.onlineCollectionListData);
					trace("[SDC]: ON buy material  complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_MATERIAL_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON buy material  FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_MATERIAL_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON buy material  FAIL null ");
				reportError("null");
			}
		}
		
		private function onBuyConsumableItemFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_CONSUMABLE_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON buy Consumable item EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onBuyConsumableItemComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_CONSUMABLE_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON buy Consumable item complete true reason", xml.@reason);
					getInventoryList();
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_CONSUMABLE_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON buy Consumable item FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_CONSUMABLE_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON buy Consumable item FAIL null");
				reportError("null");
			}
		}
		
		private function onCheckIfOwnItemFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: on check own item EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onCheckIfOwnItemComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_OWN_ITEM_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: on check own item compleye true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: on check own item FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: on check own item FAIL null ");
				reportError("null");
			}
		}
		
		private function onAcceptQuestFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ACCEPT_QUEST_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON ACCEPT QUEST EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onAcceptQuestComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ACCEPT_QUEST_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON ACCEPT QUEST complete true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ACCEPT_QUEST_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON ACCEPT QUEST FAIL false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_ACCEPT_QUEST_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON ACCEPT QUEST FAIL reason null ");
				reportError("null");
			}
		}
		
		private function onUpdateCharPositionFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_CHAR_POSITION_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON_UPDATE_CHAR_POSITION_FAILED EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onUpdateCharPositionComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_CHAR_POSITION_COMPLETE);
					_sdcEvent.obj.x = xml.@x;
					_sdcEvent.obj.y = xml.@y;
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_UPDATE_CHAR_POSITION_COMPLETE true REASON", xml.@reason, "x", xml.@x, "y", xml.@y);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_CHAR_POSITION_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_UPDATE_CHAR_POSITION_FAILED FAIL FALSE REASON", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_UPDATE_CHAR_POSITION_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON_UPDATE_CHAR_POSITION_FAILED null ");
				reportError("null");
			}
		}
		
		private function onStopMachineFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_STOP_MACHINE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON_STOP_MACHINE_FAILED EPIC FAIL");
			reportError("epicfail");
		}
		
		private function onStopMachineComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_STOP_MACHINE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_STOP_MACHINE_COMPLETE true reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_STOP_MACHINE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_STOP_MACHINE_FAILED false reason", xml.@reason);
					reportError(xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_STOP_MACHINE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON_STOP_MACHINE_FAILED null");
				reportError("null");
			}
		}
		
		private function onReportErrorFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_REPORT_ERROR_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			trace("[SDC]: ON_REPORT_ERROR_FAILED EPIC FAIL");
		}
		
		private function onReportErrorComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_REPORT_ERROR_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_REPORT_ERROR_COMPLETE true  reason", xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_REPORT_ERROR_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_REPORT_ERROR_FAILED false FAIL reason", xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_REPORT_ERROR_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				trace("[SDC]: ON_REPORT_ERROR_FAILED null FAIL");
			}
		}
		
		private function onBuyWallFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_WALL_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_BUY_WALL_FAILED EPIC FAIL");
			trace("[SDC]: ON_BUY_WALL_FAILED EPIC FAIL");
		}
		
		private function onBuyWallComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					trace("[SDC]: ON_BUY_WALL_COMPLETE true ", "fileurl xml.@imgl", xml.@imgl, "xml.@imgr", xml.@imgr, "filename left", xml.@imglname, "right", xml.@imgrname);
					_gd.wallImageLeft = _gd.absPath + xml.@imgl;
					_gd.wallImageLeftName = xml.@imglname;
					_gd.wallImageRight = _gd.absPath + xml.@imgr;
					_gd.wallImageRightName = xml.@imgrname;
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_WALL_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_WALL_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError(xml.@reason);
					trace("[SDC]: ON_BUY_WALL_FAILED FAIL false ");
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_WALL_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_BUY_WALL_FAILED FAIL null ");
				trace("[SDC]: ON_BUY_WALL_FAILED FAIL null ");
			}
		}
		
		private function onBuyTileFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_TILE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_BUY_TILE_FAILED EPIC FAIL");
			trace("[SDC]: ON_BUY_TILE_FAILED EPIC FAIL");
		}
		
		private function onBuyTileComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_gd.tileImage = xml.@img;
					_gd.tileImageName = xml.@imgname;
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_TILE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_BUY_TILE_COMPLETE true");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_TILE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError(xml.@reason);
					trace("[SDC]: ON_BUY_TILE_FAILED false FAIL");
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_BUY_TILE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_BUY_TILE_FAILED null FAIL");
				trace("[SDC]: ON_BUY_TILE_FAILED null FAIL");
			}
		}
		
		private function onMachineCollectFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_MACHINE_COLLECT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_MACHINE_COLLECT_FAILED EPIC FAIL");
			trace("[SDC]: ON_MACHINE_COLLECT_FAILED EPIC FAIL");
		}
		
		private function onMachineCollectComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_MACHINE_COLLECT_COMPLETE);
					_sdcEvent.obj.qf = xml.@qf;
					trace("[SDC]: ON_MACHINE_COLLECT_COMPLETE qf: ", xml.@qf);
					_es.dispatchESEvent(_sdcEvent);
					
					var energy:int = int( xml.@he );
					//==========================
					if ( energy >= 0 )
					{
						_globalData.pHE = energy;
					}
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE);
					_es.dispatchESEvent(_sdcEvent);	
					
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_MACHINE_COLLECT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError(xml.@reason);
					trace("[SDC]: ON_MACHINE_COLLECT_FAILED reason: ", xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_MACHINE_COLLECT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_MACHINE_COLLECT_FAILED null");
				trace("[SDC]: ON_MACHINE_COLLECT_FAILED null");
			}
		}
		
		private function onCheckBoughtFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED EPIC FAIL");
			trace("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED EPIC FAIL");
		}
		
		private function onCheckBoughtComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_BOUGHT_CLOTH_ITEM_COMPLETE);
					_sdcEvent.obj.qf = xml.q.@qf;
					_sdcEvent.obj.qtid = xml.q.@qtid;
					_sdcEvent.obj.qid = xml.q.@qid;
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_COMPLETE true reason", xml.@reason);
					trace("[SDC]: check bought item date recieved qf", xml.q.@qf, "qtid: ", xml.q.@qtid, "qid", xml.q.@qid);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED false reason" + xml.@reason);
					trace("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED false reason", xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED null");
				trace("[SDC]: ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED null");
			}
		}
		
		private function onCheckWearingClotheFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_WEARING_CLOTH_ITEM_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED EPIC FAIL");
			trace("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED EPIC FAIL");
		}
		
		private function onCheckWearingClotheComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_WEARING_CLOTH_ITEM_COMPLETE);
					_sdcEvent.obj.qf = xml.q.@qf;
					_sdcEvent.obj.qtid = xml.q.@qtid;
					_sdcEvent.obj.qid = xml.q.@qid;
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_COMPLETE true reason: " + xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_WEARING_CLOTH_ITEM_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED false reason: " + xml.@reason);
					trace("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED false reason: " + xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_WEARING_CLOTH_ITEM_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED null");
				trace("[SDC]: ON_CHECK_WEARING_CLOTH_ITEM_FAILED null");
			}
		}
		
		private function onCheckInviteFriendsFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_INVITE_FRIENDS_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED EPIC FAIL");
			trace("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED EPIC FAIL");
		}
		
		private function onCheckInviteFriendsComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_INVITE_FRIENDS_COMPLETE);
					_sdcEvent.obj.qf = xml.@qf;
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_INVITE_FRIENDS_COMPLETE true REASON" + xml.@reason);
					trace("[SDC]: ON_CHECK_INVITE_FRIENDS_COMPLETE true REASON" + xml.@reason);
					
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_INVITE_FRIENDS_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					//reportError("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED FALSE REASON" + xml.@reason);
					trace("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED FALSE REASON" + xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_INVITE_FRIENDS_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED NULL");
				trace("[SDC]: ON_CHECK_INVITE_FRIENDS_FAILED NULL");
			}
		}
		
		private function onSetMiniGameDataStoryModeFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED EPIC FAIL");
			trace("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED EPIC FAIL");
		}
		
		private function onSetMiniGameDataStoryModeComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINI_GAME_DATA_STORY_MODE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					trace("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_COMPLETE true reason" + xml.@reason);
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED reason" + xml.@reason);
					trace("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED reason" + xml.@reason);
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED null");
				trace("[SDC]: ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED null");
			}
		}
		
		private function checkHelpChallengeFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_HELP_CHALLENGE_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED EPIC FAIL");
			trace("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED EPIC FAIL");
		}
		
		private function checkHelpChallengeComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_HELP_CHALLENGE_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_HELP_CHALLENGE_COMPLETE true complete");
					trace("[SDC]: ON_CHECK_HELP_CHALLENGE_COMPLETE true complete");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_HELP_CHALLENGE_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED false FAIL");
					trace("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED false FAIL");
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_HELP_CHALLENGE_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED null FAIL");
				trace("[SDC]: ON_CHECK_HELP_CHALLENGE_FAILED null FAIL");
			}
		}
		
		private function onGetFriendContestantFailed(e:XMLExtractorEvent):void
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED EPIC FAIL");
			trace("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED EPIC FAIL");
		}
		
		private function onGetFriendContestantComplete(e:XMLExtractorEvent):void
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_COMPLETE);
					var contestant:ContestantData = new ContestantData();
					contestant.fbid = xml.@fbid;
					contestant.cid = xml.@cid;
					contestant.name = xml.@name;
					contestant.lvl = int(xml.@lvl);
					contestant.gender = xml.@gender;
					contestant.health = int(xml.@health);
					contestant.sing = int(xml.@sing);
					contestant.intelligent = int(xml.@intelligent);
					contestant.acting = int(xml.@acting);
					contestant.attraction = int(xml.@attraction);
					contestant.bodydef = xml.@bodydef;
					_sdcEvent.contestantData = contestant;
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_GET_FRIEND_CONTESTANT_COMPLETE true ");
					trace("[SDC]: ON_GET_FRIEND_CONTESTANT_COMPLETE true ");
				}
				else
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED false");
					trace("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED false ");
				}
			}
			else
			{
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED null");
				trace("[SDC]: ON_GET_FRIEND_CONTESTANT_FAILED null");
			}
		}
		
		private function _completeHandler(event:LoaderEvent):void {			
			trace("Finished loading one ssi " + event.target);
			trace( "ssiid Check" + event.target.name , "content", event.target.content );			
			_imageStorage.addImage( event.target.name, _holder );			
			
			var image:Bitmap = _imageStorage.getImage( _sceneData.ssiid[ _ssiImageCnt ] );
			_sceneData.ssiImage.push( image );
			_ssiImageCnt++;
			
			var len:int = _sceneData.ssi.length;
			
			if ( _ssiImageCnt < len ){
				trace( "[SDC]: load another ssi" );
				loadSSI();
			}else {
				addScene();				
			}		
		}
		
		private function addScene():void 
		{
			trace( "[SDC]: done loading all ssi" );
			//push the scene here
			//increment scene tracker
			//check if there's more scene if true do the same process
			//if there's no more scene dispatched ServerDataControllerEvent.ON_GET_SCENE_COMPLETE
			
			_globalData.sceneData.push( _sceneData );
			trace( "[SDC]: pushing scene index: ", _sceneTracker );
			_sceneTracker++;
			
			if ( _sceneTracker < _sceneXml.scene.length() ) {
				trace( "[SDC]: extract another scene index: ", _sceneTracker );
				extractScene();
			}else {
				_sdcEvent = new ServerDataControllerEvent( ServerDataControllerEvent.ON_GET_SCENE_COMPLETE );
				_es.dispatchESEvent( _sdcEvent );
				_sceneTracker = 0;
				//trace("[SDC]: ON GET SCENE BUY Complete true reason", "names", _globalData.sceneData[ _sceneTracker ].npcName, "script", _globalData.sceneData[ _sceneTracker ].script, "npcImage", _globalData.sceneData[ _sceneTracker ].npcImage, "eventid", _sceneData[ _sceneTracker ].id, "_globalData.hasScript", _globalData.sceneData[ _sceneTracker ].hasScript, "_globalData.sceneData.hasSsi", _globalData.sceneData[ _sceneTracker ].hasSsi, "_globalData.sceneData.hasNpcImage", _globalData.sceneData[ _sceneTracker ].hasNpcImage);
				trace("[SDC]: ON GET SCENE BUY Complete true reason", "id", _globalData.sceneData[ _sceneTracker ].id, "npcName", _globalData.sceneData[ _sceneTracker ].npcName );
				_imageLoader.removeEventListener( ImageLoaderEvent.IMAGE_LOADED, onEventSceneImageLoaded );	
			}		
		}
		
		
		private function _ioErrorHandler(event:LoaderEvent):void {
			trace("[SDC ] SSI image load IOError:", event);
		}
		
		private function _failHandler(event:LoaderEvent):void {
			trace("[SDC ] SSI image failed to load:", event);
		}
		
		private function _progressHandler(event:LoaderEvent):void {			
			trace( "[SDC ] SSI image percent loaded check: ", event.target.progress , "_ssiImageCnt: ", _ssiImageCnt );
		}
		
		private function onCheckIfConnectedFailed(e:XMLExtractorEvent):void 
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECKING_IS_CONNECTED_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECKING_IS_CONNECTED_FAILED epic fail");
			trace("[SDC]: ON_CHECKING_IS_CONNECTED_FAILED epic fail");
		}
		
		private function onCheckIfConnectedComplete(e:XMLExtractorEvent):void 
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret != "true")
				{				
					//not connected
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECKING_IS_CONNECTED_COMPLETE);
					_es.dispatchESEvent(_sdcEvent);			
					trace("[SDC]: ON_CHECKING_IS_CONNECTED_COMPLETE");
				}
			}else {
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECKING_IS_CONNECTED_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECKING_IS_CONNECTED_FAILED null ");
				trace("[SDC]: ON_CHECKING_IS_CONNECTED_FAILED null ");
			}
		}
		
		private function onCheckCharCountFailed(e:XMLExtractorEvent):void 
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_CHECK_CHAR_COUNT_FAILED epic fail");
			trace("[SDC]: ON_CHECK_CHAR_COUNT_FAILED epic fail");
		}
		
		private function onCheckCharCountComplete(e:XMLExtractorEvent):void 
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE );
					_sdcEvent.obj.count = int( xml.@cnt );
					_sdcEvent.obj.limit = int( xml.@limit );
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_CHAR_COUNT_COMPLETE TRUE count:" +  xml.@cnt + "limit: " + xml.@limit );
					trace("[SDC]: ON_CHECK_CHAR_COUNT_COMPLETE true count:" +  xml.@cnt + "limit: " + xml.@limit );
				}else {
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_CHECK_CHAR_COUNT_FAILED FALSE  fail");
					trace("[SDC]: ON_CHECK_CHAR_COUNT_FAILED FALSE fail");
				}
			}else {
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_CHECK_CHAR_COUNT_FAILED NULL  fail");
				trace("[SDC]: ON_CHECK_CHAR_COUNT_FAILED NULL fail");
			}
		}
		
		private function onGetVisitingRewardFailed(e:XMLExtractorEvent):void 
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_VISITING_REWARD_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_GET_VISITING_REWARD_FAILED epic fail");
			trace("[SDC]: ON_GET_VISITING_REWARD_FAILED epic fail");
		}
		
		private function onGetVisitingRewardComplete(e:XMLExtractorEvent):void 
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{					
					var ap:int = int(xml.@ap);
					setPlayerActionPoints( ap );
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_COIN_CHANGE);
					_es.dispatchESEvent(_sdcEvent);
					
					var coin:int = int(xml.@coin );
					setPlayerCoin( coin );
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE);					
					_es.dispatchESEvent(_sdcEvent);
					
					trace("[SDC]: ON_GET_VISITING_REWARD_COMPLETE true coin: " , coin, "ap: ", ap   );
					
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_VISITING_REWARD_COMPLETE);
					_sdcEvent.obj.ap = ap;
					_sdcEvent.obj.coin = coin;
					_es.dispatchESEvent(_sdcEvent);										
				}else {
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_VISITING_REWARD_FAILED);
					_es.dispatchESEvent(_sdcEvent);
					reportError("[SDC]: ON_GET_VISITING_REWARD_FAILED false ");
					trace("[SDC]: ON_GET_VISITING_REWARD_FAILED false ");
				}
			}else {
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_GET_VISITING_REWARD_FAILED);
				_es.dispatchESEvent(_sdcEvent);
				reportError("[SDC]: ON_GET_VISITING_REWARD_FAILED null ");
				trace("[SDC]: ON_GET_VISITING_REWARD_FAILED null ");
			}
		}
		
		private function onPostVisitingRewardFailed(e:XMLExtractorEvent):void 
		{
			_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_POST_VISITING_REWARD_FAILED);
			_es.dispatchESEvent(_sdcEvent);
			reportError("[SDC]: ON_GET_VISITING_REWARD_FAILED epic fail");
			trace("[SDC]: ON_GET_VISITING_REWARD_FAILED epic fail");
		}
		
		private function onPostVisitingRewardComplete(e:XMLExtractorEvent):void 
		{
			var xml:XML = (e.obj as XML);
			if (xml != null)
			{
				if (xml.@ret == "true")
				{
					_sdcEvent = new ServerDataControllerEvent( ServerDataControllerEvent.ON_POST_VISITING_REWARD_COMPLETE );
					_es.dispatchESEvent( _sdcEvent );					
					trace("[SDC]: ON_POST_VISITING_REWARD_COMPLETE true ");
				}else {
					_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_POST_VISITING_REWARD_FAILED);
					_es.dispatchESEvent( _sdcEvent );
					reportError("[SDC]: ON_POST_VISITING_REWARD_COMPLETE false ");
					trace("[SDC]: ON_POST_VISITING_REWARD_COMPLETE false ");
				}
			}else {
				_sdcEvent = new ServerDataControllerEvent(ServerDataControllerEvent.ON_POST_VISITING_REWARD_FAILED);
				_es.dispatchESEvent( _sdcEvent );
				reportError("[SDC]: ON_POST_VISITING_REWARD_COMPLETE null");
				trace("[SDC]: ON_POST_VISITING_REWARD_COMPLETE null");
			}
		}
	}
}

class SingletonEnforcer
{
}