package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.contestantData.ContestantData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class miniGameDataTest extends Sprite
	{	
		
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		
		public function miniGameDataTest() 
		{
			_es = EventSatellite.getInstance();
			_sdc  = ServerDataController.getInstance();
			_sdc.getMiniGameData();
			_es.addEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_DATA_COMPLETE, onShowMiniGameData );
		}
		
		
		private function onShowMiniGameData(e:ServerDataControllerEvent):void 
		{			
			var myContestant:ContestantData = _sdc.myContestant;
			var friendContestant:ContestantData = _sdc.friendContestant;
			
			trace( "my contestant data", myContestant.name, myContestant.lvl, myContestant.sing, myContestant.intelligent, myContestant.health
			,myContestant.gender, myContestant.fbid, myContestant.cid, myContestant.attraction, myContestant.acting, myContestant.bodydef );
			
			trace( "my friend contestant data", friendContestant.name, friendContestant.lvl, friendContestant.sing, friendContestant.intelligent, friendContestant.health
			,friendContestant.gender, friendContestant.fbid, friendContestant.cid, friendContestant.attraction, friendContestant.acting, friendContestant.bodydef );
		}
	}

}