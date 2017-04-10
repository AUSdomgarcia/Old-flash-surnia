package com.surnia.socialStar.test 
{	
	import com.surnia.socialStar.utils.dataManager.DataManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class TestDataManager extends Sprite
	{		
		public function TestDataManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var dataManager:DataManager = new DataManager();
			
			//
			var url:String = "http://127.0.0.1/poker/testRequest.php";
			var url2:String = "http://127.0.0.1/poker/tester.php";
			var url3:String = "http://127.0.0.1/poker/textme.txt";		
			var url4:String = "http://127.0.0.1/poker/testValuePair.php";
			var url5:String = "http://tada.zeratool.net/index.php/dialog/json";
			var url6:String = "http://tada.zeratool.net/index.php/dialog/post";
			var url7:String = "http://127.0.0.1/poker/testNavi.php";
			var url8:String = "http://tada.zeratool.net/index.php/dialog/choose_payment";
			var url9:String = "http://apps.facebook.com/surniatrailer/fb/fl.php";
			var url10:String = "http://1.234.2.179/socialstardev/public/tests/jc/testsend.php";
			var url11:String = "http://1.234.2.179/socialstardev/messages/send/1211416091";
			
			//send message user
			var useFbid:String = "1373812866";
			var url12:String = "http://1.234.2.179/socialstardev/messages/send/" + useFbid;
			
			//delete message
			var msgid:String = "yZfQJwKgaIDHGiY4Jn4LDdx1upxNtTHI99e85wIfhSuJUojsPZTiupMgyB664kuo6WBhJ93h1UiaGn6MhmTTNdjtu7B7OPh4PF";			
			var url13:String = "http://1.234.2.179/socialstardev/messages/deletemsg/" + msgid +"/1";
			
			//extract all your messages user
			var url14:String = "http://1.234.2.179/socialstardev/messages/viewall";		
			
			//get messages of other player
			var fbId:String = "1373812866";
			
			var url15:String = "http://1.234.2.179/socialstardev/messages/viewall/" + fbId;
			
			//buy
			var itemId:String = "c8ctCwDpqWLIsJ8WI8E";
			var url16:String = "http://1.234.2.179/socialstardev/offices/buy/" + itemId;
			
			//sell
			var entryId:String = "EI4nKttPGWSXjZFJxqEJ";
			var url17:String = "http://1.234.2.179/socialstardev/offices/sell/" + entryId;
			
			
			//1373812866
			//req for jason ecnoded data
			
			//dataManager.sendRequest( url10 );
			//dataManager.sendRequest( url9  );
			//dataManager.sendNavigateToUrl( url10 );
			dataManager.sendRequestVariables( url17 );
			
			//passed variables and recieve that variables
			//dataManager.sendRequestVariables( url10, false );
			//dataManager.sendNavigateToUrl( url9, false, false );
		}
		
	}

}