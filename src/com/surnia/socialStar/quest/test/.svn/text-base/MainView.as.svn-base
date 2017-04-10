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
	public class MainView extends Sprite
	{
		private var questDetail:QuestDetailHolder;
		private var qm:QuestManager;
		private var f:Function = new Function();
		public var m:QuestDataModel = new QuestDataModel(f);
		//private var _questPopup:questPopup;
		public var category:String;
	
		public function MainView()
		{
			m.addEventListener("DATA_LOADED", onLoaded);
		}
		
		private function onLoaded( e:Event ):void {
			qm = QuestManager.instance;
			qm.instanceQuestModel( m );
			initView();
			initShape();
		}
		
		private function initShape():void {
			var square:Sprite = new Sprite();
			addChild(square);
			square.graphics.lineStyle(3,0x00ff00);
			square.graphics.beginFill(0x0000FF);
			square.graphics.drawRect(0,0,200,70);
			square.graphics.endFill();
			square.x = stage.stageWidth / 2 - square.width / 2;
			square.y = stage.stageHeight / 2 - square.height / 2;
			square.addEventListener(MouseEvent.CLICK, onTrigger );
		}
		
		private function onTrigger(e:Event):void 
		{
			qm.questAction( "own_officeitem_StarterBooks" );
		}

		private function initView():void {
			trace("panel Loaded.. ");
			
			//getting quest terms
			for (var j:int = 0; j < m.questList.length; j++) 
			{
				m.questList[j].mcIcon.buttonMode = true;
				m.questList[j].mcIcon.y = m.questList[j].mcIcon.height * j;
				m.questList[j].mcIcon.addEventListener( MouseEvent.CLICK, onClick );
				m.questList[j].mcIcon.indexnum = j;
				m.questList[j].mcIcon.alpha = 1;
				m.questList[j].mcIcon.buttonMode = true;
				addChild( m.questList[j].mcIcon );	
			}
		}
		
		private function onClick( e:Event ):void {
			
			trace( "btnMC:",m.questList[ e.currentTarget.indexnum ].mcIcon );
			trace( "Terms:",m.questList[ e.currentTarget.indexnum ].terms );
			trace( "Reward:",m.questList[ e.currentTarget.indexnum ].reward );
			trace( "Title:",m.questList[ e.currentTarget.indexnum ].title );
			trace( "URL:",m.questList[ e.currentTarget.indexnum ].objimg_str );
			trace( "HintSript:", m.questList[ e.currentTarget.indexnum ].hintScript );
			trace( "NpcScript:", m.questList[ e.currentTarget.indexnum ].npcScript );
			trace( "Coin:", m.questList[ e.currentTarget.indexnum ].rewardCoin );
			trace( "Pexp:", m.questList[ e.currentTarget.indexnum ].rewardPexp );
			trace( "Ahave:", m.questList[ e.currentTarget.indexnum ].amountHave );
			trace( "AReq:", m.questList[ e.currentTarget.indexnum ].amountReq );
			
		}

//end		
	}

}