package com.surnia.socialStar.test 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SampleBasicClass 
	{
		/*-------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		public function SampleBasicClass() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}				
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			
		}
		
		private function removeDisplay():void 
		{
			
		}
		/*-------------------------------------------------------------Setters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/		
	}

}