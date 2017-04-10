package com.surnia.socialStar.minigames.popupUI.model 
{
	import flash.display.Stage;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author domz
	 */
	public class VersusWindowModel 
	{
		public var window:VersusWindow = new VersusWindow();
		public var st:Stage;
		public var SHARE:String = "SHARE_REWARD";
		public var WINNER:String = "WINNER";
		public var LOSE:String = "LOSE";
		public var CLOSE:String = "CLOSE";
		public var arrText:Array = [ ["Better luck next time", "What a close match !" ],
								 ["Your are so great! ", "You got it! "]
							   ];
		
		public var newformat:TextFormat = new TextFormat();
		public function VersusWindowModel( ) 
		{
		
		}
//end
	}
}