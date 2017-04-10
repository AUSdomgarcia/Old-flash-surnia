package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
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
	 */
	public class BuildingComponent extends MovieClip
	{			
		public static const BLINK_TIME:int = 15; //frame rate
		
		public static const BUILDING_NORMAL:String	= "2";
		public static const BUILDING_DIM:String		= "1";
		public static const BUILDING_LOCKED:String	= "0";
		
		public static const BUILDING_BOSS:String = "1";	
		
		public static const BUILDING_BRIGHT:String	= "building bright";		
		
		public var locX:int;
		public var locY:int;
		
		public var lockURL:String;
		public var buildingURL:String;
		
		public var buildingID:String;
		public var buildingName:String;
		public var buildingStatus:String;	
		
		public var buildingIsBoss:String;
		
		public var posX:int;
		public var posY:int;
		public var posZ:int;
		
		public var lockX:int;
		public var lockY:int;
		
		public var activeMode:MovieClip;		
		public var buildingData:BuildingDetail;		
		
		public var tf:TextFormat = new TextFormat;
		public var gf:GlowFilter = new GlowFilter(0xFFCCCCCC, 1.0, 6, 6, 50);
		public var gfBlink:GlowFilter = new GlowFilter(0xFF0000, 1.0, 6, 6, 50);
		
		public	var txt:TextField = new TextField;
		public	var txtMC:MovieClip = new MovieClip;
		
		public var isActive:Boolean = false;
		public var isLock:Boolean = false;
		public var levelDetail:LevelDetail;
		
		private var _loadCtr:int = 0;
		private var _loadTotal:int = 4;	//NORMAL/ DIM /BRIGTH /LOCKED 
		
		private var _objData:Object
		private var _callbackBuilding:Function;
		
		private var _loader:Loader;		
		private var _loaderDim:Loader;
		private var _loaderBright:Loader;	
		private var _loaderLock:Loader;
		
		private var _buildingUI:Bitmap;
		private var _buildingDimUI:Bitmap;
		private var _buildingBrightUI:Bitmap;
		private var _lockUI:Bitmap;
		
		private var _buildingMC:MovieClip;		
		private var _buildingDimMC:MovieClip;	
		private var _buildingBrightMC:MovieClip;
		private var _buildingLockMC:MovieClip;
		
		private	var _gf:GlowFilter = new GlowFilter(0xFCD116, 1.0, 6, 6, 50);		
		
		private var _ctr:int = 0;
		public function BuildingComponent(callbackBuilding:Function, buildingDetail:BuildingDetail ) 
		{				
			buildingData	= buildingDetail;
			
			buildingID		= buildingData.buildingID;
			buildingName	= buildingData.buildingName;
			buildingStatus	= buildingData.buildingMode;
			
			posX			= buildingData.posX;
			posY			= buildingData.posY;
			posZ			= buildingData.posZ;			
			
			levelDetail 	= buildingData.levelDetail;
			buildingIsBoss	= buildingData.buildingIsBoss;			
			
			_callbackBuilding	= callbackBuilding;			
			
			initialization();	
			loadBuildingURL();
			callBackData();
			addListener();
			
			if (buildingStatus == BuildingComponent.BUILDING_DIM) {
				isActive = true;
				addEnterFrame();
			}
		}	
		
		private function addEnterFrame():void 
		{
			this.addEventListener(Event.ENTER_FRAME, onUpdate);
		}		
		
		private function removeEnterFrame():void 
		{
			this.filters = [];
			this.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:Event):void 
		{
			_ctr++;
			
			if (_ctr == BuildingComponent.BLINK_TIME / 2 || _ctr == (BuildingComponent.BLINK_TIME / 2) + .5) {				
				this.filters = [gfBlink];
			}
			if (_ctr == BuildingComponent.BLINK_TIME) {
				_ctr = 0;
				this.filters = [];
			}
		}
		
		private function initialization():void 
		{			
			_loader = new Loader;
			_loaderDim = new Loader;
			_loaderBright = new Loader;			
			_loaderLock = new Loader;
			
			_objData = new Object
			
			_buildingMC = new MovieClip;
			_buildingMC.x = posX;
			_buildingMC.y = posY;	
			
			_buildingDimMC = new MovieClip;
			_buildingDimMC.x = posX;
			_buildingDimMC.y = posY;	
			
			_buildingBrightMC = new MovieClip;
			_buildingBrightMC.x = posX;
			_buildingBrightMC.y = posY;	
			
			_buildingLockMC = new MovieClip;			
		}	
		
		private function loadBuildingURL():void {
			
			//LOAD NORMAL BUILDING					
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedImage);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcher);
				_loader.load(new URLRequest(buildingData.buildingURL));	
			
			//LOAD DIM BUILDING				
				_loaderDim.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedImage2);
				_loaderDim.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcher2);
				_loaderDim.load(new URLRequest(buildingData.buildingDimURL));	
		
			
			//LOAD BRIGHT BUILDING				
				_loaderBright.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedImage3);
				_loaderBright.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcher3);
				_loaderBright.load(new URLRequest(buildingData.buildingBrightURL));	
			
			//LOAD BUILDING LOCK				
				_loaderLock.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedLock);
				_loaderLock.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherLock);
				_loaderLock.load(new URLRequest(buildingData.buildingLockURL));	
			
		}
		
		private function errorCatcherLock(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING BUILDING LOCK ERROR!!!");
			if(buildingData != null){
				trace(this, "RETURN URL LINK:", buildingData.buildingLockURL, " BUILDING ID:",buildingID);
			}
		}
		
		private function errorCatcher3(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING BUILDING BRIGHT ERROR!!!");
			if(buildingData != null){
				trace(this, "RETURN URL LINK:", buildingData.buildingBrightURL, " BUILDING ID:",buildingID);
			}
		}
		
		private function errorCatcher2(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING BUILDING DIM ERROR!!!");
			if(buildingData != null){
				trace(this, "RETURN URL LINK:", buildingData.buildingDimURL, " BUILDING ID:",buildingID);
			}
		}
		
		private function errorCatcher(e:IOErrorEvent):void 
		{
			trace(this, "ERROR RETURN LOADING BUILDING NORMAL ERROR!!!");
			if(buildingData != null){
				trace(this, "RETURN URL LINK:", buildingData.buildingURL, " BUILDING ID:",buildingID);
			}
		}	
		
		private function loadedLock(e:Event):void 
		{			
			_lockUI = e.target.content;		
			if(_buildingLockMC != null && _lockUI != null){
				_buildingLockMC.addChild(_lockUI);	
				_buildingLockMC.x 	= posX;
				_buildingLockMC.y 	= posY;	
			}			
			
			checkTotalLoad();
			
			_loaderLock.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedLock);
			_loaderLock = null;				
		}
		
		private function loadedImage(e:Event):void 
		{						
			_buildingUI = e.target.content;	
			if(_buildingMC != null && _buildingUI != null){
				_buildingMC.addChild(_buildingUI);		
			}
		
			checkTotalLoad();
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedImage);
			_loader = null;
		}
		
		private function loadedImage2(e:Event):void 
		{			
			_buildingDimUI = e.target.content;	
			if(_buildingDimMC != null && _buildingDimUI != null){
				_buildingDimMC.addChild(_buildingDimUI);
			}
			
			checkTotalLoad();
			
			_loaderDim.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedImage2);
			_loaderDim = null;
		}
		
		private function loadedImage3(e:Event):void 
		{			
			_buildingBrightUI = e.target.content;	
			if(_buildingBrightMC != null && _buildingBrightUI != null){
				_buildingBrightMC.addChild(_buildingBrightUI);
			}
			
			checkTotalLoad();
			
			_loaderBright.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadedImage3);
			_loaderBright = null;
		}
		
		private function checkTotalLoad():void {
			_loadCtr++;				
			if (_loadCtr >= _loadTotal) {	
				trace(this, "RETURN LOAD BUILDING COMPLETE _loadCtr:", _loadCtr);	
				
				if (buildingStatus == BuildingComponent.BUILDING_LOCKED) {
					if (buildingIsBoss != BuildingComponent.BUILDING_BOSS) {
						buildingStatus = BuildingComponent.BUILDING_DIM;
					}
					isLock = true;
				}
				
				display();		
				addLockListener();
			}
		}
		
		private function display():void {				
			switchBuilding(buildingStatus);
			
			if ( isLock == false ) {
				addBuildingListener();
			}
			else {
				removeBuildingListener();				
			}
		}
		
		private function addListener():void {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function removeListener():void {
			removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (isLock == true) {
				displayWarning();
			}
		}
		
		//DISPLAY WARNING IF BUILDING NOT ACTIVE			
		private function displayWarning():void {			
			txt.selectable = false;
			txt.x = 0;// building.building.x - ((building.width / 2) + (txt.width / 2));
			txt.y = 0;// building.building.y;		
					
			txtMC.x = 0;
			txtMC.y = 0;
			
			txtMC.addChild(txt);
			addChild(txtMC);
			
			tf.font = "Arial Bold";
			tf.bold = true;
			tf.size = 24;
			tf.color = 0xFFFFFF;
			
			txt.defaultTextFormat = tf;				
			txt.width = 450;
			txt.height = Number(tf.size + 5);
			txt.text = "You must meet all requirements!";			
			txt.filters = [gf];
			
			txtMC.alpha = 0;
			if(txtMC != null){
				TweenLite.to(txtMC, 2, {
					y:-50, 
					alpha:1, 
					ease:Back.easeOut,
					onComplete: function():void {
						TweenLite.to(txtMC, .5, { 
							alpha:0, 
							onComplete: function():void {
								if (txtMC != null) {									
									removeChild(txtMC);											
								}							
							}					
						});					
					}					
				});
			}
			
			if (txt.x < 0) {
				txt.x = 0;
			}
			/*
			if (txt.x + txt.width > GameConfig.GAME_WIDTH ) {
				
				txt.x = GameConfig.GAME_WIDTH  - txt.width;
			}		
			*/
		}	
		
		public function addBuildingListener():void {
			if(activeMode != null){
				activeMode.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				activeMode.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
			if(_buildingBrightMC != null){
				_buildingBrightMC.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				_buildingBrightMC.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				_buildingBrightMC.addEventListener(MouseEvent.CLICK, onClick);
			}
		}		
		
		
		public function removeBuildingListener():void {
			if(activeMode != null){
				activeMode.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				activeMode.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
			if(_buildingBrightMC != null){
				_buildingBrightMC.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				_buildingBrightMC.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
				_buildingBrightMC.removeEventListener(MouseEvent.CLICK, onClick);
			}
		}	
		
		private function addLockListener():void {
			if(_buildingLockMC != null){
				_buildingLockMC.addEventListener(MouseEvent.CLICK, onLockClick);
			}
		}
		
		private function removeLockListener():void {
			if(_buildingLockMC != null){
				_buildingLockMC.removeEventListener(MouseEvent.CLICK, onLockClick);
			}
		}
		
		private function onLockClick(e:MouseEvent):void 
		{			
			if(_buildingLockMC != null){
				TweenLite.to(MovieClip(_buildingLockMC), 1, {
					y:0 - 5,
					 useFrames:true,
					onComplete: function():void {
						TweenLite.to(MovieClip(_buildingLockMC), 1, { y:0, useFrames:true } );
					}				
				});
			}
		}
		
		public function switchBuilding(modeType:String = BuildingComponent.BUILDING_NORMAL):void {
			removeBuilding();
			
			switch(modeType) {
				case BuildingComponent.BUILDING_NORMAL:
					removeLock();
					if (_buildingMC != null) {	
						
						activeMode = _buildingMC;
						addChild(_buildingMC);						
					}
				break;
				case BuildingComponent.BUILDING_DIM:
					removeLock();
					if (_buildingDimMC != null) {
						
						activeMode = _buildingDimMC;
						addChild(_buildingDimMC);
						
					}
				break;
				case BuildingComponent.BUILDING_LOCKED:
					if(_buildingLockMC != null && _buildingMC != null){
						_buildingLockMC.x = (_buildingMC.width / 2) - (_buildingLockMC.width / 2);
						_buildingLockMC.y = (_buildingMC.height / 2) - (_buildingLockMC.height / 2);				
					}
					
					if (_buildingMC != null && _buildingLockMC != null) {
						_buildingMC.addChild(_buildingLockMC);
						
						activeMode = _buildingMC;
						addChild(_buildingMC);
					}					
				break;
				
				case BuildingComponent.BUILDING_BRIGHT:
					removeLock();
					if (_buildingDimMC != null) {						
						activeMode = _buildingBrightMC;
						addChild(_buildingBrightMC);						
					}
				break;
			}				
		}
		
		public function removeLock():void {
			if (_buildingLockMC != null) {
				if (_buildingMC.contains(_buildingLockMC)) {
					_buildingMC.removeChild(_buildingLockMC);
				}
			}
		}
		
		public function removeBuilding():void {
			//remove normal
			if (_buildingMC != null) {
				if (this.contains(_buildingMC)) {
					removeChild(_buildingMC);
				}
			}
			
			//remove dim
			if (_buildingDimMC != null) {
				if (this.contains(_buildingDimMC)) {
					removeChild(_buildingDimMC);
				}
			}
			
			//remove bright
			if (_buildingBrightMC != null) {
				if (this.contains(_buildingBrightMC)) {
					removeChild(_buildingBrightMC);
				}
			}
		}
		
		public function nullAllInstances():void {
			removeEnterFrame();
			removeLock();
			if (_buildingLockMC != null) {
				_buildingLockMC = null;
			}
			
			removeBuilding();
			if(_buildingMC != null){
				_buildingMC = null;
			}
			
			if(_buildingDimMC != null){
				_buildingDimMC = null;
			}
			
			if(_buildingBrightMC != null){
				_buildingBrightMC = null;
			}
			
			
			if (_objData != null) {
				_objData = null;
			}
			
			if (buildingData != null) {
				buildingData = null;
			}
			trace("CLEAN :", this);
			
			
			//---------------------------------------------------------------CHECK ALL!!!!!-------------------------------------------
			/*
			trace(this, "RETURN :", _loadCtr);
			trace(this, "RETURN :", _loadTotal);
			
			trace(this, "RETURN :", _objData);
			trace(this, "RETURN :", _callbackBuilding);
			
			trace(this, "RETURN :", _loader);	
			trace(this, "RETURN :", _loaderDim);
			trace(this, "RETURN :", _loaderBright);
			trace(this, "RETURN :", _loaderLock);
			
			trace(this, "RETURN :", _buildingUI);
			trace(this, "RETURN :", _buildingDimUI);
			trace(this, "RETURN :", _buildingBrightUI);
			trace(this, "RETURN :", _lockUI);
			
			trace(this, "RETURN :", _buildingMC);
			trace(this, "RETURN :", _buildingDimMC);	
			trace(this, "RETURN :", _buildingBrightMC);
			trace(this, "RETURN :", _buildingLockMC);
			
			trace(this, "RETURN :", _gf);
			
			trace(this, "RETURN :", locX);
			trace(this, "RETURN :", locY);
			
			trace(this, "RETURN :", lockURL);
			trace(this, "RETURN :", buildingURL);
			
			trace(this, "RETURN :", buildingID);
			trace(this, "RETURN :", buildingName);
			trace(this, "RETURN :", buildingStatus);
			
			trace(this, "RETURN :", buildingIsBoss);
			
			trace(this, "RETURN :", posX);
			trace(this, "RETURN :", posY);
			trace(this, "RETURN :", posZ);
			
			trace(this, "RETURN :", lockX);
			trace(this, "RETURN :", lockY);
			
			trace(this, "RETURN :", activeMode);
			trace(this, "RETURN :", buildingData);	
			
			trace(this, "RETURN :", levelDetail);
			*/			
		}
		
		private function onOut(e:MouseEvent):void 
		{
			switchBuilding(buildingStatus);
			
			e.target.filters = [];
			
			if(isActive == true){
				addEnterFrame();
			}
			/*
			if(_buildingBrightMC != null && _buildingDimMC != null && _buildingMC != null){
				TweenLite.to(MovieClip(_buildingBrightMC), 10, { x:posX , y:posY, scaleX:1, scaleY:1, useFrames:true });
				TweenLite.to(MovieClip(_buildingDimMC), 10, { x:posX , y:posY, scaleX:1, scaleY:1, useFrames:true });	
				TweenLite.to(MovieClip(_buildingMC), 10, { x:posX , y:posY, scaleX:1, scaleY:1, useFrames:true } );
			}	
			*/
		}
		
		private function onOver(e:MouseEvent):void
		{				
			var origWidth:int = _buildingMC.width;			
			if (buildingStatus != BuildingComponent.BUILDING_LOCKED) {
				switchBuilding(BuildingComponent.BUILDING_BRIGHT);
				
				e.target.filters = [_gf];				
				removeEnterFrame();
				/*
				if(_buildingBrightMC != null && _buildingDimMC != null && _buildingMC != null){
					TweenLite.to(MovieClip(_buildingBrightMC), 10, { x: _buildingBrightMC.x - 5, y: _buildingBrightMC.y - 5, scaleX:1.1, scaleY:1.1, useFrames:true } );				
					TweenLite.to(MovieClip(_buildingDimMC), 10, { x: _buildingDimMC.x - 5, y: _buildingDimMC.y - 5, scaleX:1.1, scaleY:1.1, useFrames:true } );
					TweenLite.to(MovieClip(_buildingMC), 10, { x: _buildingMC.x - 5, y: _buildingMC.y - 5, scaleX:1.1, scaleY:1.1, useFrames:true } );			
				}	
				*/
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{			
			_callbackBuilding(_objData);
		}
		
		//CALL BACK SELECT BUILDING
		private function callBackData():void 
		{
			_objData.buildingID 	= buildingID;
			_objData.buildingName 	= buildingName;
			_objData.buildingStatus 	= buildingStatus;
			
			_objData.posX 	= posX;
			_objData.posY 	= posY;
			_objData.posZ 	= posZ;
			
			_objData.buildingURL 		= buildingData.buildingURL;
			_objData.buildingDimURL		= buildingData.buildingDimURL;
			_objData.buildingBrightURL 	= buildingData.buildingBrightURL;
			
			_objData.buildingIsBoss		= buildingIsBoss;
			
			_objData.lvlProgram		= levelDetail.lvlProgram;
			_objData.lvlAP 			= levelDetail.lvlAP;
			_objData.lvlBossScript  = levelDetail.lvlBossScript;
			_objData.lvlCoin 		= levelDetail.lvlCoin;
			_objData.lvlDifficulty  = levelDetail.lvlDifficulty;
			_objData.lvlDuration	= levelDetail.lvlDuration;
			_objData.lvlLevReq		 = levelDetail.lvlLevReq;
			_objData.lvlRewardCoin	 = levelDetail.lvlRewardCoin;
			_objData.lvlRewardExp	 = levelDetail.lvlRewardExp;
			
			_objData.npcID			 = levelDetail.npcID;
			_objData.npcSing		 = levelDetail.npcSing;
			_objData.npcActing		 = levelDetail.npcActing;
			_objData.npcAttraction 	 = levelDetail.npcAttraction;
			_objData.npcHealth		 = levelDetail.npcHealth;
			_objData.npcIntelligent	 = levelDetail.npcIntelligent;
			
			_objData.npcDefinition	 = levelDetail.npcDefinition;			
			//trace(this, "RETURN NPC DEF:", _objData.npcDefinition);
			_objData.npcGender		 = levelDetail.npcGender;
			
			_objData.npcLvlNPC		 = levelDetail.npcLvlNPC;
			_objData.npcNameNPC		 = levelDetail.npcNameNPC;	
		}		
	}
}