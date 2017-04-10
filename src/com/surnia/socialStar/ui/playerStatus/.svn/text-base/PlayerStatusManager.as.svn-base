package com.surnia.socialStar.ui.playerStatus
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	/**
	 * 
	 *  @author hedrick david
	 * 	@email hedrickdavid.surnia@gmail.com
	 * 
	 * Handles logic and instantiates the data and interface of theT
	 * player status.  
	 * 
	 */	
	
	public class PlayerStatusManager extends EventDispatcher
	{ 
		private var _mainView:Sprite;
		private var _playerStatusProxy:PlayerStatusProxy;
		private var _playerStatusUI:PlayerStatusUI;
		private var _jobQueue:Array = [];
		private var _onShowCalled:Boolean = false;
		private var _serverDataController:ServerDataController = ServerDataController.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		private var _es:EventSatellite = EventSatellite.getInstance();
		
		/**
		 * 
		 * Constructor
		 * 
		 * @param stage - the stage of the main view.
		 * 
		 */	
		
		public function PlayerStatusManager(mainView:Sprite)
		{
			_mainView = mainView;
		}
		
		/**
		 *
		 * Use this to start the controller and
		 * initialize the UI and proxy classes. 
		 * 
		 */		
		
		public function start():void{
			_playerStatusProxy = new PlayerStatusProxy();
			
			_playerStatusUI = new PlayerStatusUI();
			_mainView.addChild(_playerStatusUI);
			addListeners();
			//if (GlobalData.instance.playerDataLoaded == true){
			_playerStatusProxy.updateData();
			//}
			_playerStatusUI.setStatusDescription(_playerStatusProxy.statusDescriptions);			
		}
		
		public function updateGUIPosition():void 
		{
			_playerStatusUI.updateGUIPosition();
		}
		
		public function destroy():void 
		{		
			removeListeners();
			
			if ( _playerStatusUI != null ) {
				if ( _mainView.contains( _playerStatusUI ) ) {
					_mainView.removeChild(_playerStatusUI );
					_playerStatusUI = null;
				}
			}
			
			_mainView = null;
		}
		
		/**
		 * 
		 * Add event listeners. 
		 * 
		 */
		
		public function addListeners():void{
			// global listeners
			_es.addEventListener(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_STAR_POINT_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_COIN_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_EXPERIENCE_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_HOT_POINT_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_LEVEL_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_TICKET_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_REDSTAR_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_BLACKSTAR_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE, onGlobalStatusChange);
			_es.addEventListener(PlayerStatusEvent.HIDE_PLAYERSTATUS, onPlayerStatusVisibility);
			_es.addEventListener(PlayerStatusEvent.SHOW_PLAYERSTATUS, onPlayerStatusVisibility);			
			
			_es.addEventListener(PlayerStatusEvent.SHOW_REDSTAR, onGameTokenParameterChange);
			_es.addEventListener(PlayerStatusEvent.HIDE_REDSTAR, onGameTokenParameterChange);
			_es.addEventListener(PlayerStatusEvent.SHOW_BLACKSTAR, onGameTokenParameterChange);
			_es.addEventListener(PlayerStatusEvent.HIDE_BLACKSTAR, onGameTokenParameterChange);
			_es.addEventListener(PlayerStatusEvent.SHOW_HELPINGENERGY, onGameTokenParameterChange);
			_es.addEventListener(PlayerStatusEvent.HIDE_HELPINGENERGY, onGameTokenParameterChange);
			
			// local listeners
			_playerStatusUI.addEventListener(PlayerStatusEvent.COIN_CLICK, onStatusUpdate);
			_playerStatusUI.addEventListener(PlayerStatusEvent.AP_CLICK, onStatusUpdate);
			_playerStatusUI.addEventListener(PlayerStatusEvent.CASH_CLICK, onStatusUpdate);
			_playerStatusUI.addEventListener(PlayerStatusEvent.ADD_AP, onAPTimerCycle);
			_es.addEventListener(PlayerStatusEvent.EXPERIENCE_MAXED, onStatusUpdate);
			_es.addEventListener(PlayerStatusEvent.REDSTAR_MAXED, onStatusUpdate);
			_es.addEventListener(PlayerStatusEvent.BLACKSTAR_MAXED, onStatusUpdate);
			_playerStatusProxy.addEventListener(PlayerStatusEvent.DATA_UPDATED, onDataUpdated);
			_playerStatusProxy.addEventListener(PlayerStatusEvent.EXPLIMIT_UPDATED, onLimitUpdated);
			_es.addEventListener(SSEvent.PLAYERXML_LOADED, onPlayerLoaded);
		}
		
		public function onPlayerStatusVisibility(ev:PlayerStatusEvent):void{
			switch(ev.type)
			{
				case PlayerStatusEvent.HIDE_PLAYERSTATUS:
				{
					_playerStatusUI.hide()
					_playerStatusProxy.blackStarVisibility = false;
					_playerStatusProxy.redStarVisibility = false;
					break;
				}
					
				case PlayerStatusEvent.SHOW_PLAYERSTATUS:
				{
					_playerStatusUI.show();
					_playerStatusProxy.blackStarVisibility = true;
					_playerStatusProxy.redStarVisibility = true;
					ServerDataController.getInstance().updateApTimer();
					ServerDataController.getInstance().updateAp();
					EventSatellite.getInstance().addEventListener(ServerDataControllerEvent.AP_TIMER_UPDATED, onTimerUpdated);
					break;
				}
			}
		}
		
		/**
		 * @return - the state of redstarMC visibility; 
		 */		
		public function get redStarVisibility():Boolean{
			return _playerStatusProxy.redStarVisibility;	
		}
		
		/**
		 * @return - the state of blackstarMC visibility; 
		 */
		
		public function get blackStarVisibility():Boolean{
			return _playerStatusProxy.blackStarVisibility;
		}
		
		public function onTimerUpdated(ev:ServerDataControllerEvent):void{
			_playerStatusUI.show();
			_playerStatusUI.countDownTimer.setRemainingTime(GlobalData.instance.pNAp);
			_playerStatusProxy.updateData();
		}
		
		//public function 
		
		/**
		 * Event handler for the red and black star.
		 * 
		 * ev - event handler for the player status event.
		 */
		
		public function onGameTokenParameterChange(ev:PlayerStatusEvent):void{
			var tweening:Boolean = false;
			if (ev.params != null){
				if (ev.params.tweening != null){
					tweening = ev.params.tweening;
				}
			}
			switch(ev.type)
			{
				case PlayerStatusEvent.SHOW_REDSTAR:
				{
					_playerStatusUI.setRedStarVisibility(GlobalData.VISIBLE_ON, tweening);
					//_playerStatusUI.addRedStarListeners();
					_playerStatusUI.setStarPositons(GlobalData.REDSTAR);
					_playerStatusProxy.redStarVisibility = true;
					break;
				}
				case PlayerStatusEvent.HIDE_REDSTAR:
				{
					
					_playerStatusUI.setRedStarVisibility(GlobalData.VISIBLE_OFF, tweening);
					//_playerStatusUI.removeRedStarListeners();
					_playerStatusProxy.redStarVisibility = false;
					break;
				}
				case PlayerStatusEvent.SHOW_BLACKSTAR:
				{
					_playerStatusUI.setBlackStarVisiblity(GlobalData.VISIBLE_ON, tweening);			
					//_playerStatusUI.addBlackStarListeners();
					_playerStatusUI.setStarPositons(GlobalData.BLACKSTAR);
					_playerStatusProxy.blackStarVisibility = true;
					break;
				}
				case PlayerStatusEvent.HIDE_BLACKSTAR:
				{
					_playerStatusProxy.blackStarVisibility = false;
					_playerStatusUI.setBlackStarVisiblity(GlobalData.VISIBLE_OFF, tweening);
					//_playerStatusUI.removeBlackStarListeners();
					break;
				}
				case PlayerStatusEvent.SHOW_HELPINGENERGY:
				{
					_playerStatusProxy.helpingEnergyVisibility = true;
					_playerStatusUI.setHelpingEnergyVisiblity(GlobalData.VISIBLE_ON);
					break;
				}
				case PlayerStatusEvent.HIDE_HELPINGENERGY:
				{
					_playerStatusProxy.helpingEnergyVisibility = false;
					_playerStatusUI.setHelpingEnergyVisiblity(GlobalData.VISIBLE_OFF);
					break;
				}
			}
		}
		
		/**
		 *
		 * Remove event listeners. 
		 * 
		 */		
		
		public function removeListeners():void{
			// global listeners
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_STAR_POINT_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_COIN_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_EXPERIENCE_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_HOT_POINT_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_LEVEL_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_TICKET_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_REDSTAR_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_BLACKSTAR_CHANGE, onGlobalStatusChange);
			_es.removeEventListener(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE, onGlobalStatusChange);
			_es.addEventListener(ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE, onGlobalStatusChange);
			
			_es.removeEventListener(PlayerStatusEvent.SHOW_REDSTAR, onGameTokenParameterChange);
			_es.removeEventListener(PlayerStatusEvent.HIDE_REDSTAR, onGameTokenParameterChange);
			_es.removeEventListener(PlayerStatusEvent.SHOW_BLACKSTAR, onGameTokenParameterChange);
			_es.removeEventListener(PlayerStatusEvent.HIDE_BLACKSTAR, onGameTokenParameterChange);
			_es.removeEventListener(PlayerStatusEvent.SHOW_HELPINGENERGY, onGameTokenParameterChange);
			_es.removeEventListener(PlayerStatusEvent.HIDE_HELPINGENERGY, onGameTokenParameterChange);
			
			// local listeners
			_playerStatusUI.removeEventListener(PlayerStatusEvent.COIN_CLICK, onStatusUpdate);
			_playerStatusUI.removeEventListener(PlayerStatusEvent.AP_CLICK, onStatusUpdate);
			_playerStatusUI.removeEventListener(PlayerStatusEvent.CASH_CLICK, onStatusUpdate);
			_playerStatusUI.removeEventListener(PlayerStatusEvent.ADD_AP, onAPTimerCycle);
			_es.removeEventListener(PlayerStatusEvent.EXPERIENCE_MAXED, onStatusUpdate);
			_es.removeEventListener(PlayerStatusEvent.REDSTAR_MAXED, onStatusUpdate);
			_es.removeEventListener(PlayerStatusEvent.BLACKSTAR_MAXED, onStatusUpdate);
			_playerStatusProxy.removeEventListener(PlayerStatusEvent.DATA_UPDATED, onDataUpdated);
			_playerStatusProxy.removeEventListener(PlayerStatusEvent.EXPLIMIT_UPDATED, onLimitUpdated);
			EventSatellite.getInstance().removeEventListener(SSEvent.PLAYERXML_LOADED, onPlayerLoaded);
		}
		
		private function onAPTimerCycle(ev:PlayerStatusEvent):void{
			trace ("ap check before ap add on timer cycle: " + _gd.pAp)
			_serverDataController.updateAp();
			GlobalData.instance.pAp += 1;
			_playerStatusUI.updateSpecificStatus(GlobalData.AP, {clientActionPoint:GlobalData.instance.pAp});
			trace ("ap check after ap add on timer cycle: " + _gd.pAp)
		}
		
		/**
		 * This manages the updates of the token display when tokens are added.
		 * 
		 * @param ev - event listener for ServerDataController events.
		 * 
		 */
		
		private function onGlobalStatusChange(ev:ServerDataControllerEvent):void{
			switch(ev.type)
			{
				case ServerDataControllerEvent.PLAYER_ACTION_POINT_CHANGE:
				{
					trace ("ap check before ap add: " + _gd.pAp)
					_playerStatusProxy.updateTotalAP();
					_playerStatusProxy.updateTotalExperience();
					if (_gd.pAp < _gd.experienceLimit){
						_playerStatusUI.updateSpecificStatus(GlobalData.AP, {clientActionPoint:GlobalData.instance.pAp});
					}
					
					trace ("ap check after ap add: " + _gd.pAp)
					
					break;
				}
				case ServerDataControllerEvent.PLAYER_STAR_POINT_CHANGE:
				{
					_playerStatusUI.updateSpecificStatus(GlobalData.STARPOINT, {clientStarPoint:GlobalData.instance.pSp});
					break;
				}
				case ServerDataControllerEvent.PLAYER_COIN_CHANGE:
				{
					var coin:int = GlobalData.instance.pCoin;
					_playerStatusUI.updateSpecificStatus(GlobalData.COIN, {clientCoin:GlobalData.instance.pCoin});
					break;
				}
				case ServerDataControllerEvent.PLAYER_EXPERIENCE_CHANGE:
				{
					updateExperience(ev.obj.ae);
					break;
				}
				/*case ServerDataControllerEvent.PLAYER_HOT_POINT_CHANGE:
				{
					if (GlobalData.instance.pHp <= GlobalData.instance.hotPointLimit){
						_playerStatusUI.updateSpecificStatus(GlobalData.HOTPOINT, {clientHotPoint:GlobalData.instance.pHp});
					} else if (GlobalData.instance.pHp <= 0) {
						_playerStatusUI.updateSpecificStatus(GlobalData.HOTPOINT, {clientHotPoint:0});
					} else {
						_playerStatusUI.updateSpecificStatus(GlobalData.HOTPOINT, {clientHotPoint:GlobalData.instance.hotPointLimit});
					}
					break;
				}*/
				case ServerDataControllerEvent.PLAYER_LEVEL_CHANGE:
				{
					if (GlobalData.instance.pLvl <= GlobalData.instance.levelLimit){
						_playerStatusUI.updateSpecificStatus(GlobalData.LEVEL, {clientLevel:GlobalData.instance.pLvl});
						_playerStatusProxy.updateTotalExperience();
						_playerStatusProxy.updateTotalAP();
					} else {
						_playerStatusUI.updateSpecificStatus(GlobalData.LEVEL, {clientLevel:GlobalData.instance.levelLimit});
					}
					break;
				}
				case ServerDataControllerEvent.PLAYER_BLACKSTAR_CHANGE:
				{
					updateBlackStar(ev.obj.ae);
					break;
				}
					
				case ServerDataControllerEvent.PLAYER_REDSTAR_CHANGE:
				{
					updateRedStar(ev.obj.ae);
					break;
				}
				case ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE:
				{
					_playerStatusUI.updateSpecificStatus(GlobalData.HELPINGENERGY, {clientHelpingEnergy:GlobalData.instance.pHE});
					break;
				}
				case ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE:
				{
					if (_gd.pChAmt <= _gd.characterLimit){
						_playerStatusUI.updateSpecificStatus(GlobalData.CHARACTERLIMIT, {clientCharacterLimit:ev.obj.limit});
					}
					if (_gd.characterLimit >= _gd.pChAmt){
						_playerStatusUI.updateSpecificStatus(GlobalData.CHARACTERHIRED, {clientCharacterHired:ev.obj.count});
					}
					break;					
				}
			}
		}
		
		/**
		 * Updated the redStar barfill display. Used for refactoring
		 * remaining values to fill.
		 * 
		 * @param redStarAdded - the amount to be added.
		 * 
		 */
		
		private function updateRedStar(redStarAdded:int):void{
			var totalValue:int = _playerStatusProxy.clientRedStarLocalExp + redStarAdded;
			
			if (totalValue >  GlobalData.instance.redStarExpLimit){
				var remaining:int = totalValue - GlobalData.instance.redStarExpLimit;
				var value:int = _playerStatusProxy.clientRedStarLocalExp + (redStarAdded - remaining);
				_jobQueue.push(GlobalData.REDSTAREXP + ":" + remaining) 
				_playerStatusUI.updateSpecificStatus(GlobalData.REDSTAREXP, {clientRedStarLocalExp:value});
			} else {
				_playerStatusProxy.clientRedStarLocalExp += redStarAdded;
				_playerStatusUI.updateSpecificStatus(GlobalData.REDSTAREXP, {clientRedStarLocalExp:totalValue});
			}
		}
		
		/**
		 * Updated the blackStar barfill display. Used for refactoring
		 * remaining values to fill.
		 * 
		 * @param blackStarAdded - the amount to be added.
		 * 
		 */
		
		private function updateBlackStar(blackStarAdded:int):void{
			var totalValue:int = _playerStatusProxy.clientBlackStarLocalExp + blackStarAdded;
			
			if (totalValue >  GlobalData.instance.blackStarExpLimit){
				var remaining:int = totalValue - GlobalData.instance.blackStarExpLimit;
				var value:int = _playerStatusProxy.clientBlackStarLocalExp + (blackStarAdded - remaining);
				_jobQueue.push(GlobalData.BLACKSTAREXP + ":" + remaining) 
				_playerStatusUI.updateSpecificStatus(GlobalData.BLACKSTAREXP, {clientBlackStarLocalExp:value});
			} else {
				_playerStatusProxy.clientBlackStarLocalExp += blackStarAdded;
				_playerStatusUI.updateSpecificStatus(GlobalData.BLACKSTAREXP, {clientBlackStarLocalExp:totalValue});
			}
		}
		
		/**
		 * Updated the experience barfill display. Used for refactoring
		 * remaining values to fill.
		 * 
		 * @param expAdded - the amount to be added.
		 * 
		 */
		
		private function updateExperience(expAdded:int):void{
			var totalValue:int = _playerStatusProxy.clientExperience + expAdded;
			var localTotalValue:int = _playerStatusProxy.clientExperienceLocal + expAdded;
			_playerStatusProxy.updateTotalExperience();
			_playerStatusProxy.updateTotalAP();
			var el:int = GlobalData.instance.experienceLimit;

			if (totalValue >=  el){
				var remaining:Number = totalValue - el;
				trace ("clientExperience before: " + _playerStatusProxy.clientExperience);
				trace ("clientExperienceLocal before: " + _playerStatusProxy.clientExperienceLocal);
				//var added:Number = expAdded - _playerStatusProxy.clientExperienceLocal;
				//trace ("remaining: " +  remaining + " ---- added: " + added);
				
				_playerStatusProxy.clientExperience += expAdded - remaining;
				//_playerStatusProxy.clientExperienceLocal += added;
				
				trace ("clientExperience: " + _playerStatusProxy.clientExperience);
				trace ("clientExperienceLocal: " + _playerStatusProxy.clientExperienceLocal);
				if (_gd.pLvl>1){
					var lastTotalXP:Number = _gd.getLevelAPTableByLevel(_gd.pLvl-1)[GlobalData.LEVELAPTABLE_EXP];
				} else {
					lastTotalXP = 0;
				}
				//var value:int = _playerStatusProxy.clientExperienceLocal + (expAdded - remaining);
				_jobQueue.push(GlobalData.EXPERIENCE + ":" + remaining)
				_playerStatusUI.updateSpecificStatus(GlobalData.EXPERIENCE, {clientExperienceLocal:el-lastTotalXP, clientExperience:_playerStatusProxy.clientExperience});
			} else {
				_playerStatusProxy.clientExperience += expAdded;
				_playerStatusProxy.clientExperienceLocal += expAdded;
				_playerStatusUI.updateSpecificStatus(GlobalData.EXPERIENCE, {clientExperienceLocal:localTotalValue, clientExperience:_playerStatusProxy.clientExperience});
			}
		}
		
		/**
		 * 
		 * @param ev - server event to update local data cache when the player data changes
		 * 
		 */
		
		private function onPlayerLoaded(ev:SSEvent):void{
			_playerStatusProxy.updateData();	
		}
		
		/**
		 * 
		 * Used to handle events pertaining to updating player limit status variables
		 * 
		 * @param ev - Event handler
		 * 
		 */		
		
		private function onLimitUpdated(ev:PlayerStatusEvent):void{
			switch(ev.type)
			{
				case PlayerStatusEvent.EXPLIMIT_UPDATED:
				{
					_playerStatusUI.updateSpecificLimits(GlobalData.EXPERIENCE_LIMIT,{experienceLimit:GlobalData.instance.experienceLimit});
					break;
				}
				case PlayerStatusEvent.APLIMIT_UPDATED:
				{
					_playerStatusUI.updateSpecificLimits(GlobalData.AP_LIMIT,{apLimit:GlobalData.instance.actionPointLimit});
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		/**
		 * 
		 * Used to handle events when data are updated in the proxy class
		 * that handles the classes.
		 * 
		 * @param ev - event handler
		 * 
		 */		
		
		private function onDataUpdated(ev:PlayerStatusEvent):void{
			if (_onShowCalled == false){
				_playerStatusUI.init();
				_onShowCalled = true;
			}
			_playerStatusProxy.updateTotalExperience();
			_playerStatusProxy.updateTotalAP();	
			_playerStatusUI.updateLimits(_playerStatusProxy.getStatusLimit());
			_playerStatusUI.updateDisplayData(_playerStatusProxy.getStatusData());
			_playerStatusUI.countDownTimer.setRemainingTime(GlobalData.instance.pNAp);			
		}
		
		/**
		 * 
		 * Used to add values to specific player status attributes.
		 * 
		 * @param statusType - the type of status. Use the constants in the PlayerStatusProxy.
		 * @param value - the value to be added.
		 * 
		 */
		
		// for testing of changing proxy values
		public function changeStatusValues(statusType:int, value:int = 0):void{
			switch(statusType)
			{
				case GlobalData.STARPOINT:
				{
					_playerStatusUI.updateSpecificStatus(GlobalData.STARPOINT, {clientStarPoint:_playerStatusProxy.clientStarPoint});
					break;
				}
				case GlobalData.COIN:
				{
					_playerStatusProxy.clientCoin += value;
					_playerStatusUI.updateSpecificStatus(GlobalData.COIN, {clientCoin:_playerStatusProxy.clientCoin});
					break;
				}
				case GlobalData.EXPERIENCE:
				{
					_playerStatusProxy.updateTotalExperience();
					var temp:int = _playerStatusProxy.clientExperienceLocal;
					var remExp:int =  GlobalData.instance.experienceLimit - _playerStatusProxy.clientExperienceLocal;
					if (value <= remExp){
						_playerStatusProxy.clientExperience += value;
						_playerStatusProxy.clientExperienceLocal += value;
						_playerStatusUI.updateSpecificStatus(GlobalData.EXPERIENCE, {clientExperienceLocal:_playerStatusProxy.clientExperienceLocal, clientExperience:_playerStatusProxy.clientExperience});
					} else if (value > remExp){
						var addValue:int = value - remExp;
						_playerStatusProxy.clientExperienceLocal = GlobalData.instance.experienceLimit;
						_playerStatusProxy.clientExperience = GlobalData.instance.experienceLimit;
						_playerStatusUI.updateSpecificStatus(GlobalData.EXPERIENCE, {clientExperienceLocal:_playerStatusProxy.clientExperienceLocal, clientExperience:_playerStatusProxy.clientExperience});
						_jobQueue.push(GlobalData.EXPERIENCE+":"+addValue);
					} else {
						_playerStatusProxy.clientExperience = GlobalData.instance.experienceLimit;
						_playerStatusProxy.clientExperienceLocal = GlobalData.instance.experienceLimit;
						_playerStatusUI.updateSpecificStatus(GlobalData.EXPERIENCE, {clientExperienceLocal:_playerStatusProxy.clientExperienceLocal, clientExperience:_playerStatusProxy.clientExperience});
					}
					break;
				}
				case GlobalData.HOTPOINT:
				{
					if (_playerStatusProxy.clientHotPoint + value <= GlobalData.instance.hotPointLimit){
						_playerStatusProxy.clientHotPoint += value;
						_playerStatusUI.updateSpecificStatus(GlobalData.HOTPOINT, {clientHotPoint:_playerStatusProxy.clientHotPoint});
					} else {
						_playerStatusProxy.clientHotPoint = GlobalData.instance.hotPointLimit;
						_playerStatusUI.updateSpecificStatus(GlobalData.HOTPOINT, {clientHotPoint:_playerStatusProxy.clientHotPoint});
					}
					break;
				}
				case GlobalData.TICKET:
				{
					_playerStatusProxy.clientTicket += value;
					_playerStatusUI.updateSpecificStatus(GlobalData.TICKET, {clientTicket:_playerStatusProxy.clientTicket});
					break;
				}
				case GlobalData.LEVEL:
				{
					if (_playerStatusProxy.clientLevel + value <= GlobalData.instance.levelLimit){
						_playerStatusProxy.clientLevel += value;
						_playerStatusUI.updateSpecificStatus(GlobalData.LEVEL, {clientLevel:_playerStatusProxy.clientLevel});
						_playerStatusProxy.updateTotalExperience();
					} else {
						_playerStatusProxy.clientLevel = GlobalData.instance.levelLimit;
						_playerStatusUI.updateSpecificStatus(GlobalData.LEVEL, {clientLevel:_playerStatusProxy.clientLevel});
					}
					break;
				}
				case GlobalData.AP:
				{
					if (_playerStatusProxy.clientActionPoint + value <= GlobalData.instance.actionPointLimit){
						_playerStatusProxy.clientActionPoint += value;
						_playerStatusUI.updateSpecificStatus(GlobalData.AP, {clientActionPoint:_playerStatusProxy.clientActionPoint});
					} else {
						_playerStatusProxy.clientActionPoint = GlobalData.instance.actionPointLimit;
						_playerStatusUI.updateSpecificStatus(GlobalData.AP, {clientActionPoint:_playerStatusProxy.clientActionPoint});
					}
					
					break;
				}
				default:
				{
					break;
				}
			}
		}
	
		/**
		 * 
		 * @param time - time format hr:min:sec in string ex. "2:2:23"
		 * 
		 */		
		
		public function changeTimeValue(time:String):void{
			var timeArray:Array = time.split(":")
			_playerStatusUI.countDownTimer.setMaxTime(timeArray[2],timeArray[1],timeArray[0]);
		}
		
		
		/**
		 *
		 * Event handler for status updates and user interface interactions.
		 * This is where dispatches for infromation will be sent to the server or
		 * database for verification.
		 *  
		 * @param ev - event handler for status updates and UI interface interactions.
		 * 
		 */		
		
		// about any changes in the status.
		private function onStatusUpdate(ev:PlayerStatusEvent):void {
			
			var data:Array;
			
			switch(ev.type)
			{
				case PlayerStatusEvent.COIN_CLICK:
				{
					dispatchEvent(new PlayerStatusEvent (PlayerStatusEvent.COIN_POPUP));
					break;
				}	
				case PlayerStatusEvent.CASH_CLICK:
				{
					dispatchEvent(new PlayerStatusEvent (PlayerStatusEvent.CASH_POPUP));
					break;
				}
				case PlayerStatusEvent.AP_CLICK:
				{
					dispatchEvent(new PlayerStatusEvent (PlayerStatusEvent.AP_POPUP));
					break;
				}
				/*case PlayerStatusEvent.HOTPOINTS_CHANGED:
				{
					_playerStatusProxy.clientHotPoint = ev.params.clientHotPoints;
					break;
				}
				case PlayerStatusEvent.HOTPOINTS_DEPLETED:
				{
					_playerStatusProxy.clientHotPoint = 0;
					break;
				}*/
				case PlayerStatusEvent.EXPERIENCE_MAXED:
				{
					data = _jobQueue[0].split(":");
					if (data[0] == GlobalData.EXPERIENCE){
						_jobQueue.shift();
						_playerStatusProxy.clientExperienceLocal = 0;
						_playerStatusUI.resetStatus(GlobalData.EXPERIENCE);
						_serverDataController.setPlayerLevel(1);
						_serverDataController.getScene( "levelup_" + GlobalData.instance.pLvl );
						updateExperience(data[1]);
					}
					break;
				}
				case PlayerStatusEvent.BLACKSTAR_MAXED:
				{
					data = _jobQueue[0].split(":");
					if (data[0] == GlobalData.BLACKSTAREXP){
						_jobQueue.shift();
						_playerStatusProxy.clientBlackStarLocalExp = 0;
						_playerStatusUI.resetStatus(GlobalData.BLACKSTAREXP);
						_playerStatusUI.updateSpecificStatus(GlobalData.BLACKSTARLVL, {clientBlackStarLvl:Math.floor(GlobalData.instance.pBSExp/100)});
						updateBlackStar(data[1]);
						
					}
					break;
				}
				case PlayerStatusEvent.REDSTAR_MAXED:
				{
					data = _jobQueue[0].split(":");
					if (data[0] == GlobalData.REDSTAREXP){
						_jobQueue.shift();
						_playerStatusProxy.clientRedStarLocalExp = 0;
						_playerStatusUI.resetStatus(GlobalData.REDSTAREXP);
						_playerStatusUI.updateSpecificStatus(GlobalData.REDSTARLVL, {clientRedStarLvl:Math.floor(GlobalData.instance.pRSExp/100)})
						updateRedStar(data[1]);
					}
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