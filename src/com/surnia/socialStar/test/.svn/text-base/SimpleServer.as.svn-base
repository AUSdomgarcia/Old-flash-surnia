package com.surnia.socialStar.test 
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.XMLSocket;
	/**
	 * ...
	 * @author JC
	 */
	public class SimpleServer extends Sprite
	{
		private var xmlSocket:XMLSocket;
		
		public function SimpleServer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			prepareClient();
			connect();
		}
		
		private function prepareClient():void 
		{
			xmlSocket = new XMLSocket();
			xmlSocket.addEventListener(DataEvent.DATA, onIncomingData);			
			xmlSocket.addEventListener(Event.CONNECT, onConnected);
			xmlSocket.addEventListener(Event.CLOSE, onConnectionClosed);
			xmlSocket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			
		}
		
		private function onIOError(evt:IOErrorEvent):void{
			trace("IO Error: " + evt);
		}
		private	function onConnectionClosed(e:Event):void {
			trace("Connection closed: " +  e.type );	
			exit();
		}	
		
		private function connect():void 
		{
			xmlSocket.connect("202.124.129.14", 35000 );
		}
			
		private function onConnected(msg:Event):void {
			
			//incomingChat_txt.htmlText += "Connected";
			//connect_btn.enabled = false;
			//xmlSocket.send(username_txt.text + "~has connected\n");
			trace( "connected!!!!!!!!!!!, ", msg );
			sendMessage();	
			//closeConnection();
		}
		
		private function exit():void 
		{
			xmlSocket.send("EXIT"); // server expects "EXIT", not "username~EXIT"
		}
		
		private function sendMessage():void 
		{
			xmlSocket.send( "abc/n");
			xmlSocket.send( "efg/n");			
			trace( "sending msg" );
		}
		
		private	function onIncomingData(e:DataEvent):void {
			trace("Incoming data " );
			trace("actual data ",e.data, e.type );
			//trace("Incoming data ("+evt.type+"): " + evt.data);
			//incomingChat_txt.htmlText += evt.data;			
		}
		
		private function closeConnection():void 
		{
			xmlSocket.close();
		}
	}

}