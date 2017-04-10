package com.surnia.socialStar.test 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author JC
	 */
	public class HireCharWindowTest extends Sprite
	{
		/*--------------------------------------------------------------------------------------Constant-------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------------Properties-----------------------------------------------------*/
		private var _mc:mc_hire;
		private var _charShop:mc_shop;
		/*--------------------------------------------------------------------------------------Constructor-------------------------------------------------------*/
		
		public function HireCharWindowTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		
		private function init(e:Event):void 
		{
			trace( "init hire char window!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" );
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			setDisplay();
		}
		
		/*--------------------------------------------------------------------------------------Methods-------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc =  new mc_hire();
			addChild( _mc );			
			
			_mc.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_mc.addEventListener( "ready2", onReadyToHire );			
			_mc.addEventListener("closed",onCloseHireCharWindow );
			_mc.addEventListener("hired",onHiredChar );
			_mc.addEventListener("charselected",onSelectChar );
			
			//_charShop = new mc_shop();
			//addChild(_charShop);
			//_charShop.gender = 1;
			//_charShop.setType = "0100010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888";						
			//_charShop.addEventListener('itembought', _onAvatarUpdate);
			//_charShop.addEventListener('close', _onAvatarShopClose);
		}
		
		private function onSelectChar(e:Event):void 
		{
			trace( "character selected..................................." );
		}
		
		private function onHiredChar(e:Event):void 
		{
			trace( "character hired!! selected..................................." );
		}
		
		private function onCloseHireCharWindow(e:Event):void 
		{
			trace( " on close window character selected..................................." );
		}
		
		private function onReadyToHire(e:Event):void 
		{
			trace( "dwadawdwadwadawdwa................");
			
			//_mc.loadXML("http://1.234.2.179/socialstardev/characters/create");
			//_mc.loadXML("../lib/Avatar/generator/_samplerandomchar.xml");
			_mc.loadXML("_samplerandomchar.xml");			
			//_mc.creditsCoin = 5000;
			//_mc.creditsCash = 8000;
			//_mc.visible = ;
			//_mc.y += 100;
			//
			//_mc.addEventListener('closed', _onAvatarStaffClose);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "on error!!!!!!!!!!!!!!!!!!" );
		}
		
		//private function _onAvatarStaffClose(e:Event):void 
		//{
			//
		//}
		
		//private function _onAvatarShopClose(e:Event):void 
		//{
			//trace( "hire shop close na!!!!!!!!!!!!" );
		//}
		
		//private function _onAvatarUpdate(e:Event):void 
		//{
			//
		//}
		
		
		/*--------------------------------------------------------------------------------------Setters-------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------------Getters-------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------------EventHandlers------------------------------------------------*/
	}

}