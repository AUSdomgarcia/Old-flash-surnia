package com.surnia.socialStar.quest.test 
{
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class TestOutSide extends Sprite 
	{
		private var _main:MainView = new MainView();
		private var _qm:QuestManager = QuestManager.instance;
		
		public function TestOutSide() 
		{
			addChild( _main );
			makeShape();
		}
		private function makeShape():void {
			var square:Sprite = new Sprite();
				square.graphics.lineStyle(3,0x00ff00);
				square.graphics.beginFill(0xccffff);
				square.graphics.drawRect(0,0,100,50);
				square.graphics.endFill();
				square.x = 130;
				square.y = 130;
				square.buttonMode = true;
				square.addEventListener( MouseEvent.CLICK, ontrigger );
				addChild(square);
		}
		private function ontrigger( e:Event ):void {
			_qm.questAction( "own_officeitem_StarterBooks" );
		}

//end
	}
}