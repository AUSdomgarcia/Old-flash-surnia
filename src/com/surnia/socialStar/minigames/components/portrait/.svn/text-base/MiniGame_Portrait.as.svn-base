package com.surnia.socialStar.minigames.components.portrait
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class MiniGame_Portrait extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _pictureHolder:*;
		private var _pictureFrame:Bitmap;
		private var _arrowAnim:MovieClip
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_Portrait(pictureHolder:*, pictureFrame:Bitmap, arrowAnim:MovieClip)
		{
			this._pictureHolder=pictureHolder;
			this._pictureFrame=pictureFrame;
			this._arrowAnim=arrowAnim;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			init();
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init():void
		{
			this._pictureFrame.width=60;
			this._pictureFrame.height=60;
			this.addChild(this._pictureFrame);
			if(this._pictureHolder!=null)
			{
				this._pictureHolder.x=5;
				this._pictureHolder.y=5;
				this._pictureHolder.width=47;
				this._pictureHolder.height=47;
				this.addChild(this._pictureHolder);
			}
			if(this._arrowAnim!=null)
			{
				this._arrowAnim.x =-3.35;
				this._arrowAnim.y =-44.9;
				this.addChild(this._arrowAnim);
				this._arrowAnim.gotoAndStop(3);
			}
		}
		public function moveArrow(frame:int):void
		{
			this._arrowAnim.gotoAndStop(frame);
		}
		private function destroyMe():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._pictureHolder=null;
			this._pictureFrame=null;
			this._arrowAnim=null;
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function removeFromStage(evt:Event):void
		{
			destroyMe();
		}
	}
}