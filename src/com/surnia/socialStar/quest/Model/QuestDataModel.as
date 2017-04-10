package com.surnia.socialStar.quest.Model 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author domz
	 */
	public class QuestDataModel extends Sprite
	{	
		public var questId:String = "";
		public var questReward:Number = 0;
		
		//Left Panel Variables
		public var questTermArr:Array = [];
		public var qmTermArr:Array = [];
		public var questList:Array = [];
		
		public var gd:Array = [];
		private var questTerm:Array = [];
		
		private var title:Array = [];
		private var cat:Array = [];
		private var questIcon:Array = [];
		private var terms:Array = [];
		private var reward:Array = [];
		private var id:Array = [];
		private var hint:Array = [];
		private var npcS:Array = [];
		private var npcImage:Array = [];
		private var questStat:Array = [];
		private var questCommand:Array = [];
		private var isAccepted:Array = [];
		
		private var _es:EventSatellite;
		private var _questWin:Function;
		private var _isOnline:Boolean;
		private var _runningOn:String;
		private var _questEvent:QuestEvent;
		
		public var onRuntime:String = "StandAlone";
		
		private var _sdc:ServerDataController;
		
		public function QuestDataModel( f:Function )
		{		
			_sdc = ServerDataController.getInstance();
			eventQuestSatellite();
			_questWin = f;		
			
			_runningOn = Capabilities.playerType;
			if ( _runningOn != 'StandAlone' ) {				
				_isOnline = true;
				extractOnlineQuestXML();
			}else {
				_isOnline = false;
				offLineXML();
			}
		}
		
		private function offLineXML():void {
			trace( " use offline ");
			_sdc.updateQuestXML( false );
			//ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.offlineQuestListData);
		}
		
		public function extractOnlineQuestXML():void
		{
			trace( " use online ");			
			_sdc.updateQuestXML( true );
			//ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData );
		}
		
		public function eventQuestSatellite():void
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener(SSEvent.QUESTLISTXML_LOADED, onXMLLoadedQuestList );
		}
		
		public function clrArray():void {
			questTermArr =  new Array();
			qmTermArr =  new Array();
			questList =  new Array();
			gd =  new Array();
			questTerm =  new Array();
			title =  new Array();
			cat =  new Array();
			questIcon =  new Array();
			terms =  new Array();
			reward =  new Array();
			id =  new Array();
			hint = new Array();			
			npcImage = new Array();
			questCommand = new Array();
			isAccepted = new Array();
			
		}
		
		public function onXMLLoadedQuestList( e:SSEvent ):void {			
			if( _isOnline ){				
				clrArray();
				trace( "[QuestDataMode] online mode..." );
				
				gd  = GlobalData.instance.questListDataArray;				
				for (var xx:int = 0; xx <  gd.length; xx++)
				{
					// id, Cat001, title, questIcon, terms, reward
					id[xx] = gd[ xx ][GlobalData.QUESTLIST_ID];
					title[xx] = gd[ xx ][GlobalData.QUESTLIST_TITLE]
					cat[xx] = gd[ xx ][GlobalData.QUESTLIST_CATEGORY];
					hint[ xx ] = gd[ xx ][GlobalData.QUESTLIST_HINTSCRIPT];
					npcS[ xx ] = gd[ xx ][GlobalData.QUESTLIST_NPCSCRIPT];
					npcImage[ xx ] = gd[ xx ][GlobalData.QUESTLIST_NPCIMAGE];
					questCommand[ xx ] = gd[ xx ][GlobalData.QUESTLIST_COMMAND];	
					isAccepted[ xx ] = gd[ xx ][GlobalData.QUESTLIST_ISACCEPTED];
					//globalData.questListDataArray[index][GlobalData.QUESTLIST_ISACCEPTED]
					//QUESTLIST_NPCIMAGE
					
					//df
					questStat [xx] = gd[ xx ][GlobalData.QUESTLIST_ISNEW];
					
					questList.push( new QuestDetailHolder( id[xx] , cat[xx] , title[xx], hint[ xx ] , npcS[ xx ] ,questStat[xx], xx, npcImage[ xx ],questCommand[ xx ], isAccepted[ xx ]  ) );
					trace( "[ QuestDataModel ]:====>>>>",this,"title: ", hint[ xx ], "npcImage",npcImage[ xx ]  );
				}
				
				if( GlobalData.instance.onAnimateQuest ){
					_questEvent = new QuestEvent( QuestEvent.UPDATE_QUEST_DISPLAY_WITH_ANIMATION );
					_es.dispatchESEvent( _questEvent );
				}else {
					_questEvent = new QuestEvent( QuestEvent.UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION );
					_es.dispatchESEvent( _questEvent );
				}
				
				//this.dispatchEvent( new Event("DATA_LOADED"));
			} else {				
				clrArray();
				trace( "stand alone mode..." );				
				gd  = GlobalData.instance.questListDataArray;		
				
				for (var i:int = 0; i <  gd.length; i++)
				{
					id[i] = gd[ i ][GlobalData.QUESTLIST_ID];
					title[i] = gd[ i ][GlobalData.QUESTLIST_TITLE]
					cat[i] = gd[ i ][GlobalData.QUESTLIST_CATEGORY];
					hint[ i ] = gd[i ][GlobalData.QUESTLIST_HINTSCRIPT];
					npcS[ i ] = gd[ i ][GlobalData.QUESTLIST_NPCSCRIPT];
					npcImage[ i ] = gd[ i ][GlobalData.QUESTLIST_NPCIMAGE];
					questCommand[ i ] = gd[ i ][GlobalData.QUESTLIST_COMMAND];
					isAccepted[ i ] = gd[ i ][GlobalData.QUESTLIST_ISACCEPTED];
					//df
					questStat [i] = gd[ i ][GlobalData.QUESTLIST_ISNEW];
					
					questList.push( new QuestDetailHolder( id[i] , cat[i] , title[i], hint[ i ] , npcS[ i ],questStat [i], i, npcImage[ i ], questCommand[ i ], isAccepted[ i ] ) );
				}
				this.dispatchEvent( new Event("DATA_LOADED"));
				if( GlobalData.instance.onAnimateQuest ){
					_questEvent = new QuestEvent( QuestEvent.UPDATE_QUEST_DISPLAY_WITH_ANIMATION );
					_es.dispatchESEvent( _questEvent );
				}else {
					_questEvent = new QuestEvent( QuestEvent.UPDATE_QUEST_DISPLAY_WITHOUT_ANIMATION );
					_es.dispatchESEvent( _questEvent );
				}
			}
		}
		
		public function popWinwindow():void {
			_questWin();
			trace(" WINDOW POP UP [ WIN ]");
		}  
		
		public function clrListenerAndArray():void 
		{
			_es.removeEventListener(SSEvent.QUESTLISTXML_LOADED, onXMLLoadedQuestList );
			clrArray();
		}
	}
} 
