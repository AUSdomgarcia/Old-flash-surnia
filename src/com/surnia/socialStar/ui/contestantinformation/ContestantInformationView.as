package com.surnia.socialStar.ui.contestantinformation
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.interfaces.ICharacter;
	import com.surnia.socialStar.ui.contestantinformation.event.ContestantInformationEvent;
	import com.surnia.socialStar.views.nodes.characters.FemaleContestant;
	import com.surnia.socialStar.views.nodes.characters.MaleContestant;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;

	public class ContestantInformationView extends Sprite
	{
		public static const SINGING:int = 0;
		public static const ACTING:int = 1;
		public static const MODELING:int = 2;
		
		public static const EMPATHY:int = 1;
		public static const AUDIENCE:int = 2;
		public static const INSTRUMENT:int = 3;
		public static const EXPERFORM:int = 4;
		public static const SHOUT:int = 5;
		public static const ACTION:int = 6;
		public static const COMEDY:int = 7;
		public static const MIME:int = 8;
		public static const EMOTION:int = 9;
		public static const MUSICAL:int = 10;
		public static const BALANCE:int = 11;
		public static const GROTESQUE:int = 12;
		public static const HOTPOSE:int = 13;
		public static const POWWALK:int = 14;
		public static const STICKACT:int = 15;
		
		public static const ACT:int = 1;
		public static const ATTR:int = 2;
		public static const HEALTH:int = 3;
		public static const INT:int = 4;
		public static const SING:int = 5;
		
		private var _contestantInfoUI:ContestantInformationWindow;
		private var _mask:ContestantInfoMask;
		private var _contestIconUI:MiniGameTitle;
		private var _commandStatusArray:Array = [];
		private var _gd:GlobalData = GlobalData.instance;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _charId:String = "";
		private var _charData:Array = [];
		private var _currentCommandIndex:int = 0;
		private var _commandLen:int = 5;
		private var _maxMinigameLen:int = 3;
		private var _character:ICharacter;
		private var _container:MovieClip;
		private var _fm:FontManager = FontManager.getInstance();
		
		public function ContestantInformationView()
		{
			init();
		}
		
		private function addListeners():void{
			_es.addEventListener(ContestantInformationEvent.SHOW_INFOWINDOW, showData);
			_contestantInfoUI.closeButton.addEventListener(MouseEvent.CLICK, onClickHandle);
			_contestantInfoUI.okButton.addEventListener(MouseEvent.CLICK, onClickHandle);
			_contestantInfoUI.arrowLButton.addEventListener(MouseEvent.CLICK, onArrowButtonClick);
			_contestantInfoUI.arrowRButton.addEventListener(MouseEvent.CLICK, onArrowButtonClick);
		}
		
		public function removeListeners():void{
			_es.removeEventListener(ContestantInformationEvent.SHOW_INFOWINDOW, showData);
			_contestantInfoUI.closeButton.removeEventListener(MouseEvent.CLICK, onClickHandle);
			_contestantInfoUI.okButton.removeEventListener(MouseEvent.CLICK, onClickHandle);
			_contestantInfoUI.arrowLButton.removeEventListener(MouseEvent.CLICK, onArrowButtonClick);
			_contestantInfoUI.arrowRButton.removeEventListener(MouseEvent.CLICK, onArrowButtonClick);
		}
		
		private function onArrowButtonClick(ev:MouseEvent):void{
			
			switch(ev.target)
			{
				case _contestantInfoUI.arrowLButton:
				{
					if (_currentCommandIndex > 0){
						_currentCommandIndex--;
						updateCommandIcons(_currentCommandIndex);
					} else {
						_currentCommandIndex = 0;
					}
					updateArrowButtonStatus();
					break;
				}
				case _contestantInfoUI.arrowRButton:
				{
					if (_currentCommandIndex < _maxMinigameLen-1){
						_currentCommandIndex++;
						updateCommandIcons(_currentCommandIndex);
					} else {
						_currentCommandIndex = _maxMinigameLen-1;
					}
					updateArrowButtonStatus();
					break;
				}
			}
		}
		
		private function updateArrowButtonStatus():void{
			if (_currentCommandIndex == 0){
				_contestantInfoUI.arrowLButton.enabled = false;
			} else if (_currentCommandIndex == _maxMinigameLen-1){
				_contestantInfoUI.arrowRButton.enabled = false;
			} else {
				_contestantInfoUI.arrowLButton.enabled = true;
				_contestantInfoUI.arrowRButton.enabled = true;
			}
		}
		
		private function onClickHandle(ev:MouseEvent):void{
			_es.dispatchEvent(new ContestantInformationEvent(ContestantInformationEvent.HIDE_INFOWINDOW));
		}
		
		public function destroy():void{
			removeListeners();
		}
		
		public function init():void{
			initAsset();
			//initFontAttributes();
			addListeners();
		}
		
		private function showData(ev:ContestantInformationEvent):void{
			_charId = ev.params.charId;
			if (!_gd.friendView){
				_charData = _gd.getCharDataOnCharID(_charId);
			} else {
				_charData = _gd.getFriendCharDataOnCharID(_charId);
			}
			initData();
			updateCommandIcons(0);
		}
		
		private function initFontAttributes():void{
			_contestantInfoUI.actStat.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.actStat.embedFonts = true;
			_contestantInfoUI.actStat.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.actStatExp.textField.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.actStatExp.textField.embedFonts = true;
			_contestantInfoUI.actStatExp.textField.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.attrStat.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.attrStat.embedFonts = true;
			_contestantInfoUI.attrStat.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.attrStatExp.textField.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.attrStatExp.textField.embedFonts = true;
			_contestantInfoUI.attrStatExp.textField.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.healthStat.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.healthStat.embedFonts = true;
			_contestantInfoUI.healthStat.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.healthStatExp.textField.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.healthStatExp.textField.embedFonts = true;
			_contestantInfoUI.healthStatExp.textField.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.intStat.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.intStat.embedFonts = true;
			_contestantInfoUI.intStat.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.intStatExp.textField.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 15 );
			_contestantInfoUI.intStatExp.textField.embedFonts = true;
			_contestantInfoUI.intStatExp.textField.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.nameTxt.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 12 );
			_contestantInfoUI.nameTxt.embedFonts = true;
			_contestantInfoUI.nameTxt.antiAliasType = AntiAliasType.ADVANCED;
			
			_contestantInfoUI.lvlStat.defaultTextFormat = _fm.getTxtFormat ("Eras Bold ITC", 24, 0xFFD628 );
			_contestantInfoUI.lvlStat.embedFonts = true;
			_contestantInfoUI.lvlStat.antiAliasType = AntiAliasType.ADVANCED;
			
		}
			
		private function initAsset():void{
			// init main window
			_contestantInfoUI = new ContestantInformationWindow();
			addChild(_contestantInfoUI);
			
			// init contest icon
			_contestIconUI = new MiniGameTitle();
			_contestantInfoUI.addChild(_contestIconUI);
			_contestIconUI.x = 38.3;
			_contestIconUI.y = 286.75;
			
			// init command icons
			var xPos:Number = 153.25;
			for (var x:int = 0; x<_commandLen; x++){
				var command:CommandStatus = new CommandStatus();
				_contestantInfoUI.addChild(command);
				command.x = xPos;
				command.y = 294.85;
				xPos += 48;
				_commandStatusArray[x] = command;
			}
		}
		
		private function updateCommandIcons(index:int):void{
			switch(index)
			{
				case SINGING:
				{
					_contestIconUI.gotoAndStop(SINGING + 1);
					_commandStatusArray[0].statusEffect1.gotoAndStop(SING);
					_commandStatusArray[0].statusEffect2.gotoAndStop(SING);
					_commandStatusArray[0].commandIcon.gotoAndStop(SHOUT);
					_commandStatusArray[0].textField.text = _charData[GlobalData.CHARLIST_SINGING_SHOUT];
					
					_commandStatusArray[1].statusEffect1.gotoAndStop(ACT);
					_commandStatusArray[1].statusEffect2.gotoAndStop(SING);
					_commandStatusArray[1].commandIcon.gotoAndStop(EMPATHY);
					_commandStatusArray[1].textField.text = _charData[GlobalData.CHARLIST_SINGING_EMPATHY];
					
					_commandStatusArray[2].statusEffect1.gotoAndStop(ATTR);
					_commandStatusArray[2].statusEffect2.gotoAndStop(SING);
					_commandStatusArray[2].commandIcon.gotoAndStop(AUDIENCE);
					_commandStatusArray[2].textField.text = _charData[GlobalData.CHARLIST_SINGING_AUDIENCE];
					
					_commandStatusArray[3].statusEffect1.gotoAndStop(INT);
					_commandStatusArray[3].statusEffect2.gotoAndStop(SING);
					_commandStatusArray[3].commandIcon.gotoAndStop(INSTRUMENT);
					_commandStatusArray[3].textField.text = _charData[GlobalData.CHARLIST_SINGING_INSTRUMENT];
					
					_commandStatusArray[4].statusEffect1.gotoAndStop(HEALTH);
					_commandStatusArray[4].statusEffect2.gotoAndStop(SING);
					_commandStatusArray[4].commandIcon.gotoAndStop(EXPERFORM);
					_commandStatusArray[4].textField.text = _charData[GlobalData.CHARLIST_SINGING_EXPERFORMANCE];
					break;
				}
				case ACTING:
				{
					_contestIconUI.gotoAndStop(ACTING + 1);
					_commandStatusArray[0].statusEffect1.gotoAndStop(SING);
					_commandStatusArray[0].statusEffect2.gotoAndStop(ACT);
					_commandStatusArray[0].commandIcon.gotoAndStop(MUSICAL);
					_commandStatusArray[0].textField.text = _charData[GlobalData.CHARLIST_ACTING_MUSICAL];
					
					_commandStatusArray[1].statusEffect1.gotoAndStop(ACT);
					_commandStatusArray[1].statusEffect2.gotoAndStop(ACT);
					_commandStatusArray[1].commandIcon.gotoAndStop(EMOTION);
					_commandStatusArray[1].textField.text = _charData[GlobalData.CHARLIST_ACTING_EMOTION];
					
					_commandStatusArray[2].statusEffect1.gotoAndStop(ACT);
					_commandStatusArray[2].statusEffect2.gotoAndStop(ACT);
					_commandStatusArray[2].commandIcon.gotoAndStop(MIME);
					_commandStatusArray[2].textField.text = _charData[GlobalData.CHARLIST_ACTING_MIME];
					
					_commandStatusArray[3].statusEffect1.gotoAndStop(INT);
					_commandStatusArray[3].statusEffect2.gotoAndStop(ACT);
					_commandStatusArray[3].commandIcon.gotoAndStop(COMEDY);
					_commandStatusArray[3].textField.text = _charData[GlobalData.CHARLIST_ACTING_COMEDY];
					
					_commandStatusArray[4].statusEffect1.gotoAndStop(HEALTH);
					_commandStatusArray[4].statusEffect2.gotoAndStop(ACT);
					_commandStatusArray[4].commandIcon.gotoAndStop(ACTION);
					_commandStatusArray[4].textField.text = _charData[GlobalData.CHARLIST_ACTING_ACTION];
					break;
				}
				case MODELING:
				{
					_contestIconUI.gotoAndStop(MODELING + 1);
					_commandStatusArray[0].statusEffect1.gotoAndStop(ATTR);
					_commandStatusArray[0].statusEffect2.gotoAndStop(ATTR);
					_commandStatusArray[0].commandIcon.gotoAndStop(GROTESQUE);
					_commandStatusArray[0].textField.text = _charData[GlobalData.CHARLIST_MODELING_GROTESQUE];
					
					_commandStatusArray[1].statusEffect1.gotoAndStop(ATTR);
					_commandStatusArray[1].statusEffect2.gotoAndStop(ATTR);
					_commandStatusArray[1].commandIcon.gotoAndStop(HOTPOSE);
					_commandStatusArray[1].textField.text = _charData[GlobalData.CHARLIST_MODELING_HOTPOSE];
					
					_commandStatusArray[2].statusEffect1.gotoAndStop(INT);
					_commandStatusArray[2].statusEffect2.gotoAndStop(ATTR);
					_commandStatusArray[2].commandIcon.gotoAndStop(STICKACT);
					_commandStatusArray[2].textField.text = _charData[GlobalData.CHARLIST_MODELING_STICKACTION];
					
					_commandStatusArray[3].statusEffect1.gotoAndStop(HEALTH);
					_commandStatusArray[3].statusEffect2.gotoAndStop(ATTR);
					_commandStatusArray[3].commandIcon.gotoAndStop(BALANCE);
					_commandStatusArray[3].textField.text = _charData[GlobalData.CHARLIST_MODELING_BALANCE];
					
					_commandStatusArray[4].statusEffect1.gotoAndStop(HEALTH);
					_commandStatusArray[4].statusEffect2.gotoAndStop(ATTR);
					_commandStatusArray[4].commandIcon.gotoAndStop(POWWALK);
					_commandStatusArray[4].textField.text = _charData[GlobalData.CHARLIST_MODELING_POWERWALKING];
					break;
				}
			}
		}
		
		private function initData():void{
			if (!_gd.friendView){
				// char init 
				_container = new MovieClip();
				_contestantInfoUI.lvlStat.text = _charData[GlobalData.CHARLIST_LEVEL];
				_contestantInfoUI.nameTxt.text = _charData[GlobalData.CHARLIST_NAME];
				if (_charData[GlobalData.CHARLIST_GENDER] == GlobalData.CONTESTANT_MALE){
					_character = new MaleContestant();
					_container.addChild(_character as MovieClip);
				} else {
					_character = new FemaleContestant();
					_container.addChild(_character as MovieClip);
				}
				_character.setDefinition(_charData[GlobalData.CHARLIST_DEFINITION]);
				_contestantInfoUI.addChild(_container);
				_container.x = 110;
				_container.y = 245;
				
				// Left Attributes
				_contestantInfoUI.popStat.text = "";
				_contestantInfoUI.stressStat.text = "";
				_contestantInfoUI.singStat.text = int(_charData[GlobalData.CHARLIST_SING] * .01) + "";
				_contestantInfoUI.actStat.text = int(_charData[GlobalData.CHARLIST_ACTING] * .01) + "";
				_contestantInfoUI.attrStat.text = int(_charData[GlobalData.CHARLIST_ATTRACTION] * .01) + "";
				_contestantInfoUI.intStat.text = int(_charData[GlobalData.CHARLIST_INTELLIGENCE] * .01) + "";
				_contestantInfoUI.healthStat.text = int(_charData[GlobalData.CHARLIST_HEALTH] * .01) + "";
				
				// right attributes
				_contestantInfoUI.popStatExp.textField.text = _charData[GlobalData.CHARLIST_POPULAR] + "";
				_contestantInfoUI.stressStatExp.textField.text = _charData[GlobalData.CHARLIST_STRESS] + "";
				_contestantInfoUI.singStatExp.textField.text = _charData[GlobalData.CHARLIST_SING] % 100 + "";
				_contestantInfoUI.actStatExp.textField.text = _charData[GlobalData.CHARLIST_ACTING] % 100 + "";
				_contestantInfoUI.attrStatExp.textField.text = _charData[GlobalData.CHARLIST_ATTRACTION] % 100 + "";
				_contestantInfoUI.intStatExp.textField.text = _charData[GlobalData.CHARLIST_INTELLIGENCE] % 100 + "";
				_contestantInfoUI.healthStatExp.textField.text = _charData[GlobalData.CHARLIST_HEALTH] % 100 + "";
				
				// bar scale
				_contestantInfoUI.popStatExp.bar.scaleX = _charData[GlobalData.CHARLIST_POPULAR] * .01 + "";
				_contestantInfoUI.stressStatExp.bar.scaleX = _charData[GlobalData.CHARLIST_STRESS] * .01 + "";
				_contestantInfoUI.singStatExp.bar.scaleX = (_charData[GlobalData.CHARLIST_SING] % 100) * .01 + "";
				_contestantInfoUI.actStatExp.bar.scaleX = (_charData[GlobalData.CHARLIST_ACTING] % 100) * .01 + "";
				_contestantInfoUI.attrStatExp.bar.scaleX = (_charData[GlobalData.CHARLIST_ATTRACTION] % 100) * .01 + "";
				_contestantInfoUI.intStatExp.bar.scaleX = (_charData[GlobalData.CHARLIST_INTELLIGENCE] % 100) * .01 + "";
				_contestantInfoUI.healthStatExp.bar.scaleX = (_charData[GlobalData.CHARLIST_HEALTH] % 100) * .01 + "";
			} else {
				// char level 
				_container = new MovieClip();
				_contestantInfoUI.lvlStat.text = _charData[GlobalData.CHARLIST_LEVEL];
				_contestantInfoUI.nameTxt.text = _charData[GlobalData.CHARLIST_NAME];
				if (_charData[GlobalData.CHARLIST_GENDER] == GlobalData.CONTESTANT_MALE){
					_character = new MaleContestant();
					_container.addChild(_character as MovieClip);
				} else {
					_character = new FemaleContestant();
					_container.addChild(_character as MovieClip);
				}
				_character.setDefinition(_charData[GlobalData.CHARLIST_DEFINITION]);
				_contestantInfoUI.addChild(_container);
				_container.x = 110;
				_container.y = 245;
				
				// Left Attributes
				_contestantInfoUI.popStat.text = "";
				_contestantInfoUI.stressStat.text = "";
				_contestantInfoUI.singStat.text = int(_charData[GlobalData.FRIENDCHARLIST_SING] * .01) + "";
				_contestantInfoUI.actStat.text = int(_charData[GlobalData.FRIENDCHARLIST_ACTING] * .01) + "";
				_contestantInfoUI.attrStat.text = int(_charData[GlobalData.FRIENDCHARLIST_ATTRACTION] * .01) + "";
				_contestantInfoUI.intStat.text = int(_charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] * .01) + "";
				_contestantInfoUI.healthStat.text = int(_charData[GlobalData.FRIENDCHARLIST_HEALTH] * .01) + "";
				
				// right attributes
				_contestantInfoUI.popStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_POPULAR] + "";
				_contestantInfoUI.stressStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_STRESS] + "";
				_contestantInfoUI.singStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_SING] % 100 + "";
				_contestantInfoUI.actStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_ACTING] % 100 + "";
				_contestantInfoUI.attrStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_ATTRACTION] % 100 + "";
				_contestantInfoUI.intStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] % 100 + "";
				_contestantInfoUI.healthStatExp.textField.text = _charData[GlobalData.FRIENDCHARLIST_HEALTH] % 100 + "";
				
				// bar scale
				_contestantInfoUI.popStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_POPULAR] % 100) / 100 + "";
				_contestantInfoUI.stressStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_STRESS] % 100) / 100 + "";
				_contestantInfoUI.singStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_SING] % 100) / 100 + "";
				_contestantInfoUI.actStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_ACTING] % 100) / 100 + "";
				_contestantInfoUI.attrStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_ATTRACTION] % 100) / 100 + "";
				_contestantInfoUI.intStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] % 100) / 100 + "";
				_contestantInfoUI.healthStatExp.bar.scaleX = (_charData[GlobalData.FRIENDCHARLIST_HEALTH] % 100) / 100 + "";
			}
		}
	}
}