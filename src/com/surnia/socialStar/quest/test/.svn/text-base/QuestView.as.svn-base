package com.surnia.socialStar.quest.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import com.surnia.socialStar.quest.Model.QuestDataModel;
	import com.surnia.socialStar.quest.Model.QuestDetailHolder;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class QuestView extends Sprite
	{
		private var questDetail:QuestDetailHolder;
		private var m:QuestDataModel = new QuestDataModel;
	
		public function QuestView()
		{
			m.addEventListener("DATA_LOADED", onLoaded);
			addListener();
		}
		
		private function addListener():void {
				
		}
		
		private function onLoaded( e:Event ):void {
			initView();
			QuestManager.getInstance();
			QuestManager.instance.instanceQuestModel( m );
		}
		
		private function initView():void {
			trace("panel Loaded.. ");
			for (var i:int = 0; i < 2; i++)
			{
				var square:Sprite = new Sprite();
				square.graphics.lineStyle(3,0x00ff00);
				square.graphics.beginFill(0x0000FF);
				square.graphics.drawRect(0,0,100,100);
				square.graphics.endFill();
				square.x = 130 * i;
				square.y = 130;
			
				square.addEventListener( MouseEvent.CLICK, ontrigger );
				addChild(square);
			}
			
			//getting quest terms
			for (var j:int = 0; j < m.questList.length; j++) 
			{
				m.questList[j].mcIcon.y = 100 * j;
				m.questList[j].mcIcon.addEventListener( MouseEvent.CLICK, onClick );
				m.questList[j].mcIcon.indexnum = j;
				addChild( m.questList[j].mcIcon );
			}
		}
		
		private function onClick( e:Event ):void {
			trace( m.questList[ e.currentTarget.indexnum ].mcIcon );
			trace( m.questList[ e.currentTarget.indexnum ].terms );
			trace( m.questList[ e.currentTarget.indexnum ].reward );
		}
		
		/*private function ontrigger( e:Event ):void {
			
			var arr:Array = QuestManager.instance.getQTerms(0);
			for (var i:int = 0; i < arr.length; i++) 
			{
				trace( arr[i] );
			}
		}*/
		
		private function initialize():void {
			QuestManager.getInstance();
			QuestManager.instance.instanceQuestModel(m);
			ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.offlineQuestListData);
		}
		
		private function ontrigger( e:Event ):void {
			//QuestManager.instance.questAction( "neighbor_npc_visit" );
			//QuestManager.instance.getQTerms( 0 );
			//createPanelLeft();
			
			var arr:Array = [];
			
			/* [DISPLAY] for (var i:int = 0; i < QuestManager.instance.m.questList.length; i++) 
			{
				arr.push( new QuestDetailHolder( QuestManager.instance.m.questList[i], "cat" + i, "title","img",i,i ));
				trace(arr[i].pexp);
			}*/
		}
//end		
	}

}