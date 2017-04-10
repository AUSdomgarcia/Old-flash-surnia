package com.surnia.socialStar.quest.Manager 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.QuestRewardInfoData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.quest.Model.QuestData;
	import com.surnia.socialStar.quest.Model.QuestDataModel;
	import com.surnia.socialStar.quest.test.MainView;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author domz
	 */
	public class QuestManager extends EventDispatcher
	{
		/*------------------------------------------------------------------------------Constant------------------------------------------------------------*/
		
			/*------------------------------------------------------------------------------Properties------------------------------------------------------------*/
			private var m:QuestDataModel;		
			private static var _instance:QuestManager;
			private var gd:GlobalData = GlobalData.instance;
			private var _sdcontroller:ServerDataController = ServerDataController.getInstance();
			private var _es:EventSatellite;
			private var _questEvent:QuestEvent;			
			private var _popUpUIManager:PopUpUIManager;
			
			private var _updateQuestSet:Array;
			
			/*------------------------------------------------------------------------------Constructor------------------------------------------------------------*/
			
			public function QuestManager(  ) 
			{
				_updateQuestSet = new Array();
				_popUpUIManager = PopUpUIManager.getInstance();
				addEventSateliteListener();
			}		
			
			public static function get instance():QuestManager {				
				if ( _instance == null ){
					_instance = new QuestManager();					
				}
				
				return _instance;
			}			
			
			public function instanceQuestModel( _m:QuestDataModel ):void {
				m = _m;
			}
			
			/*------------------------------------------------------------------------------Methods------------------------------------------------------------*/			
			private function checkbyQtermbyID( idOfQuest:int, str:String ):void {
				var _onCheck:Boolean = false;
				var _onDone:Boolean = true;									
				
				var qid:String = gd.questListDataArray[ idOfQuest ][GlobalData.QUESTLIST_ID ];
				m.questTermArr = GlobalData.instance.getQuestTermsDataByQuestID( qid );				
					
				for (var i:int = 0; i < m.questTermArr.length; i++)
				{					
					if ( str == m.questTermArr[i][GlobalData.QUESTLIST_TERM_FUNCTION])
					{							
						if ( m.questTermArr[i][GlobalData.QUESTLIST_TERM_STATUS] != "done" ) {
							if ( m.questTermArr[i][GlobalData.QUESTLIST_TERM_AMOUNTREQUIRED] > m.questTermArr[i][GlobalData.QUESTLIST_TERM_AMOUNTHAVE]) {
								
								trace("[QuestManager]: checking qid and qtermid" , gd.questListDataArray[ idOfQuest ][GlobalData.QUESTLIST_ID],
								m.questTermArr[i][GlobalData.QUESTLIST_TERM_ID] );
								
								
								var obj:Object = new Object();
								obj.qid = gd.questListDataArray[ idOfQuest ][GlobalData.QUESTLIST_ID];
								obj.qtid = m.questTermArr[i][GlobalData.QUESTLIST_TERM_ID];
								_updateQuestSet.push( obj );								
							}									
						}					
					}								
				}
				updateQuestTerm();				
			}
			
			
			private function updateQuestTerm():void 
			{
				var len:int = _updateQuestSet.length;				
				if ( len > 0 ){
					trace( "[QuestManager]: quest term detected length", len ,"qid", _updateQuestSet[ 0 ].qid, "qtid",_updateQuestSet[ 0 ].qtid  );
					_sdcontroller.updateQuestData( _updateQuestSet[ 0 ].qid, _updateQuestSet[ 0 ].qtid );
				}else {
					trace( "[QuestManager]: there's no quest term to update len", len );
				}
			}
			
			public function questAction( func:String ):void 
			{			
				var qid:String;
				var isAccepted:Boolean;
				
				for (var i:int = 0; i < m.questList.length; i++ )
				{
					qid = gd.questListDataArray[ i ][GlobalData.QUESTLIST_ID ];					
					isAccepted = GlobalData.instance.getQuestIfAcceptedByQuestID(  qid );
				
					if ( isAccepted ) {
						trace( "[QuestManager]: this quest is accepted", "questid", qid  );
						checkbyQtermbyID( i, func );
					}else {
						trace( "[QuestManager]: this quest is not accepted", "questid", qid  );
					}
				}
				trace( "quest action call", func );
			}
			
			private function addEventSateliteListener():void 
			{
				_es = EventSatellite.getInstance(  );
				_es.addEventListener( ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE, onBuyItem );
				_es.addEventListener( ServerDataControllerEvent.UPDATE_QUEST_DATA_COMPLETE, onUpdateQuestDisplay );
				_es.addEventListener( ServerDataControllerEvent.END_QUEST_DATA_COMPLETE, onQuestComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_COMPLETE, onGetMiniGameResultComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_CHECK_INVITE_FRIENDS_COMPLETE, onCheckInviteFriendsComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_CHECK_WEARING_CLOTH_ITEM_COMPLETE, onCheckWearClothesComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_CHECK_BOUGHT_CLOTH_ITEM_COMPLETE, onCheckBoughtClothesComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_QUEST_VISIT_FRIEND_NPC_COMPLETE, onVisitNpcFriendComplete );
				_es.addEventListener( ServerDataControllerEvent.ON_MACHINE_COLLECT_COMPLETE, onMachineCollectComplete );				
			}
			
			/*------------------------------------------------------------------------------Setters------------------------------------------------------------*/			
			/*------------------------------------------------------------------------------Getters------------------------------------------------------------*/			
			/*------------------------------------------------------------------------------EventHandlers------------------------------------------------------------*/
			
			private function onMachineCollectComplete(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction for Machine Collect================================================>>> qf: ", e.obj.qf );
				questAction( e.obj.qf );
			}
			
			private function onVisitNpcFriendComplete(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction for visiting friend or npc================================================>>> qf: ", e.obj.qf );				
				if ( e.obj.qf != "none" ) {
					trace( "qf", e.obj.qf );
					questAction( e.obj.qf );
				}
			}
			
			private function onCheckBoughtClothesComplete(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction for checking Bought clothes================================================>>> qf: ", e.obj.qf );
				questAction( e.obj.qf );
			}
			
			private function onCheckWearClothesComplete(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction for checking wearing clothes================================================>>> qf: ", e.obj.qf );								
				questAction( e.obj.qf );
			}
			
			private function onCheckInviteFriendsComplete(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction for checking invite Friends================================================>>> qf: ", e.obj.qf );								
				questAction( e.obj.qf );				
			}			
			
			private function onGetMiniGameResultComplete(e:ServerDataControllerEvent):void 
			{				
				trace( "[ QuesManager ] call questAction for wining minigame================================================>>> qf: ", e.obj.qf );				
				if ( e.obj.qf != "none" && e.obj.win == 1 ) {
					trace( "qf", e.obj.qf );
					questAction( e.obj.qf );
				}
			}
			
			private function onBuyItem(e:ServerDataControllerEvent):void 
			{
				trace( "[ QuesManager ] call questAction================================================>>> qf: ", e.obj.qf );				
				questAction( e.obj.qf );
			}
			
			private function onUpdateQuestDisplay(e:ServerDataControllerEvent):void 
			{
				//new
				_updateQuestSet.shift();
				updateQuestTerm();				
				trace( "[QuestManager]: update quest Manager==========================================>", e.obj.qid, "qtid", e.obj.qtid, "done", e.obj.done );				
				
				if ( e.obj.done == "true" ) {
					//quest complete					
					_sdcontroller.endQuestData( e.obj.qid );
					_questEvent = new QuestEvent( QuestEvent.UPDATE_QUEST_DISPLAY );
					var obj:Object = new Object();
					obj.qid = e.obj.qid;
					
					var questRewardInfoData:QuestRewardInfoData = new QuestRewardInfoData();
					questRewardInfoData.id = obj.qid;
					questRewardInfoData.questcommand = e.obj.qcmd;
					GlobalData.instance.currentCompletedQuestData.push( questRewardInfoData );
					
					//var questData:QuestData = new QuestData();
					//GlobalData.instance.currentCompletedQuestData = new QuestData();
					//GlobalData.instance.currentCompletedQuestData.id = obj.qid;
					//GlobalData.instance.currentCompletedQuestData.questcommand = e.obj.qcmd;
					
					GlobalData.instance.currentCompleteQuestID = obj.qid;
					_es.dispatchESEvent( _questEvent , obj );
					
					if ( !_popUpUIManager.isWindowActive ){
						_popUpUIManager.loadWindow( WindowPopUpConfig.REWARD_WINDOW );
					}else {
						_popUpUIManager.loadSubWindow( WindowPopUpConfig.REWARD_WINDOW );
					}
					
					trace( "[QuestManager call end quest!!] finishing questid", e.obj.qid, "qtid", e.obj.qtid, "done", e.obj.done );
					GlobalData.instance.onAnimateQuest = true;			
					m.extractOnlineQuestXML();
				}else {
					//quest not complete
					GlobalData.instance.onAnimateQuest = false;
					m.extractOnlineQuestXML();
					trace( "[QuestManager update questxml not yet complete!!] finishing questid", e.obj.qid, "qtid", e.obj.qtid, "done", e.obj.done );
				}
			}
			
			private function onQuestComplete(e:ServerDataControllerEvent):void 
			{
				//m.extractOnlineQuestXML();
			}
	}
}
		