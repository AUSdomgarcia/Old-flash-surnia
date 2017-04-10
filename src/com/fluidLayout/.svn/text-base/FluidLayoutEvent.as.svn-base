package com.fluidLayout 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FluidLayoutEvent extends Event 
	{
		
		public static const DONE_TWEENING:String = "DONE_TWEENING";
		
		public function FluidLayoutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FluidLayoutEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FluidLayoutEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}