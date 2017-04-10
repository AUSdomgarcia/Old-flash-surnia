package com.surnia.socialStar.quest.views 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.quest.component.QuestComponent;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import com.surnia.socialStar.quest.Model.QuestData;
	import com.surnia.socialStar.quest.Model.QuestDataModel;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	/**
	 * ...
	 * @author DF
	 */
	public class QuestPanelView extends Sprite
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/	
		private var _model:QuestDataModel;
		
		private var _quest:Array = [];	
		private var _questComponent:Array = [];
		private var _questTab:Array = [];
		private var _questFinish:Array = [];
		
		private var _entityLayer:Sprite;		
		
		private var _selectUp:SwitchComponent;
		private var _selectDown:SwitchComponent;
		
		private var _index:int = 0;
		
		private var _buttonUp:MovieClip;
		private var _buttonDown:MovieClip;			
		
		private var _activeQuest:QuestComponent;
		
		private var _callBack:Function;
		private var _callBackVisible:Function;
		
		private var _manager:QuestManager;
		
		private	var _gf:GlowFilter = new GlowFilter(0xFCD116, 1.0, 6, 6, 50);		
		//new
		private var _es:EventSatellite;
		
		public var dfg:int = 0;
		private var _sdc:ServerDataController;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTORS
		 * ----------------------------------------------------------------------------------------------------------*/
		public function QuestPanelView(callBack:Function,callBackVisible:Function, model:QuestDataModel, buttonUp:MovieClip, buttonDown:MovieClip) 
		{	
			//nullAllInstances();
			_sdc =  ServerDataController.getInstance();
			_es = EventSatellite.getInstance();
		
			_es.addEventListener( QuestEvent.UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION, onUpdateQuestNoAnimation );
			_es.addEventListener( QuestEvent.UPDATE_QUEST_DISPLAY_WITH_ANIMATION, onUpdateQuestWithAnimation );
			
			_callBack = callBack;
			_callBackVisible = callBackVisible;
			_model = model;			
			
			_buttonUp 	= buttonUp;
			_buttonDown = buttonDown;		
			
			initialization();
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);				
		}	
		
		private function onRemove(e:Event):void {			
			nullAllInstances();
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/		
		 //INITIALIZATION
		private function initialization():void {
			_entityLayer = new Sprite;		
			
			_selectUp = new SwitchComponent(onUp, _buttonUp);
			_selectDown = new SwitchComponent(onDown, _buttonDown);
			
			_manager = QuestManager.instance;
			_manager.instanceQuestModel(_model);
		}	
		
		//UPDATE QUEST LIST DATA
		public function updateDataDisplay():void {				
			clearAll();		
			_quest = _model.questList;			
			
			updateIcon();
		}		
		
		//UPDATE ICON (questComponent)
		private function updateIcon():void {		
			removeAllTabCharacter();
			for (var j:int = _questComponent.length; j > 0; j-- ) {
				if (_questComponent[j] != null) {
					_questComponent[j] = null;			
				}
				_questComponent.pop();
			}
			
			if (_quest.length != 0) {
				_callBackVisible(true);
				for (var i :int = 0; i < _quest.length; i++ ) {
					_questComponent.push(new QuestComponent(_quest[i], onSelectQuest , new NewQuestMC));
				}
			}
			else {
				_callBackVisible(false);
			}
		}
		
		//CLEAN ARRAYS _quest AND _questComponent
		private function clearAll():void {			
			for (var i:int = _quest.length; i > 0; i-- ) {
				if (_quest[i] !=null) {
					_quest[i] = null;				
				}
				_quest.pop();
			}
						
			removeAllTabCharacter();
			for (var j:int = _questComponent.length; j > 0; j-- ) {
				if (_questComponent[j] != null) {
					_questComponent[j] = null;					
				}
				_questComponent.pop();
			}
		}
		
		//REMOVE ALL QUEST IN QUEST TAB		
		private function removeAllTabCharacter():void {		
			//check all questTab
			for (var j:int = 0; j < _questTab.length; j++ ) {
				//check all quest component in questTab
				for (var i:int =  0; i < _questComponent.length; i++ ) {
					if (_questComponent[i] != null) {
						if(_questTab[j].contains(_questComponent[i])){
							_questTab[j].removeChild(_questComponent[i]);
						}
					}
				}
			}
		}
		
		//DISPLAY QUEST
		private function display():void {		
			//REMOVE EXISTING LAYER
			if (_entityLayer !=null) {
				if (this.contains(_entityLayer)) {
					removeChild(_entityLayer);
				}
			}
			
			_entityLayer = new Sprite;
			addChild(_entityLayer);
			
			for (var j:int = 0; j < 4; j++ ) {		
				//REMOVE EXISTING QUEST TAB
				if (_questTab[j] !=null) {
					if (_entityLayer.contains(_questTab[j])) {
						_entityLayer.removeChild(_questTab[j]);
						_questTab[j] = null;
					}
				}
				
				//CREATE NEW QUEST TAB
				_questTab[j] = new MovieClip;
				_entityLayer.addChild(_questTab[j]);				
				
				if (_questComponent[j] != null) {
					trace(this, "RETURN isNew:",_questComponent[j].isNew);
					_questTab[j].addChild(_questComponent[j]);
					
				}					
			}
			
			if(_selectUp != null){
				addChild(_selectUp);
			}		
			
			//test rotate arrows
			_selectUp.rotationZ = 90;
			_selectDown.rotationZ = 90;	
			
			_selectUp.x = (_selectUp.width / 2);
			_selectUp.y = 0 - ( 86.9 / 2);
			
			_selectDown.x = (_selectDown.width / 2);
			
			if(_questComponent.length < _questTab.length){
				_selectDown.y = _questTab[0].height * (_questComponent.length) -  _selectDown.height ;
			}
			else {
				_selectDown.y = _questTab[0].height * (_questTab.length) - _selectDown.height;
			}			
			
			if(_selectDown != null){
				addChild(_selectDown);
			}
			
		}
		
		//UPDATE QUEST WITH ANIMATION
		private function updateAnimation():void {
			var isDone:Boolean = true;
			for (var i:int = 0; i < _questTab.length; i++ ) {
				
				_questTab[i].alpha = 0;
				_questTab[i].y = (_questTab[0].height * i) + 20;	
				
				TweenLite.to(_questTab[i], .5, {					
					alpha:1,
					onComplete: function():void {						
					isDone = true;
					}					
				});
			}
		}
		
		//UPDATE QUEST WITHOUT ANIMATION
		private function updateNoAnimation():void {
			var isDone:Boolean = true;
			for (var i:int = 0; i < _questTab.length; i++ ) {
				_questTab[i].y = (_questTab[0].height * i) + 20;				
			}
		}
		
		//DISPATCH DATA TO CALL BACK WHEN QUEST ICON IS CLICKED
		private function onSelectQuest(id:String):void {			
			var questData:QuestData = new QuestData();
			
			for (var i:int = 0; i <  _quest.length; i++ ) {
				if (_quest[i].id == id) {
					_activeQuest = _questComponent[i];					
					
					questData.id = _quest[i].id;			
					questData.title = _quest[i].title;	
					questData.npcscript = _quest[i].npcScript;		
					questData.hintscript = _quest[i].hintScript;										
					
					questData.rewardlist = _quest[i].rewards;					
					questData.termlist = _quest[i].terms;						
				
					questData.rewardnpcimage = _quest[i].npcImage;				
					questData.questicon = _quest[i].qIcon;
					
					questData.isnew = _quest[i].isNew;					
					questData.category = _quest[i].category;
					
					questData.npcimage = _quest[i].npcImage;
					questData.questcommand = _quest[i].questCommand;
					questData.isAccepted = _quest[i].isAccepted;
					
					if ( questData.isnew == 1 ){
						_sdc.setOldToNewQuest( questData.id );
					}
					
					break;
				}
			}
			
			trace(this, "---------------------------------- ", questData.id);
			_callBack( questData );			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALL BACK FOR UP BUTTON
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onUp(id:int):void {			
			_index --;
			if(_index < 0){				
				_index = 0;
			}					
			displayTab(_index);
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALL BACK FOR DOWN BUTTON
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onDown(id:int):void {		
			_index++;
			
			if(_questComponent.length >= _questTab.length){
				if(_index > _questComponent.length - _questTab.length){
					_index = _questComponent.length - _questTab.length;
				}	
			}
			else{			
				_index = 0;
				
			}			
			displayTab(_index);
		}
		
		
		 //DISPLAY QUEST IN QUESTTAB		
		private function displayTab(index:int):void {		
			removeAllTabCharacter();				
			for (var i:int =  0; i < _questTab.length; i++ ) {
				if (_questComponent[i + index] != null) {					
					_questTab[i].addChild(_questComponent[i + index]);								
				}
			}
		}
		
		
		//NULL ALL INSTANCES		
		public function nullAllInstances():void {		
			//REMOVE LISTENER
			if(_model != null){
				_model.removeEventListener(QuestEvent.QUEST_LOAD_COMPLETE, onRemove);
			}
			
			//REMOVE AND NULL ALL INSTANCES AND TWEENS
			for (var j:int = 0; j < _questTab.length; j++ ) {
				//check all quest component in questTab
				for (var i:int =  0; i < _questComponent.length; i++ ) {
					if (_questComponent[i] != null) {
						if(_questTab[j].contains(_questComponent[i])){
							_questTab[j].removeChild(_questComponent[i]);
						}
					}
					_questComponent[i] = null;
				}
				TweenLite.killTweensOf(_questTab[j]);
				_questTab[j] = null;
			}
			
			if (_entityLayer !=null) {
				if (this.contains(_entityLayer)) {
					removeChild(_entityLayer);
					_entityLayer = null;
				}
			}
			
			trace("CLEAN :", this);
		}			
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		//EVENT HANDLER WHEN UPDATE QUEST WITH ANIMATION
		private function onUpdateQuestNoAnimation(e:QuestEvent):void 
		{			
			trace( "[ Quest Panel view qid]:========================> update display questPanel ", e.obj.qid );					
			//_model.extractOnlineQuestXML();
			
			//update data from XML
			updateDataDisplay();		
			//update display icon
			display();
			//animate display							
			updateNoAnimation();
			displayTab(_index);
		}
		
		//EVENT HANDLER WHEN UPDATE QUEST WITHOUT ANIMATION
		private function onUpdateQuestWithAnimation(e:QuestEvent):void 
		{
			trace(this, "ALL DATA LOADED COMPLETE!!!");					
			//update data from XML
			updateDataDisplay();		
			//update display icon
			display();	
			//animate display				
			//updateAnimation();
			updateNoAnimation();
			displayTab(_index);
		}
		
	}

}