package 
{
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;

	public class fadebutton extends MovieClip
	{

		var twn0:Tween;
		var twn1:Tween;
		var isLocked:Boolean;

		public function fadebutton()
		{
			this.buttonMode = true;
			btn1.alpha = 0;
			addEventListener(MouseEvent.CLICK,mClick);
			addEventListener(MouseEvent.MOUSE_OVER,mOver);
			addEventListener(MouseEvent.MOUSE_OUT,mOut);
			// constructor code
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
			alphaTo(1,.5);
		}
		private function collapse():void
		{
			alphaTo(0,.5);
		}
		public function fullExpand():void
		{
			isLocked=false;
			collapse();
			fullAlphaTo(1,.5);
		}
		public function fullCollapse():void
		{
			isLocked=false;
			collapse();
			fullAlphaTo(0,.5);
		}
		private function alphaTo(aa:Number,tt:Number):void
		{
			btn1.visible = true;
			if (twn0 != null)
			{
				twn0.stop();
			}
			twn0 = new Tween(btn1,"alpha",Strong.easeOut,btn1.alpha,aa,tt,true);
			twn0.addEventListener(TweenEvent.MOTION_FINISH,twn0Finish);
		}
		private function twn0Finish(e:TweenEvent):void
		{
			if (btn1.alpha == 0)
			{
				btn1.visible = false;
			}
			else
			{
				btn1.visible = true;
			}
		}
		private function fullAlphaTo(aa:Number,tt:Number):void
		{
			visible = true;
			if (twn1 != null)
			{
				twn1.stop();
			}
			twn1 = new Tween(this,"alpha",Strong.easeOut,alpha,aa,tt,true);
			twn1.addEventListener(TweenEvent.MOTION_FINISH,twn0FullFinish);
		}
		private function twn0FullFinish(e:TweenEvent):void
		{
			if (alpha == 0)
			{
				visible = false;
			}
			else
			{
				visible = true;
			}
		}

	}

}