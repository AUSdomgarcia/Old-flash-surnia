package com.surnia.socialStar.ui.popUI.views.characterPanel.view 
{	
	import com.greensock.*;
	import com.greensock.easing.Expo;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.CharacterPanel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.Char;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.CharHead;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.charStatPanel.CharStatPanel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.charTab.CharTab;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.data.CharListModel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import fl.text.TLFTextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	/**
	 * ...
	 * @author DF
	 */
	public class CharListView extends Sprite
	{			
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		private var isOver:Boolean = false;		
		private var _characterPanel:CharacterPanelMC;		
		private var _challengeSettings:ChallengeSettingMC;
		
		private var _arrayTab:Array = [];
		
		private var _char:Char;
		private var _rival:Char;
		
		private var _charDisplayLayer:MovieClip;
		private var _rivalDisplayLayer:Sprite;
		
		private var _character:Array = [];	
		private var _charHead:Array = [];
		
		
		private var _charLayer:Sprite;		
		private var _model:CharListModel;
		
		private var _playerStat:CharStatPanel;
		private var _rivalStat:CharStatPanel;
		private var _index:int = 0;
		
		private var _closeMC:SwitchComponent;
		//load program arrow buttons
		private var _arrowLeft:SwitchComponent;
		private var _arrowRight:SwitchComponent;
		
		//load character arrow button
		private var _arrowLeft2:SwitchComponent;
		private var _arrowRight2:SwitchComponent;
		
		private var _arrowProgramLayer:Sprite;
		private var _arrowProgramLayer2:Sprite;
		
		private var _indexLogo:int = 1;
		
		private var _charName2:String = "";
		private var _charLevel2:int;
		private var	_charPopular2:int;
		private var	_charStress2:int;
		private var	_charHealth2:int;
		private var	_charSing2:int;
		private var	_charIntelligence2:int;
		private var	_charActing2:int;
		private var	_charAttraction2:int;
		
		private var _coin:int;
		private var _ap:int;
		private var _gameTime:int;
		
		private var _function:Function;
		private var _closeFunction:Function;
		
		private var _playerObj:Object;
		private var _isSelect:Boolean = false;			
		
		private var _isCharPresent:Boolean = false;
		private var _isRivalPresent:Boolean = false;
		
		private var _txtPatternArray:Array = []; 
		private var _txtNewStringArray:Array = []; 
		
		private var _fontManager:FontManager;
		private var _es:EventSatellite = EventSatellite.getInstance();
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR	
		 * ----------------------------------------------------------------------------------------------------------*/		
		public function CharListView(model:CharListModel) 
		{				
			_model = model;
			//_function = funct;
			//_closeFunction = closeFunction;
			
			_model.addEventListener(CharacterPanelEvent.LOAD_COMPLETE, onLoadComplete);
			
			nullAllInstances();
			initialization();
			display();
			displayChallengeSetting();
			playerStat();
			rivalStat();
			
			//add listeners
			addListener();		
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void {
			trace("CLEAN :", this);
			removeListener();
			nullAllInstances();
		}
		
		private function displayChallengeSetting():void {
			_characterPanel.addChild(_challengeSettings);
			_challengeSettings.x = ((_characterPanel.width /2) - (_challengeSettings.width / 2))+5 ;
			_challengeSettings.y = 130;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/		
		 private function initialization():void {		
			 _fontManager = FontManager.getInstance();
			 
			_playerObj = new Object;				
			_charLayer = new Sprite;
			
			_characterPanel = new CharacterPanelMC;		
			_challengeSettings = new ChallengeSettingMC;
			
			_charDisplayLayer = new MovieClip;
			_rivalDisplayLayer = new Sprite;
			_arrowProgramLayer = new Sprite;	
			_arrowProgramLayer2 = new Sprite;			
			_closeMC = new SwitchComponent(closePanel, new CloseCharPanelMC);
			_closeMC.x = 520;
			_closeMC.y = 20;			
			_arrowLeft2 = new SwitchComponent(onButtonUpL, new ProgramLeftMC);
			_arrowRight2 = new SwitchComponent(onButtonUpR, new ProgramRightMC,0,298);			
			_arrowProgramLayer2.x = 110;
			_arrowProgramLayer2.y = 233;			
			_characterPanel.x = 20;			
			//set charDisplayLayer coordinate
			_charDisplayLayer.x = 60;
			_charDisplayLayer.y = 160;			
			//set rivalDisplayLayer coordinate
			_rivalDisplayLayer.x = 590;
			_rivalDisplayLayer.y = 160;			
			//set Program arrow coordinate
			_arrowProgramLayer.x = 120;
			_arrowProgramLayer.y = 100;			
					
			//set Character tab coordinate
			var tabX:int = 158;
			var tabY:int = 205;
			for (var i:int = 0; i < 3; i++ ) {				
				_arrayTab.push(new CharTab( new ChallengeTabMC, new ChallengeTabMC ,tabX, tabY, new SwitchComponent(onSelectItem, new SelectMC, i)));	
				tabX = tabX + 90;
			}
			//initial set of game program to runningman
			//setGameProgram(_indexLogo);	
			//set tab panel start button
			_characterPanel.Start.gotoAndStop(1);			
		}		
	
		
		private function onSelectItem(i:int):void {	
			
			_isSelect = true;
			if (_character[i + _index] != null) {				
				//display player and set new stat				
				displayPlayer(_character[i + _index]);		
				_playerObj.definition			= _character[i + _index].definition;
				_playerObj.charExp				= _character[i + _index].charExp;					
				_playerObj.charLevel			= _character[i + _index].charLevel;
				_playerObj.charName				= _character[i + _index].charName;
				_playerObj.charCondition		= _character[i + _index].charCondition;
				_playerObj.charGrade	 		= _character[i + _index].charGrade;					
				_playerObj.charLevel 			= _character[i + _index].charLevel;
				_playerObj.charPopular			= _character[i + _index].charPopular;
				_playerObj.charStress			= _character[i + _index].charStress;
				_playerObj.charHealth			= _character[i + _index].charHealth;
				_playerObj.charSing 			= _character[i + _index].charSing;
				_playerObj.charIntelligence		= _character[i + _index].charIntelligence;
				_playerObj.charActing			= _character[i + _index].charActing;
				_playerObj.charAttraction		= _character[i + _index].charAttraction;	
				_playerObj.charID				= _character[i + _index].charID;
				
				_playerObj.charGender			= setGender(_character[i + _index].charGender);
			}		
			
			//selected program
			_playerObj.selectionProgram			= selectProgram(_indexLogo - 1);
			trace(this, "RETURN charGender:",_playerObj.charGender);
		}		
		
		private function setGender(gender:String = "Male"):int {			
			var genderNum:int = 0;
			if (gender == "Male") {
				genderNum = 0;
			}
			else {
				genderNum = 1;
			}			
			return genderNum;			
		}
		
		//LOOKUP
		private function selectProgram(index:int):String {
			var gameProg:String;
			
			switch(index) {
				case 0:
					gameProg = CharacterPanel.PROGRAM_SINGING;
				break;
				case 1:
					gameProg = CharacterPanel.PROGRAM_MOVIESTAR;
				break;
				case 2:
					gameProg = CharacterPanel.PROGRAM_SUPERMODEL;
				break;
			}			
			return gameProg;
		}
		
		//----------------------------------------------------------------PROGRAM ARROW LEFT--------------------------------------------------------------
		private function onProgramUpL(id:int):void {
			_indexLogo--;
			if(_indexLogo < 1){				
				_indexLogo = 1;
			}	
			setGameProgram(_indexLogo);
		}
		
		//----------------------------------------------------------------PROGRAM ARROW RIGHT--------------------------------------------------------------
		private function onProgramUpR(id:int):void {
			_indexLogo++;
			if(_indexLogo > _characterPanel.logoName.totalFrames){
				_indexLogo = _characterPanel.logoName.totalFrames;
			}				
			setGameProgram(_indexLogo);
		}				
		
		//----------------------------------------------------------------ARROW LEFT--------------------------------------------------------------
		private function onButtonUpL(id:int):void {
			_index = _index - _arrayTab.length;
			if(_index < 0){				
				_index = 0;
			}			
			displayTab(_index);
		}
		
		//----------------------------------------------------------------ARROW RIGHT--------------------------------------------------------------		
		private function onButtonUpR(id:int):void {
			_index = _index + _arrayTab.length;
			if(_index > (_character.length - 1)){
				_index = _index - _arrayTab.length;
			}			
			displayTab(_index);
		}			
		
		//---------------------------------------------------------------DISPLAY--------------------------------------------------------------
		private function display():void {	
			//display main character panel
			addChild(_characterPanel);			
			
			//display character and rival stage Layer
			_characterPanel.addChild(_charLayer);			
			
			//display character arrow layer
			_characterPanel.addChild(_arrowProgramLayer);
			
			//display program arrow layer
			_characterPanel.addChild(_arrowProgramLayer2);
			
			//display close button			
			addChild(_closeMC);
			
			//display character stage
			_charLayer.addChild(_charDisplayLayer);	
			//display rival stage
			_charLayer.addChild(_rivalDisplayLayer);			
			
			//display the three character tab
			for (var i:int = 0; i < _arrayTab.length; i++ ) {
				addChild(_arrayTab[i])
			}			
			//display character arrow button
			_arrowProgramLayer2.addChild(_arrowLeft2);
			_arrowProgramLayer2.addChild(_arrowRight2);	
		}
		
		//---------------------------------------------------------------SET CHARACTER--------------------------------------------------------
		private function addCharacter(charAvatar:Array):void {
			_character = charAvatar;			
					
			for (var i:int = _character.length - 1; i > 0; i-- ) {
				if (_charHead[i] != null) {
					_charHead[i].remove();
					_charHead[i] = null;
					_charHead.pop();
				}
			}			
			
			for (var j:int = 0; j < _character.length; j++ ) {
				var charHead:CharHead = new CharHead(_character[j].definition, _character[j].charGender );	
				_charHead[j] = charHead;				
				charHead = null;
			}
		}
		
		//---------------------------------------------------------------DISPLAY PLAYER AND RIVAL---------------------------------------------
		private function displayPlayer(player:Char):void {
			_char = player;				
			for (var i :int = 0; i < _character.length; i ++ ) {				
				if (_character[i] !=null) {
					if (_charDisplayLayer.contains(_character[i])) {
						_charDisplayLayer.removeChild(_character[i]);						
					}
				}				
			}			
			
			_charDisplayLayer.addChild(_char);				
			//tweenCharTab(_char);			
			_isCharPresent = true;			
			addListenerStart();
		}		
		
		private function displayRival(rival:Char):void {
			if( rival != null && _rivalDisplayLayer != null ){
				_rival = rival;				
				_rivalDisplayLayer.addChild(_rival);				
				_isRivalPresent = true			
				addListenerStart();
			}
		}
		
		public function removeRival():void {
			if (_rival != null) {
				if(_rivalDisplayLayer.contains(_rival)){
					_rivalDisplayLayer.removeChild(_rival);
					_rival = null;
				}
			}			
			_isRivalPresent = false;
			trace(this, "RETURN remove rival!!");
		}
		
		private function displayTab(index:int):void {		
			removeAllTabCharacter();				
			for (var i:int =  0; i < _arrayTab.length; i++ ) {
				if (_charHead[i + index] != null) {					
					_arrayTab[i].displayItem(_charHead[i + index]);							
					//tweenCharTab(_charHead[i + index]);					
				}
			}				
		}
		
		private function removeAllTabCharacter():void {		
			//check all charTab
			for (var i:int =  0; i < _charHead.length; i++ ) {
				//check all arrayTab
				for (var j:int = 0; j < _arrayTab.length; j++ ) {
					if (_charHead[i] != null) {
						if(_arrayTab[j].contains(_charHead[i])){
							_arrayTab[j].removeItem();						
						}
					}
				}
			}
		}
		
		private function tweenCharTab(mc:MovieClip):void {
			/*
			mc.alpha = 0;
			TweenLite.to(mc, 0.5, { 
				alpha:1,
				onComplete: function():void {
				TweenLite.killTweensOf(mc);
				
				}
			});
			*/
		}
		
		private function playerStat():void {
			_playerStat = new CharStatPanel();					
			addChild(_playerStat);
			_playerStat.x = 0;			
			_playerStat.y = _characterPanel.height - 150;		
		}
		
		private function rivalStat():void {
			_rivalStat = new CharStatPanel();
			addChild(_rivalStat);
			_rivalStat.x = _characterPanel.width - 80;			
			_rivalStat.y = _characterPanel.height - 150;
			
		}
		
		
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function addListener():void {			
			//start			
			for (var i:int = 0; i < _arrayTab.length; i++ ) {				
				_arrayTab[i].addEventListener(MouseEvent.MOUSE_OVER, onOver);
				_arrayTab[i].addEventListener(MouseEvent.MOUSE_OUT, onOut);
			}			
		}
		
		public function addListenerStart():void {			
			if(_characterPanel != null){
				_characterPanel.Start.addEventListener(MouseEvent.ROLL_OVER, onStartOver);
				_characterPanel.Start.addEventListener(MouseEvent.ROLL_OUT, onStartOut);
				_characterPanel.Start.addEventListener(MouseEvent.MOUSE_DOWN, onStartDown);
				_characterPanel.Start.addEventListener(MouseEvent.MOUSE_UP, onStartUp);
			}
			
			
			
		}		
		
		public function removeListener():void {
			//start
			removeListenerStart();
			
			for (var i:int = 0; i < _arrayTab.length; i++ ) {		
				if(_arrayTab[i] != null){
					_arrayTab[i].removeEventListener(MouseEvent.MOUSE_OVER, onOver);
					_arrayTab[i].removeEventListener(MouseEvent.MOUSE_OUT, onOut);
				}
			}	
		}	
		
		public function removeListenerStart():void {
			if(_characterPanel != null){
				_characterPanel.Start.removeEventListener(MouseEvent.ROLL_OVER, onStartOver);
				_characterPanel.Start.removeEventListener(MouseEvent.ROLL_OUT, onStartOut);
				_characterPanel.Start.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDown);
				_characterPanel.Start.removeEventListener(MouseEvent.MOUSE_UP, onStartUp);	
			}
		}
		
		public function setGameProgram(type:int = 1):void {
			_indexLogo = type;			
			_playerObj.selectionProgram			= selectProgram(_indexLogo - 1);
			_playerObj.selectionProgramNumber	= _indexLogo - 1;
			_characterPanel.logoName.gotoAndStop(type);		
			
			_es.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.PROGRAM_SELECT, _playerObj));
		}	
		
		public function setBossScript(bossScript:String):void {	
			setFontManager(_characterPanel.txtScript, 15);
			_characterPanel.txtScript.htmlText = covertString(bossScript);			
		}
		
		private function setPattern(pattern:RegExp, newString:String = ""):void {
			_txtPatternArray.push(pattern);
			_txtNewStringArray.push(newString);
		}
		
		private function covertString(scriptTxt:String):String {
			
			//var myPattern:RegExp = /sh/gi;  			
			setPattern(/&quot;/gi, "\"");
			setPattern(/&apo;/gi, "\'");
			setPattern(/&lt;/gi, "<");
			setPattern(/&gt;/gi, ">");
			setPattern(/&amp;/gi, "&");
			
			for (var i:int = 0; i < _txtPatternArray.length; i++ ) {				
				scriptTxt = scriptTxt.replace(_txtPatternArray[i], _txtNewStringArray[i]);  
			}
			trace(this, "RETURN new string:", scriptTxt);
			
			return scriptTxt;
		}
		
		public function setRival(_charLevel:int = 1,_charPopular:int = 1,_charStress:int = 1,_charActing:int = 1,_charAttraction:int = 1,_charCondition:int = 1,_charGrade:int = 1,_charHealth:int = 1,_charIntelligence:int = 1,_charSing:int = 1,_charExp:int = 1,_charGender:String = "Male",_charName:String = "NoName", _definition:String = "01"):void {			
			var rivalChar:Char = new Char(_definition,_charExp,_charGender,_charLevel,_charName,_charStress,_charActing,_charAttraction,_charCondition,_charGrade,_charHealth,_charIntelligence,_charPopular,_charSing);
			
			//rivalChar.setRivalAvatar(true);
			//rivalChar.setBossNPC(2, .7,.7);
			
			_charName2		= _charName;
			_charLevel2 	= _charLevel;
			_charPopular2 	= _charPopular;
			_charStress2 	= _charStress;
			_charHealth2 	= _charHealth;
			_charSing2 		= _charSing;
			_charIntelligence2 = _charIntelligence;
			_charActing2 	= _charActing;
			_charAttraction2= _charAttraction;
			trace(this, "RETURN _charName:",_charName,"_definition:",_definition);
			displayRival(rivalChar);
			_rivalStat.setStat(_charName, _charLevel,_charPopular, _charStress, _charHealth, _charSing, _charIntelligence, _charActing, _charAttraction);					
		}
		
		public function setBossNPC(_bossType:int = 0, _charLevel:int = 1,_charPopular:int = 1,_charStress:int = 1,_charActing:int = 1,_charAttraction:int = 1,_charCondition:int = 1,_charGrade:int = 1,_charHealth:int = 1,_charIntelligence:int = 1,_charSing:int = 1,_charExp:int = 1,_charGender:String = "Male",_charName:String = "NoName", _scaleX:Number = .7, _scaleY:Number = .07, _definition:String = "01"):void {			
			var rivalChar:Char = new Char(_definition,_charExp,_charGender,_charLevel,_charName,_charStress,_charActing,_charAttraction,_charCondition,_charGrade,_charHealth,_charIntelligence,_charPopular,_charSing);
			
			rivalChar.setBossNPC(_bossType, _scaleX, _scaleY);
			
			_charName2		= _charName;
			_charLevel2 	= _charLevel;
			_charPopular2 	= _charPopular;
			_charStress2 	= _charStress;
			_charHealth2 	= _charHealth;
			_charSing2 		= _charSing;
			_charIntelligence2 = _charIntelligence;
			_charActing2 	= _charActing;
			_charAttraction2= _charAttraction;
			
			displayRival(rivalChar);
			_rivalStat.setStat(_charName, _charLevel,_charPopular, _charStress, _charHealth, _charSing, _charIntelligence, _charActing, _charAttraction);					
		}
		
		public function setMode(mode:int = CharacterPanel.CHALLENGE_STORY_MODE):void {
			if (mode == CharacterPanel.CHALLENGE_STORY_MODE) {				
				if (_arrowLeft != null) {
					if (_arrowProgramLayer.contains(_arrowLeft)) {
						_arrowProgramLayer.removeChild(_arrowLeft);
						_arrowLeft = null;
					}					
				}
				if (_arrowRight != null) {
					if (_arrowProgramLayer.contains(_arrowRight)) {
						_arrowProgramLayer.removeChild(_arrowRight);
						_arrowRight = null;
					}					
				}
			}
			else {		
				//clean arrows
				if (_arrowLeft != null) {
					if (this.contains(_arrowLeft)) {
						_arrowProgramLayer.removeChild(_arrowLeft);
						_arrowLeft = null;
					}
				}				
				if (_arrowRight != null) {
					if (this.contains(_arrowRight)) {
						_arrowProgramLayer.removeChild(_arrowRight);
						_arrowRight = null;
					}
				}
				
				//display program arrows
				_arrowLeft = new SwitchComponent(onProgramUpL, new ProgramLeftMC);
				_arrowRight = new SwitchComponent(onProgramUpR, new ProgramRightMC, 0, 380);				
				
				_arrowProgramLayer.addChild(_arrowLeft);
				_arrowProgramLayer.addChild(_arrowRight);	
				
				
			}
		}
		
		public function setPlayerCoin(val:int):void {
			_coin = val;
			setFontManager(_challengeSettings.txtCoin, 12);
			_challengeSettings.txtCoin.text = String(_coin);
		}
		
		public function setPlayerAP(val:int):void {
			_ap = val;
			setFontManager(_challengeSettings.txtAP, 12);
			_challengeSettings.txtAP.text = String(_ap);
		}
		
		public function setGameTime(val:int):void {
			_gameTime = val;
			setFontManager(_challengeSettings.txtTime, 12);
			_challengeSettings.txtTime.text = String(_gameTime);
		}
		
		private function setFontManager(txtField:TLFTextField, fontSize:int = 8, fontColor:int = 0, fontFamily:String = "Eras Demi ITC"):void 
		{
			txtField.defaultTextFormat = _fontManager.getTxtFormat(fontFamily , fontSize, fontColor );			
			txtField.embedFonts = true;
			txtField.antiAliasType = AntiAliasType.ADVANCED;			
		}
		
		public function nullAllInstances():void {			
			trace("CLEAN :", this);
			if (_playerObj != null) {				
				_playerObj = null;	
			}
			
			for (var i :int = 0; i < _character.length; i ++ ) {				
				if (_character[i] != null) {
					if(_charDisplayLayer != null){
						if (_charDisplayLayer.contains(_character[i])) {
							_charDisplayLayer.removeChild(_character[i]);	
							_character[i] = null;
						}
					}
				}				
			}
			
			if (_rival != null) {
				if(_rivalDisplayLayer != null){
					_rivalDisplayLayer.addChild(_rival);	
					_rival = null;
				}
			}
			
			if (_charDisplayLayer != null) {
				_charLayer.removeChild(_charDisplayLayer);
				_charDisplayLayer = null;
			}				
			if (_rivalDisplayLayer != null) {
				_charLayer.removeChild(_rivalDisplayLayer);
				_rivalDisplayLayer = null;	
			}
			
			if (_charLayer != null) {
				_characterPanel.removeChild(_charLayer);
				_charLayer = null;
			}	
			
			//remove left right arrow switchcomponent
			if (_arrowLeft != null) {
				_arrowProgramLayer.removeChild(_arrowLeft);
				_arrowLeft = null;	
			}				
			if (_arrowRight != null) {
				_arrowProgramLayer.removeChild(_arrowRight);
				_arrowRight = null;		
			}
			
			//remove left right programm arrow
			if (_arrowLeft2 != null){ 
				_arrowProgramLayer2.removeChild(_arrowLeft2);
				_arrowLeft2 = null;
			}
			if (_arrowRight2 != null) {
				_arrowProgramLayer2.removeChild(_arrowRight2);
				_arrowRight2 = null;	
			}
			
			//remove arrow layer
			if (_arrowProgramLayer != null){ 
				_characterPanel.removeChild(_arrowProgramLayer);
				_arrowProgramLayer = null;	
			}			
			if (_arrowProgramLayer2 != null){ 
				_characterPanel.removeChild(_arrowProgramLayer2);
				_arrowProgramLayer2 = null;	
			}
			
			//remove character panel
			if (_characterPanel != null) {
				removeChild(_characterPanel);
				_characterPanel = null;
			}		
			
			if (_closeMC != null) {
				removeChild(_closeMC);
				_closeMC = null;
			}			
			
			if (_playerStat != null) {
				removeChild(_playerStat);
				_playerStat = null;		
			}
			
			if (_rivalStat != null){
				removeChild(_rivalStat);
				_rivalStat = null;	
			}
				
			removeAllTabCharacter();
			
			for (var a:int = _arrayTab.length; a >= 0;a-- ) {
				if (_arrayTab[a] != null) {					
					removeChild(_arrayTab[a]);
					_arrayTab[a] = null;
					_arrayTab.pop();
				}				
			}	
			
			for (var b:int = _character.length; b >= 0;b-- ) {
				if (_character[b] != null) {		
					_character[b] = null;
					_character.pop();
				}				
			}			
			
		}
		
		//ON START GAME
		private function dispatchData():void {	
			if (_isSelect == true) {
				_isSelect = false;
				_es.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.CHARACTER_SELECT, _playerObj));
				//_function(_playerObj);
				removeListener();
				nullAllInstances();
			}			
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function closePanel(val:Object = null):void {			
			removeListener();
			nullAllInstances();
			_es.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.PANEL_CLOSE));
			//_closeFunction(null);			
		}
		
		private function onOver(e:MouseEvent):void {			
			for (var i:int = 0; i <  _arrayTab.length; i++ ) {
				if (e.currentTarget == _arrayTab[i]) {
					if(_character[i + _index] != null ){					
						_playerStat.setCompareStat(_charLevel2, _charPopular2, _charStress2, _charHealth2, _charSing2, _charIntelligence2, _charActing2, _charAttraction2);
						_playerStat.setStat(_character[i + _index].charName,_character[i + _index].charLevel,_character[i + _index].charPopular, _character[i + _index].charStress, _character[i + _index].charHealth, _character[i + _index].charSing, _character[i + _index].charIntelligence, _character[i + _index].charActing, _character[i + _index].charAttraction);
						_rivalStat.setCompareStat(_character[i + _index].charLevel,_character[i + _index].charPopular, _character[i + _index].charStress, _character[i + _index].charHealth, _character[i + _index].charSing, _character[i + _index].charIntelligence, _character[i + _index].charActing, _character[i + _index].charAttraction);
						_rivalStat.setStat(_charName2,_charLevel2, _charPopular2, _charStress2, _charHealth2, _charSing2, _charIntelligence2, _charActing2, _charAttraction2);	
					}
				}
			}				
		}
		
		private function onOut(e:MouseEvent):void {
			if(_isSelect == false){
				for (var i:int = 0; i <  _arrayTab.length; i++ ) {
					if (e.currentTarget == _arrayTab[i]) {
						_playerStat.remove();					
					}
				}
			}
		}		
		
		private function onLoadComplete(e:CharacterPanelEvent):void {			
			_model.removeListener();
			addCharacter(_model.charAvatar );
			//Displaye player and rival characters
			//diplayCharacter(_character[0],_character[2])			
			displayTab(0);				
		}		
		
		//----------------------------------------------------------------START-------------------------------------------------------------		
		private function onStartOver(e:MouseEvent):void {				
			//e.target.gotoAndStop(1);			
		}
		private function onStartOut(e:MouseEvent):void {		
			isOver = false;
			e.target.gotoAndStop(1);
		}
		private function onStartDown(e:MouseEvent):void {				
			if (isOver == false) {
				isOver = true;
				e.target.gotoAndStop(2);			
			}
		}		
		private function onStartUp(e:MouseEvent):void {		
			isOver = false;			
			_characterPanel.Start.gotoAndStop(1);	
			
			if(_isCharPresent == true && _isRivalPresent == true){
				dispatchData();
			}
			else {
				var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
				popUpUIEvent.obj.msg = GameDialogueConfig.CANT_START_MINIGAME_MUST_SELECT_TWO_CONTESTANT;
				_es.dispatchESEvent( popUpUIEvent );
			}
			
			trace(this, "RETURN isCharPresent:", _isCharPresent, " isRivalPresent:", _isRivalPresent);
		}
	}

}