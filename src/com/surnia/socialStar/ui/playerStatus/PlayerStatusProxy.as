package com.surnia.socialStar.ui.playerStatus
{
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.utils.Logger;
	
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * 	@author hedrick david
	 * 	@email hedrickdavid.surnia@gmail.com
	 * 
	 * This class contains the variable and data regarding the player status.
	 * This is where to call and process data from external sources such as xml's and
	 * databases.
	 * 
	 */
	
	public class PlayerStatusProxy extends EventDispatcher
	{
		
		// tooltip descriptions
		public var statusDescriptions:Array = [];
		
		// player data
		public var clientCoin:int = 0;
		public var clientStarPoint:int = 0;
		public var clientActionPoint:int = 0;
		public var clientLevel:int = 1;
		public var clientTicket:int = 0;
		public var clientHotPoint:int = 0;
		public var clientExperience:int = 0;
		public var clientExperienceLocal:int = 0;
		public var clientRedStarExp:int = 0;
		public var clientRedStarLvl:int = 1;
		public var clientBlackStarExp:int = 0;
		public var clientBlackStarLvl:int = 1;
		public var clientRedStarLocalExp:int = 0;
		public var clientBlackStarLocalExp:int = 0;
		public var clientHelpingEnergy:int = 0;
		public var clientCharacterHired:int = 0;
		public var clientCharacterlimit:int = 3;
		
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _playerXML:XML;
		
		public var redStarVisibility:Boolean = false;
		public var blackStarVisibility:Boolean = false;
		public var helpingEnergyVisibility:Boolean = false;
		
		private var _gd:GlobalData = GlobalData.instance;
		
		/**
		 * 
		 * Constructor. 
		 * Generates the total experience table and inital
		 * values. 
		 * 
		 */	
		
		public function PlayerStatusProxy()
		{
			setDescriptions();
			initData();
		}
		
		/**
		 * 
		 * Sets the value of status descriptions for tooltips.
		 * 
		 */
		
		private function setDescriptions():void{
			statusDescriptions[GlobalData.COIN] = "Used in purchasing \noffice items and \nclothes for avatar.";
			statusDescriptions[GlobalData.STARPOINT] = "Used for converting \ncoins, purchasing special \nitems and clothes for \navatar.";
			statusDescriptions[GlobalData.AP] = "Used in doing actions.";
			statusDescriptions[GlobalData.LEVEL] = "Shows the player's \ncurrent level.";
			statusDescriptions[GlobalData.EXPERIENCE] = "Shows the player's \ncurrent experience.";
			//statusDescriptions[GlobalData.HOTPOINT] = "Shows the player's \ncurrent hotpoints ";
			//statusDescriptions[GlobalData.TICKET] = "Shows the player's \ncurrent ticket amount. \nUsed for attending TV \nprograms and hiring \ncharacters";
			statusDescriptions[GlobalData.REDSTARLVL] = "Shows the player's current \nred star level and exp.";
			statusDescriptions[GlobalData.BLACKSTARLVL] = "Shows the player's current \nblack star level and exp.";
			statusDescriptions[GlobalData.HELPINGENERGY] = "Shows the player's current \nhelping energy per friend.";
			statusDescriptions[GlobalData.CHARACTERHIRED] = "Shows the player's current \nnumber of characters hired \nand the character limit.";
		}
		
		/**
		 *
		 * Update total experience variable based on the level
		 * and dispatch an event to notify change. 
		 * 
		 */		
		
		public function updateTotalExperience():void{
			_gd.experienceLimit = _gd.getLevelAPTableByLevel(_gd.pLvl)[GlobalData.LEVELAPTABLE_EXP];
			dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.EXPLIMIT_UPDATED));
		}
		
		/**
		 *
		 * Update total action point variable based on the level
		 * and dispatch an event to notify change. 
		 * 
		 */	
		
		public function updateTotalAP():void{
			_gd.actionPointLimit = _gd.getLevelAPTableByLevel(_gd.pLvl)[GlobalData.LEVELAPTABLE_AP];;
			dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.APLIMIT_UPDATED));
		}
		
		/**
		 *
		 * Updates local cache from global data. 
		 * 
		 */		
		
		public function initData():void{
			//TODO: get player data from database
			//test data
			
			clientCoin = 0;
			clientStarPoint = 0;
			clientActionPoint = 0;
			clientHotPoint = 0;
			clientTicket =0;
			clientExperience = 1000;
			clientLevel = 1;
			
			GlobalData.instance.actionPointLimit = 20;
			GlobalData.instance.experienceLimit = 1000;
			GlobalData.instance.levelLimit = 50;
			GlobalData.instance.hotPointLimit = 100;
			ServerDataController.getInstance().updateAp();
			/*_urlRequest = new URLRequest("http://202.124.129.14/surnia/data/playerui");
			//_urlRequest = new URLRequest("xmltest/playerui.xml");
			_urlLoader = new URLLoader(_urlRequest);
			_urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);*/
		}
		
		public function updateData():void{
			clientCoin = _gd.pCoin;
			clientStarPoint = _gd.pSp;
			clientActionPoint = _gd.pAp;
			clientExperience = _gd.pExp;
			var lastTotalExp:Number = _gd.getLevelAPTableByLevel(_gd.pLvl-1)[GlobalData.LEVELAPTABLE_EXP];
			clientExperienceLocal = _gd.pExp - lastTotalExp;
			clientLevel = _gd.pLvl;
			clientRedStarExp = _gd.pRSExp;
			clientRedStarLvl = _gd.pRSLvl;
			clientRedStarLocalExp = computeRedStarLocalExp();
			clientBlackStarExp = _gd.pBSExp;
			clientBlackStarLvl = _gd.pBSLvl;
			clientBlackStarLocalExp = computeBlackStarLocalExp();
			clientHelpingEnergy = _gd.pHE;
			clientCharacterHired = _gd.pChAmt;
			clientCharacterlimit = _gd.characterLimit;
			dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.DATA_UPDATED));
			Logger.tracer(this, "Data updated");
		}
		
		public function computeRedStarLocalExp():int{
			return Math.floor(_gd.pRSExp % 100);
		}
		
		public function computeBlackStarLocalExp():int{
			return Math.floor(_gd.pBSExp % 100);
		}
		
		/**
		 *
		 * Event handler for loading xml data.
		 *  
		 * @param ev - event handler when xml loader completes.
		 * 		 
		 */		
		/*
		private function onLoadComplete(ev:Event):void{
			_playerXML = new XML(ev.target.data);
			
			clientCoin = _playerXML.children().elements("coin");
			clientCash = _playerXML.children().elements("cash");
			clientActionPoint = _playerXML.children().elements("ap");
			clientLevel = _playerXML.children().elements("lv");
			clientExperience = _playerXML.children().elements("exp");
			clientTicket = _playerXML.children().elements("ticket");
			clientHotPoint = _playerXML.children().elements("hotpoints");

			dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.DATA_UPDATED));
		}
		*/
		
		/**
		 * Event handling for tracing the error when XML data loading fails.
		 * 
		 * @param ev - event handler for error
		 * 
		 */		

		/*private function onLoadError(ev:IOErrorEvent):void{
			Logger.tracer(this, "Failed loading player data XML" + " - " + ev.text);
		}*/
		
		/**
		 * Gets the the local cache of data.
		 * 
		 * @return object - contatins data of status variables.
		 * 
		 */		
		
		public function getStatusData ():Object{
			var data:Object = new Object();
			data.clientCoin = clientCoin;
			data.clientStarPoint = clientStarPoint;
			data.clientActionPoint = clientActionPoint;
			data.clientLevel = clientLevel;
			data.clientTicket = clientTicket;
			data.clientRedStarExp = clientRedStarExp;
			data.clientRedStarLvl = clientRedStarLvl;
			data.clientExperience = clientExperience;
			data.clientBlackStarExp = clientBlackStarExp;
			data.clientBlackStarLvl = clientBlackStarLvl;
			data.clientExperienceLocal = clientExperienceLocal;
			data.clientRedStarLocalExp = clientRedStarLocalExp;
			data.clientBlackStarLocalExp = clientBlackStarLocalExp;
			data.clientHelpingEnergy = clientHelpingEnergy;
			data.clientCharacterHired = clientCharacterHired;
			data.clientCharacterLimit = clientCharacterlimit;
			//data.clientHotPoint = clientHotPoint;
			return data;
		}
		
		/**
		 * 
		 * @return object - containts data of limits variables.
		 * 
		 */
		
		public function getStatusLimit():Object{
			var data:Object = new Object();
			data.coinLimit = _gd.coinLimit;
			data.starPointLimit = _gd.starPointLimit;
			data.apLimit = _gd.getLevelAPTableByLevel(GlobalData.instance.pLvl)[GlobalData.LEVELAPTABLE_AP];
			data.levelLimit = _gd.levelLimit;
			data.ticketLimit = _gd.ticketLimit;
			data.hotPointLimit = _gd.hotPointLimit;
			data.expLimit = _gd.getLevelAPTableByLevel(GlobalData.instance.pLvl)[GlobalData.LEVELAPTABLE_EXP];
			data.charLimit = _gd.characterLimit;
			return data;
		}
	}
}