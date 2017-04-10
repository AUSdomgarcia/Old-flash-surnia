package com.surnia.socialStar.ui.popUI.views.characterPanel 
{
	import com.surnia.socialStar.ui.popUI.views.characterPanel.data.CharListModel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.view.CharListView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author DF
	 */
	public class CharacterPanel extends Sprite
	{		
	/*------------------------------------------------------------------------------------------------------------
	 *												CONSTANTS
	 * ----------------------------------------------------------------------------------------------------------*/
		public static const CHALLENGE_FRIEND_MODE:int = 0;
		public static const CHALLENGE_STORY_MODE:int = 1;
		
		public static const PROGRAM_SINGING:String = "singing";
		public static const PROGRAM_MOVIESTAR:String = "acting";
		public static const PROGRAM_SUPERMODEL:String = "modeling";
	/*------------------------------------------------------------------------------------------------------------
	 *												VARIABLE	
	 * ----------------------------------------------------------------------------------------------------------*/
		private var _model:CharListModel;	
		private var _view:CharListView;
	
		private var _function:Function;
		private var _closeFunction:Function;
		
		private var _onStagePresent:Boolean = true;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR	
		 * ----------------------------------------------------------------------------------------------------------*/
		public function CharacterPanel() 
		{			
			_onStagePresent = true;
			
			trace(this, "CHAR XML DATA COMPLETE 3!")
			initialization();	
			_model.addEventListener(CharacterPanelEvent.LOAD_COMPLETE, onLoadComplete);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
			
		}		
		
		private function onLoadComplete(e:CharacterPanelEvent):void 
		{
			trace(this, "RETURN CHAR LIST DATA LOAD COMPLETE!");
			
			_model.removeEventListener(CharacterPanelEvent.LOAD_COMPLETE, onLoadComplete);			
			this.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.LOAD_COMPLETE));		
		}
				
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			nullAllInstances();
			_model = new CharListModel;				
			_view = new CharListView(_model);
			_model.dispatchCharLoadComplete();
			
			addChild(_view);		
		}
		
		public function nullAllInstances():void {
			trace("CLEAN :", this)
			if (_view != null) {
				if (this.contains(_view)) {	
					_view.nullAllInstances();
					removeChild(_view);						
				}				
				_view = null;					
			}	
			
			if (_model !=null) {
				_model.removeListener();
				_model = null;
			}		
		}	
		
		private function lookUpType(_type:String):int {
			var _fn:int;							
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
			return _fn;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/		
		//SET RIVAL STAT		
		public function setRivalStat(_charLevel:int = 1,_charActing:int = 1,_charAttraction:int = 1,_charHealth:int = 1,_charIntelligence:int = 1,_charSing:int = 1,_charGender:String = "Male",_charName:String = "NoName",_definition:String = "01",_charStress:int = 1,_charCondition:int = 1,_charGrade:int = 1,_charPopular:int = 1,_charExp:int = 1):void {
			if(_onStagePresent == true){
				_view.setRival(_charLevel,_charPopular, _charStress, _charActing, _charAttraction, _charCondition, _charGrade, _charHealth, _charIntelligence, _charSing, _charExp, _charGender, _charName,_definition);	
			}
		}	
		
		//SET BOSS STAT
		public function setBossStat(_bossType:int = 0, _charLevel:int = 1,_charActing:int = 1,_charAttraction:int = 1,_charHealth:int = 1,_charIntelligence:int = 1,_charSing:int = 1,_charName:String = "NoName", _scaleX:Number = .7, _scaleY:Number = .7, _definition:String = "01",_charStress:int = 1,_charCondition:int = 1,_charGrade:int = 1,_charPopular:int = 1,_charExp:int = 1):void {
			if(_onStagePresent == true){
				_view.setBossNPC(_bossType, _charLevel,_charPopular, _charStress, _charActing, _charAttraction, _charCondition, _charGrade, _charHealth, _charIntelligence, _charSing, _charExp, "No Gender", _charName, _scaleX, _scaleY, _definition);	
			}
		}
		
		//SET MODE (CHALLENGE_FRIEND/CHALLENGE_WORLD)		
		public function setMode(mode:int = CharacterPanel.CHALLENGE_FRIEND_MODE):void {		
			if(_onStagePresent == true){
				_view.setMode(mode);
			}
		}		
		
		public function removeRival():void {
			if ( _view != null ) {
				_view.removeRival();
			}
		}
		
		//SET LOGO GAME TYPE	
		public function setGameProgram(gameType:String = CharacterPanel.PROGRAM_SINGING):void {
			trace(this, "RETURN gameType:", gameType);
			if(_onStagePresent == true){
				_view.setGameProgram(lookUpType(gameType));
			}
		}		
		
		//SET LOGO GAME TYPE NUMBER	
		public function setGameProgramNumber(gameType:int = 0):void {
			gameType++;
			trace(this, "RETURN gameType number:", gameType);
			if(_onStagePresent == true){
				_view.setGameProgram(gameType);
			}
		}	
		
		//SET NPC BOSS SCRIPT
		public function setBossScript(bossScript:String):void {
			if(_onStagePresent == true){
				_view.setBossScript(bossScript);
			}
		}
		
		//SET PLAYER COIN	
		public function setPlayerCoin(playerCoin:int):void {
			if(_onStagePresent == true){
				_view.setPlayerCoin(playerCoin);
			}
		}
		
		//SET PLAYER AP
		public function setPlayerAP(playerAP:int):void {
			if(_onStagePresent == true){
				_view.setPlayerAP(playerAP);
			}
		}
		
		//SET GAME TIME
		public function setGameTime(gameTime:int):void {
			if(_onStagePresent == true){
				_view.setGameTime(gameTime);
			}
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLER METHODS
		 * ----------------------------------------------------------------------------------------------------------*/				
		private function onRemove(e:Event):void {
			_onStagePresent = false;
			nullAllInstances();
		}
	}
}