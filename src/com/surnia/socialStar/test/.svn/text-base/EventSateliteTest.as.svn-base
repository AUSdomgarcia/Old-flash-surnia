package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatelite;
	import com.surnia.socialStar.ui.FriendUI.events.FriendUIEvent;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class EventSateliteTest extends Sprite
	{
		
		/*---------------------------------------------------------------Constant---------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties-------------------------------------------------------------------------*/
		private var _es:EventSatelite;
		/*---------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		public function EventSateliteTest() 
		{
			trace( "es test init.................." );
			_es = EventSatelite.getInstance();
			
			var fUIEvent:FriendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN );			
			var fUIEvent2:FriendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN2 );
			var fUIEvent3:FriendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN3 );			
			
			_es.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN, onFeedBack );
			_es.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN2, onFeedBack2 );
			_es.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN3, onFeedBack3 );			
			
			
			_es.dispatchESEvent( fUIEvent2 );
			_es.dispatchESEvent( fUIEvent3 );
			_es.dispatchESEvent( fUIEvent );
		}
		
		
		/*---------------------------------------------------------------Methods---------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Setters---------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Getters---------------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		private function onFeedBack(e:FriendUIEvent):void 
		{
			trace( "feed back1........................." );
		}
		
		private function onFeedBack3(e:FriendUIEvent):void 
		{
			trace( "feed back3........................." );
		}
		
		private function onFeedBack2(e:FriendUIEvent):void 
		{
			trace( "feed back2........................." );
		}
	}

}