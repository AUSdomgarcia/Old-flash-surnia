package com.surnia.socialStar.test 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class AddingCharTest extends MovieClip
	{
		private var mc:character;
		
		public function AddingCharTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE,init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChar();
		}
		
		
		private function addChar():void 
		{
			mc = new character();
			addChild( mc );
			mc.x = 200;
			mc.y = 200;
			mc.isDebug = true;
			mc.addEventListener("ready2",mcready);
			//TweenLite.to( mc, 1, { x:mc.x - 100 } );
			//TweenLite.to( mc, 1, { x:mc.x - 100 } );
			//addEventListener( Event.ENTER_FRAME, onGameloop );
		}
		
		private function mcready(e:Event ):void {
			//mc.setType = "0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303";
			mc.setType = "616161611111101050708030307030303030303030303030303030303030103030303030303030303030303030303030303030303030303040303030303030303030303030303030303030303030303";
		}
		
		
		private function onGameloop(e:Event):void 
		{
			mc.x = mouseX;
			mc.y = mouseY;
		}
		
	}

}