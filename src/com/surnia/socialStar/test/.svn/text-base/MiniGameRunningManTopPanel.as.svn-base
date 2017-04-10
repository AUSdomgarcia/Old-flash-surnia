package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.minigames.runningMan.model.StatusModel;
	import com.surnia.socialStar.minigames.runningMan.view.StatusManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author domz
	 */
	public class MiniGameRunningManTopPanel extends Sprite 
	{
		private var managertopPanel:StatusManager;
		private var modeltopPanel:StatusModel;
		public function MiniGameRunningManTopPanel( stref:Stage, isLive:Boolean, x:Number, y:Number, _sp:Sprite )
		{
			modeltopPanel = new StatusModel( stref );
			managertopPanel = new StatusManager( modeltopPanel, isLive, x , y , _sp );
		}
		public function setRoundText( num:Number ):void {
			modeltopPanel.rounds = num;
			managertopPanel.setRoundText = modeltopPanel.rounds + " \n ROUND";
		}
		public function setWeekText( num:Number, indexs:Number ):void{
			modeltopPanel.week = num;
			modeltopPanel.article[indexs];
			managertopPanel.setWeekText =  modeltopPanel.week + modeltopPanel.article[indexs] +" " + " Week";
		}
		public function getStatus( val:Number ,desX:Number, fromY:Number, toY:Number ):void {
			managertopPanel.getStatus(  val, desX, fromY, toY );
		}
		public function statusUpdate():void {
			managertopPanel.updateStatusShow();
		}
		
		public function removeSelf():void {
			managertopPanel.removeStatus();
		}
	}
}