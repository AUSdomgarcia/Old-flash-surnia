package 
{
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;

	public class raisebutton extends MovieClip
	{

		private var twn0:Tween;
		private var twn1:Tween;
		public var isLocked:Boolean;
		private var mc:MovieClip

		public function raisebutton()
		{
			this.buttonMode = true;
			addEventListener(MouseEvent.CLICK,mClick);
			mc=new MovieClip();
			mc.graphics.beginFill(0,0);
			mc.graphics.drawRect(0,-10,width,height)
			mc.buttonMode=true;
			mc.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT,mOut);
			addChild(mc);
		}
		
		public function set setLock(bb:Boolean):void
		{
			isLocked = bb;
			if (bb)
			{
				expand();
			}
			else
			{
				collapse();
			}
		}
		private function mOver(e:MouseEvent):void
		{
			expand();
		}
		private function mOut(e:MouseEvent):void
		{
			if (! isLocked)
			{
				collapse();
			}
		}
		private function mClick(e:MouseEvent):void
		{
			expand();
			dispatchEvent(new Event("clicked"));
		}
		private function expand():void
		{
			tweenTo(-10,.5);
		}
		private function collapse():void
		{
			tweenTo(0,.5);
		}
		private function tweenTo(yy:Number,tt:Number):void
		{
			if (twn0 != null)
			{
				twn0.stop();
			}
			twn0 = new Tween(btn1,"y",Strong.easeOut,btn1.y,yy,tt,true);
			twn0.addEventListener(TweenEvent.MOTION_FINISH,twn0Finish);
		}
		private function twn0Finish(e:TweenEvent):void
		{
		}
	}

}