package com.surnia.socialStar.ui.popUI.events 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.sceneHandler.data.SceneConfig;
	import com.surnia.socialStar.tutorial.controller.TutorialGuideManager;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.contestantinformation.event.ContestantInformationEvent;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.eventScene.event.EventSceneEvent;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	
	import flash.events.Event;

	public class PopUpManagerEvent
	{
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _pm:PopUpUIManager = PopUpUIManager.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		private var _sdc:ServerDataController = ServerDataController.getInstance();
		private var _tutGuideManager:TutorialGuideManager;
		
		public function PopUpManagerEvent()
		{
			_tutGuideManager = TutorialGuideManager.getInstance();
		}
		
		public function addListeners():void{
			_es.addEventListener( EventSceneEvent.EVENTSCENE_DONE, onHandleEventScenePopup);			
			_es.addEventListener( ServerDataControllerEvent.ON_GET_SCENE_COMPLETE , onShowEventScene );
			//_es.addEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_COMPLETE , onShowRewardWindow );
			_es.addEventListener( ContestantInformationEvent.HIDE_INFOWINDOW, onHideInfoWindow );
			_es.addEventListener( PopUIEvent.ON_SHOW_MESSAGE, onShowMessageWindow );
			_es.addEventListener( QuestEvent.SHOW_QUEST_POP_UP_WINDOW, onShowQuestWindow);
			_es.addEventListener( PlayerStatusEvent.EXPERIENCE_MAXED, onShowLevelUpWindow);
			_es.addEventListener( FriendInteractionEvent.FRIENDINTERACT_STARTCHALLENGE, onStartChallenge );
			
			//tutorial events
			_es.addEventListener( TutorialEvent.START_TUTORIAL, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_SHOP_BTN, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_BUY_BTN, onShowTutorial );
			_es.addEventListener( TutorialEvent.PLACE_STAFF, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_BUBBLE, onShowTutorial );
			_es.addEventListener( TutorialEvent.BUY_STAFF, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_STAFF, onShowTutorial );
			_es.addEventListener( TutorialEvent.HIRE_CONTESTANT, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_CONTESTANT, onShowTutorial );
			_es.addEventListener( TutorialEvent.CLICK_STAFF_BTN, onShowTutorial );
			_es.addEventListener( TutorialEvent.HIRE_CREW, onShowTutorial );
			_es.addEventListener( TutorialEvent.END_TUTORIAL, onShowTutorial );
		}				
		
		public function removeListeners():void{
			_es.removeEventListener(EventSceneEvent.EVENTSCENE_DONE, onHandleEventScenePopup);
			_es.removeEventListener( ServerDataControllerEvent.ON_GET_SCENE_COMPLETE , onShowEventScene );
			//_es.removeEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_COMPLETE , onShowRewardWindow );
			_es.removeEventListener( ContestantInformationEvent.HIDE_INFOWINDOW, onHideInfoWindow );
			_es.removeEventListener( PopUIEvent.ON_SHOW_MESSAGE, onShowMessageWindow );
			_es.removeEventListener( QuestEvent.SHOW_QUEST_POP_UP_WINDOW, onShowQuestWindow);
			_es.removeEventListener( PlayerStatusEvent.EXPERIENCE_MAXED, onShowLevelUpWindow);
			
			//tutorial events
			_es.removeEventListener( TutorialEvent.START_TUTORIAL, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_SHOP_BTN, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_BUY_BTN, onShowTutorial );
			_es.removeEventListener( TutorialEvent.PLACE_STAFF, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_BUBBLE, onShowTutorial );
			_es.removeEventListener( TutorialEvent.BUY_STAFF, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_STAFF, onShowTutorial );
			_es.removeEventListener( TutorialEvent.HIRE_CONTESTANT, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_CONTESTANT, onShowTutorial );
			_es.removeEventListener( TutorialEvent.CLICK_STAFF_BTN, onShowTutorial );
			_es.removeEventListener( TutorialEvent.HIRE_CREW, onShowTutorial );
			_es.removeEventListener( TutorialEvent.END_TUTORIAL, onShowTutorial );
		}
		
		
		/*---------------------------------------------------------------EventHandlers-----------------------------------------------------------------*/
		
		public function onHideInfoWindow (ev:ContestantInformationEvent):void{
			_pm.removeWindow(WindowPopUpConfig.CONTESTANT_INFORMATION_WINDOW);
		}
		
		public function onHandleEventScenePopup(ev:Event):void{
			switch(ev.type)
			{
				case EventSceneEvent.EVENTSCENE_DONE:
				{
					_pm.removeWindow(WindowPopUpConfig.EVENT_SCENE_WINDOW);
					break;
				}
			}
		}
		
		private function onShowEventScene(e:ServerDataControllerEvent):void 
		{	
			trace( "[popUpMnagerEvent]: trigger", _gd.sceneData[ 0 ].trigger );
			
			switch ( _gd.sceneData[ 0 ].trigger ) 
			{
				case SceneConfig.BUYING:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case SceneConfig.QUEST_START:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );	
				break;
				
				case SceneConfig.QUEST_END:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );	
				break;
				
				case SceneConfig.TRAINING_START:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case SceneConfig.TRAINING_END:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case SceneConfig.LEVEL_UP:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case SceneConfig.CONTEST:
					_pm.loadSubWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				default:
			}
		}
		
		//private function onShowRewardWindow(e:ServerDataControllerEvent):void 
		//{			
			//if ( e.obj.win == 1 ){
				//_pm.loadWindow( WindowPopUpConfig.REWARD_WINDOW );
			//}
		//}
		
		private function onShowMessageWindow(e:PopUIEvent):void 
		{
			_pm.loadSubWindow( WindowPopUpConfig.MESSAGE_WINDOW , 0, 0, true, 190 ,157  );
			
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_UPDATE_MESSAGE_WINDOW );
			popUpUIEvent.obj.msg = e.obj.msg;
			_es.dispatchESEvent( popUpUIEvent );			
		}
		
		private function onShowQuestWindow(e:QuestEvent):void
		{			
			_pm.loadSubWindow(WindowPopUpConfig.QUEST_WINDOW);			
		}
		
		private function onShowLevelUpWindow(e:PlayerStatusEvent):void
		{
			_sdc.checkCharCount();
			_pm.loadSubWindow(WindowPopUpConfig.LEVEL_UP_WINDOW);
		}
		
		private function onStartChallenge(ev:FriendInteractionEvent):void{
			_pm.loadWindow(WindowPopUpConfig.CONTESTANT_SELECION_WINDOW);
		}
		
		private function onShowTutorial(e:TutorialEvent):void
		{
			trace("wapak");
			trace("[IsoRoom]event name", e.type);
			//var tutEvent:TutorialEvent;
			var eventName:String = e.type;
			var label:String;
			
			//hack
			//_gd.isTutorialDone = true;
			
			var len:int = _gd.tutTracker.length;
			var found:Boolean = false;
			
			for (var i:int = 0; i < len; i++)
			{
				if (_gd.tutTracker[i] == eventName)
				{
					found = true;
					break;
				}
			}
			
			if (!_gd.isTutorialDone && !found)
			{
				_gd.tutTracker.push(eventName);
				switch (eventName)
				{
					case "START_TUTORIAL": 
						label = "startTutorial";						
						_tutGuideManager.addTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_1, 0, 0.5, 100, 110 );
						//tutEvent = new TutorialEvent( TutorialEvent.UPDATE_ARROW_GUIDE_SHOP_BTN );
						//tutEvent = new TutorialEvent( TutorialEvent.SHOW_ARROW_GUIDE_SHOP_BTN );						
						break;
					
					case "CLICK_SHOP_BTN": 
						label = "showShop";
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_2, 1, 0.5, -600, 110 );
						break;
					
					case "CLICK_BUY_BTN": 
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_3, 0, 0.5, 100, 110 );
						label = "placeStaff";
						break;
					
					case "PLACE_STAFF": 
						label = "clickBubble";
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_4, 0, 0.5, 100, 110 );
						break;
					
					case "CLICK_BUBBLE": 
						label = "buyStaff";
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_5, 0, 0.5, 100, 110 );
						break;
					
					case "BUY_STAFF": 
						label = "clickStaff";
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_6, 0, 0.5, 100, 110 );
						break;
					
					case "CLICK_STAFF": 
						label = "hireContestant";
						_tutGuideManager.updateTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_7, 0, 0.5, 100, 110 );
						break;
					
					case "HIRE_CONTESTANT": 
						//label = "clickContestant";
						label = "endTutorial";
						_gd.tutLabel = label;
						_tutGuideManager.removeTutGuide();
						_pm.loadSubWindow(WindowPopUpConfig.TUTORIAL_WINDOW, 0, 0, true, 0, 0);
						//_characterNodeManager.stopRandomMovement();
						break;
					
					case "CLICK_CONTESTANT": 
						label = "clickStaffBtn";
						break;
					
					case "CLICK_CONTESTANT": 
						label = "clickStaffBtn";
						break;
					
					case "CLICK_STAFF_BTN": 
						label = "hireCrew";
						break;
					
					case "HIRE_CREW": 
						label = "endTutorial";
						_pm.removeWindow(WindowPopUpConfig.CREW_WINDOW);
						trace("remove crew window......");
						break;
					
					case "END_TUTORIAL": 
						label = "";
						_gd.isTutorialDone = true;
						_sdc.endTutorial();
						//_characterNodeManager.startRandomMovement();
						break;
					
					default: 
				}
				
				//_gd.tutLabel = label;
				
				if (label != "")
				{
					//_pm.removeCurrentSubWindow();
					//_pm.loadSubWindow(WindowPopUpConfig.TUTORIAL_WINDOW, 0, 0, true, 0, 0);
					//_tutGuideManager.addTutGuide( "tut1", GameDialogueConfig.TUTORIAL_SCRIPT_1, 0, 0.5, 100, 110 );
					//_es.dispatchESEvent( tutEvent );
				}
			}
		}
	}
}