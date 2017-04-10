package com.surnia.socialStar.test
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.PopupManager;
	import com.surnia.socialStar.ui.popUI.views.staff.StaffView;
	import com.surnia.socialStar.ui.popUI.views.staff.event.StaffEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;

	[SWF (height = "630", width="760")]
	public class StaffTest extends Sprite
	{
		private var _popupManager:PopUpUIManager;
		private var _staffView:StaffView;
		
		private var _friendLoaded:Boolean = false;
		private var _officeStateLoaded:Boolean = false;
		public function StaffTest()
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
			
			ServerDataExtractor.instance.updateData(GlobalData.FRIENDS_DATA, "testXML/fl.xml");
			EventSatellite.getInstance().addEventListener(SSEvent.FRIENDXML_LOADED, onFriendLostLoaded);
			ServerDataExtractor.instance.updateData(GlobalData.OFFICESTATE_DATA, "testXML/officestate.xml");
			EventSatellite.getInstance().addEventListener(SSEvent.OFFICESTATEXML_LOADED, onOfficeStateLoaded);
			/*_staffView = new StaffView();
			addChild(_staffView);
			_staffView.init();*/
		}
		
		private function onFriendLostLoaded(ev:SSEvent):void{
			_friendLoaded = true;
			if (_friendLoaded == true && _officeStateLoaded == true){
				startStaffUI();
			}
		}
		
		private function onOfficeStateLoaded(ev:SSEvent):void{
			_officeStateLoaded = true;
			if (_friendLoaded == true && _officeStateLoaded == true){
				startStaffUI();
			}
		}
		
		private function startStaffUI():void{
			_popupManager = PopUpUIManager.getInstance();
			addChild(_popupManager);
			_popupManager.loadWindow(WindowPopUpConfig.STAFF_WINDOW);
			EventSatellite.getInstance().dispatchEvent(new StaffEvent(StaffEvent.UPDATE_STAFFITEMDATA, {itemEntryID:"hbBesGrlR5OKA9j4hOz"}));
		}
	}
}