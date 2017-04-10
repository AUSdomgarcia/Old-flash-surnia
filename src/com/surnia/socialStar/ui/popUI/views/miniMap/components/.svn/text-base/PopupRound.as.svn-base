package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.CharacterPanel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author DF
	 */
	public class PopupRound extends MovieClip implements IPopup 
	{	
		public static const POPUP_GAME_SINGER:int = 1;
		public static const POPUP_GAME_BRAINSTORM:int = 2;
		public static const POPUP_GAME_RUNNINGMAN:int = 3;
		public static const POPUP_GAME_BESTCOUPLE:int = 4;
		public static const POPUP_GAME_MOVIESTAR:int = 5;
		
		private var _parentDisplay:DisplayObjectContainer;
		
		private var isOver:Boolean = false;				
		private var _parent:Sprite;
		
		public var roundMC:popupRoundMC;	
		public var npcMC:npcTestMC;
		
		public var roundCtr:int = 1;
		public var roundMax:int = 1;	
		public var maxCtr:int = 1;
		
		public var nameBuilding:String = "My Building";
		public var nameNPC:String = "NPC";
		
		private var _gameArray:Array = [];
		private var _currentFN:int;
		
		private var _activeScript:String = "No Script Available";
		private var _ap:int;
		private var _coin:int;
		private var _dur:int;
		
		private var _levelReq:int;
		
		public var _npcIsBoss:int;
		public var _npcRewardCoin:int;
		public var _npcRewardExp:int;		
		
		private var _npcDef:String;
		private var _npcActing:int;
		private var _npcHealth:int;
		private var _npcIntelligent:int;
		private var _npcLevel:int;
		private var _npcName:String;
		private var _npcAttraction:int;
		private var _npcSing:int;
		private var _npcGender:String;
		
		private var _playerLevel:int;		
	
		private var _bossFN:int;
		private var _isBossBattle:Boolean = false;
		public function PopupRound(parent:Sprite) 
		{
			_parent = parent;		

			initialize();	
			roundMC.buttonMC.buttonMode = true;		
			addListenersChallenger();
			//addListenersLeft();
		}
		
		private function initialize():void {
			roundMC = new popupRoundMC;		
			
			//npcMC  = new npcTestMC;			
			//roundMC.holderIconMC.addChild(npcMC);	
			
			roundMC.buttonMC.gotoAndStop(1);
			roundMC.arrowLeft.gotoAndStop(1);
			roundMC.arrowRight.gotoAndStop(1);
			roundMC.closeButton.gotoAndStop(1);
			roundMC.npc.gotoAndStop(1);
			this.addChild(roundMC);		
		}
		
		public function setNPC(npcNumber:int = 1):void {
			_bossFN = npcNumber;
			roundMC.npc.gotoAndStop(_bossFN);
		}
		
		public function addListenersChallenger():void {
			//Challenger Button
			roundMC.buttonMC.addEventListener(MouseEvent.ROLL_OVER, onButtonOver);
			roundMC.buttonMC.addEventListener(MouseEvent.ROLL_OUT, onButtonOut);
			roundMC.buttonMC.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
			roundMC.buttonMC.addEventListener(MouseEvent.MOUSE_UP, onButtonUp);
			
			//Close Button
			roundMC.closeButton.addEventListener(MouseEvent.ROLL_OVER, onCloseOver);
			roundMC.closeButton.addEventListener(MouseEvent.ROLL_OUT, onCloseOut);
			roundMC.closeButton.addEventListener(MouseEvent.MOUSE_DOWN, onCloseDown);
			roundMC.closeButton.addEventListener(MouseEvent.MOUSE_UP, onCloseUp);
			
			//arrow right
			roundMC.arrowRight.addEventListener(MouseEvent.ROLL_OVER, onButtonOverR);
			roundMC.arrowRight.addEventListener(MouseEvent.ROLL_OUT, onButtonOutR);
			roundMC.arrowRight.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDownR);
			roundMC.arrowRight.addEventListener(MouseEvent.MOUSE_UP, onButtonUpR);
			
			//arrow left
			roundMC.arrowLeft.addEventListener(MouseEvent.ROLL_OVER, onButtonOverL);
			roundMC.arrowLeft.addEventListener(MouseEvent.ROLL_OUT, onButtonOutL);
			roundMC.arrowLeft.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDownL);
			roundMC.arrowLeft.addEventListener(MouseEvent.MOUSE_UP, onButtonUpL);
		}
		
		public function removeListenersChallenger():void {
			
			roundMC.buttonMC.removeEventListener(MouseEvent.ROLL_OVER, onButtonOver);
			roundMC.buttonMC.removeEventListener(MouseEvent.ROLL_OUT, onButtonOut);
			roundMC.buttonMC.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
			//roundMC.buttonMC.removeEventListener(MouseEvent.MOUSE_UP, onButtonUp);
			
			//Close Button
			roundMC.closeButton.removeEventListener(MouseEvent.ROLL_OVER, onCloseOver);
			roundMC.closeButton.removeEventListener(MouseEvent.ROLL_OUT, onCloseOut);
			roundMC.closeButton.removeEventListener(MouseEvent.MOUSE_DOWN, onCloseDown);
			//roundMC.closeButton.removeEventListener(MouseEvent.MOUSE_UP, onCloseUp);
			
			//arrow right
			roundMC.arrowRight.removeEventListener(MouseEvent.ROLL_OVER, onButtonOverR);
			roundMC.arrowRight.removeEventListener(MouseEvent.ROLL_OUT, onButtonOutR);
			roundMC.arrowRight.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDownR);
			//roundMC.arrowRight.removeEventListener(MouseEvent.MOUSE_UP, onButtonUpR);
			
			//arrow left
			roundMC.arrowLeft.removeEventListener(MouseEvent.ROLL_OVER, onButtonOverL);
			roundMC.arrowLeft.removeEventListener(MouseEvent.ROLL_OUT, onButtonOutL);
			roundMC.arrowLeft.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDownL);
			//roundMC.arrowLeft.removeEventListener(MouseEvent.MOUSE_UP, onButtonUpL);
		}
		
		private function onButtonOver(e:MouseEvent):void {			
			if (isOver == false) {
				isOver = true;
				roundMC.buttonMC.gotoAndStop(2);
			}
		}
		private function onButtonOut(e:MouseEvent):void {			
			isOver = false;
			roundMC.buttonMC.gotoAndStop(1);
		}
		private function onButtonDown(e:MouseEvent):void {			
			isOver = false;
			roundMC.buttonMC.gotoAndStop(1);
		}
		
		private function onButtonUp(e:MouseEvent):void {
			//isOver = true;
			addListenersChallenger();
			dispatchGame();		
		}		
		
		private function onCloseOver(e:MouseEvent):void {			
			if (isOver == false) {
				isOver = true;
				roundMC.closeButton.gotoAndStop(2);
			}
		}
		private function onCloseOut(e:MouseEvent):void {			
			isOver = false;
			roundMC.closeButton.gotoAndStop(1);
		}
		private function onCloseDown(e:MouseEvent):void {			
			isOver = false;
			roundMC.closeButton.gotoAndStop(1);
		}
		
		private function onCloseUp(e:MouseEvent):void {
			var params:Object = new Object;			
			//isOver = true;
			addListenersChallenger();			
			_parent.dispatchEvent(new MapEvent(MapEvent.POPUP_CLOSE));
			//_parent.addListenerBuilding();
		}
		
		//----------------------------------------------------------------ARROW LEFT--------------------------------------------------------------
		
		private function onButtonOverL(e:MouseEvent):void {			
			if (isOver == false) {
				isOver = true;
				roundMC.arrowLeft.gotoAndStop(2);
			}
		}
		private function onButtonOutL(e:MouseEvent):void {		
			isOver = false;
			roundMC.arrowLeft.gotoAndStop(1);
		}
		private function onButtonDownL(e:MouseEvent):void {		
			isOver = false;
			roundMC.arrowLeft.gotoAndStop(1);
		}		
		private function onButtonUpL(e:MouseEvent):void {
			//isOver = true;
			addListenersChallenger();
			roundCtr--;			
			
			selectRound(roundCtr);			
		}
		
		//----------------------------------------------------------------ARROW RIGHT--------------------------------------------------------------		
		private function onButtonOverR(e:MouseEvent):void {			
			if (isOver == false) {
				isOver = true;
				roundMC.arrowRight.gotoAndStop(2);
			}
		}
		private function onButtonOutR(e:MouseEvent):void {		
			isOver = false;
			roundMC.arrowRight.gotoAndStop(1);
		}
		private function onButtonDownR(e:MouseEvent):void {		
			isOver = false;
			roundMC.arrowRight.gotoAndStop(1);
		}		
		private function onButtonUpR(e:MouseEvent):void {
			//isOver = true;
			addListenersChallenger();
			if(roundCtr < maxCtr){
				roundCtr++;		
			}			
			selectRound(roundCtr);				
		}		
		
		public function selectRound(value:int):void {			
			roundCtr = value;				
			
			if (roundCtr <= 1) {				
				roundCtr = 1
			}
			
			if (roundCtr >= roundMax ) {
				roundCtr = roundMax;
			}
			
			/*_levelReq		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDLVLREQ];				
			//roundMC.logoMC.gotoAndStop(_gameArray[roundCtr -1]);			
			_ap			 	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDAP];
			_dur		  	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDDURATION];
			_coin		 	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDCOIN];			
			
			_activeScript 	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDBOSSCRIPT];			
			_npcIsBoss		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCISBOSS];
			_npcRewardCoin	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCREWARDCOIN];
			_npcRewardExp	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCREWARDEXP];			
			_npcDef			= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCBODYDEF];
			_npcActing		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCACTING];
			_npcHealth		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCHEALTH];
			_npcIntelligent	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCINTELLIGENT];
			_npcLevel		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCLVL];
			_npcName		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCNAME];
			_npcAttraction	= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCNPCATTRACTION];
			_npcSing		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCSING];	
			_npcGender		= _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDNPCGENDER];			
			roundMC.logoMC.gotoAndStop(lookUpType(_gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDTYPE]));	*/
						
			if (roundCtr < roundMax) {			
			//if(_npcIsBoss == 0){
				roundMC.txtRound.text	 = "ROUND :" + String(roundCtr);
				_isBossBattle = false;
			}
			else {
				roundMC.txtRound.text	 = "BOSS ROUND";
				_isBossBattle = true;
			}
			
			if (roundCtr >= maxCtr) {
				roundMC.arrowRight.gotoAndStop(3);
				
				roundMC.arrowRight.removeEventListener(MouseEvent.ROLL_OVER, onButtonOverR);
				roundMC.arrowRight.removeEventListener(MouseEvent.ROLL_OUT, onButtonOutR);
				roundMC.arrowRight.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDownR);
				roundMC.arrowRight.removeEventListener(MouseEvent.MOUSE_UP, onButtonUpR);
			}else {
				roundMC.arrowRight.gotoAndStop(1);
				
				roundMC.arrowRight.addEventListener(MouseEvent.ROLL_OVER, onButtonOverR);
				roundMC.arrowRight.addEventListener(MouseEvent.ROLL_OUT, onButtonOutR);
				roundMC.arrowRight.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDownR);
				roundMC.arrowRight.addEventListener(MouseEvent.MOUSE_UP, onButtonUpR);
			}		
		}	
		
		public function emptyGameArray():void {	
			for (var i:int = _gameArray.length; i > 0; i-- ) {				
				_gameArray.pop();				
			}				
		}
		
		private function dispatchGame():void {		
			var params:Object = new Object;			
			
			params.ap			 = _ap;
			params.dur			 = _dur;
			params.coin			 = _coin;	
			params.bossScript	 = _activeScript;	
			
			params.levelReq		 = _levelReq;
			
			params.npcDef		 = _npcDef;			
			params.npcName		 = _npcName;	
			params.npcLevel		 = _npcLevel;
			params.npcGender	 = _npcGender;
			
			params.npcSing		 = _npcSing;
			params.npcHealth	 = _npcHealth;	
			params.npcActing	 = _npcActing;
			params.npcAttraction = _npcAttraction;
			params.npcIntelligent= _npcIntelligent;
			
			params.bossFN		 = _bossFN;
			params.bossBattle	 = _isBossBattle;
			
			params.npcIsBoss	 = _npcIsBoss;
			params.npcRewardCoin = _npcRewardCoin;
			params.npcRewardExp	 = _npcRewardExp;			
			
			//params.result = lookUpType(_gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDTYPE]);
			//params.result = _gameArray[roundCtr - 1][GlobalData.MAPBUILDING_ROUNDTYPE];
			_parent.dispatchEvent(new MapEvent(MapEvent.GAME_SELECT, params));			
		}		
		
		public function get popupResult():Boolean 
		{
			return true;
		}
		
		private function lookUpType(_type:String):int {
			var _fn:int;
			for (var i:int = 0; i < _gameArray.length; i++ ) {				
				switch(_type) {
					case CharacterPanel.PROGRAM_SINGING:
						_fn = 1;
					break;
					case CharacterPanel.PROGRAM_MOVIESTAR:
						_fn = 2;
					break;
					case CharacterPanel.PROGRAM_SUPERMODEL:
						_fn = 3;
					break;							
				}
			}		
			return _fn;
		}
		
		public function setContestData(building:Building, playerLevel:int = 1):void {			
			_gameArray = building.roundContest;
			_playerLevel = playerLevel;
			//_currentFN = building.currentGameFN;
			_currentFN = building.roundFinishTotal + building.roundOnGoingTotal;	
			trace(this, "RETURN roundFinishTotal:", building.roundFinishTotal);
			//roundFinishTotal
			
			roundMC.txtBuilding.text = building.nameBuilding;
			roundMC.txtNPC.text = building.nameNPC;
			
			setNPC(building.npcFN);
			//setRoundTypeFN();
			
			//ROUND FINISH
			//maxCtr = _currentFN;		
			maxCtr = checkLevelReq(_currentFN);
			//MAXIMUM ROUND
			roundMax = _gameArray.length;
			selectRound(maxCtr);
		}
		
		private function checkLevelReq(buildingIndex:int = 1):int {
			var _ctr:int = 0;
			var _lvlReq:int;
			trace(this, "RETURN buildingIndex:",buildingIndex, " _ctr:", _ctr );
			for (var i:int = 0; i < buildingIndex; i++ ) {
				//_lvlReq = _gameArray[i][GlobalData.MAPBUILDING_ROUNDLVLREQ];				
				if (_lvlReq > _playerLevel) {
					_ctr++;
				}
				trace(this, "RETURN _lvlReq:", _lvlReq, " _playerLevel:", _playerLevel ," _ctr:",_ctr);
			}
			buildingIndex = buildingIndex - _ctr;
			
			trace(this, "RETURN buildingIndex:",buildingIndex, " _ctr:", _ctr );
			return buildingIndex;
		}
		
		public function show(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void 
		{
			_parentDisplay = parentDisplay;			
			_parentDisplay.addChild(this);
			
			this.x = X;
			this.y = Y;		
			
			//var startValue:int = popupManager.arrayPopup[POPUP_ROUND].roundCtr;
			//trace(this, " ARRAY GAMES Lenght ", gameManager.arrayGames.length, " " , startValue );
			//popupManager.arrayPopup[POPUP_ROUND].selectRound(startValue);
		}
		
		public function remove():void 
		{						
			if (_parentDisplay != null) {			
				if (this != null) {						
					_parentDisplay.removeChild(this);
				}
			}			
		}
		
		public function get visibility():Boolean 
		{
			return true;
		}
		
	}

}