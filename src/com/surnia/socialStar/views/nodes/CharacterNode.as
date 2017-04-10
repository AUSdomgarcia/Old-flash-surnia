package com.surnia.socialStar.views.nodes
{
	import as3isolib.display.IsoSprite;
	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.interfaces.ICharacter;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUI;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUIEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.FriendInteractionPortraitPopup;
	import com.surnia.socialStar.utils.CountdownTimer;
	import com.surnia.socialStar.utils.randomNumberGen.RandomGen;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.characters.FemaleContestant;
	import com.surnia.socialStar.views.nodes.characters.MaleContestant;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import mx.core.MovieClipAsset;
	
	/**
	 * 
	 * @author Hedrick David
	 * 
	 */
	
	public class CharacterNode extends IsoSprite
	{
		public static const MALE:int = 1;
		public static const FEMALE:int = 0;
		
		public static const LEFT:int = 0;
		public static const RIGHT:int = 1;
		
		//  variables with getter setter 
		private var _xPos:int;
		private var _yPos:int;
		private var _zPos:int;
		private var _charID:String;
		private var _name:String;
		private var _characterLoaded:Boolean;
		private var _charDef:String;
		private var _gender:String = GlobalData.CONTESTANT_MALE;
		private var _charName:String = "Character: " + _charID;
		private var _grade:String;
		private var _animation:String; // the state of animation (based on the character animation constants). Used for actual animation calls
		private var _stressLevel:int; // level if stress up to 100
		private var _action:String; // the character action state (walking, idle, training)
		private var _expressionArray:Array = []; // the character emotion state (crying, normal or stressed)
		private var _popularity:int;
		private var _randomMode:Boolean = false;
		private var _trainingType:String;
		private var _trainingEntryID:String;
		private var _addedStressValue:int;
		private var _stressValueBeforeAdd:int;
		private var _bubbleTimeDelayMax:Number = 3000;
		private var _bubbleTimeDelayMin:Number = 2000;
		private var _trainingObject:IsoObject;
		private var _restObject:IsoObject;
		private var _selectable:Boolean = true;
		
		private var _isSelected:Boolean = false;
		private var _isOver:Boolean = false;
		private var _destination:Point = new Point();
		private var _moving:Boolean = false;
		private var _destinationReached:Boolean = false;
		private var _index:int;
		private var _progressBarActive:Boolean = false;
		private var _resting:Boolean = false;
		private var _tempRandStop:Boolean = true;
		
		private var _elementContainer:Sprite;
		private var _character:ICharacter;
		private var _progressBar:Sprite;
		private var _popupManager:PopUpUIManager = PopUpUIManager.getInstance();
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		private var _clickable:Boolean = true;
		
		private var _avatarUI:AvatarTooltipUI;
		private var _bubbleUI:Sprite; //todo: Change the class into actual bubbleUI class.
		private var _currentBubble:int = -1;
		private var _bubbleTimer:Timer;
		
		private var _restTimer:CountdownTimer;
		private var _restUI:TimeCounterMC02;
		
		private var _characterRestResume:Boolean = false;
		private var _isFlipped:Boolean = false;
		
		// test bubbles
		private var _bubble:Bubble;
		
		private var _levelUpAnimationMC:LevelUpAnimation; 
		private var _newCharacterAnimationMC:NewCharacterAnimation;
		
		private var _friendVisitPortrait:FriendInteractionPortraitPopup;
		private var _friendChallengePortrait:FriendInteractionPortraitPopup; 
		
		public function CharacterNode(gender:String)
		{
			_gender = gender;
			initDefault();
		}

		/**
		 * Destroys any related listeners and instances of elements
		 * 
		 */
		
		public function destroy():void{
			//removeEventListener(MouseEvent.MOUSE_DOWN, onCharacterClick);
			removeFriendPortraits();
		}
		
		private function removeFriendPortraits():void{
			_friendVisitPortrait.hide();
			_friendChallengePortrait.hide();
		}

		/**
		 * Adds listeners 
		 * 
		 */		
		public function addListeners():void{
			//_character.addEventListener(MouseEvent.MOUSE_DOWN, onCharacterClick);
		}
		
		/**
		 * Event handler for removing listeners.
		 * @param ev - avatar tooltip event
		 * 
		 */		
		
		public function onAvatarClose(ev:AvatarTooltipUIEvent = null):void{
			if (_avatarUI){
				TweenLite.to(_avatarUI, .3, {alpha:0, onComplete:hideAvatarUI});
			}
		}
		
		/**
		 * Init default instancing when character node is created. 
		 * 
		 */		
		
		public function initDefault():void{
			_friendVisitPortrait = new FriendInteractionPortraitPopup();
			_friendChallengePortrait = new FriendInteractionPortraitPopup();
			
			_elementContainer = new Sprite();
			if (_gender == GlobalData.CONTESTANT_MALE){
				_character = new MaleContestant();
				char.y = 20;
				sprites = [_friendChallengePortrait, _friendVisitPortrait, char, _elementContainer];
			} else {
				_character = new FemaleContestant();
				char.y = 20;
				sprites = [_friendChallengePortrait, _friendVisitPortrait, char, _elementContainer];
			}
			// default definitions
			_character.setDefinition("0202020202020202020202020202020202020202090909090909090909090909090909090909090905050505050505050505050505050505050505050808080808080808080808080808080808080808F160386D2C2CED8A4B792E2EFADCCCDB967C59A8632B3C2C595E38253025C67A64C67A64682C2DD06953DAE3C544453A000000000000000000000000000000000000000000000000");
			//addEventListener(MouseEvent.MOUSE_DOWN, onCharacterClick);
			addListeners();
		}
		
		public function levelUp():void{
			TweenLite.to(this, 2.3, {onComplete:initLevelUp});
		}
		
		private function initLevelUp():void{
			_levelUpAnimationMC = new LevelUpAnimation();
			_elementContainer.addChild(_levelUpAnimationMC);
			_levelUpAnimationMC.gotoAndPlay(1);
			_levelUpAnimationMC.x -= char.width / 1.5;
			_levelUpAnimationMC.y -= char.height * 1.5;
			_levelUpAnimationMC.addEventListener(Event.ENTER_FRAME, onLevelFrameCheck);
		}
		
		private function onLevelFrameCheck(ev:Event):void{
			if (_levelUpAnimationMC.currentFrame == _levelUpAnimationMC.totalFrames){
				_levelUpAnimationMC.removeEventListener(Event.ENTER_FRAME, onLevelFrameCheck);
				_elementContainer.removeChild(_levelUpAnimationMC);
				_levelUpAnimationMC = null;
			}
		}
		
		public function getFacing():int{
			return _character.getFacing();
		}
		
		public function characterFlip():void{
			var char:MovieClip = _character as MovieClip;
			if (char.scaleX == 1){
				char.scaleX = -1;
			} else {
				char.scaleX = 1;
			}
		}
		
		public function newCharacterAnimation():void{
			TweenLite.to(this, .7, {onComplete:initNewCharacterAnimation});
		}
		
		private function initNewCharacterAnimation():void{
			_newCharacterAnimationMC = new NewCharacterAnimation();
			_elementContainer.addChild(_newCharacterAnimationMC);
			_newCharacterAnimationMC.gotoAndPlay(1);
			_newCharacterAnimationMC.x -= char.width / 2;
			_newCharacterAnimationMC.y -= char.height; 
			_newCharacterAnimationMC.addEventListener(Event.ENTER_FRAME, onNewCharacterFrameCheck);
		}
		
		private function onNewCharacterFrameCheck(ev:Event):void{
			if (_newCharacterAnimationMC.currentFrame == _newCharacterAnimationMC.totalFrames){
				_newCharacterAnimationMC.removeEventListener(Event.ENTER_FRAME, onNewCharacterFrameCheck);
				_elementContainer.removeChild(_newCharacterAnimationMC);
				_newCharacterAnimationMC = null;
			}
		}
		
		public function showHelpInteractionPortrait(entry:String, routeData:Array, isChallenge:Boolean, fbid:String):void{
			_friendVisitPortrait.show(entry, routeData, char.height, isChallenge, fbid);
			_friendVisitPortrait.hide();
			_friendVisitPortrait.show(entry, routeData, char.height, isChallenge, fbid);
		}
		
		public function showChallengeInteractionPortrait(entry:String, routeData:Array, isChallenge:Boolean, fbid:String):void{
			_friendChallengePortrait.show(entry, routeData, char.height, isChallenge, fbid);
			_friendChallengePortrait.hide();
			_friendChallengePortrait.show(entry, routeData, char.height, isChallenge, fbid);
		}
		
		public function hideHelpInteractionPortrait(tweening:Boolean = false):void{
			_friendVisitPortrait.hide(tweening);
		}
		
		public function hideChallengeInteractionPortrait(tweening:Boolean = false):void{
			_friendChallengePortrait.hide(tweening);
		}
		
		/**
		 * Checks if there exists a status for the character
		 * @param type
		 * 
		 */ 
		
		public function addStatus(type:String):void{
			if (!checkIfExpressionExists(type)){
				_expressionArray.push(type);
				removeBubble();
				showBubble();
			}
		}
		
		public function removeStatus(type:String):void{
			var len:int = _expressionArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_expressionArray[i] == type){
					_expressionArray.splice(i,1);
					break;
				}
			}
			if (_expressionArray.length == 0){
				hideBubbleUI();
				//stopBubbles();
			}
		}
		
		public function checkIfExpressionExists(type:String):Boolean{
			var len:int = _expressionArray.length;
			for (var i:int = 0; i < len; i++)
			{
				if (_expressionArray[i] == type){
					return true;
				}
			}
			return false;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// CountDownTimer
		
		public function startRestTimer(duration:int):void{
			// disable the status of the bubbles above the character
			removeBubble();
			
			_restTimer = new CountdownTimer(1000);
			_restTimer.setMaxTime(duration);
			_restTimer.addEventListener(TimerEvent.TIMER, onRestTimerUpdate);
			_restTimer.addEventListener(CountdownTimer.INTERVAL_ENDED, onCountDownIntervalEnded);
			_restTimer.start();
			_restUI = new TimeCounterMC02();
			_elementContainer.addChild(_restUI);
			_restUI.alpha = 0;
			TweenLite.to(_restUI, .3, {alpha:1});
			_restUI.timeTextField.text = "";
			_restUI.x -= _restUI.width / 2;
			_restUI.y -= 120;
			_restUI.timeTextField.text = "READY: " + _restTimer.timeValue;
		}
		
		private function onCountDownIntervalEnded(ev:Event):void{
			_es.dispatchEvent(new CharacterNodeEvent(CharacterNodeEvent.CHARACTER_RESTTIMERDONE, {charNode:this}));
		}
		
		private function onRestTimerUpdate(ev:TimerEvent):void{
			_restUI.timeTextField.text = "READY: " + _restTimer.timeValue;
		}
		
		public function stopRestTimer():void{
			// restore the status of the bubbles above the character
			showBubble();
			if( _restUI != null ){
				TweenLite.to(_restUI, .3, {alpha:0, onComplete:removeRestUI});
				_restTimer.stop();
				_restTimer.removeListeners();
				_restTimer.removeEventListener(TimerEvent.TIMER, onRestTimerUpdate);
				_restTimer.removeEventListener(CountdownTimer.INTERVAL_ENDED, onCountDownIntervalEnded);
			}
		}
		
		public function removeRestUI():void {
			TweenLite.killTweensOf( _restUI )
			_elementContainer.removeChild(_restUI);
			_restUI = null;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Bubble instancing and effects
		
		public function removeBubble():void{
				//stopBubbles();
				hideBubbleUI();
		}
		
		public function showBubble():void{
			if (_expressionArray.length != 0){
				showBubbleUI();
				//startBubbles();
			}
		}
		
		private function startBubbles():void{
			if (!_bubbleTimer){
				_bubbleTimer = new Timer(RandomGen.randomNumbers(_bubbleTimeDelayMax, _bubbleTimeDelayMin, false));
				_bubbleTimer.start();
				_bubbleTimer.addEventListener(TimerEvent.TIMER, onBubbleTimerUpdate);
			}
		}
		
		private function stopBubbles():void{
			if (_bubbleTimer){
				_bubbleTimer.stop();
				_bubbleTimer.removeEventListener(TimerEvent.TIMER, onBubbleTimerUpdate);
				_bubbleTimer = null;
			}
		}
		
		private function onBubbleTimerUpdate(ev:TimerEvent):void{
			removeBubble();
			showBubble();
			ev.target.delay = RandomGen.randomNumbers(_bubbleTimeDelayMax, _bubbleTimeDelayMin, false);
		}
		
		public function addHoveringTextField(textType:String, text:String = "", delay:Number = .3):void{
			var hoverTextField:BubbleTextField = new BubbleTextField();
			var textFormat:TextFormat = new TextFormat();
			textFormat.align = TextFormatAlign.LEFT;
			
			_elementContainer.addChild(hoverTextField);
			hoverTextField.typeTextField.width = 300;
			hoverTextField.valueTextField.width = 300;
			//hoverTextField.typeTextField.alpha = 0;
			//hoverTextField.valueTextField.alpha = 0;
			hoverTextField.alpha = 0
			hoverTextField.typeTextField.text = textType + "";
	
			if( text != null  ){
				hoverTextField.valueTextField.text = text;
			} else {
				hoverTextField.valueTextField.text = "Down";
			}
			
			hoverTextField.valueTextField.x = hoverTextField.typeTextField.textWidth + 7;
			hoverTextField.x -= (hoverTextField.typeTextField.textWidth + hoverTextField.valueTextField.textWidth)/2;
			hoverTextField.y = -130;
			
			var arr:Array = [hoverTextField];
			TweenLite.to(hoverTextField, 1, {alpha:1 , y:hoverTextField.y-30, delay:delay, onComplete:hideHoverTextField, onCompleteParams:arr});
			hoverTextField.valueTextField.setTextFormat(textFormat);
			hoverTextField.typeTextField.setTextFormat(textFormat);
		}
		
		private function hideHoverTextField(hoverTextField:BubbleTextField):void{
			var arr:Array = [hoverTextField];
			TweenLite.to(hoverTextField, .3, {alpha:0, onComplete:removeHoverTextField, onCompleteParams:arr});
		}
		
		private function removeHoverTextField(hoverTextField:BubbleTextField):void{
			_elementContainer.removeChild(hoverTextField);
			hoverTextField = null;
		}
		
		public function addStressTextField(value:Number = 0, delay:Number = .3):void{
			if (_stressLevel <= 100 && _stressLevel >= 0){
				var stressTextField:BubbleTextField = new BubbleTextField();
				var textFormat:TextFormat = new TextFormat();
				textFormat.align = TextFormatAlign.LEFT;
				_elementContainer.addChild(stressTextField);
				stressTextField.typeTextField.width = 300;
				stressTextField.valueTextField.width = 300;
				stressTextField.alpha = 0;				
				
				if (value>0){
					stressTextField.typeTextField.text = GlobalData.TFTYPE_STRESS + " ";
					stressTextField.valueTextField.text = "+" + value;
				} else {
					stressTextField.typeTextField.text = GlobalData.TFTYPE_STRESS + " ";
					stressTextField.valueTextField.text = "" + value;
				}
				stressTextField.valueTextField.x = stressTextField.typeTextField.textWidth + 7;
				stressTextField.x -= (stressTextField.typeTextField.textWidth + stressTextField.valueTextField.textWidth)/2;
				stressTextField.y = -130;
				var arr:Array = [stressTextField];
				TweenLite.to(stressTextField, 1, {alpha:1, y:stressTextField.y-30, delay:delay, onComplete:hideStressTextField, onCompleteParams:arr});
				stressTextField.valueTextField.setTextFormat(textFormat);
				stressTextField.typeTextField.setTextFormat(textFormat);
			}
		}
		
		private function hideStressTextField(stressTextField:BubbleTextField):void{
			var arr:Array = [stressTextField];
			TweenLite.to(stressTextField, .3, {alpha:0, onComplete:removeStressTextField, onCompleteParams:arr});
		}
		
		private function removeStressTextField(stressTextField:BubbleTextField):void{
			_elementContainer.removeChild(stressTextField);
			stressTextField = null;
		}

		public function addStressLevel(value:int):void{
			_stressLevel += value;
			if (_stressLevel <= 0){
				_stressLevel = 0;
			} else if (_stressLevel >= 100){
				_stressLevel = 100;
			}
		}
		
		/**
		 * add remove ui
		 */		
		
		public function showAvatarUI():void {
			//swifer
			GlobalData.instance.currentCharId = _charID;
			//swifer
			
			var Xpos:Number = GlobalData.instance.GameStage.mouseX;
			var Ypos:Number = GlobalData.instance.GameStage.mouseY;
			var widthTotal:Number = width + 121;
			var heightTotal:Number = height + 121;
			var currWidthPercentage:Number = (Xpos + widthTotal) / GlobalData.GAME_WIDTH;
			var currHeightPercentage:Number = (Ypos + heightTotal) / (GlobalData.GAME_HEIGHT - 300);
			//if (currWidthPercentage > currHeightPercentage){
				if (Xpos + widthTotal  > GlobalData.GAME_WIDTH){
					Xpos -= widthTotal;
				} else {
					Xpos += width;
				}
			/*} else {
				if (Ypos - heightTotal < 0 + heightTotal ){
					Ypos += heightTotal;
				} else {
					if (Ypos - heightTotal < 0 + heightTotal){
						Ypos -= height ;
					} else {
						Ypos -= heightTotal * 2 ;
					}
				}
			}*/
			
			/*if ( xPos > 700 ) {
				Xpos -= 300;
			}else if ( GlobalData.instance.GameStage.mouseX < 50 ) {
				Xpos += 300;
			}*/
			
			//Xpos += 300 * _gd.gridSize;
			//Ypos += 300 * _gd.gridSize;
			
			/*if ( xPos > 600 ) {
				Ypos -= 100;
			}else if ( xPos < 50 ) {
				Ypos = 100;
			}	*/		
			
			_popupManager.loadWindow( WindowPopUpConfig.AVATAR_TOOL_WINDOW  ,0,0,false, Xpos, Ypos );
			
			//removeBubble();
		
			/*
			if (!_avatarUI){
				removeBubble();
				_avatarUI = new AvatarTooltipUI(_charID);
				_elementContainer.addChild(_avatarUI);
				_avatarUI.alpha = 0;
				TweenLite.to(_avatarUI, .3, {alpha:1});
				_avatarUI.x -= _avatarUI.width /2;
				_avatarUI.y = -260;
				
				if (y < _avatarUI.height){
					_avatarUI.y = 20;
				}
				
				//_avatarUI.y -= 30;
				_es.addEventListener(AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT, onAvatarClose);
				_es.dispatchEvent(new CharacterNodeEvent (CharacterNodeEvent.CHARACTER_AVATARUI_SHOW, {charNode:this}));
			
			}*/
		}
		
		public function hideAvatarUI():void{
			/*if (_avatarUI){
				showBubble();
				_elementContainer.removeChild(_avatarUI);
				_avatarUI = null;
				_es.removeEventListener(AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT, onAvatarClose);
				_es.dispatchEvent(new CharacterNodeEvent (CharacterNodeEvent.CHARACTER_AVATARUI_HIDE, {charNode:this}));
			}*/
			
			_popupManager.removeWindow(WindowPopUpConfig.AVATAR_TOOL_WINDOW);
		}
		
		private function showBubbleUI():void{
			if (!_bubble && _expressionArray.length >0){
				_bubble = new Bubble();
				_elementContainer.addChild(_bubble);
				_bubble.x -= 10;
				_bubble.y -= 140;
				_bubble.alpha = 1;
				_bubble.stop();
				//_currentBubble += 1;
				
				/*
				if (_currentBubble >= _expressionArray.length){
					_currentBubble = 0;
				}*/
				//TweenLite.to(_bubble, .3, {alpha:1, delay:0});
				
				//filterExpression(GlobalData.CHARACTER_EXPRESSION_CRY)
				expressionHierarchy(_bubble);
			}
		}
		
		private function expressionHierarchy(bubble:Bubble):void{
			if (checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY)){
				bubble.gotoAndStop(filterExpression(GlobalData.CHARACTER_EXPRESSION_CRY));
			} else if (checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED)){
				bubble.gotoAndStop(filterExpression(GlobalData.CHARACTER_EXPRESSION_STRESSED));
			}
		}
		
		public function bubbleVisiblity(value:Boolean):void{
			if (_bubble){
				_bubble.visible = value;
			}
		}
		
		private function filterExpression(expression:String):int{
			switch(expression)
			{
				case GlobalData.CHARACTER_EXPRESSION_CRY:
				{
					return 2;
					break;
				}
				case GlobalData.CHARACTER_EXPRESSION_STRESSED:
				{
					return 1;
					break;
				}
			}
			trace ("should return an int expression greater than 0");
			return 0;
		}
		
		private function hideBubbleUI():void{
			if (_bubble){
				TweenLite.to(_bubble, 0, {alpha:0, onComplete:removeBubbleUI});
			}
		}
		
		private function removeBubbleUI():void{
			_elementContainer.removeChild(_bubble);
			_bubble = null;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Selection of characters
		
		/**
		 * Updates on selection of characters 
		 */
		
		public function set selected(value:Boolean):void{
			if (value && selectable){
				_isSelected = value;
				setSelectionFilter(value);
			} else if (!value){
				_isSelected = value;
				setSelectionFilter(value);
			}
		}
		
		public function setSelectionFilter(value:Boolean = false):void{
			if (value){
				(_character as MovieClip).filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 48 )] 
			} else {
				(_character as MovieClip).filters = [];
			}
		}
		
		public function get selected():Boolean{
			return _isSelected;
		}
		
		public function setOverFilter(value:Boolean = false):void{
			if (!selected){
				if (value){
					(_character as MovieClip).filters = [new GlowFilter( 0xEEEEE0, 1, 4, 4, 48 )]
				} else {
					(_character as MovieClip).filters = [];
				}
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Animation of character
		
		public function setCharacterAnimation(animType:String, duration:Number):void{
			_character.setAnimation(animType, duration);
		}
		
		/**
		 * Getter and Setters
		 * 
		 */
		
		public function get tempRandStop()
		{
			return _tempRandStop;
		}
		
		public function set tempRandStop(value:Boolean):void
		{
			_tempRandStop = value;
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		public function set selectable(value:Boolean):void
		{
			_selectable = value;
		}
		
		public function get over():Boolean
		{
			return _isOver;
		}
		
		public function set over(value:Boolean):void
		{
			_isOver = value;
			setOverFilter(value);
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}

		
		public function get resting():Boolean
		{
			return _resting;
		}
		
		public function set resting(value:Boolean):void
		{
			_resting = value;
		}
		
		public function get stressValueBeforeAdd():int
		{
			return _stressValueBeforeAdd;
		}
		
		public function set stressValueBeforeAdd(value:int):void
		{
			_stressValueBeforeAdd = value;
		}
		
		public function get restObject():IsoObject
		{
			return _restObject;
		}
		
		public function set restObject(value:IsoObject):void
		{
			_restObject = value;
		}
		
		public function get trainingObject():IsoObject
		{
			return _trainingObject;
		}
		
		public function set trainingObject(value:IsoObject):void
		{
			_trainingObject = value;
		}
		
		public function get addedStressValue():int
		{
			return _addedStressValue;
		}
		
		public function set addedStressValue(value:int):void
		{
			_addedStressValue = value;
		}

		public function get trainingEntryID():String
		{
			return _trainingEntryID;
		}
		
		public function set trainingEntryID(value:String):void
		{
			_trainingEntryID = value;
		}
		
		public function get trainingType():String
		{
			return _trainingType;
		}
		
		public function set trainingType(value:String):void
		{
			_trainingType = value;
		}
		
		public function get randomMode():Boolean
		{
			return _randomMode;
		}
		
		public function set randomMode(value:Boolean):void
		{
			_randomMode = value;
		}
		
		public function get popularity():int
		{
			return _popularity;
		}
		
		public function set popularity(value:int):void
		{
			_popularity = value;
		}
		
		public function get grade():String
		{
			return _grade;
		}
		
		public function set grade(value:String):void
		{
			_grade = value;
		}
		
		public function get expression():Array
		{
			return _expressionArray;
		}
		
		public function set expression(value:Array):void
		{
			_expressionArray = value;
		}
		
		public function get action():String
		{
			return _action;
		}
		
		public function set action(value:String):void
		{
			_action = value;
		}
		
		public function get stressLevel():int
		{
			return _stressLevel;
		}
		
		public function set stressLevel(value:int):void
		{
			if (value < 100 && value >0){
				_stressLevel = value;
			} else if (value <= 0){
				_stressLevel = 0;
			} else if (value >= 100){
				_stressLevel = 100;
			}
		}
	
		public function get progressBarActive():Boolean
		{
			return _progressBarActive;
		}
		
		public function set progressBarActive(value:Boolean):void
		{
			_progressBarActive = value;
		}
		
		public function get elementContainer():Sprite
		{
			return _elementContainer;
		}
		
		public function set elementContainer(value:Sprite):void
		{
			_elementContainer = value;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get destinationReached():Boolean
		{
			return _destinationReached;
		}
		
		public function set destinationReached(value:Boolean):void
		{
			_destinationReached = value;
		}
		
		public function get moving():Boolean
		{
			return _moving;
		}
		
		public function set moving(value:Boolean):void
		{
			_moving = value;
		}
		
		public function set destination(point:Point):void{
			_destination = point;
		}
		
		public function get destination():Point{
			return _destination;
		}
		
		public function set character(value:ICharacter):void
		{
			_character = value;
		}
		
		public function get animation():String
		{
			return _animation;
		}
		
		public function set animation(value:String):void
		{
			_animation = value;
		}
		
		public function get charName():String
		{
			return _charName;
		}
		
		public function set charName(value:String):void
		{
			_charName = value;
		}
		
		public function get gender():String
		{
			return _gender;
		}
		
		/**
		 * 0 for male, 1 for female
		 */		
		
		public function set gender(value:String):void
		{
			_gender = value;
		}
		
		public function get charDef():String
		{
			return _charDef;
		}
		
		/**
		 * DNA String that defines the apparels and accessories of the characters
		 */	
		
		public function set charDef(value:String):void
		{
			_charDef = value;
			_character.setDefinition(_charDef);
		}
		
		public function get charID():String
		{
			return _charID;
		}
		
		public function set charID(value:String):void
		{
			_charID = value;
		}
		
		public function get zPos():int
		{
			return _zPos;
		}
		
		public function set zPos(value:int):void
		{
			_zPos = value;
		}
		
		public function get yPos():int
		{
			return _yPos;
		}
		
		public function set yPos(value:int):void
		{
			_yPos = value;
		}
		
		public function get xPos():int
		{
			return _xPos;
		}
		
		public function set xPos(value:int):void
		{
			_xPos = value;
		}
		
		public function get clickable():Boolean
		{
			return _clickable;
		}
		
		public function set clickable(value:Boolean):void
		{
			_clickable = value;
		}
		
		public function get isFlipped():Boolean
		{
			return _isFlipped;
		}
		
		public function set isFlipped(value:Boolean):void
		{
			_isFlipped = value;
		}
		
		public function get characterRestResume():Boolean
		{
			return _characterRestResume;
		}
		
		public function set characterRestResume(value:Boolean):void
		{
			_characterRestResume = value;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Get character
		
		public function get char():MovieClip{
			return _character as MovieClip;
		}
	}
}