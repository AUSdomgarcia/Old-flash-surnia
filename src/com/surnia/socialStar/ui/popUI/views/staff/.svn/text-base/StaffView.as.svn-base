package com.surnia.socialStar.ui.popUI.views.staff
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.staff.event.StaffEvent;
	import com.surnia.socialStar.utils.Logger;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class StaffView extends Sprite
	{
		private  var _staffMC:StaffMC;
		
		private var _staffEntryID:String;
		private var _staffDeskFrameNumber:String;
		private var _staffItemDataArray:Array = [];
		private var _isOnline:Boolean = true;
		
		private var _urlRequest:URLRequest;
		private var _loader:Loader;
		private var _loaderContext:LoaderContext;
		private var _popUIManager:PopUpUIManager = PopUpUIManager.getInstance();
		
		
		//new
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		private var _staffPositions:String;
		
		public function StaffView()
		{
			
		}
		
		public function init():void {
			
			_sdc = ServerDataController.getInstance();
			_es = EventSatellite.getInstance();
			
			_staffMC = new StaffMC();
			addChild(_staffMC);
			
			_staffMC.buyButton.enabled = true;
			_staffMC.buyButton.visible = true;
			
			_staffMC.hireButton.enabled = true;
			_staffMC.hireButton.visible = true;
			
			_staffMC.friendPortrait.visible = false;
			
			_staffMC.staffMC.gotoAndStop(85);
			
			/*_deskDisplay = new Icons();
			_staffMC.addChild(_deskDisplay);
			_deskDisplay.x = 76.45;
			_deskDisplay.y = 150;*/
			
			addListeners();
		}
		
		private function addListeners():void {						
			EventSatellite.getInstance().addEventListener(StaffEvent.UPDATE_STAFFITEMDATA, updateStaffData);
			_staffMC.buyButton.addEventListener(MouseEvent.CLICK, onClick);
			_staffMC.hireButton.addEventListener(MouseEvent.CLICK, onClick);
			_staffMC.closeButton.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function removeListeners():void{
			EventSatellite.getInstance().removeEventListener(StaffEvent.UPDATE_STAFFITEMDATA, updateStaffData);
			_staffMC.buyButton.removeEventListener(MouseEvent.CLICK, onClick);
			_staffMC.hireButton.removeEventListener(MouseEvent.CLICK, onClick);
			_staffMC.closeButton.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		/**
		 * Updates the staff display based on the staffItem used; 
		 * @ev - the event handler.
		 * 
		 */		
		
		public function updateStaffData(ev:StaffEvent):void{
			_staffEntryID = ev.params.itemEntryID;
			_staffDeskFrameNumber = ev.params.fn;
			_staffPositions = ev.params.staffPositions;
			updateDataDisplay();			
			//trace( "[StaffView]: _staffPositions================>>> ", _staffPositions );
		}
		
		/**
		 * Updates the display of characters' staff details. Calls the
		 * visibility of buttons based on data.
		 */		
		
		private function  updateDataDisplay():void{
			var globalData:GlobalData = GlobalData.instance;
			_staffItemDataArray = globalData.getStaffItemDataByEntryID(_staffEntryID);
			
			/*if (_staffItemDataArray != null){
			if (_staffItemDataArray[GlobalData.OFFICESTATE_EMPTY] == "false" && _staffItemDataArray[GlobalData.OFFICESTATE_NPC] == "false"){
			loadFriendPic(_staffItemDataArray[GlobalData.OFFICESTATE_FBID]);
			_staffMC.pic.gotoAndStop(1);
			_staffMC.friendPortrait.visible = true;
			_staffMC.buyButton.visible = false;
			_staffMC.buyButton.enabled = false;
			_staffMC.buyButton.mouseEnabled = false;
			_staffMC.hireButton.visible = false;
			_staffMC.hireButton.enabled = false;
			_staffMC.hireButton.mouseEnabled = false;
			} else if (_staffItemDataArray[GlobalData.OFFICESTATE_EMPTY] == "true" && _staffItemDataArray[GlobalData.OFFICESTATE_NPC] == "false"){
			_staffMC.pic.gotoAndStop(1);
			_staffMC.friendPortrait.visible = false;
			_staffMC.buyButton.visible = true;
			_staffMC.buyButton.enabled = true;
			_staffMC.buyButton.mouseEnabled = true;
			_staffMC.hireButton.visible = true;
			_staffMC.hireButton.enabled = true;
			_staffMC.hireButton.mouseEnabled = true;
			} else if (_staffItemDataArray[GlobalData.OFFICESTATE_EMPTY] == "false" && _staffItemDataArray[GlobalData.OFFICESTATE_NPC] == "true"){
			_staffMC.pic.gotoAndStop(2);
			_staffMC.friendPortrait.visible = false;
			_staffMC.buyButton.visible = false;
			_staffMC.buyButton.enabled = false;
			_staffMC.buyButton.mouseEnabled = false;
			_staffMC.hireButton.visible = false;
			_staffMC.hireButton.enabled = false;
			_staffMC.hireButton.mouseEnabled = false;
			} 
			} else {*/
			_staffMC.pic.gotoAndStop(1);
			_staffMC.friendPortrait.visible = false;
			_staffMC.buyButton.visible = true;
			_staffMC.buyButton.enabled = true;
			_staffMC.buyButton.mouseEnabled = true;
			_staffMC.hireButton.visible = true;
			_staffMC.hireButton.enabled = true;
			_staffMC.hireButton.mouseEnabled = true;
			//}
		}
		
		private function loadFriendPic(fbID:String):void{
			if (_isOnline == true){
				_loaderContext = new LoaderContext();
				_loaderContext.checkPolicyFile = true;
				_loaderContext.securityDomain = SecurityDomain.currentDomain;
			}
			var fbPicLink:String = GlobalData.instance.getPicLinkByFID(fbID);
			_urlRequest = new URLRequest(fbPicLink);
			_loader = new Loader();
			_loader.load(_urlRequest, _loaderContext);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPicLoadError);
		}
		
		private function onPicLoaded(ev:Event):void{
			if (_staffMC.friendPortrait != null){
				var friendPic:Bitmap = _loader.content as Bitmap;
				_staffMC.friendPortrait.addChild(friendPic);
				friendPic.x +=2;
				friendPic.y +=2;
				var parent:DisplayObjectContainer = _staffMC.friendPortrait.pic.parent;
				parent.removeChildAt(0);
				//parent.removeChild(_staffPositionArray[x].friendPortrait.pic);
				friendPic.alpha = 0;
				TweenLite.to(friendPic, .3, {alpha:1});
				trace ("picture loaded");
			} else {
				_staffMC.friendPortrait.addChild(ev.target.data as Sprite);
				trace ("picture loaded");
			}		
		}
		
		private function onPicLoadError(ev:IOErrorEvent):void{
			Logger.tracer(this, "Error loading friend pic." + ev.text);
		}
		
		private function onClick(ev:MouseEvent):void{
			switch ( ev.currentTarget ) 
			{
				case _staffMC.closeButton:				
					trace( "remove staff window!!!!!!" );
					_popUIManager = PopUpUIManager.getInstance();
					_popUIManager.removeWindow( WindowPopUpConfig.STAFF_WINDOW );
					EventSatellite.getInstance().dispatchEvent(new StaffEvent(StaffEvent.CLOSE));
					break;
				case _staffMC.buyButton:		
					trace( "[StaffView]: _staffPositions buy staff ================>>> ", _staffPositions );
					_sdc.hireStaff( _staffEntryID, _staffPositions, 1 );
					_popUIManager.removeWindow( WindowPopUpConfig.STAFF_WINDOW );
					
					var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.BUY_STAFF );
					_es.dispatchESEvent( tutEvent );					
					trace( "[ StaffView ] hire npc....................................................." );
					break;
				case _staffMC.hireButton:
					//scouter, ..... soon
					trace( "[StaffView]: _staffPositions hire friend ================>>> ", _staffPositions );
					_sdc.hireFriendStaff( _staffEntryID,_staffPositions, GlobalData.instance.myFbId  );				
					EventSatellite.getInstance().dispatchEvent(new StaffEvent (StaffEvent.HIRED_FRIEND, {entryID:_staffEntryID}));
					trace( "[ StaffView ] hire friends staff scouter......................................................" );
					break;
				
			}
		}
	}
}