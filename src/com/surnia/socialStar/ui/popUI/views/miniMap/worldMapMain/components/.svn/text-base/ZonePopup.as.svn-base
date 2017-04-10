package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.greensock.*;
	import com.greensock.loading.core.DisplayObjectLoader;
	import com.greensock.plugins.*;
	import flash.events.IOErrorEvent;

	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author df
	 */
	public class ZonePopup extends Sprite
	{
		private var _bossURL:String;
		private var _bgURL:String;
		
		private var _bossBmp:Bitmap;
		private var _bgBmp:Bitmap;
		
		private var _loadTotal:int = 2;
		private var _loadCtr:int = 0;	
		
		private var _bossX:int;
		private var _bossY:int;		
		
		private var _posX:int = 0;
		private var _posY:int = 0;
		
		private var _zoneComplete:Boolean;
		private var _zoneName:String;
		private var _bossName:String;
		
		private var _bgClass:Class;
		
		private var _bgMC:MovieClip;
		private var _bossMC:MovieClip;	
		
		private var _skyLayer:DisplayObjectContainer;
		private var _zoneUI:DisplayObjectContainer;
		private var _parentLayer:DisplayObjectContainer;
		
		private var _loaderBG:Loader;
		private var _loaderBoss:Loader;	
		
		private var _zoneStatus:int;
		public function ZonePopup(zoneUI:DisplayObjectContainer, bgURL:String = null, bossURL:String = null, bossX:int = 0, bossY:int = 0, zoneName:String = null, bossName:String = null, zoneComplete:Boolean = false, zoneStatus:int = 0) 
		{
			_bossURL = bossURL;
			_bgURL	 = bgURL;		
			
			_bossX	= bossX;
			_bossY	= bossY;
		
			
			_zoneComplete 	= zoneComplete;
			_zoneStatus		= zoneStatus;
			
			_zoneName = zoneName;
			_bossName = bossName;			
			
			_zoneUI = zoneUI;
			initialization();		
			loadURL();			
		}	
		
		private function initialization():void 
		{		
			_loaderBG 	= new Loader;
			_loaderBoss	= new Loader;		
			
			_bossMC = new MovieClip;
			_bossMC.x = _bossX;
			_bossMC.y = _bossY;				
		}
		
		private function loadURL():void 
		{	
			if(_bgURL != null){
				_loaderBG.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedBGImage);
				_loaderBG.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherBG);
				_loaderBG.load(new URLRequest(_bgURL));	
			}
			
			if(_bossURL != null){
				_loaderBoss.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedBossImage);
				_loaderBoss.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherBoss);
				_loaderBoss.load(new URLRequest(_bossURL));	
			}
		}
		
		private function errorCatcherBoss(e:Event):void 
		{
			trace(this, "ERROR RETURN LOADING POPUP BOSS ERROR!!!");
			trace(this, "RETURN URL LINK:", _bossURL);
		}
		
		private function errorCatcherBG(e:Event):void 
		{
			trace(this, "ERROR RETURN LOADING POPUP BACKGROUND ERROR!!!");
			trace(this, "RETURN URL LINK:", _bgURL);
		}
		
		private function showDisplay():void {		
			if(_bgMC != null && _parentLayer != null){
				_parentLayer.addChild(_bgMC);
			}
			
			if(_bossMC != null){
				_bgMC.addChild(_bossMC);
			}	
			
			popupPosition();	
			hide();
		}		
		
		private function popupPosition():void 
		{			
			if(_bgMC != null && _zoneUI != null){
				_bgMC.x = _posX +(_zoneUI.width / 2) - (_bgMC.width / 2);
				_bgMC.y	= _posY -(_bgMC.height);				
				
				if (_bgMC.y + _zoneUI.y < 0) {
					_bgMC.y = _posY + (_bgMC.y - (_bgMC.y + _zoneUI.y));			
				}		
			}
		}			
		
		public function show():void {			
			if(_bgMC != null){
				_bgMC.visible = true;		
			}
		}
		
		public function hide():void {			
			if(_bgMC != null){
				_bgMC.visible = false;
			}
		}
		
		public function removeDisplay():void {
			if (_bgMC != null && _parentLayer != null) {
				if(_zoneUI.contains(_bgMC)){
					_parentLayer.removeChild(_bgMC);
				}
			}
			
			if (_bossMC != null) {
				if(this.contains(_bossMC)){
					removeChild(_bossMC);
				}
			}
		}		
		
		public function setParentLayer(parentLayer:DisplayObjectContainer, X:int = 0, Y:int = 0):void {
			_parentLayer = parentLayer;
			
			_posX = X;
			_posY = Y;
		}
		
		public function setImageDim():void {			
			if (_zoneStatus == ZoneComponent.ZONE_LOCKED) {
				if(_bossMC !=null){
					TweenPlugin.activate([TintPlugin]);
					TweenLite.to(_bossMC, 1, { tint:0x000000 } );
				}
			}			
		}
		
		public function nullAllInstances():void {
			removeDisplay();
			if(_bgMC != null){
				_bgMC = null;
			}
			
			if(_bossMC != null){
				_bossMC = null;
			}			
			
			trace("CLEAN :", this);
			
			//---------------------------------------------------------------CHECK ALL!!!!!-------------------------------------------			
			
			/*
			trace(this, "RETURN CHECK CLEAN :", _bossURL);
			trace(this, "RETURN CHECK CLEAN :", _bgURL);
			
			trace(this, "RETURN CHECK CLEAN :", _bossBmp);
			trace(this, "RETURN CHECK CLEAN :", _bgBmp);
			
			trace(this, "RETURN CHECK CLEAN :", _loadTotal);
			trace(this, "RETURN CHECK CLEAN :", _loadCtr);
			
			trace(this, "RETURN CHECK CLEAN :", _bossX);
			trace(this, "RETURN CHECK CLEAN :", _bossY);
			
			trace(this, "RETURN CHECK CLEAN :", _zoneComplete);
			trace(this, "RETURN CHECK CLEAN :", _zoneName);
			trace(this, "RETURN CHECK CLEAN :", _bossName);
			
			trace(this, "RETURN CHECK CLEAN :", _bgClass);
			
			trace(this, "RETURN CHECK CLEAN :", _bgMC);
			trace(this, "RETURN CHECK CLEAN :",_bossMC);	
			
			trace(this, "RETURN CHECK CLEAN :", _skyLayer);
			trace(this, "RETURN CHECK CLEAN :", _zoneUI);
			
			trace(this, "RETURN CHECK CLEAN :", _loaderBG);
			trace(this, "RETURN CHECK CLEAN :", _loaderBoss);
			*/
		}
		
		private function loadedBGImage(e:Event):void 
		{				
			_bgClass = _loaderBG.contentLoaderInfo.applicationDomain.getDefinition("WorldmapZone") as Class;
			_bgMC = new _bgClass;			
			//_bgMC = e.target.content;
			if (_bossName != null) {
				if(_bgMC != null){
					_bgMC.BossName.text = _bossName;
				}
			}
			
			if (_zoneName != null) {
				if(_bgMC != null){
					_bgMC.ZoneName.text = _zoneName;
				}
			}	
			if(_bgMC != null){
				addChild(_bgMC);
			}
			checkTotalLoad();
			
			_loaderBG.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedBGImage);
			_loaderBG = null;
		}		
		
		private function loadedBossImage(e:Event):void 
		{			
			_bossBmp = e.target.content;
			if (_bossBmp != null) {				
				if(_bossMC != null){
					_bossMC.addChild(_bossBmp);		
				}
			}
			
			setImageDim();
			
			checkTotalLoad();
			
			_loaderBoss.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedBossImage);
			_loaderBoss = null;
		}
		
		private function checkTotalLoad():void {
			_loadCtr++;	
			trace(this, "RETURN _loadCtr/_loadTotal :", _loadCtr, " ", _loadTotal );
			
			if (_loadCtr >= _loadTotal) {	
				trace(this, "RETURN LOAD POPUP COMPLETE _loadCtr:", _loadCtr);			
				showDisplay();
			}
		}
	}
}