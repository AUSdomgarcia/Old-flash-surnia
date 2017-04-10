package com.surnia.socialStar.quest.Model 
{
	import com.surnia.socialStar.data.GlobalData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class QuestDetailHolder extends Sprite 
	{
		private var gd:GlobalData = GlobalData.instance;
		public var rewards:Array = [];
		public var terms:Array = [];

		public var id:String;
		public var title:String;
		public var category:String;
		public var qIcon:String;
		public var npcImage_Array:Array = ["0","1","2","3"];
		public var npcImage:String;
		public var randNum:Number;
		
		//new 
		public var questCommand:String;
		public var isAccepted:String;
		
		//Scripts
		public var mcIcon:QuestIConMC;
		public var hintScript:String;
		public var npcScript:String;

		//df
		public var isNew:Number;
		
		//new		
		public var reward:RewardListData;
		
		public function QuestDetailHolder( ids:String, categories:String , titles:String, hintScipts:String, npcScripts:String,questNew:Number, indexNum:Number , npcImageLive:String, questCommands:String, isAccepteds:String ) 
		{
			randNum = Math.floor( Math.random() * 3 );
			npcImage = npcImageLive;
			trace( "[QuestDetailHolder]: =========>npcImage", npcImage );
			qIcon = npcImage_Array[randNum];
			//QuestWindowMC
			mcIcon = new QuestIConMC;
			id = ids;
			category = categories;
			title = titles;
			questCommand = questCommands;
			isAccepted = isAccepteds;
			
			//df
			isNew = questNew;
			
			trace( "[QuestDetailHolder]: check categories: ", categories );
			
			if( mcIcon != null && categories != "" ){
				//mcIcon.gotoAndStop(categories);	
				mcIcon.face.gotoAndStop(categories);
			}else {
			}
			//QuestIconMC
			hintScript = hintScipts;
			npcScript = npcScripts;
			
			var arrTerms:Array = [];	
			var term:TermListData;
			arrTerms = gd.getQuestTermsDataByQuestID( gd.questListDataArray[ indexNum ][GlobalData.QUESTLIST_ID] );
			for (var i:int = 0; i < arrTerms.length; i++)
			{	
				term = new TermListData();
				term.id = arrTerms[ i ][GlobalData.QUESTLIST_TERM_ID];
				term.objectimage = arrTerms[ i ][GlobalData.QUESTLIST_TERM_OBJECTIMAGE] ;
				term.amountreq = arrTerms[ i ][GlobalData.QUESTLIST_TERM_AMOUNTREQUIRED] ;
				term.amounthave = arrTerms[ i ][GlobalData.QUESTLIST_TERM_AMOUNTHAVE] ;
				term.termcommand = arrTerms[ i ][GlobalData.QUESTLIST_TERM_COMMAND];
				term.status = arrTerms[ i ][GlobalData.QUESTLIST_TERM_STATUS];	
				term.conditiontext = arrTerms[ i ][GlobalData.QUESTLIST_TERM_CONDITIONTEXT];					
				terms.push( term );
			}
				
			
			var arrReward:Array = [];
			arrReward = gd.getQuestRewardDataByQuestID( gd.questListDataArray[ indexNum ][GlobalData.QUESTLIST_ID] );
			for (var xx:int = 0; xx < arrReward.length; xx ++)
			{
				reward = new RewardListData();				
				reward.qid = arrReward[ xx ][GlobalData.QUESTLIST_REWARD_QID ];
				reward.amount = arrReward[ xx ][GlobalData.QUESTLIST_REWARD_AMOUNT];
				reward.type = arrReward[ xx ][GlobalData.QUESTLIST_REWARD_TYPE];
				reward.qreward = arrReward[ xx ][GlobalData.QUESTLIST_REWARD_QUESTREWARD];
				rewards.push( reward );			
			}
		}
	}
}