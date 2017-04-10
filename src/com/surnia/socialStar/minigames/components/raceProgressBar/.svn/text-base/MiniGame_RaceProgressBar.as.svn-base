package com.surnia.socialStar.minigames.components.raceProgressBar
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Droids
	 */
	public class MiniGame_RaceProgressBar extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		public var progressBar:Bitmap;
		public var player:*;
		public var rival:*;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_RaceProgressBar(progressBar:Bitmap, player:*, rival:*)
		{
			this.progressBar=progressBar;
			this.player=player;
			this.rival=rival;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addChild(this.progressBar);
			this.player.x=this.progressBar.x;
			this.player.y=this.progressBar.y+10;
			this.rival.x=this.progressBar.x;
			this.rival.y=this.progressBar.y-10;
			this.addChild(this.rival);
			this.addChild(this.player);

		}
		private function destroyMe(evt:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
			while(this.numChildren)
			{
				this.removeChildAt(0);	
			}
			this.progressBar=null;
			this.player=null;
			this.rival=null;
		}
	}
}