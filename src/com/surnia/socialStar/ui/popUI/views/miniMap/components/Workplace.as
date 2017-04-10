package com.surnia.socialStar.ui.popUI.views.miniMap.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Workplace extends MovieClip
	{
		public static const NORMAL_COLOR:int = 0;
		public static const GRAY_COLOR:int = 1;
		public static const RED_COLOR:int = 2;
		
		public var building:MovieClip;	
		public var buildingRed:MovieClip;
		public var buildingGray:MovieClip;
		
		public var id:String;			
		public var nameBuilding:String = "";
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
		
		public var gameFN:Array = [];
		
		public var container:Sprite = new Sprite;
		public function Workplace(_currentGameFN:int, _gameFN:Array, _building:MovieClip, _buildingRed:MovieClip, _buildingGray:MovieClip, _fn:uint, _X:uint, _Y:uint, _name:String = "n/a", _lvreq:uint = 1, _clear:Boolean =false, buildingId:String = ""  )			
		{					
			building = _building;	
			buildingRed	= _buildingRed;
			buildingGray	= _buildingGray;
			currentGameFN = _currentGameFN;
			
			X = _X;
			Y = _Y;
			nameBuilding = _name;
			fn = _fn;
			
			//_gameID = gameID;
			//_gameName = gameName;
			gameFN = _gameFN;	
			
			building.gotoAndStop(_fn);			
			buildingRed.gotoAndStop(_fn);		
			buildingGray.gotoAndStop(_fn);		
			
			
			building.x = X;
			building.y = Y;	
			
			buildingRed.x = X;
			buildingRed.y = Y;
			
			buildingGray.x = X;
			buildingGray.y = Y;
			
			lvlreq = _lvreq;
			clear = _clear;					
			
			displayBuilding();
		}
		private function displayBuilding():void{
			container = building;
			this.addChild(container);
			
		}
		
		public function switchNormal():void {	
			if (container.parent != null) {
				if (container !=null) {
					this.removeChild(container);
				}
			}
			container = building;
			this.addChild(container);
		}
		
		public function switchRed():void {			
			if (container.parent != null) {
				if (container !=null) {
					this.removeChild(container);
				}
			}
			container = buildingRed;
			this.addChild(container);			
		}
		
		public function switchGray():void {			
			if (container.parent != null) {
				if (container !=null) {
					this.removeChild(container);
				}
			}
			container = buildingGray;
			this.addChild(container);
			}
	}
}