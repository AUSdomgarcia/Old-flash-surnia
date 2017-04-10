package com.surnia.socialStar.quest.views 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import flash.xml.*;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * 
	 */
	public class Quest extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _questId:String;
		
		private var _es:EventSatellite;
		private var _questPopup:questPopup;
		private var _questPopup2:questPopup2;
		private var _questPopup3:questPopup3;
		private var _questPopup4:questPopup4;
		private var _questNpc:questNpc;
		private var _questDone:questDone;
		private var _questcounter:int = 0;
		
		
		
		/*----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		public function Quest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			//_es = EventSatellite.getInstance();
			//_es.addEventListener( MainMenuUIEvent.SHOW_SETUP, onShowPart1 );	//CLICK AND SHOW BUILD SHOP		
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			//removeDisplay();
		}
		
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
	
		private function setDisplay():void 
		{
			_questNpc =  new questNpc();
			addChild( _questNpc );
			
			_questPopup =  new questPopup();
			addChild( _questPopup );
			
			_questPopup2 =  new questPopup2();
			addChild( _questPopup2 );
			
			_questPopup3 =  new questPopup3();
			addChild( _questPopup3 );
			
			_questPopup4 =  new questPopup4();
			addChild( _questPopup4 );
			
			_questNpc.x = 20;
			_questNpc.y = 120;
			
			_questNpc.npc1.visible = false;
			_questNpc.npc2.visible = false;
			_questNpc.npc3.visible = false;
			_questNpc.npc4.visible = false;
			
			if (GlobalData.instance.Plvl >= 1) {
				_questNpc.npc1.visible = true;
			}
			
			if (GlobalData.instance.Plvl >= 4) {
				_questNpc.npc2.visible = true;
			}
			
			if (GlobalData.instance.Plvl >= 6) {
				_questNpc.npc3.visible = true;
			}
			
			if (GlobalData.instance.Plvl >= 8) {
				_questNpc.npc4.visible = true;
			}
			
			_questPopup.x = 123.55;
			_questPopup.y = 132.55;
			
			_questPopup2.x = 123.55;
			_questPopup2.y = 132.55;
			
			_questPopup3.x = 123.55;
			_questPopup3.y = 132.55;
			
			_questPopup4.x = 123.55;
			_questPopup4.y = 132.55;
			
			_questDone.x = 123.55;
			_questDone.y = 132.55;
						
			_questPopup.visible = false;
			_questPopup2.visible = false;
			_questPopup3.visible = false;
			_questPopup4.visible = false;
			_questDone.visible = false;
			
			_questNpc.npc1.buttonMode = true;
			_questNpc.npc2.buttonMode = true;
			_questNpc.npc3.buttonMode = true;
			_questNpc.npc4.buttonMode = true;
			
			
			_questNpc.npc1.addEventListener(MouseEvent.CLICK, showQuest1);	
			_questNpc.npc2.addEventListener(MouseEvent.CLICK, showQuest2);
			_questNpc.npc3.addEventListener(MouseEvent.CLICK, showQuest3);
			_questNpc.npc4.addEventListener(MouseEvent.CLICK, showQuest4);
			
			//_questDone.addEventListener(, showHooray);
						
		}
		
		private function showQuest1():void
		{
			arguments;  
			_questPopup.visible = true;
			_questPopup.questComplete.visible = false;
			
			_questPopup.closeBtn.buttonMode = true;
			_questPopup.closeBtn.addEventListener(MouseEvent.CLICK, closeBtn);
			
			//loadQuest();
			
		}
		
		private function showQuest2():void
		{
			arguments;  
			_questPopup2.visible = true;
			_questPopup2.questComplete.visible = false;
			
			_questPopup2.closeBtn.buttonMode = true;
			_questPopup2.closeBtn.addEventListener(MouseEvent.CLICK, closeBtn);
			
			//loadQuest();
			
		}
		
		private function showQuest3():void
		{
			arguments;  
			_questPopup3.visible = true;
			_questPopup3.questComplete.visible = false;
			
			_questPopup3.closeBtn.buttonMode = true;
			_questPopup3.closeBtn.addEventListener(MouseEvent.CLICK, closeBtn);
			
			//loadQuest();
			
		}
		
		private function showQuest4():void
		{
			arguments;  
			_questPopup4.visible = true;
			_questPopup4.questComplete.visible = false;
			
			_questPopup4.closeBtn.buttonMode = true;
			_questPopup4.closeBtn.addEventListener(MouseEvent.CLICK, closeBtn);
			
			//loadQuest();
			
		}
	
		private function closeBtn():void 
		{
			arguments;
			this.removeChild( _questPopup );
			this.removeChild( _questPopup2 );
			this.removeChild( _questPopup3 );
			this.removeChild( _questPopup4 );
		
			setDisplay();
			
		}
		
		private function questSequenceDone():void 
		{
			arguments;
			_questDone =  new questDone();
			addChild( _questDone );
			
			_questDone.closeBtn_hooray.addEventListener(MouseEvent.CLICK, close_sequence);
			setDisplay();

		}
		
		private function close_sequence():void {
			arguments;
			this.removeChild( _questDone );
			
		}
		
		/*private function loadQuest():void 
		{
			var categoryType:String;
			var questData:Array = GlobalData.instance.questListDataArray;
			var rewardArr:Array = GlobalData.instance.getQuestRewardDataByQuestID([GlobalData.QUESTLIST_ID]);
			var termArr:Array = GlobalData.instance.getQuestTermDataByQuestID([GlobalData.QUESTLIST_ID]);
			
			switch (categoryType) 
			{
				case "cat1":
					
					for (var i:int = 0; GlobalData.instance.questListDataArray.length ; i++) {
				
						questData[i][GlobalData.QUESTLIST_ID];
						questData[i][GlobalData.QUESTLIST_TITLE];
						
						_questPopup.questMission.text = questData[i][GlobalData.QUESTLIST_TITLE];
					}
					
					for (var k:int = 0; k <= 2 ; k++ ) {
					
						rewardArr[k][GlobalData.QUESTLIST_REWARD_AMOUNT];
						
					}
						
					for (var j:int = 0; j <= 3 ; j++) {
					
						termArr[j][GlobalData.QUESTLIST_TERM_STATUS];
						termArr[j][GlobalData.QUESTLIST_TERM_OBJECTIMAGE];
						termArr[j][GlobalData.QUESTLIST_TERM_FUNCTION];
					
					}
						
						if ( GlobalData.QUESTLIST_TERM_STATUS == "ongoing" )
						{
						
						}
				
				break;
				
				case "cat2":
					
					for (var i:int = 0; i <= 7 ; i++) {
				
						questData[i][GlobalData.QUESTLIST_ID];
						questData[i][GlobalData.QUESTLIST_TITLE];
						rewardArr[0][GlobalData.QUESTLIST_REWARD_AMOUNT];
						termArr[0][GlobalData.QUESTLIST_TERM_STATUS];
						termArr[0][GlobalData.QUESTLIST_TERM_OBJECTIMAGE];
						termArr[0][GlobalData.QUESTLIST_TERM_FUNCTION];
						
						_questPopup.questMission.text = questData[i][GlobalData.QUESTLIST_TITLE];
						
						if ( GlobalData.QUESTLIST_TERM_STATUS == "ongoing" )
						{
							
						}
				
				break;
				
				case "cat3":
					
					for (var i:int = 0; i <= 9 ; i++) {
				
						questData[i][GlobalData.QUESTLIST_ID];
						questData[i][GlobalData.QUESTLIST_TITLE];
						rewardArr[0][GlobalData.QUESTLIST_REWARD_AMOUNT];
						termArr[0][GlobalData.QUESTLIST_TERM_STATUS];
						termArr[0][GlobalData.QUESTLIST_TERM_OBJECTIMAGE];
						termArr[0][GlobalData.QUESTLIST_TERM_FUNCTION];
						
						_questPopup.questMission.text = questData[i][GlobalData.QUESTLIST_TITLE];
						
						if ( GlobalData.QUESTLIST_TERM_STATUS == "ongoing" )
						{
				
						}
				
				break;
				
				case "cat4":
					
					for (var i:int = 0; i <= 7 ; i++) {
				
						questData[i][GlobalData.QUESTLIST_ID];
						questData[i][GlobalData.QUESTLIST_TITLE];
						rewardArr[0][GlobalData.QUESTLIST_REWARD_AMOUNT];
						termArr[0][GlobalData.QUESTLIST_TERM_STATUS];
						termArr[0][GlobalData.QUESTLIST_TERM_OBJECTIMAGE];
						termArr[0][GlobalData.QUESTLIST_TERM_FUNCTION];
						
						_questPopup.questMission.text = questData[i][GlobalData.QUESTLIST_TITLE];
						
						if ( GlobalData.QUESTLIST_TERM_STATUS == "ongoing" )
						{
				
						}
				
				break;
			}*/
		
			
		//}
		
		
		
	}

}