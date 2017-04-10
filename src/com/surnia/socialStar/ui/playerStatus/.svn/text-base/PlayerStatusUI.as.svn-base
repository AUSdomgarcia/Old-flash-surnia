package com.surnia.socialStar.ui.playerStatus
{
	import CraftingUI_fla.Arial_1;
	
	import caurina.transitions.TweenListObj;
	
	import com.fluidLayout.FluidObject;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.utils.CountdownTimer;
	import com.surnia.socialStar.utils.TooltipCreator;
	import com.surnia.socialStar.utils.currencyConverter.CurrencyConverter;
	import com.surnia.socialStar.utils.fonttextmanager.TextFieldUtility;
	import com.surnia.socialStar.utils.points.Points;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * 
	 *  @author hedrick david
	 * 	@email hedrickdavid.surnia@gmail.com
	 * 
	 * Contains the interface for the
	 * player status UI
	 * 
	 */	
	
	public class PlayerStatusUI extends Sprite
	{
		private var _gd:GlobalData = GlobalData.instance;
		// temporary assets;
		private var _coinMC:CoinMC;
		private var _cashMC:CashMC;
		private var _apMC:APMC;
		private var _levelMC:LevelMC;
		//private var _ticketMC:TicketMC;
		//private var _hotPointMC:HotPointsMC;
		private var _redStarMC:RedStarMC;
		private var _blackStarMC:BlackStarMC;
		private var _helpingEnergyMC:HelpingEnergyMC;
		private var _characterLimitUI:CharacterLimitUI;
		private var _countDownTimer:CountdownTimer;
		
		private var _maxExp:int = 0;
		private var _maxAP:int = 0;
		private var _maxTicket:int = 0;
		private var _maxHotPoint:int = 0;
		private var _canDispatch:Boolean = false;
		private var _hotPointsReductionRate:Number = .1;
		private var _statusDescription:Array = [];
		private var _toolTip:ToolTipMC;
		private var _showTooltip:Boolean = false;
		private var _statusTextField:ToolTipText;
		private var _descriptionTextField:ToolTipText;
		private var _levelSprite:Sprite;
		private var _runTimerValue:Boolean = false;
		private var _es:EventSatellite = EventSatellite.getInstance();
		
		private var _starXPos:int = 8.50;
		private var _starYPos:int = 145;
		
		private var _textFormat:TextFormat;
		private var _fm:FontManager = FontManager.getInstance();
		
		/**
		 *
		 * Constructor 
		 * 
		 */		
		
		public function PlayerStatusUI()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}		
		
		/**
		 * Set the visibility of the red star game token
		 *  
		 * @param value - the visibily value.
		 * @param tweening - if the token will be tweening.
		 */		
		
		public function setRedStarVisibility(value:Boolean, tweening:Boolean = false):void{
			if (_redStarMC && _redStarMC != null){
				if (tweening == false){
					_redStarMC.visible = value;
					toggleRedStarListeners(value);
				} else{
					if (value == true){
						TweenLite.to(_redStarMC, .3, {alpha:1});	
						toggleRedStarListeners(value);
					} else {
						TweenLite.to(_redStarMC, .3, {alpha:0});
						toggleRedStarListeners(value);
					}
				}
			}
		}
		
		/**
		 * Set the visibility of the black star game token
		 *  
		 * @param value - the visibily value.
		 * @param tweening - if the token will be tweening.
		 */	
		
		public function setBlackStarVisiblity(value:Boolean, tweening:Boolean = false):void{
			if (_blackStarMC && _blackStarMC != null){
				if (tweening == false){
					_blackStarMC.visible = value;
					if (value == true){
						toggleBlackStarListeners(value);
					}
				} else{
					if (value == true){
						TweenLite.to(_blackStarMC, .3, {alpha:1});
						toggleBlackStarListeners(value);
					} else {
						TweenLite.to(_blackStarMC, .3, {alpha:0});
						toggleBlackStarListeners(value);
					}
				}
			}
		}
		
		/**
		 * Set the visibility of the helping energy token
		 *  
		 * @param value - the visibily value.
		 */	
		
		public function setHelpingEnergyVisiblity(value:Boolean):void{
			if (_helpingEnergyMC && _helpingEnergyMC != null){
				if (value){
					_helpingEnergyMC.alpha = 1;
					toggleHelpingEnergyListeners(value);
				} else {
					_helpingEnergyMC.alpha = 0;
					toggleHelpingEnergyListeners(value);
				}
			}
		}
		
		public function toggleBlackStarListeners(value:Boolean):void{
			if (value) {
				_blackStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_blackStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			} else {
				_blackStarMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				_blackStarMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		public function toggleRedStarListeners(value:Boolean):void{
			if (value) {
				_redStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_redStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			} else {
				_redStarMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				_redStarMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
			
		}	
		
		public function toggleHelpingEnergyListeners(value:Boolean):void{
			if (value) {
				_helpingEnergyMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_helpingEnergyMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			} else {
				_helpingEnergyMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				_helpingEnergyMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}

		
		public function setStatusDescription(value:Array):void{
			_statusDescription = value;
		}
		
		/**
		 * 
		 * @return Number - gets the reduction rate for the hotpoint.
		 * 
		 */		
		
		public function get hotpointsReductionRate():Number
		{
			return _hotPointsReductionRate;
		}
		
		/**
		 * 
		 * @param value - sets the hotpoints reduction rate.
		 * 
		 */		

		public function set hotpointsReductionRate(value:Number):void
		{
			_hotPointsReductionRate = value;
		}
		
		/**
		 * 
		 * @return CountdownTimer - gets the custom timer used for the countdown in the ap.
		 * 
		 */		

		public function get countDownTimer():CountdownTimer
		{
			return _countDownTimer;
		}
		
		/**
		 * 
		 * Updates the limit of the data
		 * 
		 * @param data - the player status data from the proxy.
		 * 
		 */		

		public function updateLimits(data:Object):void{
			_maxAP = data.apLimit;
			_maxTicket = data.ticketLimit;
			_maxHotPoint = data.hotPointLimit;
			_maxExp =  data.expLimit;
		}
		
		/**
		 * 
		 * Updates the specific limits of locally cached variables.
		 * 
		 * @param statusType - the type of status.
		 * @param data - the player status data from the proxy.
		 * 
		 */		
		
		public function updateSpecificLimits(statusType:int, data:Object):void{
			switch(statusType)
			{
				case GlobalData.EXPERIENCE_LIMIT:
				{
					_maxExp = data.experienceLimit;
					break;
				}
				case GlobalData.AP_LIMIT:
				{
					_maxAP = data.apLimit;
					break;
				}
			}
		}
		
		/**
		 *	
		 * Sets the display of the textfields of the appropriate
		 * status. 
		 *  
		 * @param data - the player status data from the proxy.
		 * 
		 */		
		
		private function setDisplayTexts(data:Object):void{
			_coinMC.textField.text = "" + CurrencyConverter.numericAmount(data.clientCoin);
			_cashMC.textField.text = "" + CurrencyConverter.numericAmount(data.clientStarPoint);
			_apMC.textField.text = "" + data.clientActionPoint;
			_levelMC.levelTextField.text = "" + data.clientLevel;
			_levelMC.textField.text = "" + data.clientExperience;
			_redStarMC.textField.text = "" + data.clientRedStarLvl;
			_blackStarMC.textField.text = "" + data.clientBlackStarLvl;
			_characterLimitUI.hired.text = data.clientCharacterHired;
			_characterLimitUI.limit.text = data.clientCharacterLimit;
			//_ticketMC.textField.text = String (CurrencyConverter.numericAmount(data.clientTicket));
		}
		
		/**
		 * 
		 * Initial updating of data
		 * 
		 * @param data - the player status data from the proxy.
		 * 
		 */		
		
		public function initDisplayData(data:Object):void{
			setDisplayTexts(data);
			//init status bars
			initStatusBar(_apMC, data.clientActionPoint/_maxAP, GlobalData.HORIZONTAL);
			initStatusBar(_levelMC, data.clientExperience/_maxExp, GlobalData.HORIZONTAL);
			initStatusBar(_redStarMC, data.clientRedStarLocalExp/GlobalData.instance.redStarExpLimit, GlobalData.HORIZONTAL);
			initStatusBar(_blackStarMC, data.clientBlackStarLocalExp/GlobalData.instance.blackStarExpLimit, GlobalData.HORIZONTAL);
			//initStatusBar(_hotPointMC, data.clientHotPoint/_maxHotPoint, GlobalData.VERTICAL);
			checkStatus();
		}
		
		/**
		 * 
		 * Updates the display data in batch.
		 * 
		 * @param data - the player status data from the proxy.
		 * 
		 */		
		
		public function updateDisplayData(data:Object):void{
			setDisplayTexts(data);
			checkStatus();
			updateFillBar(GlobalData.AP, data.clientActionPoint/_maxAP, GlobalData.HORIZONTAL);
			//updateFillBar(GlobalData.HOTPOINT, data.clientHotPoint/_maxHotPoint, GlobalData.VERTICAL);
			if (_gd.pLvl>1){
				var lastTotalXP:Number = _gd.getLevelAPTableByLevel(_gd.pLvl-1)[GlobalData.LEVELAPTABLE_EXP];
			} else {
				lastTotalXP = 0;
			}
			updateFillBar(GlobalData.EXPERIENCE, data.clientExperienceLocal/(_maxExp - lastTotalXP), GlobalData.HORIZONTAL);
			updateFillBar(GlobalData.REDSTAREXP, data.clientRedStarLocalExp/GlobalData.instance.redStarExpLimit, GlobalData.HORIZONTAL);
			updateFillBar(GlobalData.BLACKSTAREXP, data.clientBlackStarLocalExp/GlobalData.instance.blackStarExpLimit, GlobalData.HORIZONTAL);
		}
		
		/**
		 * 
		 * Updates the specific player status display.
		 *  
		 * @param statusType - the type of player status.
		 * @param data - the player status data from the proxy.
		 * 
		 */		
		
		public function updateSpecificStatus(statusType:int, data:Object):void{
			
			switch(statusType)
			{
				case GlobalData.COIN:
				{
					var coin:uint = data.clientCoin;
					_coinMC.textField.text = CurrencyConverter.numericAmount(uint(data.clientCoin));
					break;
				}
				case GlobalData.STARPOINT:
				{
					_cashMC.textField.text = CurrencyConverter.numericAmount(uint(data.clientStarPoint));
					break;
				}
				case GlobalData.LEVEL:
				{
					_levelMC.levelTextField.text = String (data.clientLevel);
					break;
				} 
				case GlobalData.EXPERIENCE:
				{
					_levelMC.textField.text = data.clientExperience;
					if (_gd.pLvl>1){
						var lastTotalXP:Number = _gd.getLevelAPTableByLevel(_gd.pLvl-1)[GlobalData.LEVELAPTABLE_EXP];
					} else {
						lastTotalXP = 0;
					}
					var percentage:Number = Number (data.clientExperienceLocal/(_maxExp - lastTotalXP));
					updateFillBar(GlobalData.EXPERIENCE, percentage, GlobalData.HORIZONTAL);
					break;
				}
				case GlobalData.AP:
				{
					_apMC.textField.text = data.clientActionPoint;
					updateFillBar(GlobalData.AP, data.clientActionPoint/_maxAP,GlobalData.HORIZONTAL);
					break;
				}
				case GlobalData.REDSTARLVL:
				{
					_redStarMC.textField.text = data.clientRedStarLvl;
					break;
				}
				case GlobalData.BLACKSTARLVL:
				{
					_blackStarMC.textField.text = data.clientBlackStarLvl;
					break;
				}
				case GlobalData.BLACKSTAREXP:
				{
					updateFillBar(GlobalData.BLACKSTAREXP, data.clientBlackStarLocalExp/_gd.blackStarExpLimit ,GlobalData.HORIZONTAL);
					break;
				}
				case GlobalData.REDSTAREXP:
				{
					//var percentage:Number = Number (data.clientRedStarLocalExp/_globalData.redStarExpLimit);
					updateFillBar(GlobalData.REDSTAREXP, data.clientRedStarLocalExp/_gd.redStarExpLimit, GlobalData.HORIZONTAL);
					break;
				}
				case GlobalData.HELPINGENERGY:
				{
					_helpingEnergyMC.textField.text = data.clientHelpingEnergy;
					break;
				}
				case GlobalData.CHARACTERHIRED:
				{
					_characterLimitUI.hired.text = data.clientCharacterHired;
					break;
				}
				case GlobalData.CHARACTERLIMIT:
				{
					_characterLimitUI.limit.text = data.clientCharacterLimit;
					break;
				}
				checkUpdates();
			}
		}
		
		/**
		 * 
		 * Updates the specific player status display.
		 *  
		 * @param statusType - the type of player status.
		 * @param data - the player status data from the proxy.
		 * 
		 */	
		
		public function resetStatus(statusType:int):void{
			switch(statusType)
			{
				case GlobalData.EXPERIENCE:
				{
					_levelMC.statusBar.scaleX = 0;
					_levelMC.textField.text = "0/" + _maxExp;
					break;
				}
				case GlobalData.AP:
				{
					_apMC.statusBar.scaleX = 0;
					break;
				}
				case GlobalData.REDSTAREXP:
				{
					_redStarMC.statusBar.scaleX = 0;
					break;
				}
				case GlobalData.BLACKSTAREXP:
				{
					_blackStarMC.statusBar.scaleX = 0;
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
		 * This is the first thing that is called 
		 * after instantiating the the UI. Shows the 
		 * player status.
		 * 
		 */	
		
		public function show():void{
			TweenLite.to(this, .3, {alpha:1});
			addListeners();
		}
		
		/**
		 *	
		 * Initializes and adds events for the PlayerStatusUI
		 * 
		 */	
		
		public function init():void{
			this.alpha = 0;
			TweenLite.to(this, .3, {alpha:1});
			initialShow();
		}
		
		public function initialShow():void{
			initAssets();
			//initFontAttributes();
			addListeners();
		}
		
		private function initFontAttributes():void{
			
			/*setFontAttributes(_characterLimitUI.hired, "Eras Bold ITC", 15);
			setFontAttributes(_characterLimitUI.limit, "Eras Bold ITC", 15);
			setFontAttributes(_helpingEnergyMC.textField, "Eras Bold ITC", 21);
			setFontAttributes(_redStarMC.textField, "Eras Bold ITC", 15);
			setFontAttributes(_blackStarMC.textField, "Eras Bold ITC", 15);
			setFontAttributes(_coinMC.textField, "Eras Bold ITC", 15);
			setFontAttributes(_cashMC.textField, "Eras Bold ITC", 15);
			setFontAttributes(_cashMC.textField, "Engravers MT", 15);
			setFontAttributes(_apMC.textField, "Eras Bold ITC", 24);
			setFontAttributes(_apMC.timer, "Engravers MT", 10);
			setFontAttributes(_apMC.addText, "Engravers MT", 7);
			setFontAttributes(_levelMC.levelTextField, "Eras Bold ITC", 24, 0xFAD904);
			setFontAttributes(_levelMC.textField , "Eras Bold ITC", 24);
			setFontAttributes(_statusTextField.textField , "Eras Bold ITC", 10);
			setFontAttributes(_descriptionTextField.textField , "Eras Bold ITC", 10);*/
			
			/*TextFieldUtility.initTextFontFormat(_fm.psErasDemiITC, _apMC.textField, _apMC.textField.defaultTextFormat);
			TextFieldUtility.initTextFontFormat(_fm.psEngraversMT, _apMC.addText, _apMC.addText.defaultTextFormat);
			TextFieldUtility.initTextFontFormat(_fm.psEngraversMT, _apMC.timer, _apMC.timer.defaultTextFormat);
			
			TextFieldUtility.initTextFontFormat(_fm.psErasDemiITC, _levelMC.textField, _levelMC.textField.defaultTextFormat);*/
		}
		
		public function setFontAttributes(textField:TextField, fontType:String, size:int = 5, color:int = 0):void{
			textField.defaultTextFormat = _fm.getTxtFormat (fontType, size, color);
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
		}
	
		/**
		 *	
		 * Initializes player status assets for display.
		 * 
		 */	
		
		public function initAssets():void{
			// character limit ui
			_characterLimitUI = new CharacterLimitUI();
			addChild(_characterLimitUI);
			_characterLimitUI.x = 631.45;
			_characterLimitUI.y = 79.95;
			_characterLimitUI.hired.mouseEnabled = false;
			_characterLimitUI.limit.mouseEnabled = false;
			
			var charLimitOffsetX:int = 280;
			var charLimitOffsetY:int = 70
			
			var charLimitParam = {
				x:0.5,
				y:0,
				offsetX:charLimitOffsetX,
				offsetY:charLimitOffsetY
			}
			new FluidObject(_characterLimitUI, charLimitParam );
			
			//_characterLimitUI.alpha = 0;
			
			// helping energy
			_helpingEnergyMC = new HelpingEnergyMC();
			addChild(_helpingEnergyMC);
			_helpingEnergyMC.x = 8.50;
			_helpingEnergyMC.y = 200;
			_helpingEnergyMC.textField.text = "5";
			_helpingEnergyMC.textField.mouseEnabled = false;
			_helpingEnergyMC.alpha = 0;
			
			// heart
			_redStarMC = new RedStarMC();
			addChild(_redStarMC);
			_redStarMC.x = _starXPos; 
			//_redStarMC.x = 8.5;
			//_redStarMC.y = 104.85;
			_redStarMC.y = _starYPos;
			_redStarMC.textField.text = "1";
			_redStarMC.textField.mouseEnabled = false;
			_redStarMC.statusBar.scaleX = 0;
			_redStarMC.alpha = 0;
			
			// blackheart
			_blackStarMC = new BlackStarMC();
			addChild(_blackStarMC);
			_blackStarMC.x = _starXPos;
			//_blackStarMC.y = 104.85;
			_blackStarMC.y = _starYPos;
			_blackStarMC.textField.mouseEnabled = false;
			_blackStarMC.textField.text = "1";
			_blackStarMC.statusBar.scaleX = 0;
			_blackStarMC.alpha = 0; 
			
			//coins
			_coinMC = new CoinMC();
			addChild(_coinMC);
			//_coinMC.x = 4.85;
			//_coinMC.y = 11.85;
			_coinMC.textField.text = "0";
			_coinMC.textField.mouseEnabled = false;
			
			
			var coinOffsetX:int = -370;
			var coinOffsetY:int = 11.85;
			
			var coinParam = {
				x:0.5,
				y:0,
				offsetX:coinOffsetX,
				offsetY:coinOffsetY
			}
			new FluidObject(_coinMC,coinParam );
			
			//cash
			_cashMC = new CashMC();
			addChild(_cashMC);
			//_cashMC.x = 179;
			//_cashMC.y = 1;
			_cashMC.textField.text = "0";
			_cashMC.textField.mouseEnabled = false;
			
			var cashOffsetX:int = -180;
			var cashOffsetY:int = 1;
			
			var cashParam = {
				x:0.5,
				y:0,
				offsetX:cashOffsetX,
				offsetY:cashOffsetY
			}
			new FluidObject(_cashMC,cashParam );
			
			_levelMC = new LevelMC();
			addChild(_levelMC);
			//_levelMC.x = 572.3;
			//_levelMC.y = 0.35;
			_levelMC.textField.text = "20";
			_levelMC.textField.mouseEnabled = false;
			_levelMC.levelTextField.text = "1";
			_levelMC.levelTextField.mouseEnabled = false;
			_levelMC.statusBar.scaleX = 0;
			
			var levelOffsetX:int = 220;
			var levelOffsetY:int = 0.35;
			
			var levelParam = {
				x:0.5,
				y:0,
				offsetX:levelOffsetX,
				offsetY:levelOffsetY
			}
			new FluidObject(_levelMC, levelParam );
			
			//var levelMcPosition:Point = _levelMC.localToGlobal( new Point( _levelMC.x, _levelMC.y ) );
			//_gd.levelMCPos = levelMcPosition;
			//trace( "[PlayerStatusUI xy check==============> ]: levelMcPosition", levelMcPosition.x, levelMcPosition.y );
			//trace( "[PlayerStatusUI xy check==============>]: _gd.levelMCPos",_gd.levelMCPos.x, _gd.levelMCPos.y );
			
			//action point
			_apMC = new APMC();
			addChild(_apMC);
			//_apMC.x = 371.3;
			//_apMC.y = 7.85;
			_apMC.textField.text = "0";
			_apMC.textField.mouseEnabled = false;
			_apMC.statusBar.scaleX = 0;
			_apMC.timer.text = "0:00";
			_apMC.timer.width = 50;
			_apMC.addText.width = 50;
			_apMC.timer.mouseEnabled = false;
			_apMC.addText.mouseEnabled = false;
			
			var apOffsetX:int = 10;
			var apOffsetY:int = 7.85;
			
			var apParam = {
				x:0.5,
				y:0,
				offsetX:apOffsetX,
				offsetY:apOffsetY
			}
			new FluidObject(_apMC,apParam );
			
			_countDownTimer = new CountdownTimer(1000);
			_countDownTimer.setMaxTime(0,2,0);
			_countDownTimer.start();
			_countDownTimer.setTextFieldOutput("", _apMC.timer);
			_countDownTimer.addEventListener(TimerEvent.TIMER, onTimerInterval);
	
			// tooltip
			_toolTip = new ToolTipMC();
			//_toolTip = TooltipCreator.createTooltip(3, ToolTipTop, ToolTipMid, ToolTipBottom);
			//_statusTextField = TooltipCreator.addTextField(_toolTip, "Value", "status", 5, 5);
			//_descriptionTextField = TooltipCreator.addTextField(_toolTip, "Decription", "description", 5, 22);
			
			_statusTextField = new ToolTipText();
			_toolTip.addChild(_statusTextField);
			_statusTextField.x = 5;
			_statusTextField.y = 5;
			_statusTextField.textField.text = "status";
			//_statusTextField.textField.width = 300;
			_statusTextField.mouseEnabled = false;
			_statusTextField.textField.multiline = true;
			_statusTextField.textField.height = 66;
			
			_descriptionTextField = new ToolTipText();
			_toolTip.addChild(_descriptionTextField);
			_descriptionTextField.x = 5;
			_descriptionTextField.y = 22;
			_descriptionTextField.textField.text = "description";
			//_descriptionTextField.textField.width = 300;
			_descriptionTextField.mouseEnabled = false;
			_descriptionTextField.textField.multiline = true;
			_descriptionTextField.textField.height = 66;
			
			///TextFieldUtility.initTextFontFormat(_fm.psErasDemiITC, _statusTextField.textField, _statusTextField.textField.defaultTextFormat);
			//TextFieldUtility.initTextFontFormat(_fm.psErasDemiITC, _descriptionTextField.textField, _descriptionTextField.textField.defaultTextFormat);
				
			_toolTip.alpha = 0;
			_toolTip.mouseChildren = false;
			_toolTip.mouseEnabled = false;
			_textFormat = new TextFormat ("Eras Demi ITC", 10);
			_textFormat.color = 0xFFFFFF;
			_textFormat.align = TextFormatAlign.JUSTIFY;
			addChild(_toolTip);			
		}
		
		/**
		 * 
		 * Fills the status bar of the corresponding movieclip based 
		 * on direction. Used for smooth tweening of status bar scale.
		 * 
		 * @param mc - the asset which contains the status bar to be moved.
		 * @param fillDir - the direction of bar fill (horizontal or vertical).
		 * @param percentage - the percentage of increase.
		 * 
		 */		
		
		public function fillType(mc:MovieClip, fillDir:int, percentage:Number):void{
			switch (fillDir){
				case GlobalData.HORIZONTAL:{
					TweenLite.to(mc.statusBar, .5,{scaleX:percentage, onComplete:checkUpdates, ease:Quad.easeInOut});
					break;
				}
				case GlobalData.VERTICAL:{
					TweenLite.to(mc.statusBar, .3,{scaleY:percentage, onComplete:checkUpdates, ease:Quad.easeInOut});
					break;
				}
			}
		}
		
		/**
		 * Checks for any updates. Called everytime one needs to
		 * check conditional change for status. 
		 * 
		 */		
		
		public function checkUpdates():void{
			checkStatus();
		}
		
		/**
		 * 
		 * Updates the fill of the status bar. 
		 *  
		 * @param mcType - the type of asset to be used.
		 * @param percentage - the rate of increase.
		 * @param fillDir - the direction of the fill either horizontal or vertical.
		 * 
		 */		
		
		public function updateFillBar(mcType:int , percentage:Number, fillDir:int):void{
			switch (mcType){
				case GlobalData.AP:{
					fillType(_apMC, fillDir, percentage);
					break;
				}
/*				case GlobalData.HOTPOINT:{
					fillType(_hotPointMC, fillDir, percentage);
					break;
				}
*/				case GlobalData.EXPERIENCE:{
					fillType(_levelMC, fillDir, percentage);
					break;
				}
				case GlobalData.REDSTAREXP:{
					fillType(_redStarMC, fillDir, percentage);
					break;
				}
				case GlobalData.BLACKSTAREXP:{
					fillType(_blackStarMC, fillDir, percentage);
					break;
				}
			}
		}
		
		/**
		 * 
		 * Set the scale base on the direction. Used for quick change of scale.
		 * 
		 * @param mcType - the type of asset to be used.
		 * @param percentage - the rate of increase.
		 * @param fillDir - the direction of the fill either horizontal or vertical.
		 * 
		 */		
		
		private function initStatusBar(mc:MovieClip, percentage:Number, type:int):void{
			switch (type){
				case GlobalData.HORIZONTAL:{
					mc.statusBar.scaleX = percentage;
					break;
				}
				case GlobalData.VERTICAL:{
					mc.statusBar.scaleY = percentage;
					break;
				}
			}
		}
		
		/**
		 *
		 * Adding of event listeners 
		 * 
		 */		
		
		private function addListeners():void{
			_coinMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_coinMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			_cashMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_cashMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			_apMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_apMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			_levelMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_levelMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			_characterLimitUI.addEventListener(MouseEvent.ROLL_OVER, onOver);
			_characterLimitUI.addEventListener(MouseEvent.ROLL_OUT, onOut);
			_coinMC.plus.addEventListener(MouseEvent.CLICK, onClick);
			_cashMC.plus.addEventListener(MouseEvent.CLICK, onClick);
			_apMC.plus.addEventListener(MouseEvent.CLICK, onClick);
			_countDownTimer.addEventListener(CountdownTimer.INTERVAL_ENDED, onTimerIntervalEnded);
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function setStarPositons(starType:int):void{
			switch(starType)
			{
				case GlobalData.REDSTAR:
				{
					_redStarMC.x = _starXPos; 
					_redStarMC.y = _starYPos;
					_blackStarMC.x = -1000; 
					_blackStarMC.y = -1000;		
					break;
				}	
				case GlobalData.BLACKSTAR:
				{
					_redStarMC.x = -1000; 
					_redStarMC.y = -1000;
					_blackStarMC.x = _starXPos;
					_blackStarMC.y = _starYPos;
					break;
				}	
			}
		}
		
		/**
		 * Adds listers for the redStarMC 
		 */
		
		public function addRedStarListeners():void{
			if (_redStarMC && _redStarMC != null){
				_redStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_redStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}			
		}

		
		/**
		 * Adds listeners for the redStarMC 
		 */
		
		public function removeRedStarListeners():void{
			if (_redStarMC && _redStarMC != null){
				_redStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_redStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		
		/**
		 * Removes listeners for the redStarMC 
		 */
		
		public function addBlackStarListeners():void{
			if (_blackStarMC && _blackStarMC != null){
				_blackStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_blackStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		/**
		 * Adds listeners for the redStarMC 
		 */
		
		public function removeBlackStarListeners():void{
			if (_blackStarMC && _blackStarMC != null){
				_blackStarMC.addEventListener(MouseEvent.ROLL_OVER, onOver);
				_blackStarMC.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		/**
		 * 
		 * @param ev - event handler when the user hover at a status.
		 * 
		 */		
		
		private function onOver(ev:Event):void{
			_statusTextField.textField.text = "";
			_descriptionTextField.textField.text = "";
			_toolTip.alpha = 1;
			_showTooltip = true;
			_toolTip.x = 0;
			_toolTip.y = 0;
			switch(ev.currentTarget)
			{
				case _coinMC:
				{
					_statusTextField.textField.text = "Coins: " + _coinMC.textField.text;
					_descriptionTextField.textField.text =  _statusDescription[GlobalData.COIN];
					_toolTip.x =  (_coinMC.x + (_coinMC.width - _toolTip.width)/2) ; //(_coinMC.x + _coinMC.width) + _toolTip.width;
					_toolTip.y = (_coinMC.y + _coinMC.height) + 5;
					break;
				}	
				case _cashMC:
				{
					_statusTextField.textField.text = "Starpoint: " + _cashMC.textField.text;
					_descriptionTextField.textField.text =  _statusDescription[GlobalData.STARPOINT];
					_toolTip.x = (_cashMC.x + (_cashMC.width - _toolTip.width)/2);
					_toolTip.y = (_cashMC.y + _cashMC.height) + 5;
					break;
				}	
				case _apMC:
				{
					_statusTextField.textField.text = "AP: " + _apMC.textField.text + "/" + _maxAP + "\n";
					_statusTextField.textField.appendText(_statusDescription[GlobalData.AP]);
					if (_countDownTimer.timeValue != "00:00"){
						_runTimerValue = true;
					}
					_toolTip.x = (_apMC.x + (_apMC.width - _toolTip.width)/2);
					_toolTip.y = (_apMC.y + _apMC.height) + 5;
					break;
				}	
				case _levelMC:
				{
					_statusTextField.textField.text = "Level: " + _levelMC.levelTextField.text;
					_statusTextField.textField.appendText("\nExp value: " + _levelMC.textField.text + "/" + _maxExp);
					_descriptionTextField.textField.text = "";
					_descriptionTextField.textField.text = "\n" + _statusDescription[GlobalData.EXPERIENCE];
					_toolTip.x = (_levelMC.x + (_levelMC.width - _toolTip.width)/2);
					_toolTip.y = (_levelMC.y + _levelMC.height) + 5;
					break;
				}
					
				/*case _hotPointMC:
				{
					_statusTextField.text = "Hot Points Value: \n" + Math.ceil(_hotPointMC.statusBar.scaleY * 100);
					_descriptionTextField.text = "\n" + _statusDescription[GlobalData.HOTPOINT];
					break;
				}	*/
				/*case _ticketMC:
				{
					_statusTextField.text = "Ticket Value: " + _ticketMC.textField.text;
					_descriptionTextField.text =  _statusDescription[GlobalData.TICKET];
					break;
				}*/
					
				case _redStarMC:
				{
					_statusTextField.textField.text = "RedStar Level: " + _redStarMC.textField.text + "\n";
					_statusTextField.textField.appendText ("RedStar Exp: " + GlobalData.instance.pRSExp % GlobalData.instance.redStarExpLimit + "/" + GlobalData.instance.redStarExpLimit);
					_descriptionTextField.textField.text =  "\n" + _statusDescription[GlobalData.REDSTARLVL];
					_toolTip.y = _redStarMC.y;
					_toolTip.x = (_redStarMC.x + _redStarMC.width) + 5;
					break;
				}
				case _blackStarMC:
				{
					_statusTextField.textField.text = "BlackStar Level: " + _blackStarMC.textField.text + "\n";
					_statusTextField.textField.appendText("BlackStar Exp: " + GlobalData.instance.pBSExp % GlobalData.instance.blackStarExpLimit + "/" + GlobalData.instance.blackStarExpLimit);
					_descriptionTextField.textField.text = "\n" + _statusDescription[GlobalData.BLACKSTARLVL];
					_toolTip.y = _blackStarMC.y;
					_toolTip.x = (_blackStarMC.x + _blackStarMC.width) + 5;
					break;
				}
				case _helpingEnergyMC:
				{
					_statusTextField.textField.text = "Helping Energy: " + _helpingEnergyMC.textField.text;
					_descriptionTextField.textField.text = "" + _statusDescription[GlobalData.HELPINGENERGY];
					_toolTip.y = _helpingEnergyMC.y;
					_toolTip.x = (_helpingEnergyMC.x + _helpingEnergyMC.width) + 5;
					break;
				}
				case _characterLimitUI:
				{
					_statusTextField.textField.text = "Character Hired: " + _characterLimitUI.hired.text + "\n";
					_statusTextField.textField.appendText("Character Limit: " + _characterLimitUI.limit.text);
					_descriptionTextField.textField.text = "\n" + _statusDescription[GlobalData.CHARACTERHIRED];
					_toolTip.x = (_characterLimitUI.x + (_characterLimitUI.width - _toolTip.width)/2) - 20;
					_toolTip.y = (_characterLimitUI.y + _characterLimitUI.height) + 5;
					break;
				}
			}
			
			
			_statusTextField.textField.setTextFormat(_textFormat);
			_descriptionTextField.textField.setTextFormat(_textFormat);
		}
		
		/**
		 * 
		 * @param ev - event handler when the user hovers out of any of the status images.
		 * 
		 */		
		
		private function onOut(ev:Event):void{
			_toolTip.alpha = 0;
			_showTooltip = false;
			_runTimerValue = false;
		}

		/**
		 * Countdown timer event handler for showing time text in seconds.
		 * 
		 * @param ev - event handler for the countdown timer;
		 * 
		 */	
		
		public function onTimerInterval (ev:TimerEvent):void{
			if (_runTimerValue){
				_descriptionTextField.textField.text = "\nMore in: " + _countDownTimer.timeValue;
				_descriptionTextField.textField.multiline = false;
				_descriptionTextField.textField.setTextFormat(_textFormat);
			}
		}
		
		/**
		 * 
		 * Event handler when timer interval has ended. Dispatches
		 * request for ap and add ap to the display.
		 * 
		 * @param ev - the event to be handled.
		 * 
		 */		
		
		private function onTimerIntervalEnded(ev:Event):void{
			trace ("ap check on timer interval ended: " + _gd.pAp)
			if (_gd.pAp < _maxAP){
				var currAP:int = _apMC.textField.text.split("/")[0];
				if (currAP < _maxAP){
					dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.ADD_AP))
					// temporary adding of values in the display (to be removed)
				}
			}
		}
		
		/**
		 *
		 * Event handler for mouse clicks and dispatches the corresponding event. 
		 *  
		 * @param ev - the event to be handled.
		 * 
		 */		
		
		private function onClick(ev:Event):void{
			switch(ev.target)
			{
				case _coinMC.plus:
				{
					EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.COIN_POPUP));
					break;
				}
					
				case _cashMC.plus:
				{
					EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.CASH_POPUP));
					break;
				}
			
				case _apMC.plus:
				{
					EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.AP_POPUP));
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
		 * Checks the status of the display and
		 * makes appropriate changes to the display.
		 * 
		 */		
		
		private function checkStatus():void{
			if (_apMC.statusBar.scaleX == 1){
				_apMC.plus.enabled = false;
				_apMC.plus.mouseEnabled = false;
				_apMC.plus.alpha = 0;
				_apMC.timer.alpha = 0;
				_apMC.addText.alpha = 0;
				_countDownTimer.stop();
			} else {
				_apMC.plus.enabled = true;
				_apMC.plus.mouseEnabled = true;
				_apMC.plus.alpha = 1;
				_apMC.timer.alpha = 1;
				_apMC.addText.alpha = 1;
				_countDownTimer.reset();
				_countDownTimer.start();
			}
			
			if (_levelMC.statusBar.scaleX >= 1){
				_levelMC.statusBar.scaleX = 0;
				_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.EXPERIENCE_MAXED));
			}
			if (_redStarMC.statusBar.scaleX >= 1){
				_redStarMC.statusBar.scaleX = 0;
				_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.REDSTAR_MAXED));
			} 
			if (_blackStarMC.statusBar.scaleX >= 1){
				_blackStarMC.statusBar.scaleX = 0;
				_es.dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.BLACKSTAR_MAXED));
			} 
		}
		
		/**
		 *
		 * Hides the display and removes any event listeners
		 * associated with this class. 
		 * 
		 */		
		
		public function hide():void{
			TweenLite.to(this, .3,{alpha:0});
			removeListener();
			removeRedStarListeners();
			removeBlackStarListeners();
		}
		
		/**
		 * 
		 * Removes event listeners. 
		 * 
		 */		
		
		public function removeListener():void{
			//_countDownTimer.stop();
			//_countDownTimer.removeListeners();
			
			_coinMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_coinMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_cashMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_cashMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_apMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_apMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_levelMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_levelMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_redStarMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_redStarMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_blackStarMC.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_blackStarMC.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			_characterLimitUI.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			_characterLimitUI.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			
			_coinMC.plus.removeEventListener(MouseEvent.CLICK, onClick);
			_cashMC.plus.removeEventListener(MouseEvent.CLICK, onClick);
			_apMC.plus.removeEventListener(MouseEvent.CLICK, onClick);
			//_countDownTimer.removeEventListener(CountdownTimer.INTERVAL_ENDED, onTimerIntervalEnded);
			//removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function removeOtherListeners():void{
			//removeEventListener(Event.ENTER_FRAME, onEnterFrame);

		}
		
		public function updateGUIPosition():void 
		{
			trace( "[PlayerStatusUI xy check==============> ]: update GUI position" );
			var levelMcPosition:Point = _levelMC.localToGlobal( new Point( _levelMC.x, _levelMC.y ) );
			_gd.levelMCPos = levelMcPosition;
			trace( "[PlayerStatusUI xy check==============> ]: levelMcPosition", levelMcPosition.x, levelMcPosition.y );
			trace( "[PlayerStatusUI xy check==============>]: _gd.levelMCPos",_gd.levelMCPos.x, _gd.levelMCPos.y );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//var playerStatusUIEvent:PlayerStatusEvent = new PlayerStatusEvent( PlayerStatusEvent.ON_PLAYER_STATUS_UI_ADDED_TO_STAGE ); 			
			//_es.dispatchESEvent( playerStatusUIEvent  );						
		}
	}
}