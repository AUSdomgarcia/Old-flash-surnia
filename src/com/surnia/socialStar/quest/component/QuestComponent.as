package com.surnia.socialStar.quest.component 
{
	import com.surnia.socialStar.quest.Model.QuestDetailHolder;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author DF
	 */
	public class QuestComponent extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		public var quest:QuestDetailHolder;
		public var callBack:Function;
		
		public var id:String;
		
		public var questID:String;
		public var questCommand:String;
		public var questIcon:MovieClip;
		public var questTerms:Array;
		public var questName:String;
		public var questCat:String;
		public var questRewardExp:String;
		public var questRewardCoin:String;
		public var questHint:String;
		public var questScript:String;
		public var npcImage:String;
		public var isAccepted:String;
		
		public var isNew:Number;
		
		public var isNewQuest:MovieClip;
		
		public var rewards:Array;
		public var terms:Array;		
		
		private	var _gf:GlowFilter = new GlowFilter(0xFCD116, 1.0, 6, 6, 50);		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTORS
		 * ----------------------------------------------------------------------------------------------------------*/
		public function QuestComponent(questEntity:QuestDetailHolder, questCallBack:Function, newQuest:MovieClip) 
		{
			quest		= questEntity;
			callBack	= questCallBack;
			isNewQuest		= newQuest;
			
			initialization();
			display();
			addListeners();
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			
			rewards = new Array();
			questTerms = new Array();			
			
			questID 	= quest.id;
			rewards = quest.rewards;
			questIcon 	= quest.mcIcon;
			questTerms 	= quest.terms;
			questName	= quest.title;
			questCat	= quest.category;
			isNew		= quest.isNew;
			npcImage    = quest.npcImage;
			questCommand = quest.questCommand;
			isAccepted = quest.isAccepted;
			
			//questRewardExp	 = quest.reward[0];
			//questRewardCoin	 = quest.reward[1];
			questScript	= quest.npcScript;
			questHint	= quest.hintScript;
		}
		
		private function display():void {
			if(questIcon != null){
				addChild(questIcon);
			}
			
			//CHECK IF QUEST IS NEW
			if(isNew == 1){
				if (isNewQuest != null) {
					addChild(isNewQuest);
				}
			}
			else {
				if (isNewQuest != null) {
					if (this.contains(isNewQuest)) {
						removeChild(isNewQuest);
					}
				}
			}				
			isNewQuest.x = questIcon.width / 2;
			isNewQuest.y = questIcon.y - (isNewQuest.height / 2);
		}
		
		public function addListeners():void {
			questIcon.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			questIcon.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			questIcon.addEventListener(MouseEvent.CLICK, onMouseClick);
		}		
		public function removeListeners():void {
			if(questIcon != null){
				questIcon.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
				questIcon.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
				questIcon.removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
		}
		
		public function nullAllInstances():void {
			questIcon.nullAllInstances();
			removeListeners();
			
			if (questIcon != null) {
				if (this.contains(questIcon)) {
					removeChild(questIcon);
					questIcon = null;
				}
			}
			
			if (callBack != null) {				
				callBack = null;				
			}
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onMouseOver(e:MouseEvent):void {			
			questIcon.filters = [_gf];
		}
		private function onMouseOut(e:MouseEvent):void {		
			questIcon.filters = [];
		}
		private function onMouseClick(e:MouseEvent):void {		
			callBack(questID);
		}
	}

}