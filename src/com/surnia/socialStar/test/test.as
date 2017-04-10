package com.surnia.socialStar.test 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author DF
	 */
	public class test extends Sprite 
	{
		private var _worldMap:mainPopUpManagerTest;
		public function test() 
		{
			_worldMap = new mainPopUpManagerTest(stage);
			this.addChild(_worldMap);
			
			_worldMap.remove();
			_worldMap.remove();
			_worldMap.display();
		}
		
	}

}