package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatelite;		
	import com.surnia.socialStar.ui.friendUI.view.FriendUI;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FriendUITest extends Sprite
	{		
		/*-----------------------------------------------------------------------------Constant---------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Properties-------------------------------------------------------*/
		private var _es:EventSatelite;
		/*-----------------------------------------------------------------------------Constructor------------------------------------------------------*/
		private var _friendUI:FriendUI;
		
		public function FriendUITest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		/*-----------------------------------------------------------------------------Methods------------------------------------------------------*/
		
		
		private function setDisplay():void 
		{
			_es = EventSatelite.getInstance();
			_es.addEventListener( MainMenuUIEvent.CHARACTER_BTN_CLICK, onCharacterBtnClick );
			_es.addEventListener( MainMenuUIEvent.CLOSET_BTN_CLICK, onClosetBtnClick );
			_es.addEventListener( MainMenuUIEvent.INVENTORY_BTN_CLICK, onInventoryBtnClick );
			_es.addEventListener( MainMenuUIEvent.COLLECTION_BTN_CLICK, onCollectionBtnClick );
			_es.addEventListener( MainMenuUIEvent.OFFICE_BTN_CLICK, onOfficeBtnClick );
			_friendUI = new FriendUI();
			addChild( _friendUI );			
			
			_friendUI.y = 300;
		}				
		
		/*-----------------------------------------------------------------------------Setters------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Getters------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Eventhandlers------------------------------------------------------*/
		private function onCharacterBtnClick(e:MainMenuUIEvent):void 
		{
			trace( "char btn click!!!!!!!!!!!!!!!" );
		}
		
		private function onOfficeBtnClick(e:MainMenuUIEvent):void 
		{
			trace( "office btn click!!!!!!!!!!!!!!!" );
		}
		
		private function onCollectionBtnClick(e:MainMenuUIEvent):void 
		{
			trace( "collection btn click!!!!!!!!!!!!!!!" );
		}
		
		private function onInventoryBtnClick(e:MainMenuUIEvent):void 
		{
			trace( "Inventory btn click!!!!!!!!!!!!!!!" );
		}
		
		private function onClosetBtnClick(e:MainMenuUIEvent):void 
		{
			trace( "closet btn click!!!!!!!!!!" );
		}
	}

}