package com.surnia.socialStar.minigames.popupUI.test 
{
	import com.surnia.socialStar.minigames.popupUI.model.RewardModel;
	import com.surnia.socialStar.minigames.popupUI.manager.RewardManager;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author domz
	 */
	public class VictoryRewardController extends Sprite
	{
		private var rewardModel:RewardModel;
		private var rewardManager:RewardManager;
		public var INVITE:String;
		public var SHARE:String;
		public var WIN:String;
		public var LOSE:String;
		public var CLOSE:String;
		
		public function VictoryRewardController( stref:Stage, _x:Number, _y:Number, _spt:Sprite ) 
		{
			rewardModel = new RewardModel( stref );
			rewardManager = new RewardManager( rewardModel, _x, _y, _spt );
			
			INVITE = rewardModel.INVITE;
			SHARE = rewardModel.SHARE;
			WIN = rewardModel.WIN;
			LOSE = rewardModel.LOSE;
			CLOSE = rewardModel.CLOSEME;
			
		}
		public function setReward( str:String, arrIndex1:Number, arrIndex2:Number ):void {
			rewardManager.setReward( str, arrIndex1, arrIndex2 );
		}
		
		public function show():void {
			rewardManager.addItem();
		}
	}

}