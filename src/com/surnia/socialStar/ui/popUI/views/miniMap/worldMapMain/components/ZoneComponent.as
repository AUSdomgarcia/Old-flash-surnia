package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author df
	 */
	public class ZoneComponent extends MovieClip
	{			
		private var _loaderOver:Loader;		
		private var _loaderOut:Loader;		
		private var _loaderZoom:Loader;
		private var _loaderFlag:Loader;
		
		private var _zoneUI:Bitmap;
		
		private var _zoneOverMC:MovieClip;
		private var _zoneOutMC:MovieClip;
		private var _zoneZoomMC:MovieClip;
		
		private var _zoneFlagMC:MovieClip;
		
		private var _callbackBuilding:Function;
		private var _callbackZone:Function;
		private var _callbackZoneOver:Function;
		
		private var _params:Object = new Object;
		
		private var _zoneDataObj:Object;
		
		private var _mapCtr:int;
		private var _zoneCtr:int;		
		
		private var _loadTotal:int = 4;	//zoneOver /zoneOut /zoneZoom/ flag
		private var _loadCtr:int = 0;
		
		private var _zoneMode:String = "";
		
		public static const ZONE_OVER:String	= "zone over";
		public static const ZONE_OUT:String		= "zone out";
		public static const ZONE_ZOOM:String		= "zone zoom";
		
		public static const DISPLAY_LAYOUT:String	= "display layout";
		public static const DISPLAY_BUILDING:String	= "display building";
		
		public static const ZONE_LOCKED:int = 0;
		public static const ZONE_ONGOING:int = 1;
		public static const ZONE_COMPLETE:int = 2;
		
		public var isComplete:Boolean = true;
		public var arrayBuilding:Array = [];
		public var arrayBuildingData:Array = [];
		
		public var id:String;		
		public var zoneName:String;	
		public var zoneNameNPC:String;
		
		public var zoneData:ZoneDetail;
		
		public var zoneOverURL:String;
		public var zoneOutURL:String;	
		public var posX:int;
		public var posY:int;
		
		public var zonePopupURL:String;
		public var zoneBossURL:String;
		public var zoneBossX:int;
		public var zoneBossY:int;
		
		public var zoneStatus:int;
		public var zoneReq:String;
		public var zoneLvlReq:int;
		
		public var activeMode:MovieClip;		
		public var isLock:Boolean = true;		
		
		private var _zoneLayerHigh:DisplayObjectContainer;
		private var _flagLayer:DisplayObjectContainer;
		private var _mouseOverLayer:DisplayObjectContainer;
		private var _zonePopup:ZonePopup;
		public function ZoneComponent(callbackZone:Function = null,callbackZoneOver:Function = null, callbackBuilding:Function = null, zoneDetail:ZoneDetail = null, zoneMode:String = ZoneComponent.DISPLAY_LAYOUT) 
		{				
			zoneData		= zoneDetail;	
			
			id 				= zoneData.id;
			zoneName		= zoneData.zoneName;
			zoneNameNPC		= zoneData.zoneNameNPC;
			
			zoneOverURL		= zoneData.zoneOverURL;
			zoneOutURL		= zoneData.zoneOutURL;
			posX			= zoneData.posX;
			posY			= zoneData.posY;
			
			zoneStatus		= zoneData.zoneStatus;
			zoneReq			= zoneData.zoneReq;
			zoneLvlReq		= zoneData.zoneLvlReq;
			
			zonePopupURL = zoneData.zonePopupURL;;
			zoneBossURL	 = zoneData.zoneBossURL;
			zoneBossX	 = zoneData.zoneBossX;
			zoneBossY	 = zoneData.zoneBossY;
			
			arrayBuildingData 	= zoneData.arrayBuildingData;
			
			_zoneMode	= zoneMode;
			
			_callbackZoneOver 	= callbackZoneOver;
			_callbackBuilding	= callbackBuilding;
			_callbackZone		= callbackZone;					
			
			initialization();			
			loadZoneURL();			
		}			
		
		private function initialization():void 
		{
			_zoneDataObj = new Object;
			
			_zoneOverMC = new MovieClip;
			_zoneOutMC  = new MovieClip;
			_zoneZoomMC = new MovieClip;
			_zoneFlagMC = new MovieClip;
			
			_loaderOver = new Loader;
			_loaderOut	= new Loader;
			_loaderZoom = new Loader;	
			_loaderFlag = new Loader;
		}	
		
		
		private function zoneLayout():void {
			switch(_zoneMode) {
				case ZoneComponent.DISPLAY_BUILDING: 							
					switchZone(ZoneComponent.ZONE_ZOOM);
				break;				
				case ZoneComponent.DISPLAY_LAYOUT: 
					if(_zoneOverMC !=null){
						_zoneOverMC.x = posX;
						_zoneOverMC.y = posY;
					}
					if(_zoneOutMC !=null){
						_zoneOutMC.x = posX;
						_zoneOutMC.y = posY;
					}				
					_zonePopup = new ZonePopup(_zoneOverMC, zonePopupURL, zoneBossURL, zoneBossX, zoneBossY, zoneName, zoneNameNPC, isComplete, zoneStatus);										
					_zonePopup.setParentLayer(_mouseOverLayer, posX, posY);
					addListener();	
					
					displayZoneStatus();
				break;
			}
		}
		
		public function displayActiveZoneLayer(onGoingZone:DisplayObjectContainer):void {
			_zoneLayerHigh = onGoingZone;
		}
		
		private function displayZoneStatus():void {
			if(zoneStatus == ZoneComponent.ZONE_ONGOING){
				switchZone(ZoneComponent.ZONE_OVER);
			}
			else {
				switchZone(ZoneComponent.ZONE_OUT);
			}
		}
		
		//fill building
		private function fillBuilding():void
		{	
			for (var i:int = 0; i < arrayBuildingData.length; i++ ) {			
				arrayBuilding[i] = new BuildingComponent(callBack, arrayBuildingData[i]);
			}		
		}	
		
		private function checkAllBuildingStatus():void {
			for (var i:int = 0; i < arrayBuilding.length; i++ ) {
				if (arrayBuilding[i].buildingStatus != BuildingComponent.BUILDING_NORMAL ) {
					isComplete = false;
				}
			}
			
			trace(this, "RETURN ZONE STATUS - ALL BUILDING COMPLETE:", isComplete);
		}
		
		//display building		
		public function displayBuilding():void 
		{
			for (var i:int = 0; i < arrayBuilding.length; i++ ) {
				_zoneZoomMC.addChild(arrayBuilding[i]);
			}
		}	
		
		public function addListener():void {			
			_zoneOverMC.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_zoneOverMC.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			_zoneOverMC.addEventListener(MouseEvent.CLICK, onClick);
			
			
			_zoneOutMC.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_zoneOutMC.addEventListener(MouseEvent.MOUSE_OUT, onOut);			
		}	
		
		public function removeListener():void {	
			if(_zonePopup != null){
				_zonePopup.hide();
			}
			displayZoneStatus();			
			if(_zoneOverMC != null){
				_zoneOverMC.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				_zoneOverMC.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
				_zoneOverMC.removeEventListener(MouseEvent.CLICK, onClick);
			}
			
			if(_zoneOutMC != null){
				_zoneOutMC.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				_zoneOutMC.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
		}		
		
		public function nullAllInstances():void {
			removeListener();
			
			if(_zonePopup != null){
				_zonePopup.nullAllInstances();
				_zonePopup = null;
			}
			
			if (_zoneDataObj != null) {
				_zoneDataObj = null;				
			}
			
			for (var i:int = 0; i < arrayBuilding.length; i++ ) {	
				if(arrayBuilding[i] != null){
					arrayBuilding[i].nullAllInstances();
					if(_zoneZoomMC.contains(arrayBuilding[i])){
						_zoneZoomMC.removeChild(arrayBuilding[i]);
					}
					
					arrayBuilding[i] = null;
				}
			}
			
			removeZone();
			if (_zoneOverMC != null) {
				_zoneOverMC = null;				
			}
			
			if (_zoneOutMC != null) {
				_zoneOutMC = null;				
			}
			
			if (_zoneZoomMC != null) {
				_zoneZoomMC = null;				
			}
			
			if (_zoneFlagMC != null) {
				_zoneFlagMC = null;
			}
			
			if (zoneData != null) {
				zoneData = null;
			}
			trace("CLEAN :", this);
			
			//---------------------------------------------------------------CHECK ALL!!!!!-------------------------------------------			
			
			if (_zoneUI != null) {
				_zoneUI = null
			}
			
			trace(this, "RETURN :", _zoneUI);
			
			if (_callbackBuilding != null) {
				_callbackBuilding = null
			}
			
			if (_callbackZone != null) {
				_callbackZone = null
			}			
			
			trace(this, "RETURN :", _zoneDataObj);	
		
			trace(this, "RETURN :", _mapCtr);
			trace(this, "RETURN :", _zoneCtr);
			
			trace(this, "RETURN :", _loadTotal);
			trace(this, "RETURN :", _loadCtr);
			
			trace(this, "RETURN :", _zoneMode);
			
			trace(this, "RETURN :", isComplete);
			trace(this, "RETURN :", arrayBuilding);
			trace(this, "RETURN :", arrayBuildingData);
			
			trace(this, "RETURN :", id);
			trace(this, "RETURN :", zoneName);
			trace(this, "RETURN :", zoneNameNPC);
			
			trace(this, "RETURN :", zoneData);
			
			trace(this, "RETURN :", zoneOverURL);
			trace(this, "RETURN :", zoneOutURL);
			trace(this, "RETURN :",posX);
			trace(this, "RETURN :", posY);
			
			trace(this, "RETURN :", zonePopupURL);
			trace(this, "RETURN :", zoneBossURL);
			trace(this, "RETURN :",zoneBossX);
			trace(this, "RETURN :", zoneBossY);
			
			trace(this, "RETURN :", zoneStatus);
			
			trace(this, "RETURN :",activeMode);
			
			trace(this, "RETURN :", _mouseOverLayer);
			trace(this, "RETURN :", _zonePopup);
			
		}
		
		
		private function onClick(e:MouseEvent):void 
		{	
			//_zonePopup.hide();
			selectZone();
		}
		
		private function onOut(e:MouseEvent):void 
		{	
			_zonePopup.hide();
			displayZoneStatus();			
		}
		
		private function onOver(e:MouseEvent):void 
		{	
			_params.id = id;
			
			_callbackZoneOver(_params);
			_zonePopup.show();
			switchZone(ZoneComponent.ZONE_OVER);				
		}	
		
		private function loadZoneURL():void 
		{
			_loaderOver.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedOverImage);
			_loaderOver.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherOver);
			_loaderOver.load(new URLRequest(zoneData.zoneOverURL));	
			
			_loaderOut.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedOutImage);
			_loaderOut.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherOut);
			_loaderOut.load(new URLRequest(zoneData.zoneOutURL));	
			
			_loaderZoom.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedZoomImage);
			_loaderZoom.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherZoom);
			_loaderZoom.load(new URLRequest(zoneData.zoneZoomURL));	
			
			_loaderFlag.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedFlagImage);
			_loaderFlag.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherFlag);
			_loaderFlag.load(new URLRequest(zoneData.zoneFlagURL));	
		}
		
		private function errorCatcherFlag(e:IOErrorEvent):void 
		{
			//_loaderZoom.contentLoaderInfo.loaderURL
			trace(this, "ERROR RETURN LOADING ZONE FLAG ERROR!!!");
			if(zoneData != null){
				trace(this, "RETURN URL LINK:", zoneData.zoneFlagURL, " ZONE ID:",id);
			}
		}
		
		private function errorCatcherZoom(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING ZONE ZOOM ERROR!!!");
			if(zoneData != null){
				trace(this, "RETURN URL LINK:", zoneData.zoneZoomURL, " ZONE ID:",id);
			}
		}
		
		private function errorCatcherOut(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING ZONE OUT ERROR!!!");
			if(zoneData != null){
				trace(this, "RETURN URL LINK:", zoneData.zoneOutURL, " ZONE ID:",id);
			}
		}
		
		private function errorCatcherOver(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING ZONE OVER ERROR!!!");
			if(zoneData != null){
				trace(this, "RETURN URL LINK:", zoneData.zoneOverURL, " ZONE ID:",id);
			}
		}
		
		private function loadedFlagImage(e:Event):void 
		{			
			_zoneFlagMC	= e.target.content;
			checkTotalLoad();
			
			_loaderFlag.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedFlagImage);
			_loaderFlag = null;
		}	
		
		private function loadedZoomImage(e:Event):void 
		{			
			_zoneUI = e.target.content;	
			if(_zoneZoomMC != null && _zoneUI != null){
				_zoneZoomMC.addChild(_zoneUI);			
			}
			checkTotalLoad();
			
			_loaderZoom.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedZoomImage);
			_loaderZoom = null;			
		}
		
		private function loadedOverImage(e:Event):void 
		{			
			_zoneUI = e.target.content;
			if(_zoneOverMC != null && _zoneUI != null){
				_zoneOverMC.addChild(_zoneUI);		
			}
			
			checkTotalLoad();
			
			_loaderOver.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedOverImage);
			_loaderOver = null;
		}
		
		private function loadedOutImage(e:Event):void 
		{			
			_zoneUI = e.target.content;	
			if(_zoneOutMC != null && _zoneUI != null){
				_zoneOutMC.addChild(_zoneUI);	
			}
			checkTotalLoad();
			
			_loaderOut.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedOutImage);
			_loaderOut = null;
		}		
		
		private function checkTotalLoad():void {
			_loadCtr++;				
			
			if (_loadCtr >= _loadTotal) {	
				trace(this, "RETURN LOAD ZONE COMPLETE _loadCtr:", _loadCtr);
				fillBuilding();				
				displayBuilding();	
				checkAllBuildingStatus();				
				
				//checkZoneStatus();
				zoneLayout();								
				
				dispatchEvent(new WorldMapEvent(WorldMapEvent.ZONE_LOAD_COMPLETE));
			}
		}	
		
		private function checkZoneStatus():void 
		{			
			if(arrayBuildingData.length != 0){
				if (isComplete == true) {
					
					//if (_mouseOverLayer != null && _zoneFlagMC != null) {					
					if (_zoneOutMC != null &&_zoneFlagMC != null){												
						//_mouseOverLayer.addChild(_zoneFlagMC);	
						_zoneFlagMC.x = posX + ((_zoneOutMC.width / 2) - (_zoneFlagMC.width / 2));		
						_zoneFlagMC.y = posY;
					}
				}	
			}
			else {
				isComplete = false;
			}
		}
		
		private function displayFlag():void {			
			if (_flagLayer != null && _zoneFlagMC != null) {
				if(isComplete == true){
					_flagLayer.addChild(_zoneFlagMC);		
				}
			}
		}
		
		private function removeFlag():void {
			if (_flagLayer != null && _zoneFlagMC != null) {
				if (_flagLayer.contains(_zoneFlagMC)) {
					_flagLayer.removeChild(_zoneFlagMC);
				}				
			}
		}		
		
		public function setMouseOverLayer(mouseOverLayer:DisplayObjectContainer):void {
			_mouseOverLayer = mouseOverLayer;			
		}	
		
		public function setFlagLayer(flagLayer:DisplayObjectContainer):void {
			_flagLayer	= flagLayer;
			
		}
		
		public function setZoneLayerHigh(zoneLayerHigh:DisplayObjectContainer):void {
			_zoneLayerHigh = zoneLayerHigh;
		}
		
		public function switchZone(modeType:String = ZoneComponent.ZONE_OUT):void {
			removeZone();			
			switch(modeType) {
				case ZoneComponent.ZONE_OVER:
					if (_zoneOverMC != null && _zoneLayerHigh != null) {
						
						activeMode = _zoneOverMC;
						_zoneLayerHigh.addChild(_zoneOverMC);
						
						removeFlag();
					}
				break;
				case ZoneComponent.ZONE_OUT:
					if (_zoneOutMC != null) {
						
						activeMode = _zoneOutMC;
						addChild(_zoneOutMC);	
						
						displayFlag();
					}
				break;		
				case ZoneComponent.ZONE_ZOOM:
					if (_zoneZoomMC != null) {
						
						activeMode = _zoneZoomMC;
						addChild(_zoneZoomMC);	
						
						displayFlag();
					}
				break;	
			}				
			checkZoneStatus();
		}
		
		public function removeZone():void {
			//remove normal
			if (_zoneOverMC != null) {
				if(_zoneLayerHigh != null){
					if (_zoneLayerHigh.contains(_zoneOverMC)) {
						_zoneLayerHigh.removeChild(_zoneOverMC);
					}
				}
			}
			
			//remove dim
			if (_zoneOutMC != null) {
				if (this.contains(_zoneOutMC)) {
					removeChild(_zoneOutMC);
				}
			}
			
			if (_zoneZoomMC != null) {
				if (this.contains(_zoneZoomMC)) {
					removeChild(_zoneZoomMC);
				}
			}
		}	
		
		//CALLBACK SELECT ZONE
		private function selectZone():void {
			_zoneDataObj.zoneID = id;
			if(_callbackZone != null){
				_callbackZone(_zoneDataObj);
			}
		}
		
		//CALLBACK SELECT BUILDING
		private function callBack(objData:Object):void {
			objData.zoneID = id;
			
			if(_callbackBuilding != null){
				_callbackBuilding(objData);
			}
		}
	}

}