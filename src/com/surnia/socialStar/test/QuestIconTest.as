package com.surnia.socialStar.test 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class QuestIconTest extends Sprite
	{
		private var _mc:QuestIConMC;
		
		public function QuestIconTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			_mc = new QuestIConMC();
			addChild( _mc );
			_mc.gotoAndStop( "cat003" );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
	}

}