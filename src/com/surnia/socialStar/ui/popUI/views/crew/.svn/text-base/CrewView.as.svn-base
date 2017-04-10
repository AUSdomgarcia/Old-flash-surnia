package com.surnia.socialStar.ui.popUI.views.crew
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.crew.event.CrewEvent;
	import com.surnia.socialStar.utils.Logger;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class CrewView extends Sprite
	{
		private const MANAGER:int = 0;
		private const HEALTHTRAINER:int = 1;
		private const VOCALTRAINER:int = 2;
		private const PRIVATETEACHER:int = 3;
		private const ACTINGTEACHER:int = 4;
		private const STYLIST:int = 5;
		
		private var _crewMC:CrewMC; 
		
		private var _crewPositionArray:Array = [];
		
		private var _urlRequestArray:Array = [];
		private var _loaderArray:Array = [];
		private var _loaderContext:LoaderContext;
		
		private var _charID:String;
		private var _charDataArray:Array;
		private var _diplayCharacter:AvatarMale;
		private var _npcNumberArray:Array = [];
		private var _charLen:int = 6;
		
		private var _isOnline:Boolean = true;
		
		//new
		private var _popUpUIManager:PopUpUIManager;
		private var _sdc:ServerDataController;
		
		private var _es:EventSatellite;
		private var _gd:GlobalData = GlobalData.instance;
		
		public function CrewView()
		{
			
		}
		
		/**
		 * Initializes the staffMC assets 
		 * 
		 */		
		
		public function init(  ):void{
			//init data controller
			_es = EventSatellite.getInstance();
			_sdc =  ServerDataController.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			
			_crewMC = new CrewMC();			
			addChild(_crewMC);
			//_staffMC.headerText.width = 3000;
			_crewMC.headerText.text = "Remind your staff to serve for your character and check in often. " +
				"\nThe more times your staff visits, your character will be stronger!";
			var posX:int = 171.15;
			var posY:int = 83.7;
			var len:int = 6;
			for (var x:int = 0; x<len; x++){
				var _crewPosition:CrewPositionMC = new CrewPositionMC();
				_crewPosition.x = posX;
				_crewPosition.y = posY;
				_crewPosition.levelText.selectable = false;
				_crewPosition.levelText.text = "0";
				
				_crewPosition.reminderButton.enabled = false;
				_crewPosition.buyButton.enabled = false;
				
				_crewPosition.reminderButton.visible = false;
				_crewPosition.buyButton.visible = false;
				
				_crewPosition.fireButton.visible = false;
				_crewPosition.fireButton.enabled = false;
				
				_crewPosition.levelBox.visible = false;
				_crewPosition.levelText.visible = false;
				
				//_staffPositionArray[x].friendPortrait.visible = false;
				
				_crewMC.addChild(_crewPosition);
				_crewPositionArray[x] = _crewPosition;
				
				if ((x+1) % 2 == 0){
					posX = 171.15;
					posY += 126;
				} else {
					posX += 125;
				}
			}
			
			// set default character;
			_diplayCharacter = new AvatarMale();
			_crewMC.addChild(_diplayCharacter);
			_diplayCharacter.x = 95;
			_diplayCharacter.y = 280;
			
			setInitialValues();	
			addListeners();
			trace( "init staff windows.........." );
		}
		
		/**
		 * Updates the character staff display based on the charID used; 
		 * @param charID
		 * 
		 */		
		public function updateCharData(charID:String):void{
			_charID = charID;
			updateCharacterDataDisplay();
		}
		
		/**
		 * Updates the display of characters' staff details. Calls the
		 * visibility of buttons based on data.
		 */		
		
		private function  updateCharacterDataDisplay():void{
			
			if (!_gd.friendView){
				_charDataArray = _gd.getCharDataOnCharID(_charID);
				_diplayCharacter.setType = _charDataArray[GlobalData.CHARLIST_DEFINITION];
				// set character and staff text displays
				_crewMC.healthText.text = Math.floor(_charDataArray[GlobalData.CHARLIST_HEALTH]/100) + "";
				_crewMC.singText.text = Math.floor(_charDataArray[GlobalData.CHARLIST_SING]/100) + "";
				_crewMC.intText.text = Math.floor(_charDataArray[GlobalData.CHARLIST_INTELLIGENCE]/100) + "";
				_crewMC.actingText.text = Math.floor(_charDataArray[GlobalData.CHARLIST_ACTING]/100) + "";
				_crewMC.attrText.text = Math.floor(_charDataArray[GlobalData.CHARLIST_ATTRACTION]/100) + "";
				/*_crewPositionArray[GlobalData.CHARLIST_MANAGER].levelText.text = _charDataArray[GlobalData.CHARLIST_MANAGER_LEVEL];
				_crewPositionArray[GlobalData.CHARLIST_HEALTHTRAINER].levelText.text = _charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_LEVEL];
				_crewPositionArray[GlobalData.CHARLIST_VOCALTRAINER].levelText.text = _charDataArray[GlobalData.CHARLIST_VOCALTRAINER_LEVEL];
				_crewPositionArray[GlobalData.CHARLIST_PRIVATETEACHER].levelText.text = _charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_LEVEL];
				_crewPositionArray[GlobalData.CHARLIST_ACTINGTEACHER].levelText.text = _charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_LEVEL];
				_crewPositionArray[GlobalData.CHARLIST_STYLIST].levelText.text = _charDataArray[GlobalData.CHARLIST_STYLIST_LEVEL];*/
			} else {
				_charDataArray = _gd.getFriendCharDataOnCharID(_charID);
				_diplayCharacter.setType = _charDataArray[GlobalData.FRIENDCHARLIST_DEFINITION];
				_crewMC.healthText.text = Math.floor(_charDataArray[GlobalData.FRIENDCHARLIST_HEALTH]/100) + "";
				_crewMC.singText.text = Math.floor(_charDataArray[GlobalData.FRIENDCHARLIST_SING]/100) + "";
				_crewMC.intText.text = Math.floor(_charDataArray[GlobalData.FRIENDCHARLIST_INTELLIGENCE]/100) + "";
				_crewMC.actingText.text = Math.floor(_charDataArray[GlobalData.FRIENDCHARLIST_ACTING]/100) + "";
				_crewMC.attrText.text = Math.floor(_charDataArray[GlobalData.FRIENDCHARLIST_ATTRACTION]/100) + "";
				/*	_crewPositionArray[GlobalData.FRIENDCHARLIST_MANAGER].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_MANAGER_LEVEL];
				_crewPositionArray[GlobalData.FRIENDCHARLIST_HEALTHTRAINER].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_HEALTHTRAINER_LEVEL];
				_crewPositionArray[GlobalData.FRIENDCHARLIST_VOCALTRAINER].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_VOCALTRAINER_LEVEL];
				_crewPositionArray[GlobalData.FRIENDCHARLIST_PRIVATETEACHER].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_PRIVATETEACHER_LEVEL];
				_crewPositionArray[GlobalData.FRIENDCHARLIST_ACTINGTEACHER].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_ACTINGTEACHER_LEVEL];
				_crewPositionArray[GlobalData.FRIENDCHARLIST_STYLIST].levelText.text = _charDataArray[GlobalData.FRIENDCHARLIST_STYLIST_LEVEL];*/
			}
			
			//assignNPCValues();
			
			// set button visibility depending on the state
			//updateButtonVisibility();
		}
		
		private function assignNPCValues():void{
			/*for (var x:int = 0; x<_charLen; x++){
			switch(x)
			{
			case GlobalData.CHARLIST_MANAGER:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_MANAGER, _charDataArray[GlobalData.CHARLIST_MANAGER_NPC]);						
			break;
			}
			case GlobalData.CHARLIST_HEALTHTRAINER:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_HEALTHTRAINER, _charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_NPC]);
			break;
			}
			case GlobalData.CHARLIST_VOCALTRAINER:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_VOCALTRAINER, _charDataArray[GlobalData.CHARLIST_VOCALTRAINER_NPC]);
			break;
			}
			case GlobalData.CHARLIST_PRIVATETEACHER:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_PRIVATETEACHER, _charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_NPC]);
			break;
			}
			case GlobalData.CHARLIST_ACTINGTEACHER:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_ACTINGTEACHER, _charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_NPC]);
			break;
			}
			case GlobalData.CHARLIST_STYLIST:
			{
			assignRandomNPCValues(GlobalData.CHARLIST_STYLIST, _charDataArray[GlobalData.CHARLIST_STYLIST_NPC]);
			break;
			}
			}
			}*/
		}
		
		/**
		 * Assigns random values for going to different mc portraits 
		 * @param staffType - the type of staff;
		 * @param isNPC - if staff is npc.
		 * 
		 */		
		
		private function assignRandomNPCValues(staffType:int, isNPC:String):void{
			if (isNPC == "true"){
				_npcNumberArray[staffType] = 2;
			} else if (isNPC == "false"){
				_npcNumberArray[staffType] = 1;
			}
		}
		
		/**
		 * 
		 * @param ev - event handler when the character is loaded.
		 * 
		 */		
		private function onCharacterLoaded(ev:Event):void{
			_diplayCharacter.removeEventListener("ready2", onCharacterLoaded)
			
		}
		
		/**
		 * Updates the data based on the state of staff availability. 
		 */
		
		private function updateButtonVisibility():void{
			// set visibility of buttons
			// charlist constants os the same as the friend list constants
			// Manager
			/*if (_charDataArray[GlobalData.CHARLIST_MANAGER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_MANAGER_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_MANAGER);
			} else if (_charDataArray[GlobalData.CHARLIST_MANAGER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_MANAGER_NPC] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_MANAGER_NPCFBID], GlobalData.CHARLIST_MANAGER);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_MANAGER);
			} else if (_charDataArray[GlobalData.CHARLIST_MANAGER_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_MANAGER_NPC] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_MANAGER);
			}
			
			// HealthTrainer
			if (_charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_HEALTHTRAINER);
			} else if (_charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_NPC] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_NPCFBID], GlobalData.CHARLIST_HEALTHTRAINER);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_HEALTHTRAINER);
			} else if (_charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_HEALTHTRAINER_NPC] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_HEALTHTRAINER);
			}
			
			// Vocal Trainer
			if (_charDataArray[GlobalData.CHARLIST_VOCALTRAINER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_VOCALTRAINER_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_VOCALTRAINER);
			} else if (_charDataArray[GlobalData.CHARLIST_VOCALTRAINER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_VOCALTRAINER_NPC] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_VOCALTRAINER_NPCFBID], GlobalData.CHARLIST_VOCALTRAINER);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_VOCALTRAINER);
			} else if (_charDataArray[GlobalData.CHARLIST_VOCALTRAINER_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_VOCALTRAINER_NPC] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_VOCALTRAINER);
			}
			
			// Private Teacher
			if (_charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_PRIVATETEACHER);
			} else if (_charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_NPC] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_NPCFBID], GlobalData.CHARLIST_PRIVATETEACHER);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_PRIVATETEACHER);
			} else if (_charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_PRIVATETEACHER_NPC] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_PRIVATETEACHER);
			}
			
			//  Acting Teacher
			if (_charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_ACTINGTEACHER);
			} else if (_charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_NPC] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_NPCFBID], GlobalData.CHARLIST_ACTINGTEACHER);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_ACTINGTEACHER);
			} else if (_charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_ACTINGTEACHER_NPC] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_ACTINGTEACHER);
			}
			
			//  Stylist
			if (_charDataArray[GlobalData.CHARLIST_STYLIST_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_STYLIST_NPC] == "true"){
			toggleBuyReminderButtonVisiblity(GlobalData.NEITHER, GlobalData.CHARLIST_STYLIST);
			} else if (_charDataArray[GlobalData.CHARLIST_STYLIST_STATE] == "false" && _charDataArray[GlobalData.CHARLIST_STYLIST_STATE] == "false") {
			loadFriendPic(_charDataArray[GlobalData.CHARLIST_STYLIST_NPCFBID], GlobalData.CHARLIST_STYLIST);
			toggleBuyReminderButtonVisiblity(GlobalData.NOTIFY, GlobalData.CHARLIST_STYLIST);
			} else if (_charDataArray[GlobalData.CHARLIST_STYLIST_STATE] == "true" && _charDataArray[GlobalData.CHARLIST_STYLIST_STATE] == "false") {
			toggleBuyReminderButtonVisiblity(GlobalData.BUY, GlobalData.CHARLIST_STYLIST);
			}*/
			
		}
		
		/**
		 * Toggles the visibility of the buy and reminder buttons.  
		 * @param type - the type to be used. Use constants to help
		 * determine input. Ex: GlobalData.BUY 
		 * @param staffType - the type to be used. Use constants to help
		 * determine input. Ex: GlobalData.CHARLIST_MANAGER 
		 */		
		private function toggleBuyReminderButtonVisiblity(type:int, staffType:int):void{
			switch(type)
			{
				case GlobalData.BUY:
				{
					_crewPositionArray[staffType].buyButton.enabled = true;
					_crewPositionArray[staffType].reminderButton.enabled = false;
					_crewPositionArray[staffType].buyButton.visible = true;
					_crewPositionArray[staffType].reminderButton.visible = false;
					_crewPositionArray[staffType].hireButton.visible = true;
					_crewPositionArray[staffType].hireButton.enabled = true;
					_crewPositionArray[staffType].fireButton.visible = false;
					_crewPositionArray[staffType].fireButton.enabled = false;
					_crewPositionArray[staffType].levelBox.visible = false;
					_crewPositionArray[staffType].levelText.visible = false;
					_crewPositionArray[staffType].npcPortrait.gotoAndStop(0); 
					_crewPositionArray[staffType].friendPortrait.visible = false;
					break;
				}
				case GlobalData.NEITHER:
				{
					_crewPositionArray[staffType].buyButton.enabled = false;
					_crewPositionArray[staffType].reminderButton.enabled = false;
					_crewPositionArray[staffType].buyButton.visible = false;
					_crewPositionArray[staffType].reminderButton.visible = false;
					_crewPositionArray[staffType].hireButton.visible = false;
					_crewPositionArray[staffType].hireButton.enabled = false;
					_crewPositionArray[staffType].fireButton.visible = true;
					_crewPositionArray[staffType].fireButton.enabled = true;
					_crewPositionArray[staffType].levelBox.visible = true;
					_crewPositionArray[staffType].levelText.visible = true;
					_crewPositionArray[staffType].npcPortrait.gotoAndStop(_npcNumberArray[staffType]);
					_crewPositionArray[staffType].friendPortrait.visible = false;
					break;
				}	
				case GlobalData.NOTIFY:
				{
					_crewPositionArray[staffType].buyButton.enabled = false;
					_crewPositionArray[staffType].reminderButton.enabled = true;
					_crewPositionArray[staffType].buyButton.visible = false;
					_crewPositionArray[staffType].reminderButton.visible = true;
					_crewPositionArray[staffType].hireButton.visible = false;
					_crewPositionArray[staffType].hireButton.enabled = false;
					_crewPositionArray[staffType].fireButton.visible = true;
					_crewPositionArray[staffType].fireButton.enabled = true;
					_crewPositionArray[staffType].levelBox.visible = true;
					_crewPositionArray[staffType].levelText.visible = true;
					_crewPositionArray[staffType].friendPortrait.visible = true; 
					_crewPositionArray[x].friendPortrait.visible = true;
					break;
				}	
			}
		}
		
		
		/**
		 * Sets the data for the staff infomation from the character
		 * list data 
		 * 
		 */
		
		private function setInitialValues():void{
			
			var len:int = _crewPositionArray.length;
			if (GlobalData.instance.characterListDataLoaded == true){
				updateCharacterDataDisplay();
			} else {
				// the textfields for the character attributes
				_crewMC.healthText.text = "0";
				_crewMC.singText.text = "0";
				_crewMC.intText.text = "0";
				_crewMC.actingText.text = "0";
				_crewMC.attrText.text = "0";
				for (var x:int = 0; x<len; x++){
					_crewPositionArray[x].levelText.text = "0";
					_crewPositionArray[x].buyButton.enabled = true;
					_crewPositionArray[x].buyButton.visible = true;
				}
			}
		}
		
		private function loadFriendPic(fbID:String, staffType:int):void{
			if (_isOnline == true){
				_loaderContext = new LoaderContext();
				_loaderContext.checkPolicyFile = true;
				_loaderContext.securityDomain = SecurityDomain.currentDomain;
			}
			var fbPicLink:String = GlobalData.instance.getPicLinkByFID(fbID);
			_urlRequestArray[staffType] = new URLRequest(fbPicLink);
			_loaderArray[staffType] = new Loader();
			var test:Loader = new Loader();
			_loaderArray[staffType].load(_urlRequestArray[_urlRequestArray.length -1], _loaderContext);
			_loaderArray[staffType].contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
			_loaderArray[staffType].contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPicLoadError);
		}
		
		private function onPicLoaded(ev:Event):void{
			for (var x:int = 0; x<_charLen; x++){
				if(_loaderArray[x] != null){
					if (ev.currentTarget == _loaderArray[x].contentLoaderInfo){
						if (_crewPositionArray[x].friendPortrait != null){
							var friendPic:Bitmap = _loaderArray[x].content as Bitmap;
							_crewPositionArray[x].friendPortrait.addChild(friendPic);
							friendPic.x +=2;
							friendPic.y +=2;
							var parent:DisplayObjectContainer = _crewPositionArray[x].friendPortrait.pic.parent;
							parent.removeChildAt(0);
							//parent.removeChild(_staffPositionArray[x].friendPortrait.pic);
							friendPic.alpha = 0;
							TweenLite.to(friendPic, .3, {alpha:1});
							
							trace ("picture loaded");
						} else {
							_crewPositionArray[x].friendPortrait.addChild(ev.target.data as Sprite);
							trace ("picture loaded");
						}		
					}
				}
			}
		}
		
		private function onPicLoadError(ev:IOErrorEvent):void{
			Logger.tracer(this, "Error loading friend pic." + ev.text);
		}
		
		public function addListeners():void{
			for (var x:int =0; x<_crewPositionArray.length; x++){
				_crewPositionArray[x].buyButton.addEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].reminderButton.addEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].hireButton.addEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].fireButton.addEventListener(MouseEvent.CLICK, onClick);
			}			
			_crewMC.closeButton.addEventListener(MouseEvent.CLICK, onClick);
			EventSatellite.getInstance().addEventListener(CrewEvent.UPDATE_CHARDATA, onCharDataUpdate);
		}
		
		public function removeListeners():void{
			for (var x:int =0; x<_crewPositionArray.length; x++){
				_crewPositionArray[x].buyButton.removeEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].reminderButton.removeEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].hireButton.removeEventListener(MouseEvent.CLICK, onClick);
				_crewPositionArray[x].fireButton.removeEventListener(MouseEvent.CLICK, onClick);
			}
			_crewMC.closeButton.removeEventListener(MouseEvent.CLICK, onClick);
			EventSatellite.getInstance().removeEventListener(CrewEvent.UPDATE_CHARDATA, onCharDataUpdate);
		}
		
		public function onCharDataUpdate(ev:CrewEvent):void{
			updateCharData(ev.params.charID);
		}
		
		public function onClick(ev:MouseEvent):void {
			//trace( "clicker!!" );
			var position:String;
			
			for (var x:int = 0; x<_charLen; x++){
				if (ev.currentTarget.parent == _crewPositionArray[x]) {
					trace( "click.....", x );
					
					if ( x == 0 ) {
						position  = "manager";						
					}else if ( x == 1 ) {
						position  = "healthtrainer";						
					}else if ( x == 2 ) {
						position  = "vocaltrainer";						
					}else if ( x == 3 ) {
						position  = "privateteacher";						
					}else if ( x == 4 ) {
						position  = "actingteacher";						
					}else if ( x == 5 ) {
						position  = "stylist";						
					}
					
					
					switch(ev.target)
					{						
						case _crewPositionArray[x].buyButton:
						{							
							if ( position == "manager" ) {								
								var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.HIRE_CREW );							
								_es.dispatchESEvent( tutEvent );
							}
							
							trace( "crew view charid", GlobalData.instance.currentCharId );						
							_sdc.hireCrew( position, _charID , true );
							
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CREW_BUY));
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CLOSE));
							_popUpUIManager.removeWindow( WindowPopUpConfig.CREW_WINDOW );
							break;
						}
						case _crewPositionArray[x].reminderButton:
						{
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CREW_SENDNOTIFICATION));
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CLOSE));
							break;
						}
						case _crewPositionArray[x].hireButton:
						{						
							_sdc.hireFriendCrew( position, _charID  );
							trace( "[CrewView]: hire friend crew........................."  );
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CREW_HIRE));
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CLOSE));
							break;
						}
						case _crewPositionArray[x].fireButton:
						{
							_sdc.fireCrew( _charID, position  );
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CREW_FIRE));
							EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CLOSE));
							break;
						}						
					}
					break;
				}
			}
			
			switch ( ev.currentTarget ) 
			{
				case _crewMC.closeButton:				
					trace( "remove staff window!!!!!!" );
					_popUpUIManager = PopUpUIManager.getInstance();
					_popUpUIManager.removeWindow( WindowPopUpConfig.CREW_WINDOW );
					//_popUpUIManager.removeCurrentWindow();
					EventSatellite.getInstance().dispatchESEvent(new CrewEvent(CrewEvent.CLOSE));
					break;
				
				default:					
					break;
			}
		}
	}
}