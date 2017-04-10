package com.surnia.socialStar.quest.views 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.quest.Manager.QuestManager;
	import com.surnia.socialStar.quest.Model.QuestDataModel;
	import com.surnia.socialStar.quest.Model.QuestDetailHolder;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import flash.display.MovieClip;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import flash.xml.*;
	import com.greensock.TweenLite;
	/**
	 * ...jerik
	 * 
	 */
	public class questPopup extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
			
		//private var _questPopup:questPopup;
		//private var _questDone:questDone;
		public var id:String;
		public var category:String;
		public var title:String;
		public var questIconUrl:String;
		public var social_xp:String;
		public var social_coins:String;
		
		public var quest_popup:MovieClip;
		
		/*----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		public function questPopup ():void 
		{
			
			//setDataDisplay("df", "cat001", "testtitle", "stringicon", "50", "100");
			
		}
		
		public function setDataDisplay (_id:String, _category:String , _title:String, _questIconUrl:String, _social_xp:String, _social_coins:String):void
		{
			
			id = _id;
			category = _category;
			title = _title;
			questIconUrl = _questIconUrl;
			social_xp = _social_xp;
			social_coins = _social_coins
			
			
			
			switch( category ) {
				case "cat001":
					quest_popup = new questPopup1();
				break;
				
				case "cat002":
					quest_popup = new questPopup2();
				break;
				
				case "cat003":
					quest_popup = new questPopup3();
				break;
			}
			if (quest_popup != null) {
				if (this.contains(quest_popup)) {
					removeChild(quest_popup);
				}
			}
			
			addChild( quest_popup );
			
			quest_popup.popup_texts.questTitle.text = _title;
			quest_popup.popup_texts.ss_xp.text = _social_xp;
			quest_popup.popup_texts.ss_coin.text = _social_coins;
			quest_popup.popup_texts.closeBtn.buttonMode = true;
			
			//loadImage(_questIconUrl);
			
			quest_popup.popup_texts.closeBtn.addEventListener(MouseEvent.CLICK, closeQuestPopup)	
			
			
			
		}
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
	
		 
		//load object icon-----------------
		//private var imageLoader:Loader;
 
		//public function loadImage(url:String):void {
		
		//imageLoader = new Loader();
		//imageLoader.load(new URLRequest(url));
		//imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
		//}
		//loadImage(url);
		 
		//public function imageLoaded(e:Event):void {
		
		//quest_popup.popup_texts.questObj_holder.addChild(imageLoader);
		//}
		 
	

		//----------------------------------------------------------------------------------------
	
		
		public function closeQuestPopup():void {
			
			this.removeChild(quest_popup);
			//setDataDisplay (_id:String, _category:String , _title:String, _questIconUrl:String, _social_xp:String, _social_coins:String);
			
		}
		
		
		//display questdonepopup
		
		
		
		
	}

}