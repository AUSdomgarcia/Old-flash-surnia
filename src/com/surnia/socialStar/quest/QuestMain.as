package com.surnia.socialStar.quest 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import com.surnia.socialStar.quest.Model.QuestData;
	import com.surnia.socialStar.quest.Model.QuestDataModel;
	import com.surnia.socialStar.quest.views.QuestPanelView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author DF
	 */
	public class QuestMain extends Sprite
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/	
		private var _model:QuestDataModel;
		private var _manager:QuestManager;
		//private var _view:QuestPanelMain	
		private var _popUpLayer:MovieClip;
		
		private var _view:QuestPanelView;
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/	
		public function QuestMain() 	
		{		
			//trace(this, "RESTRUCTURED LATEST");
			_gd = GlobalData.instance;
			_sdc = ServerDataController.getInstance();
			addEventListener( Event.ADDED_TO_STAGE, init );				
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS	
		 * ----------------------------------------------------------------------------------------------------------*/		
		//INITIALIZE CLASS
		private function initialization():void {
						
			_model = new QuestDataModel(onQuestWin);
			
			_manager = QuestManager.instance;
			_manager.instanceQuestModel(_model);	
			
			_view  = new QuestPanelView(onQuestPanelClick, visibility, _model, new arrowBlueLeft, new arrowBlueRight);	
			_view.x = 0;
			_view.y = 100;	
		}		
		
		//SET DISPLAY
		private function setDisplay():void {	
			if(_view != null){
				addChild(_view);
			}	
		}
		
		//NULL ALL INSTANCES
		private function removeDisplay():void 
		{
			_view.nullAllInstances();			
			if (_view != null) {
				if (this.contains(_view)) {
					removeChild(_view);
				}
				_view = null;
			}
			
			if (_manager != null) {
				_manager = null;
			}
			
			if (_model !=null) {
				_model = null;
			}
		}		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALL BACK		
		 * ----------------------------------------------------------------------------------------------------------*/	
		//WHEN QUEST CLICK
		private function onQuestPanelClick( data:QuestData = null ):void {
			
			//trace( "quest panel click questdata", data );
			
			var questEvent:QuestEvent = new QuestEvent( QuestEvent.SHOW_QUEST_POP_UP_WINDOW );
			var es:EventSatellite = EventSatellite.getInstance();		
				
			if ( data.id != null ) {
				//trace( "qpanel questdata", data );
				
				
				var questData:QuestData = new QuestData();									
				questData.id 			= data.id;
				questData.title			= data.title;	
				questData.npcscript 	= data.npcscript;		
				questData.hintscript 	= data.hintscript;										
				questData.npcimage      = data.npcimage; 
				questData.questcommand  = data.questcommand; 
				
				questData.rewardlist 	 = data.rewardlist;					
				questData.termlist 		 = data.termlist;						
			
				questData.rewardnpcimage = data.rewardnpcimage;				
				questData.questicon 	 = data.questicon;	
				questData.category		 = data.category;
				questData.isAccepted 	 = data.isAccepted;
				
				_gd.currentSelectedQuestData = new QuestData;
				_gd.currentSelectedQuestData = questData;
				
				//_gd.currentSelectedQuestData.id = data.id;
				//_gd.currentSelectedQuestData.title = data.title;
				//_gd.currentSelectedQuestData.npcscript = data.npcscript;
				//_gd.currentSelectedQuestData.hintscript = data.hintscript;
				//_gd.currentSelectedQuestData.npcimage = data.npcimage;
				//_gd.currentSelectedQuestData.questcommand = data.questcommand;
				//_gd.currentSelectedQuestData.rewardlist = data.rewardlist;
				//_gd.currentSelectedQuestData.termlist = data.termlist;
				//_gd.currentSelectedQuestData.rewardnpcimage = data.rewardnpcimage;
				//_gd.currentSelectedQuestData.questicon = data.questicon;
				//_gd.currentSelectedQuestData.category = data.category;
				
				trace(this, "questData.id :", questData.id);
				trace(this, "questData.title :", questData.title);
				trace(this, "questData.npcscript :", questData.npcscript);
				trace(this, "questData.hintscript :", questData.hintscript);
				trace(this, "questData.npcImage :", questData.npcimage);
				trace(this, "questData.QuestComand :", questData.questcommand );
				
				var arrayReward:Array = questData.rewardlist;
				for (var i:int = 0; i < arrayReward.length; i++ ) {
					trace(this, "questData.rewardlist :", arrayReward[i]);
				}
				
				var arrayTerm:Array = questData.termlist;
				for (var j:int = 0; j <  arrayTerm.length; j++ ) {				
					trace(this, "questData.termlist :", arrayTerm[j]);
				}
				
				trace(this, "questData.rewardnpcimage :", questData.rewardnpcimage);
				trace(this, "questData.questicon :", questData.questicon);
				
				es.dispatchESEvent( questEvent , questData );
			}else {
				//trace( "qpanel questdata null", data );
				es.dispatchESEvent( questEvent , null );
			}
			
			_sdc.updateQuestXML( true );			
			_sdc.getScene( "quest_" + questData.questcommand + "_start" );
		}
		
		// SET ICON VISIBILITY
		public function visibility(val:Boolean = true):void {
			if ( _view != null ) {
				_view.visible = val;			
			}
			//trace(this, "VISIBLE :", val);
		}
		
		private function onQuestWin():void {
			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER		
		 * ----------------------------------------------------------------------------------------------------------*/			
		
		 /*------------------------------------------------------------------------------------------------------------
		 *												GETTER		
		 * ----------------------------------------------------------------------------------------------------------*/	
		 
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLER		
		 * ----------------------------------------------------------------------------------------------------------*/
		private function init(e:Event):void 
		{			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			
			initialization();			
			setDisplay();		
		}	
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
	}

}