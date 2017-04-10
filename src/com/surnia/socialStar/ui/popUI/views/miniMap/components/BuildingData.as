package com.surnia.socialStar.ui.popUI.views.miniMap.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class BuildingData extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/
		public static const NORMAL_COLOR:int = 0;
		public static const GRAY_COLOR:int = 1;
		public static const RED_COLOR:int = 2;
		
		public var building:MovieClip;	
		public var buildingRed:MovieClip;
		public var buildingGray:MovieClip;
		
		public var id:String;			
		public var nameBuilding:String = "";
		public var nameNPC:String;
		public var npcFN:int;
		
		public var icon:MovieClip;
		public var fn:uint;
		public var lvlreq:uint=1;	
		public var clear:Boolean;
		public var gameID:Array;
		public var gameName:Array;
		public var currentGameFN:int;
		public var currentGameNewFN:int;
		public var X:int;
		public var Y:int;
		
		public var buildingReq:String;
		
		public var roundContest:Array = [];
		
		//round contest data	
		public var roundID:Array = [];
		public var roundType:Array = [];
		public var roundDifficulty:Array = [];
		public var roundOrder:Array = [];
		public var roundStatus:Array = [];
		public var roundDuration:Array = [];
		public var roundCoin:Array = [];
		public var roundAP:Array = [];
		public var roundScript:Array = [];	
		
		public var container:Sprite = new Sprite;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function BuildingData(_currentGameFN:int, _roundContest:Array, _building:MovieClip, _buildingRed:MovieClip, _buildingGray:MovieClip, _fn:uint, _X:uint, _Y:uint, _name:String = "n/a", _clear:Boolean =false, buildingId:String = "", buildReq:String = "", namenpc:String = "", npcfn:int = 1  )			
		{					
			building = _building;	
			buildingRed	= _buildingRed;
			buildingGray	= _buildingGray;
			currentGameFN = _currentGameFN;
		
			buildingReq = buildReq;
			
			X = _X;
			Y = _Y;
			
			nameBuilding = _name;
			nameNPC = namenpc;
			
			fn = _fn;
			npcFN = npcfn;
			
			id = buildingId;				
			roundContest = _roundContest;	
			
			building.gotoAndStop(_fn);			
			buildingRed.gotoAndStop(_fn);		
			buildingGray.gotoAndStop(_fn);		
			
			
			building.x = X;
			building.y = Y;	
			
			buildingRed.x = X;
			buildingRed.y = Y;
			
			buildingGray.x = X;
			buildingGray.y = Y;
			
			//lvlreq = _lvreq;
			clear = _clear;		
		}
	}		
}