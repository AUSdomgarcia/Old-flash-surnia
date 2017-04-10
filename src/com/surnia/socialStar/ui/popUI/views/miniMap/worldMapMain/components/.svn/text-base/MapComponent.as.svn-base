package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.PlayerData;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import com.surnia.socialStar.utils.facebookAPI.events.FacebookApiEvent;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author df
	 * 
	 */
	
	
	public class MapComponent extends MovieClip
	{
		
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES/CONSTANTS
		 * ----------------------------------------------------------------------------------------------------------*/
		private var isHold:Boolean = false;		
		private var _zoneManager:ZoneManager;
		private var _mapCtr:int;	
		
		private var _mapLayer:Sprite;		
		private var _zoneLayer:Sprite;
		
		private var _flagLayer:Sprite;
		private var _skyLayer:Sprite;
		private var _topLayer:Sprite;		
		private var _zoneLayerHigh:Sprite;
		private var _zoneLayerHighest:Sprite;
		
		private var _mapBmp:Bitmap;
		private var _maskBmp:Bitmap;		
		
		private var _isShow:Boolean = false;	
		
		private var _loader:Loader;		
		private var _mapMC:MovieClip;	
		
		private var _loaderCloud:Loader;
		private var _cloudMC:MovieClip;
		
		private var _loaderMask:Loader;
		private var _mapMask:MovieClip;
		
		private var _loadTotal:int = 3; //MAP /MASK /SKY
		private var _loadCtr:int = 0;
		
		private var _zoneCtr:int = 0;
		
		private var _callbackClose:Function;
		private var _callbackBuilding:Function;
		private var _callbackZone:Function;
		
		private var _button:DynamicButton;
		private var _isZoneZoom:Boolean = false;
		
		private var _w:int;
		private var _h:int;	
		
		private var _gd:GlobalData;
		private var _zoneOngoing:ZoneComponent;
		
		public var mapID:String;
		public var mapName:String;
		
		public var buttonOutURL:String;
		public var buttonOverURL:String;
		
		public var arrayZoneData:Array = [];
		
		public var arrayZone:Array = [];
		
		
		public var txt:TextField = new TextField;
		public	var txtMC:MovieClip = new MovieClip;
		
		public	var tf:TextFormat = new TextFormat;
		public	var gf:GlowFilter = new GlowFilter(0xFFCCCCCC, 1.0, 6, 6, 50);
		public var mapData:MapDetail;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MapComponent(callbackClose:Function, callbackZone:Function, callbackBuilding:Function, mapDetail:MapDetail) 
		{			
			mapData	= mapDetail;
			
			mapID	= mapDetail.mapID;
			mapName	= mapDetail.mapName;
			
			buttonOutURL	= mapDetail.buttonOutURL;
			buttonOverURL	= mapDetail.buttonOverURL;
			
			arrayZoneData	= mapData.arrayZoneData;				
		
			_callbackClose	  = callbackClose;
			_callbackBuilding = callbackBuilding;
			_callbackZone	  = callbackZone;
			
			initialization();	
			loadMapURL()
			displayZoneManager();
			
			displayMap();
			addListener();				
		}		
		
		
		
		public function setSize(w:int, h:int):void {
			_w = w;
			_h = h;
			
			_zoneManager.setSize(_w, _h);
		}	
		
		private function testMem():void 
		{
			var mem:MemoryProfiler = new MemoryProfiler();
			addChild(mem);
			mem.x = 100;
			mem.y = 100;
			var frame:FrameRateViewer = new FrameRateViewer();
			addChild(frame);
			frame.x = 100;	
			frame.y = 100;	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/	
		private function initialization():void 
		{	
			_gd 	= GlobalData.instance;
			_mapLayer 	= new Sprite;
			_zoneLayer  = new Sprite;
			
			_flagLayer = new Sprite;
			_skyLayer	= new Sprite;
			_topLayer = new Sprite;		
			_zoneLayerHigh = new Sprite;
			_zoneLayerHighest = new Sprite;
			
			//_mapMask = new MovieClip;
			//_mapMC = new MovieClip;
			
			_loader = new Loader;
			_loaderCloud = new Loader;
			_loaderMask = new Loader;
			
			//HANDLES THE ZONE DISPLAY
			_zoneManager = new ZoneManager(arrayZoneData, _callbackBuilding);			
		}
		
		//LOAD MAP BACKGROUND URL
		private function loadMapURL():void 
		{	
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedImage);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcher);
			_loader.load(new URLRequest(mapData.mapURL));
			
			_loaderMask.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedMaskImage);
			_loaderMask.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherMask);
			_loaderMask.load(new URLRequest(mapData.mapURL));	
			
			_loaderCloud.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedCloudImage);
			_loaderCloud.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherCloud);
			_loaderCloud.load(new URLRequest(mapData.mapSkyURL));	
		}	
		
		private function errorCatcherCloud(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING MAP CLOUD ERROR!!!");
			if(mapData != null){
				trace(this, "RETURN URL LINK:", mapData.mapSkyURL, " MAP ID:", mapID);
			}
		}
		
		private function errorCatcherMask(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING MAP MASK ERROR!!!");
			if(mapData != null){
				trace(this, "RETURN URL LINK:", mapData.mapURL, " MAP ID:", mapID);
			}
		}
		
		private function errorCatcher(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING MAP BACKGROUND ERROR!!!");
			if(mapData != null){
				trace(this, "RETURN URL LINK:", mapData.mapURL, " MAP ID:", mapID);
			}
		}
		
		//FILL ZONE
		private function fillZoneLayout():void {			
			for (var i:int = 0; i < arrayZoneData.length; i++ ) {
				arrayZone[i] = new ZoneComponent(selectZone, onOverCallback, null, arrayZoneData[i], ZoneComponent.DISPLAY_LAYOUT);
			}
			
			for (var j:int = 0; j < arrayZone.length; j++ ) {				
				_mapLayer.addChild(arrayZone[j]);	
			
				
				arrayZone[j].setMouseOverLayer(_topLayer);		
				arrayZone[j].setFlagLayer(_flagLayer);
				
				if (arrayZone[j].zoneStatus == ZoneComponent.ZONE_ONGOING) {
					_zoneOngoing = arrayZone[j];
					setZoneLayerHighest(arrayZone[j]);
				}else {
					setZoneLayerHigh(arrayZone[j]);
				}	
			}			
			addZoneListener();			
		}			
		
		private function setZoneLayerHighest(zoneComponent:ZoneComponent):void {
			
			trace(this, "RETURN onGoingZone.posY:", zoneComponent.posY);
			zoneComponent.setZoneLayerHigh(_zoneLayerHighest);				
		}
		
		private function setZoneLayerHigh(zoneComponent:ZoneComponent):void {
			
			trace(this, "RETURN onGoingZone.posY:", zoneComponent.posY);
			zoneComponent.setZoneLayerHigh(_zoneLayerHigh);					
		}	
		
		
		private function addZoneListener():void 
		{			
			for (var i:int = 0; i < arrayZone.length; i++ ) {
				arrayZone[i].addEventListener(WorldMapEvent.ZONE_LOAD_COMPLETE, onZoneComplete);	
			}			
		}
		
		private function onZoneComplete(e:WorldMapEvent):void 
		{
			_zoneCtr++;
			//CHECK IF ALL ZONES ARE ADDED TO _mapLayer FOR MAP WIDTH ADJUSTMENT	
			if (_zoneCtr == arrayZone.length) {				
				
				
				//SET MAP WIDTH
				if(_mapLayer.width > _mapMC.width){
					_mapMC.width 	= _mapLayer.width;	
				}	
				
				if(_mapLayer.height > _mapMC.height){
					_mapMC.height 	= _mapLayer.height;	
				}
				
				_mapMask.width	= _w;
				_mapMask.height	= _h;	
				
				_mapLayer.addChild(_zoneLayerHigh);
				_mapLayer.addChild(_zoneLayerHighest);
				
				_mapLayer.addChild(_flagLayer);
				_mapLayer.addChild(_skyLayer);					
				_mapLayer.addChild(_topLayer);
				
				_topLayer.addChild(txtMC);
				
				_skyLayer.mask = _mapMask;
				_mapLayer.mask = _mapMask;
				
				_skyLayer.addChild(_cloudMC);
				
				if (_mapLayer.width > _skyLayer.width) {
					//_skyLayer.width = _mapLayer.width;
				}
				else {
					//_skyLayer.width = _mapMC.width;
				}
				
				if (_mapLayer.height > _skyLayer.height) {
					//_skyLayer.height = _mapLayer.height;
				}else {
					//_skyLayer.height = _mapMC.height;
				}				
				
				addChild(_button);
				_button.x = _w - (_button.width + 20);
				_button.y = _h - (_button.height + 10);			
				
				/*
				TweenLite.to(_button, 3, {
					x:_w - (_button.width + 20),
					y:_h - (_button.height + 270)
				});
				*/
				
				trace(this, "RETURN _mapMC.width::", _mapMC.width, _mapMask.width, _w,  _w - (_button.width + 20));
				trace(this, "RETURN _mapMC.height::", _mapMC.height, _mapMask.height, _h,  _h - (_button.height + 10));
				
				//testMem();
				addPanningListener();									
			}			
		}
		
		
		
		private function addListener():void {
			_mapLayer.addEventListener(MouseEvent.CLICK, onLayerClick);	
			
		}
		
		private function addPanningListener():void {
			//for (var i:int = 0; i < arrayZone.length; i++ ) {
			addEventListener(MouseEvent.MOUSE_MOVE, onZoneOver);
			//}
		}
		
		private function removePanningListener():void {
			removeEventListener(MouseEvent.MOUSE_MOVE, onZoneOver);
		}
		
		private function onZoneOver(e:MouseEvent):void 
		{	
			if(_mapLayer != null && _skyLayer != null){
				if (stage.mouseX >= (_w * .75) ) {				
					TweenLite.to(_mapLayer, 1, {
						x:_w - _mapMC.width
					});
					
					TweenLite.to(_skyLayer, 1, {
						x:_mapMC.width - _w
					});				
				}
				if (stage.mouseX < (_w * .25) ) {		
					TweenLite.to(_mapLayer, 1, {
						x:0
					});
					
					TweenLite.to(_skyLayer, 1, {
						x:0
					});				
				}	
			}
		}		
		
		private function removeListener():void {
			if(_mapLayer != null){
				_mapLayer.removeEventListener(MouseEvent.CLICK, onLayerClick);
			}
		}
		
		private function displayZoneManager():void 
		{		
			_zoneLayer.addChild(_zoneManager);			
		}
		
		public function displayMap():void {				
			addChild(_mapLayer);
			addChild(_zoneLayer);			
			
			_button = new DynamicButton(callBackButton, buttonOverURL, buttonOutURL);
			//addChild(_button);
		}
		
		private function callBackButton(buttonID:int):void {
			if(_isZoneZoom == false){
				_callbackClose();
			}
			else {
				showZone();
				_isZoneZoom = false;
			}
		}
		
		public function removeMap():void {
			if (_mapMC != null) {
				if (_mapLayer.contains(_mapMC)) {
					_mapLayer.removeChild(_mapMC);
				}
			}
		}	
		
		private function showZone():void {			
			if (_isShow == false) {
				
				_isShow = true;
				_isZoneZoom = false;
				
				_zoneManager.removeAllZone();
				
				for (var j:int = 0; j < arrayZone.length; j++ ) {			
					arrayZone[j].addListener();
				}
				addPanningListener();
			}
			else {
				_isShow = false;				
			}
			
			trace(this, "RETURN MAP LAYER CLICK:", _isShow, _isZoneZoom);
		}	
		
		//DISPLAY WARNING IF BUILDING NOT ACTIVE			
		private function displayWarning(zone:ZoneComponent):void {
			
			trace(this, "RETURN DISPLAY WARNING!!");
			
			
			txt.selectable = false;
			txt.x = zone.x - ((zone.width /2) + (txt.width/2));
			txt.y = zone.y;		
					
			txtMC.addChild(txt);
			
			
			tf.font = "Arial Bold";
			tf.bold = true;
			tf.size = 24;
			tf.color = 0xFFFFFF;
			
			txt.defaultTextFormat = tf;				
			txt.width = 410;
			txt.height = Number(tf.size + 5);
			txt.text = "You cannot challenge a contest yet!";			
			txt.filters = [gf];
			
			txtMC.alpha = 0;
			TweenLite.to(txtMC, 2, {
				y:-50, 
				alpha:1, 
				ease:Back.easeOut,
				onComplete: function():void {
					TweenLite.to(txtMC, .5, { 
						alpha:0, 
						onComplete: function():void {
							if (_topLayer != null) {
								if(_topLayer.contains(txtMC)){
									_topLayer.removeChild(txtMC);							
								}
							}							
						}					
					} );					
				}					
			});
			
			if (txt.x < 0) {
				//txt.x = 0;
			}
			if (txt.x + txt.width > _w ) {
				
				//txt.x = _w  - txt.width;
			}			
		}		
		
		public function nullAllInstances():void {
			TweenLite.killTweensOf(_mapLayer);
			removeListener();
			//clear zone manager
			if(_zoneManager != null){
				_zoneManager.nullAllInstances();
				if (_zoneLayer.contains(_zoneManager)) {
					_zoneLayer.removeChild(_zoneManager);
				}
				_zoneManager = null;
			}
			//clear all zones
			for (var j:int = 0; j < arrayZone.length; j++ ) {			
				arrayZone[j].removeListener();
				arrayZone[j].nullAllInstances();
				if (arrayZone[j] != null) {
					if (_mapLayer.contains(arrayZone[j])) {
						_mapLayer.removeChild(arrayZone[j]);
					}
					arrayZone[j] = null;
				}
			}
			//clear cloud
			if (_cloudMC != null) {
				if (_skyLayer.contains(_cloudMC)) {
					_skyLayer.removeChild(_cloudMC);
				}
				_cloudMC = null;
			}
			//clear mask
			if (_mapMask != null) {
				if (this.contains(_mapMask)) {
					removeChild(_mapMask);
				}
				_mapMask = null;
			}
			//clear map
			removeMap();
			if (_mapMC != null) {				
				_mapMC = null;
			}	
			//clear toplayer
			if (_zoneLayerHigh != null) {
				if (_mapLayer.contains(_zoneLayerHigh)) {
					_mapLayer.removeChild(_zoneLayerHigh);
				}
				_zoneLayerHigh = null;
			}	
			//clear toplayer
			if (_topLayer != null) {
				if (_mapLayer.contains(_topLayer)) {
					_mapLayer.removeChild(_topLayer);
				}
				_topLayer = null;
			}	
			//clear _flagLayer
			if (_flagLayer != null) {
				if (_mapLayer.contains(_flagLayer)) {
					_mapLayer.removeChild(_flagLayer);
				}
				_flagLayer = null;
			}				
			//clear skylayer
			if (_skyLayer != null) {
				if (_mapLayer.contains(_skyLayer)) {
					_mapLayer.removeChild(_skyLayer);
				}
				_skyLayer = null;
			}
			//clear maplayer
			if (_mapLayer != null) {
				if (this.contains(_mapLayer)) {
					removeChild(_mapLayer);
				}
				_mapLayer = null;
			}			
			//clear zonelayer
			if (_zoneLayer != null) {
				if (this.contains(_zoneLayer)) {
					removeChild(_zoneLayer);
				}
				_zoneLayer = null;
			}			
			trace("CLEAN", this);
			
			//---------------------------------------------------------------CHECK ALL!!!!!-------------------------------------------			
			
			
			trace(this, "RETURN :", isHold);
			trace(this, "RETURN :", _zoneManager);
			trace(this, "RETURN :", _mapCtr);
			
			trace(this, "RETURN :", _mapLayer);	
			trace(this, "RETURN :", _zoneLayer);
			trace(this, "RETURN :", _skyLayer);
			trace(this, "RETURN :", _topLayer);
			
			trace(this, "RETURN :", _mapBmp);
			trace(this, "RETURN :", _maskBmp);	
			
			trace(this, "RETURN :", _isShow);
			
			trace(this, "RETURN :", _loader);	
			trace(this, "RETURN :", _mapMC);
			
			trace(this, "RETURN :", _loaderCloud);
			trace(this, "RETURN :", _cloudMC);
			
			trace(this, "RETURN :", _loaderMask);
			trace(this, "RETURN :", _mapMask);
			
			trace(this, "RETURN :", _loadTotal);
			trace(this, "RETURN :", _loadCtr);
			
			trace(this, "RETURN :", _zoneCtr);
			
			trace(this, "RETURN :", _callbackClose);
			trace(this, "RETURN :", _callbackBuilding);
			trace(this, "RETURN :", _callbackZone);
			
			trace(this, "RETURN :", _button);
			
			trace(this, "RETURN :", _w);
			trace(this, "RETURN :", _h);
			
			trace(this, "RETURN :", _gd);
			
			trace(this, "RETURN :", mapID);
			trace(this, "RETURN :", mapName);
			
			trace(this, "RETURN :", buttonOutURL);
			trace(this, "RETURN :", buttonOverURL);
			
			trace(this, "RETURN :", arrayZoneData);
			
			trace(this, "RETURN :", arrayZone);
			
			
			trace(this, "RETURN :", mapData);
		}
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/	
		private function loadedImage(e:Event):void 
		{
			_mapMC		= e.target.content;				
			checkTotalLoad();
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedImage);
			_loader = null;				
		}
		
		private function loadedMaskImage(e:Event):void 
		{
			_mapMask		= e.target.content;		
			checkTotalLoad();
			
			_loaderMask.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedMaskImage);
			_loaderMask = null;
		}
		
		private function loadedCloudImage(e:Event):void 
		{
			_cloudMC = e.target.content;			
			checkTotalLoad();
			
			_loaderCloud.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedCloudImage);
			_loaderCloud = null;			
		}
		
		private function onLayerClick(e:MouseEvent):void 
		{				
			showZone();
		}
		
		private function checkTotalLoad():void {
			_loadCtr++;				
			if (_loadCtr >= _loadTotal) {
				trace(this, "RETURN LOAD MAP COMPLETE _loadCtr:", _loadCtr);				
				
				addChild(_mapMask);	
				_mapLayer.addChild(_mapMC);	
				
				_mapMC.width		= _w;
				_mapMC.height		= _h;
				
				//_mapLayer.width		= _w;
				//_mapLayer.height	= _h;
				
				fillZoneLayout();
				trace(this, "RETURN MAPLAYER WIDTH:", _mapLayer.width);				
			}
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CALL BACKS
		 * ----------------------------------------------------------------------------------------------------------*/	
		//CALLBACK ZONE MOUSE OVER
		private function onOverCallback(params:Object = null):void {
			if(params != null){
				for (var i:int = 0; i < arrayZone.length; i++ ) {					
					if (params.id == arrayZone[i].id) {
						
						//check onGoing zone and other zone layering every mouseover
						if (_zoneOngoing.posY > arrayZone[i].posY) {
							setZoneLayerHigh(arrayZone[i]);
						}else {
							setZoneLayerHighest(arrayZone[i]);
						}				
					}
				}
			}
		}
		
		//CALLBACK ZONE CLICK
		private function selectZone(objData:Object):void {		
			
			for (var j:int = 0; j < arrayZone.length; j++ ) {					
				
				if (arrayZone[j].id == objData.zoneID) {
					
					if (arrayZone[j].zoneStatus != ZoneComponent.ZONE_LOCKED) {							
						
						_isShow = true;			
						_isZoneZoom = true;
						
						_callbackZone(objData);					
						_zoneManager.showZone(objData.zoneID, _mapLayer);	
						
						removePanningListener();
					}
					else {
						displayWarning(arrayZone[j]);
					}
				}
			}		
			
			for (var i:int = 0; i < arrayZone.length; i++ ) {
				if (_isZoneZoom == true) {
					arrayZone[i].removeListener();
				}
				else {
					arrayZone[i].addListener();
				}
			}			
		}
	}

}