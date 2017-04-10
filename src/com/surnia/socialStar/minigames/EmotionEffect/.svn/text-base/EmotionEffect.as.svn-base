package com.surnia.socialStar.minigames.EmotionEffect 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class EmotionEffect extends Sprite
	{
		//Model
		public var PERFEC_EMOTE:String = "PERFEC_EMOTE";
		public var GOOD_EMOTE:String = "GOOD_EMOTE";
		public var LOSE_EMOTE:String = "LOSE_EMOTE";
		public var WINNING_EMOTE:String = "WINNING_EMOTE";
		
		private var arrString:Array = [];
		private var goodMc:FeatherGood = new FeatherGood();
		private var perfectMc:FeatherPerfect = new FeatherPerfect();
		private var lose:WindLOSEPOP = new WindLOSEPOP();
		private var win:WinPOP = new WinPOP();
		public var strX:String;
		private var target:Sprite;

		public function EmotionEffect() 
		{
			arrString["PERFEC_EMOTE"] = perfectMc;
			arrString["GOOD_EMOTE"] = goodMc;
			arrString["LOSE_EMOTE"] = lose;
			arrString["WINNING_EMOTE"] = win;
		}
		
		public function getEmotion( str:String, x:Number, y:Number , setScaleX:Number, spt:Sprite ):void {
			
			target = spt;
			strX = str;
			arrString[strX].scaleX *= setScaleX;
			arrString[strX].x = x;
			arrString[strX].y = y;
			target.addChild( arrString[ strX ] );
		}
		
		public function removeEmotion():void {
			if ( arrString[strX] != null ) {
				target.removeChild( arrString[strX] );
				strX = null;
			}
		}
//end	
	}
}