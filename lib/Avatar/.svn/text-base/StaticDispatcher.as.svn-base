package 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.display.MovieClip;
	import fl.motion.Color;
	import flash.display.DisplayObject;

	public class StaticDispatcher implements IEventDispatcher
	{
		protected static const staticDispatcher:EventDispatcher = new EventDispatcher();

		static var obj:Object=new Object();
		static var arrListeners:Array = new Array();
		static var counter:Number = new Number(0);


		public function StaticDispatcher()
		{

		}

		static public function addEventListener(type:String, listener:Function, marker:String, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			return;
			var i:Number;
			counter++;
			/*for (i=arrListeners.length-1; i>=0; i--)
			{
			if (arrListeners[i].marker == marker)
			{
			staticDispatcher.removeEventListener(arrListeners[i].type,arrListeners[i].listener);
			arrListeners.splice(i,1);
			}
			}*/
			staticDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
			arrListeners.push({type:type,listener:listener,counter:counter,marker:marker});
			return (counter);
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			staticDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}



		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			staticDispatcher.removeEventListener( type, listener, useCapture );
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			staticDispatcher.removeEventListener( type, listener, useCapture );
		}




		static public function dispatchEvent(event:Event):Boolean
		{
			return staticDispatcher.dispatchEvent( event );
		}

		public function dispatchEvent(event:Event):Boolean
		{
			return staticDispatcher.dispatchEvent( event );
		}




		static public function hasEventListener(type:String):Boolean
		{
			return staticDispatcher.hasEventListener(type);
		}

		public function hasEventListener(type:String):Boolean
		{
			return staticDispatcher.hasEventListener(type);
		}




		static public function willTrigger(type:String):Boolean
		{
			return staticDispatcher.willTrigger(type);
		}

		public function willTrigger(type:String):Boolean
		{
			return staticDispatcher.willTrigger(type);
		}



		static public function testThisType():void
		{
			trace("dispatching event");

			dispatchEvent( new Event("test") );
		}

		static public function setVar(str:String,num:Number):void
		{
			obj[str] = num;
		}

		static public function updateAll():void
		{
			dispatchEvent(new Event("updated"));
		}

		static public function getVar(str:String):Number
		{
			return (obj[str]);
		}

		static public function processFrame(mc:MovieClip,str:String=""):Array
		{
			var i:Number;
			var i1:Number;
			var frameIndex:Number;
			var solidColor:uint;
			var lineColor:uint;
			var lmc:MovieClip = mc;
			var dobj:DisplayObject;
			var arr:Array=new Array();
			var color:Color;
			for (i=0; i<10; i++)
			{

				try
				{
					mc = MovieClip(mc.parent);
					if (mc.obj != null)
					{
						if (mc.obj['key'] == 123)
						{
							if (str!="")
							{
								frameIndex = mc.obj[str];
							}
						}
					}
				}
				catch (error:Error)
				{
					break;
				}
			}
			if (! isNaN(frameIndex))
			{
				if (frameIndex == 0)
				{
					lmc.visible = false;
				}
				else
				{
					lmc.visible = true;
					if (frameIndex != mc.currentFrame)
					{
						lmc.visible = true;
						lmc.gotoAndStop(frameIndex);
					}
				}
				//return (frameIndex);
			}
			return arr;
		}

		static public function getParentValues(mc:MovieClip,...parameters):Array
		{
			var arr:Array=new Array();
			var i:Number;
			var i1:Number;
			for (i=0; i<10; i++)
			{
				try
				{
					mc = MovieClip(mc.parent);
					if (mc.obj != null)
					{
						if (mc.obj['key'] == 123)
						{
							for (i1=0; i1<parameters.length; i1++)
							{
								arr.push(mc.obj[parameters[i1]]);
							}
							break;
						}
					}
				}
				catch (error:Error)
				{
				}

			}
			return arr;
		}
		static public function setPartColorArray(mc:MovieClip,...parameters):void
		{
			var color:Color;
			var i:Number;
			for (i=0; i<parameters.length/2; i++)
			{
				if (mc.getChildByName(parameters[i * 2]) != null)
				{
					color=new Color();
					if (parameters[i * 2 + 1] == undefined)
					{
						color.setTint(0x888888,1);
					}
					else
					{
						color.setTint(parameters[i*2+1],1);
					}
					mc[parameters[i * 2]].transform.colorTransform = color;
				}
			}

		}
		static public function setPartColor(mc:MovieClip,solidcol:uint=0x888888,bordercol:uint=0x888888,shadowcol:uint=0x888888):void
		{
			if (solidcol==0)
			{
				solidcol = 0x888888;
			}
			if (bordercol==0)
			{
				bordercol = 0x888888;
			}
			if (shadowcol==0)
			{
				shadowcol = 0x888888;
			}
			var color:Color;
			if (mc.getChildByName('solid') != null)
			{
				color=new Color();
				color.setTint(solidcol,1);
				mc['solid'].transform.colorTransform = color;
			}
			if (mc.getChildByName('border') != null)
			{
				color=new Color();
				color.setTint(bordercol,1);
				mc['border'].transform.colorTransform = color;
			}
			if (mc.getChildByName('shadowblend') != null)
			{
				color=new Color();
				color.setTint(shadowcol,1);
				mc['shadowblend'].transform.colorTransform = color;
			}

		}
		static public function getParentKey(mc:MovieClip,str:String=""):Number
		{
			var i:Number;
			for (i=0; i<10; i++)
			{
				try
				{
					mc = MovieClip(mc.parent);
					if (mc.obj != null)
					{
						if (mc.obj['key'] == 123)
						{
							return (mc.obj[str]);
							break;
						}
					}
				}
				catch (error:Error)
				{
				}

			}
			return NaN;
		}

		static public function clearEventListeners():void
		{
			for (var i:Number = 0; i<arrListeners.length; i++)
			{
				if (hasEventListener(arrListeners[i].type))
				{
					staticDispatcher.removeEventListener(arrListeners[i].type, arrListeners[i].listener);
				}
			}
			arrListeners = new Array();
		}

		static public function deleteEventListener(num:Number):void
		{
			var i:Number;
			for (i=0; i<arrListeners.length; i++)
			{
				if (arrListeners[i].counter == num)
				{
					staticDispatcher.removeEventListener(arrListeners[i].type, arrListeners[i].listener);
				}
			}
		}

	}
}