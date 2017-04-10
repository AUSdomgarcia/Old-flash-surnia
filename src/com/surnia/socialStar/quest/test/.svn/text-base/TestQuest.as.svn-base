package com.surnia.socialStar.quest.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class TestQuest extends Sprite
	{
		public function TestQuest() 
		{
			initialize();
			initShape();
		}
		
		private function initShape():void {
			
		var square:Sprite = new Sprite();
		square.graphics.lineStyle(3,0x00ff00);
		square.graphics.beginFill(0x0000FF);
		square.graphics.drawRect(0,0,100,100);
		square.graphics.endFill();
		square.x = 30;
		square.y = 30;
		
		square.addEventListener( MouseEvent.CLICK, ontrigger );
		addChild(square);
		}
		
		private function initialize():void {
			QuestManager.instance();
			QuestManager.instance.questModel();
			ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.offlineQuestListData);
		}
		
		private function ontrigger( e:Event ):void {
			QuestManager._instance.questAction( "neighbor_npc_visit" );
		}
//end		
	}

}