package com.surnia.socialStar.ui.popUI.views.characterPanel 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.ChallengeDetail;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author DF
	 */
	public class TestChar extends Sprite
	{
		private var _characterPanel:CharacterPanel;		
		private var _es:EventSatellite;
		private var _popUpUIPanel:PopUpUIManager;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		
		private var _challengeDetails:ChallengeDetail;
		private var _rivalCid:String;
		private var _myCid:String;
		private var _params:Object = new Object;
		private var _isRevenge:Boolean = false;
		public function TestChar() 
		{				
			intantiation();
			addESListeners();
			
			if (_characterPanel != null) {					
				removeChild(_characterPanel);
				_characterPanel = null;						
			}				
			
			_characterPanel = new CharacterPanel();	
			_characterPanel.setGameProgramNumber(0);
			addChild(_characterPanel);					
			
			//removeChild(_characterPanel);	
			_characterPanel.y = 50;
			
			//_characterPanel.closeGame();
			_characterPanel.setMode(CharacterPanel.CHALLENGE_FRIEND_MODE);
			
			trace( "[TestChar]: _gd.isRevengeFbid checker b4 call 1", _gd.isRevengeFbid, "_gd.isRevenge", _gd.isRevenge );
			
			
			if ( !_gd.isRevenge ) {
				_isRevenge = false;
				trace( "RETURN challenge _gd.selectedFriendFbId / _gd.selectedFriendCid : ", _gd.selectedFriendFbId, "_gd.selectedFriendCid: ", _gd.selectedFriendCid );
				//_sdc.getRandomContestantFromFriend( _gd.selectedFriendFbId );
				_sdc.getFriendContestant( _gd.selectedFriendFbId, _gd.selectedFriendCid );
			}else {
				_isRevenge = true;
				trace( "RETURN revenge _gd.isRevengeFbid / _gd.isRevengeCharID : ", _gd.isRevengeFbid, "_gd.isRevengeCharID: ", _gd.isRevengeCharID );
				_params.fbid = _gd.isRevengeFbid;
				//_sdc.getRandomContestantFromFriend( _gd.isRevengeFbid );				
				_sdc.getFriendContestant( _gd.isRevengeFbid, _gd.isRevengeCharID );							
			}			
			
			//remove rival display
			_characterPanel.removeRival();
			//display();			
		}			
		
		private function intantiation():void 
		{
			_gd = GlobalData.instance;
			_sdc = ServerDataController.getInstance();
			_popUpUIPanel = PopUpUIManager.getInstance();
			_es = EventSatellite.getInstance();				
		}
		
		private function addESListeners():void 
		{
			_es.addEventListener(CharacterPanelEvent.PANEL_CLOSE, closeFunction)
			_es.addEventListener(CharacterPanelEvent.CHARACTER_SELECT, onSelectClick)
			_es.addEventListener(CharacterPanelEvent.PROGRAM_SELECT, onProgramSelect)
			
			_es.addEventListener(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_COMPLETE, onChallengeFriendComplete );			
			_es.addEventListener(ServerDataControllerEvent.ON_CHALLENGE_FRIEND_CONTESTANT_FAILED, onChallengeFriendFailed );
			
			/*
			_es.addEventListener(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_COMPLETE, onChallengeRouteComplete );
			_es.addEventListener(ServerDataControllerEvent.ON_ROUTE_CHALLENGE_FAILED, onChallengeRouteFailed );
			*/
			
			//df: jan 19, 2012 - uncomment this two line, and functions 'onLoadRandomContestantComplete' and 'onGetRandomContestantFailed'  
			_es.addEventListener( ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_COMPLETE, onLoadRandomContestantComplete  );
			_es.addEventListener( ServerDataControllerEvent.ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED, onGetRandomContestantFailed  );
			//df
			
			_es.addEventListener( ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_COMPLETE, onLoadFriendContestantComplete  );
			_es.addEventListener( ServerDataControllerEvent.ON_GET_FRIEND_CONTESTANT_FAILED, onGetFriendContestantFailed  );
		}		
		
		/*
		private function onChallengeRouteFailed(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.ON_ROUTE_CHALLENGE_FAILED;
			_es.dispatchESEvent( popUpUIEvent );
			trace( "[TestChar]: on load random contestant Failed!!.............................. " );
		}
		*/
		
		/*
		private function onChallengeRouteComplete(e:ServerDataControllerEvent):void 
		{
			_sdc.getRandomContestantFromFriend( _gd.isRevengeFbid );
		}
		*/
		
		private function display():void {				
			//_characterPanel = null;
			//memory management display			
			
			var mem:MemoryProfiler = new MemoryProfiler();
			addChild(mem);			
			var frame:FrameRateViewer = new FrameRateViewer();
			addChild(frame);				
		}
		
		private function closeFunction(e:CharacterPanelEvent):void {
			if (_characterPanel != null){
				removeChild(_characterPanel);
				_characterPanel = null;				
			}									
			
			/*df: jan 18, 2012 - comment this statement
			//new  01112012
			if( _gd.friendView ){
				_gd.friendCharListDataArray = [new Array()];
				_sdc.updateFriendCharlist(GlobalData.instance.selectedFriendFbId);
				trace( "[TestChar]: Give me back my friend Charlists" );
			}else {
				trace( "[TestChar]: Give me back my contestant Charlists" );
			}
			*/
			
			_gd.isRevenge = false;
			_gd.isRevengeFbid = null;
			_popUpUIPanel.removeWindow( WindowPopUpConfig.CONTESTANT_SELECION_WINDOW );
			
		}	
		
		private function setDataByProgram(program:Object):void {
			/*
			var gameType:Array = [];
			var ap:Array = [];
			var coin:Array = [];
			var duration:Array = [];
			
			var val:Array = _gd.challengeValuesDataArray;	
			
			trace(this, "RETURN val:", val.length, val);
			for (var i:int = 0; i < val.length; i++ ) {
				gameType[i] = val[i][GlobalData.CHALLENGEVALUES_TYPE];
				ap[i]		= val[i][GlobalData.CHALLENGEVALUES_APCOST];
				coin[i]		= val[i][GlobalData.CHALLENGEVALUES_COINCOST];
				duration[i]	= val[i][GlobalData.CHALLENGEVALUES_DURA];					
				
				if (gameType[i] == program.selectionProgramNumber || gameType[i] == program.selectionProgram) {
					//set player coin, ap, gametime
					
					trace(this, "RETURN _characterPanel:", _characterPanel);
					if(_characterPanel != null){
						_characterPanel.setPlayerCoin(ap[i]);
						_characterPanel.setPlayerAP(coin[i]);
						_characterPanel.setGameTime(duration[i]);	
					}
				}
			}	
			
			*/	
			
			_challengeDetails = new ChallengeDetail;
			
			var ap:int			= _challengeDetails.getApByType( program.selectionProgramNumber);
			var coin:int		= _challengeDetails.getCoinByType(program.selectionProgramNumber);
			var duration:int	= _challengeDetails.getDurationByType(program.selectionProgramNumber);
			var scriptNPC:String = _challengeDetails.getScripNPCByType(program.selectionProgramNumber);
			
			trace(this, "RETURN _challengeDetails AP/coind/duration:", ap, coin, duration);
			if(_characterPanel != null){				
				_characterPanel.setPlayerAP(ap);
				_characterPanel.setPlayerCoin(coin);
				_characterPanel.setGameTime(duration);	
				_characterPanel.setBossScript(scriptNPC);				
			}
			
		}
		
		private function onProgramSelect(e:CharacterPanelEvent):void 
		{
			var playerObj:Object = e.params;	
			
			trace(this, " RETURN PROGRAM STRING: ", playerObj.selectionProgram );
			trace(this, " RETURN PROGRAM NUMBER: ", playerObj.selectionProgramNumber );
			
			if(playerObj != null){
				setDataByProgram(playerObj);
			}
		}	
		
		public function onSelectClick(e:CharacterPanelEvent):void {	
			var playerObj:Object = e.params;			
			
			trace(this, " CALL BACK! ", playerObj.charName);
			trace(this, " CALL BACK! ", playerObj.charLevel);
			trace(this, " CALL BACK! ", playerObj.charExp);
			trace(this, " CALL BACK! ", playerObj.charGender);		
			trace(this, " CALL BACK! ", playerObj.charCondition);
			trace(this, " CALL BACK! ", playerObj.charGrade);		
			
			trace(this, " CALL BACK! ", playerObj.definition);
			trace(this, " CALL BACK! ", playerObj.charPopular);
			trace(this, " CALL BACK! ", playerObj.charStress);
			trace(this, " CALL BACK! ", playerObj.charHealth);
			trace(this, " CALL BACK! ", playerObj.charSing);
			trace(this, " CALL BACK! ", playerObj.charIntelligence);
			trace(this, " CALL BACK! ", playerObj.charActing);
			trace(this, " CALL BACK! ", playerObj.charAttraction);		
			trace(this, " CALL BACK! ", playerObj.charID );
			
			trace(this, " CALL BACK! ", playerObj.selectionProgram );
			trace(this, " CALL BACK! ", playerObj.selectionProgramNumber );
			if( _isRevenge == true ){					
				_es.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.REVENGE_ACCEPTED, _params));
			}
			
			_gd.selectionProgram = playerObj.selectionProgram;
			_myCid = playerObj.charID;	
			
			_sdc.challengeFriendContestant( playerObj.charID, _rivalCid );			
		}
		
		
		private function onLoadFriendContestantComplete(e:ServerDataControllerEvent):void 
		{
			_rivalCid = e.contestantData.cid;
			
			trace(this, "RETURN 1 e.contestantData.gender / e.contestantData.name / e.contestant.cid:",e.contestantData.gender, e.contestantData.name, e.contestantData.cid);
			trace(this, "RETURN 1 e.contestantData.bodydef:", e.contestantData.bodydef);
			if( _characterPanel != null ){
				_characterPanel.removeRival();
				_characterPanel.setRivalStat( e.contestantData.lvl, e.contestantData.acting, e.contestantData.attraction, e.contestantData.health, e.contestantData.intelligent,
				e.contestantData.sing, e.contestantData.gender, e.contestantData.name, e.contestantData.bodydef );	
			}
		}
		
		private function onLoadRandomContestantComplete(e:ServerDataControllerEvent):void 
		{
			_rivalCid = e.contestantData.cid;
			
			trace(this, "RETURN 2 e.contestantData.gender / e.contestantData.name / e.contestant.cid:",e.contestantData.gender, e.contestantData.name, e.contestantData.cid);
			trace(this, "RETURN 2 e.contestantData.bodydef:", e.contestantData.bodydef);
			if( _characterPanel != null ){
				_characterPanel.removeRival();
				_characterPanel.setRivalStat( e.contestantData.lvl, e.contestantData.acting, e.contestantData.attraction, e.contestantData.health, e.contestantData.intelligent,
				e.contestantData.sing, e.contestantData.gender, e.contestantData.name, e.contestantData.bodydef );
			}
		}
		
		private function onChallengeFriendComplete(e:ServerDataControllerEvent):void 
		{			
			_sdc.setMiniGameData( _myCid, _rivalCid , _gd.selectionProgram, 40 );
			_popUpUIPanel.removeWindow( WindowPopUpConfig.CONTESTANT_SELECION_WINDOW );
			trace( "[TestChar]: on Challenge Friend complete minigame will load now!!.............................. " );
		}
		
		private function onChallengeFriendFailed(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.ON_CHALLENGE_FRIEND_FAILED;
			_es.dispatchESEvent( popUpUIEvent );
			trace( "[TestChar]: on Challenge Friend Failed!!.............................. " );
		}
		
		private function onGetFriendContestantFailed(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.ON_LOAD_FRIEND_CONTESTANT_FAILED;
			_es.dispatchESEvent( popUpUIEvent );
			trace( "[TestChar]: onGetFriendContestantFailed!!.............................. " );			
		}
		
		private function onGetRandomContestantFailed(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.ON_LOAD_FRIEND_CONTESTANT_FAILED;
			_es.dispatchESEvent( popUpUIEvent );
			trace( "[TestChar]: on load random contestant Failed!!.............................. " );			
		}
	}

}