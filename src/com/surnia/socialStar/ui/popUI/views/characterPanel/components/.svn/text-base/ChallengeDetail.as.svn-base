package com.surnia.socialStar.ui.popUI.views.characterPanel.components 
{
	import com.surnia.socialStar.data.GlobalData;
	/**
	 * ...
	 * @author df
	 */
	public class ChallengeDetail 
	{
		public var gameType:Array = [];
		public	var ap:Array = [];
		public	var coin:Array = [];
		public	var duration:Array = [];
		public var scriptNPC:Array = [];
		
		public	var val:Array = [];
		
		private var _gd:GlobalData;
		public function ChallengeDetail() 
		{		
			instantiation();
			setData();
		}
		
		private function instantiation():void 
		{
			_gd = GlobalData.instance;			
			val = _gd.challengeValuesDataArray;	
		}
		
		private function setData():void 
		{
			trace(this, "RETURN val:", val.length, val);
			for (var i:int = 0; i < val.length; i++ ) {
				gameType[i] = val[i][GlobalData.CHALLENGEVALUES_TYPE];
				ap[i]		= val[i][GlobalData.CHALLENGEVALUES_APCOST];
				coin[i]		= val[i][GlobalData.CHALLENGEVALUES_COINCOST];
				duration[i]	= val[i][GlobalData.CHALLENGEVALUES_DURA];					
				scriptNPC[i] = val[i][GlobalData.CHALLENGEVALUES_SCRIPT];
				trace(this, "RETURN val[i][GlobalData.CHALLENGEVALUES_SCRIPT]:",val[i][GlobalData.CHALLENGEVALUES_SCRIPT]);
			}	
		}
		
		public function getApByType(type:int = 0):int {
			var gameAP:int;
			for (var i:int = 0; i < val.length; i++ ) {
				if (type == gameType[i]) {
					gameAP = ap[i];
				}				
			}	
			
			return gameAP;
		}
		
		public function getCoinByType(type:int = 0):int {
			var gameCoin:int;
			for (var i:int = 0; i < val.length; i++ ) {
				if (type == gameType[i]) {
					gameCoin = coin[i];
				}				
			}	
			
			return gameCoin;
		}
		
		public function getDurationByType(type:int = 0):int {
			var gameDuration:int;
			for (var i:int = 0; i < val.length; i++ ) {
				if (type == gameType[i]) {
					gameDuration = duration[i];
				}				
			}	
			
			return gameDuration;
		}
		
		public function getScripNPCByType(type:int = 0):String {
			var gameScript:String;
			for (var i:int = 0; i < val.length; i++ ) {
				if (type == gameType[i]) {
					gameScript = scriptNPC[i];
				}				
			}				
			return gameScript;
		}
	}

}