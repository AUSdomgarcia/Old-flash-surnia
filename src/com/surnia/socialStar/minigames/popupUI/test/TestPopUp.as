package com.surnia.socialStar.minigames.popupUI.test
{
	import com.surnia.socialStar.minigames.EmotionEffect.EmotionEffect;
	import com.surnia.socialStar.minigames.popupUI.test.VersusPopUpController;
	import com.surnia.socialStar.minigames.popupUI.test.VictoryRewardController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class TestPopUp extends Sprite
	{
		private var newPic1:contestBrainMC = new contestBrainMC();
		private var newPic2:contestLoveMC = new contestLoveMC();
		
		private var btn2:glovesUI= new glovesUI();
		
		private var btn:UICloseBtn = new UICloseBtn();
		private var emo:EmotionEffect = new EmotionEffect();
		
		public function TestPopUp() 
		{
			btn.addEventListener(MouseEvent.CLICK, trigger);
			addChild(btn);
			btn2.y = 50;
			addChild(btn2 );
			btn2.addEventListener(MouseEvent.CLICK, trigger);
			
			this.addEventListener("POST_VICTORY", function():void { trace("POSTVICTORY"); } );
			this.addEventListener("INVITE_FRIEND", function():void { trace("INVITE"); } );
			this.addEventListener("SHARE_REWARD", function():void { trace("SHAREREWARD"); } );
			this.addEventListener("CLOSE", function():void { trace("CLOSE"); } );
			
		}
		
		private function trigger( e:Event ):void {
			
			switch( e.currentTarget ) {
				case btn:
					var versus:VersusPopUpController = new VersusPopUpController( 50, 50, this );
					versus.setDialog( " Dominador E. Garcia III \n Surnia Entertainment Inc. " , 1 );//Optional
			
					var result:Number = 0;
					result = Math.floor( Math.random() * 1 )
					var arr:Array = new Array("WINNER","WINNER");
					
					
					
					versus.setWindowValues( /*arr[result]*/ "WINNER" , 1 );
					//versus.setPicLeft( newPic2 );
					//versus.setPicRight( newPic1 );
					versus.show();
					
					
					emo.getEmotion( emo.WINNING_EMOTE, 300 , 0, 1 , this);
				
				break;
				case btn2:
					var reward:VictoryRewardController = new VictoryRewardController( stage, 50, 50, this );
					reward.setReward( reward.LOSE, 1, 1);
					reward.show();
					
					if ( this.emo != null ) {
						emo.removeEmotion();
					}
				break;
			}
		}
//end
	}
}