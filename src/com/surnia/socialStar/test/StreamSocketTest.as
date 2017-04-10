package com.surnia.socialStar.test 
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.XMLSocket;
	import flash.system.Security;
	/**
	 * ...
	 * @author JC
	 */
	public class StreamSocketTest extends Sprite
	{
		
		
		/*-------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		public function StreamSocketTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE,init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("http://monsterpatties.net");
			Security.allowDomain("http://localhost");
			Security.allowDomain("http://127.0.0.1");
			Security.allowDomain("http://b.static.ak.fbcdn.net");			
			Security.allowDomain("https://graph.facebook.com/");
			Security.allowDomain("http://monsterpatties.net/stargazer/credits.swf");
			Security.allowDomain("http://monsterpatties.net/stargazer/");
			Security.allowDomain("http://monsterpatties.net");
			Security.allowDomain("http://202.124.129.14");
			Security.allowDomain("xmlsocket://202.124.129.14");
			//http://1.234.2.179/socialstardev/public/tests/jc/SocialStar.swf
			//xmlsocket://202.124.129.14:35000
			//202.124.129.14:35000
			
			connect();
		}
		
		/*-------------------------------------------------------------------------Methods-----------------------------------------------------------*/
		private function connect():void 
		{
			var xmlSocket:XMLSocket = new XMLSocket();
			xmlSocket.connect("202.124.129.14", 35000 );
		
			xmlSocket.send( "hello world" );
			
			xmlSocket.addEventListener( DataEvent.DATA, onIncomingData);
			trace( "connecting............" );
		}
		/*-------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Eventhandlers--------------------------------------------------------------*/
		
		private function onIncomingData(e:DataEvent):void
		{
			trace( "ddawdwadwadwa", "[" + e.type + "] " + e.data);
			trace( "connected............" );
		}
		
	}

}