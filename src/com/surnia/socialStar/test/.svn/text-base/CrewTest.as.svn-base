package com.surnia.socialStar.test
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.views.crew.CrewView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;

	[SWF (height = "630", width="760")]
	public class CrewTest extends Sprite
	{
		private var _staffUI:CrewView;
		private var _charlistLoaded:Boolean = false;
		private var _friendlistLoaded:Boolean = false;
		public function CrewTest()
		{
			Security.loadPolicyFile("crossdomain.xml");
			Security.allowDomain("http://b.static.ak.fbcdn.net");	
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("http://b.static.ak.fbcdn.net");	
			Security.allowDomain("202.124.129.14");
			Security.allowDomain("1.234.2.179");
			Security.allowDomain("localhost");
			Security.allowDomain("https://graph.facebook.com/");
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(ev:Event = null):void{
			ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, "testXML/charlist.xml");
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, "testXML/fl.xml");
			EventSatellite.getInstance().addEventListener(SSEvent.CHARLISTXML_LOADED, onLoaded);
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDXML_LOADED, onLoaded);
		}
		
		public function onLoaded (ev:SSEvent):void{
			switch(ev.type)
			{
				case SSEvent.FRIENDXML_LOADED:
				{
					_friendlistLoaded = true;
					break;
				}
				case SSEvent.CHARLISTXML_LOADED:
				{
					_charlistLoaded = true;
					break;
				}
				
			}
			if (_friendlistLoaded == true && _charlistLoaded == true){
				allLoaded();	
			}
		}
		
		public function allLoaded():void{
			_staffUI = new CrewView();
			addChild(_staffUI);
			_staffUI.init();
			_staffUI.updateCharData(GlobalData.instance.charListDataArray[0][GlobalData.CHARLIST_ID]);
		}
	}
}