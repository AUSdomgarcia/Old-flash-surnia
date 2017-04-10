package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class ThreeButtonManager extends MovieClip
	{

		private var mc:MovieClip;
		private var active:Boolean = true;

		public function ThreeButtonManager()
		{
			mc=new MovieClip();
			mc.graphics.beginFill(0,0);
			mc.graphics.drawRect(0,0,width,height);
			mc.buttonMode = true;
			mc.addEventListener(MouseEvent.MOUSE_UP,mUp);
			mc.addEventListener(MouseEvent.MOUSE_DOWN,mDown);
			mc.addEventListener(MouseEvent.MOUSE_OVER,mOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT,mOut);
			mc.addEventListener(MouseEvent.CLICK,mClick);
			addChild(mc);
			setActive(1);
		}
		function set isEnabled(bb:Boolean):void
		{
			if (bb)
			{
				setActive(1);
			}
			else
			{
				setActive(2);
			}
			active = bb;
		}
		function setActive(num:Number)
		{
			switch (num)
			{
				case 0 :
					btn0.visible = true;
					btn1.visible = false;
					btn2.visible = false;
					mc.buttonMode=true;
					break;
				case 1 :
					btn0.visible = false;
					btn1.visible = true;
					btn2.visible = false;
					mc.buttonMode=true;
					break;
				case 2 :
					btn0.visible = false;
					btn1.visible = false;
					btn2.visible = true;
					mc.buttonMode=false;
					break;
			}
		}
		function mDown(e:MouseEvent):void{
			if (active){
				setActive(0);
			}
		}
		function mUp(e:MouseEvent):void{
			if (active){
				setActive(0);
			}
		}
		function mOver(e:MouseEvent):void
		{
			if (active)
			{
				setActive(0);
			}
		}
		function mOut(e:MouseEvent):void
		{
			if (active)
			{
				setActive(1);
			}
		}
		function mClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("clicked"));
		}

	}

}