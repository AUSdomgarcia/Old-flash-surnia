package com.surnia.socialStar.utils.rewardComponents
{
	import com.surnia.socialStar.utils.CountdownTimer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author Droids
	 */	
	public class RewardPopUpMain extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _parent:MovieClip;
		private var _popUp:FX_PopUp;
		private var _text:FX_ObjectTab;
		private var _hasCoin:Boolean;
		private var _countDownTimer:CountdownTimer;
		
		
		private var _hour:int;
		private var _minute:int;
		private var _second:int;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function RewardPopUpMain(parent:MovieClip, hour:int, minute:int, second:int)
		{
			this._parent=parent;
			this._hour=hour;
			this._minute=minute;
			this._second=second;
			this._parent.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/

		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function init(evt:Event):void
		{
			this._parent.removeEventListener(Event.ADDED_TO_STAGE, init);
			this._parent.addEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
			this._parent.addEventListener(MouseEvent.CLICK, mouseClick);
			this._parent.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this._parent.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			this._popUp=new FX_PopUp();
			this._popUp.name="MyPopUp";
			this._popUp.width=45;
			this._popUp.height=54;
			this._popUp.x=(this._parent.width/2) - (this._popUp.width/2);
			this._popUp.y=(this._parent.height/this._parent.height)-this._popUp.height/2;
			this._popUp.gotoAndStop(1);
			this._popUp.visible=false;
			this._parent.addChild(this._popUp);		
			this._text=new FX_ObjectTab();
			this._text.x=(this._parent.width/2) - (this._text.width/2);
			this._text.y=(this._parent.height/this._parent.height)-this._text.height/2;
			this._text.visible=false;
			this._parent.addChild(this._text)
			this._countDownTimer = new CountdownTimer(1000);
			this._countDownTimer.setMaxTime(this._second, this._minute, this._hour)
			this._countDownTimer.addEventListener(CountdownTimer.INTERVAL_ENDED, onTimerIntervalEnded);
			this._countDownTimer.start();
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(evt:Event):void
		{
			this._text.myText.text="More in: " + this._countDownTimer.timeValue
		}
		private function destroyMe(evt:Event):void
		{
			this._parent.removeEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
			this._parent.removeEventListener(MouseEvent.CLICK, mouseClick);
			this._parent.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this._parent.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			this._countDownTimer.removeListeners();
			this._countDownTimer.removeEventListener(CountdownTimer.INTERVAL_ENDED, onTimerIntervalEnded);
			
			this._countDownTimer.stop();
			
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._parent=null;
			this._popUp=null;
		}
		private function mouseClick(evt:Event):void
		{
			if(this._hasCoin==true)
			{
				this._hasCoin=false;
				this._popUp.visible=false;

				this._countDownTimer.start();
			}
		}
		private function mouseOver(evt:MouseEvent):void
		{
			if(this._hasCoin==true)
			{
				this._popUp.play();
			}
			else
			{
				this._text.visible=true;
			}
		}
		private function mouseOut(evt:MouseEvent):void
		{
			this._text.visible=false;
		}
		private function onTimerIntervalEnded(evt:Event):void
		{
			this._text.visible=false;
			this._hasCoin=true
			this._popUp.play();
			this._popUp.visible=true;
			this._countDownTimer.stop();
		}
	}
}