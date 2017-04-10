package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class JsManagerTest extends Sprite
	{
		
		private var _jsm:JsManager;
		
		
		public function JsManagerTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_jsm = JsManager.getInstance();
			
			//var js:String = "$('.game').load('http://1.234.2.179/socialstardev/game/invite');";
			//_jsm.runJS( js );
			//_jsm.callJs( "jsFunction", "hahhahaehhehehe" );
			_jsm.callJs( "addFriend",".game" );
		}
		
	}

}