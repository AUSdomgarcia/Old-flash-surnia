package com.surnia.socialStar.ui.questUI
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.questUI.event.QuestEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	public class QuestController extends EventDispatcher
	{
		
		private var _mainView:Sprite;
		private var _questScrollerView:QuestScrollerView;
		private var _questPopupView:QuestPopupView;
		private var _questNPCView:QuestNPCView;
		
		public function QuestController(mainView:Sprite)
		{
			_mainView = mainView;
		}
		
		public function startQuestController():void{
			_questScrollerView = new QuestScrollerView();
			_mainView(_questScrollerView);
			addListeners();
		}
		
		private function addListeners():void{
			
		}
	}
}