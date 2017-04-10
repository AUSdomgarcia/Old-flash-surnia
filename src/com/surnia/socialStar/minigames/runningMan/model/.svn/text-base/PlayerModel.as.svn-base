package com.surnia.socialStar.minigames.runningMan.model 
{
	/**
	 * ...
	 * @author domz
	 */
	public class PlayerModel 
	{
		private var strDef:String;
		//Basic Info
		public var pName:String;
		public var pGender:String;
		public var pCid:String;
		//Attribute
		public var pStr:Number;
		public var pInt:Number;
		public var pSing:Number;
		public var pActing:Number;
		// UI
		public var pRank:Number;
		public var pLvl:Number;
		public var pExp:Number;
		public var pCurrentCoint:Number;
		public var pCurrentActionPoint:Number;
		//HeadDefinition
		
		public var pHair:Number;
		public var pHat:Number;
		public var pEye:Number;
		public var pNose:Number;
		public var pMouth:Number;
		public var pJawline:Number;
		public var pFcolor:Number;
		public var pGlasses:Number;
		public var pEarings:Number;
		public var pHairLayer2:Number;
		public var phatLayer2:Number;
		
		public function PlayerModel( _str:String )
		{
			strDef = _str;
			extractStrDef();
		}
		private function extractStrDef():void {
			//Mini Map Use
			pHair = parseInt( strDef.substr( 0, 2 ));
			pHat = parseInt( strDef.substr( 4, 2 ));
			pEye = parseInt( strDef.substr( 6, 2 ));
			pNose = parseInt( strDef.substr( 8, 2 ));
			pMouth = parseInt( strDef.substr( 10, 2 ));
			pJawline = parseInt( strDef.substr( 12, 2 ));
			pFcolor = parseInt( strDef.substr( 14, 2 ));
			pGlasses = parseInt( strDef.substr( 16, 2 ));
			pEarings = parseInt( strDef.substr( 18, 2 ));
			pHairLayer2 = parseInt( strDef.substr( 20, 2 ));
			phatLayer2 = parseInt( strDef.substr( 22, 2 ));
			
			
			// MiniGames use
			pName =  strDef.substr(24, 2);
			pGender = strDef.substr(26, 2);
			pCid = strDef.substr(28, 2);
			pStr = Number( strDef.substr(30, 2));
			pSing = Number(strDef.substr(32, 2));
			pActing = Number(strDef.substr(34, 2));
			pRank = Number(strDef.substr(36, 2));
			pLvl = Number(strDef.substr(38, 2));
			pExp = Number(strDef.substr(40, 2));
			pCurrentCoint = Number(strDef.substr(42, 2));
			pCurrentActionPoint = Number(strDef.substr(44, 2));
		}

		//Setter
		public function set setPname( str:String ):void {
			pName = str;
		}
		public function set setGender( str:String ):void {
			pGender = str;
		}
		public function set setpCid( str:String ):void {
			pCid = str;
		}
		public function set setpStr( val:Number ):void {
			pStr = val;
		}
		public function set setpSing( val:Number ):void {
			pSing = val;
		}
		public function set setpActing( val:Number ):void {
			pActing = val;
		}
		public function set setpRank( val:Number ):void {
			pRank = val;
		}
		public function set setpLvl( val:Number ):void {
			pLvl = val;
		}
		public function set setpExp( val:Number ):void {
			pExp = val;
		}
		public function set setpCurrentCoint( val:Number ):void {
			pCurrentCoint = val;
		}
		public function set setpCurrentActionPoint( val:Number ):void {
			pCurrentActionPoint = val;
		}

		//Getter
		public function get getPname():String {
			return pName;
		}
		public function get getpGender():String {
			return pGender;
		}
		public function get getpCid():String {
			return pCid;
		}
		public function get getpStr():Number {
			return pStr;
		}
		public function get getpActing():Number {
			return pActing;
		}
		public function get getpRank():Number {
			return pRank;
		}
		public function get getpLvl():Number {
			return pLvl;
		}
		public function get getpExp():Number {
			return pExp;
		}
		public function get getpCurrentCoint():Number {
			return pCurrentCoint;
		}
		public function get getpCurrentActionPoint():Number {
			return pCurrentActionPoint;
		}
			
		//end	
	}
}