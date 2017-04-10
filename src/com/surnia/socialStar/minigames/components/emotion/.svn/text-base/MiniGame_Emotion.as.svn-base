package com.surnia.socialStar.minigames.components.emotion
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ...
	 * @author Droids
	 */
	public class MiniGame_Emotion extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _emo:MC_Emotion;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_Emotion()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		public function playEmo(num:int):void
		{
			this._emo.gotoAndStop(1);
			this._emo.gotoAndStop(num);
		}
		private function destroyMe(evt:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._emo=null;
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		public function set xAxis (x:Number):void
		{
			this._emo.x=x;
		}
		public function set yAxis (y:Number):void
		{
			this._emo.y=y;
		}
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		public function get xAxis ():Number
		{
			return this._emo.x;
		}
		public function get yAxis ():Number
		{
			return this._emo.y;
		}
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this._emo=new MC_Emotion();
			this.addChild(this._emo);
		}
	}
}