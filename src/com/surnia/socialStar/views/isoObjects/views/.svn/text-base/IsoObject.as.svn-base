package com.surnia.socialStar.views.isoObjects.views 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.primitive.IsoRectangle;
	
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.component.progressBarProxy.ProgressBarManagerProxy;
	import com.surnia.socialStar.ui.component.progressBarProxy.ProgressBarProxy;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.FriendInteractionPortraitPopup;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.ui.popUI.views.staff.event.StaffEvent;
	import com.surnia.socialStar.utils.CountdownTimer;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.bubbles.Bubbles;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.isoItems.miniProgressbar.MiniProgressBar;
	import com.surnia.socialStar.views.isoItems.miniProgressbar.events.MiniProgressBarEvent;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.ringCommand.events.RingCommandEvent;
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.Bitmap;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author JC
	 */
	
	public class IsoObject extends Sprite
	{
		
		/*-----------------------------------------------------------------------Constant------------------------------------------------------------------------*/
		//public const CELL_SIZE:int = 34;
		//public const GRID_WIDTH:int = 10;
		//public const GRID_LENGTH:int = 10;
		//public const GRID_HEIGHT:int = 0;
		/*-----------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		public var instance:IsoSprite;
		public var skin:MovieClip;
		//public var name:String;
		public var id:String;
		public var entryid:String;
		public var w:int;
		public var l:int;
		public var h:int;
		public var gridW:int;
		public var gridL:int;
		public var gridH:int;
		//public var rotation:int;
		public var gridX:int;
		public var gridY:int;
		public var type:String;
		public var subType:String;
		public var npc:String;
		public var npcid:String;
		public var empty:String;
		public var level:int;
		public var fbid:String;
		public var gender:String;
		public var staff:String;
		public var state:String;
		public var fn:String;
		// new 
		public var select:Boolean = true;
		public var selectable:Boolean = true;
		
		//public var x:int;
		//public var y:int;
		//public var z:int;
		
		//extra
		public var from:String;
		public var stafflist:String;
		public var assignednpc:String;		
		
		//extra for spacing
		public var extraSpacePosition:String;
		public var extraSpace:IsoBox;
		
		private var _bubbles:Bubbles;
		private var _bubbleType:String = "none";
		
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		private var _popUpUIManager:PopUpUIManager;
		
		//initial office state data
		public var rotatable:Boolean;
		public var dimension:Vector3D;
		public var position:Vector3D;
		
		//new
		public var stress:int;
		public var duration:int;		
		public var health:int;
		public var acting:int;
		public var attraction:int;
		public var intelligence:int;
		public var sing:int;
		public var machineDuration:int;
		public var machineStress:int;
		
		//grid gridcalc
		public var sfxPos:int;
		public var sfyPos:int;
		
		//new prop added
		public var moving:Boolean;
		
		//when there's staff there's state
		
		//new 
		private var _gd:GlobalData;
		
		//officeStore
		public var coin:int;
		public var star:int;
		public var sellPrice:int;
		
		public var isUsed:int = 0;
		public var progressBar:MiniProgressBar;	
		
		//new attributes
		public var eff:String;
		public var machineRewardCoin:int;
		public var machinerewardcooldown:int;
		public var desc:String;
		public var unlocklevel:int;
		public var collected:Boolean;
		private var _collectionTimer:TimeCounterMC02;
		private var _countDownTimer:CountdownTimer;
		
		private var _friendPortrait:FriendInteractionPortraitPopup;
		private var _canCollect:Boolean = false;
		private var _elementContainer:Sprite;
		private var _canShow:Boolean = false;
		private var _canShowCollectionTimer:Boolean = true;
		
		//for dynamic loading of this office item
		private var _imageHolder:Sprite;
		private var _loadingMC:LoadingMC; 
		private var _imageStorage:ImageStorage;
		private var imageLoader:ImageLoader;
		private var _swfLoader:SWFLoader;
		private var _imageName:String;
		private var _isSwf:Boolean;
		private var _url:String;
		private var _isRotated:Boolean;
		public var _image:MovieClip;
		private var _isDynamic:Boolean = false;
		
		//new 01112012
		public var exp:int;
		public var apCost:int;
		
		/*-----------------------------------------------------------------------Constructor---------------------------------------------------------------------*/
		
		public function IsoObject( data:IsoObjectData ) 
		{
			_gd = GlobalData.instance;
			_popUpUIManager = PopUpUIManager.getInstance();	
			
			_sdc = ServerDataController.getInstance();			
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( RingCommandEvent.ON_COLLECT_OFFICE_OBJECT, onCollectOfficeObject );
			
			// listen to collection events by interaction frient event 
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTOBJECTROUTEREWARD, onCollectReward);
			if( data != null ){
				if( data.name != null  ){
					name = data.name;
				}
				
				id = data.id;
				entryid = data.entryid;
				
				/*w = data.w;
				l = data.l;
				h = data.h;*/
				
				//w = pixelToIso(data.w);
				//l = pixelToIso(data.l);
				//h = 3;//data.h;
				
				//hacked sign!!
				
				w = 1;
				l = 1;
				h = 3;
				
				var objectData:Array = _gd.getOfficeStateDataByEntryID(entryid);
				if (objectData.length > 0){
					gridL = objectData[GlobalData.OFFICESTATE_DIMENSION].x;
					gridW = objectData[GlobalData.OFFICESTATE_DIMENSION].y;
					gridH = objectData[GlobalData.OFFICESTATE_DIMENSION].z;
				} else {
					gridW = 1;
					gridL = 1;
					gridH = 3;
				}
				
				rotation = data.rotation;
				gridX = data.gridX;
				gridY = data.gridY;
				type = data.type;			
				subType = data.subType;
				npc = data.npc;
				npcid = data.npcid;
				empty = data.empty;
				level = data.level;
				fbid = data.fbid;
				gender = data.gender;
				staff = data.staff;
				state = data.state;
				fn  = data.fn;			
				
				//extra
				extraSpacePosition = data.extraSpacePosition;
				extraSpace = data.extraSpace;
				from = data.from;
				stafflist = data.stafflist;
				assignednpc = data.assignednpc;			
				
				
				//initial office state data
				rotatable = data.rotatable;
				dimension = data.dimension;
				position = data.position;
				
				stress = data.stress;
				duration = data.duration;
				health = data.health;
				acting = data.acting;
				attraction = data.attraction;
				intelligence = data.intelligence;
				sing = data.sing;
				machineDuration = data.machineDuration;
				machineStress = data.machineStress;			
				
				//shop thing			
				coin = data.coin;
				star = data.star;
				
				//inventroy thing
				sellPrice = data.sellPrice;
				isUsed = data.isUsed;
				
				//new 10192011
				eff = data.eff;
				machineRewardCoin = data.machineRewardCoin;
				machinerewardcooldown = data.machinerewardcooldown;
				desc = data.desc;
				unlocklevel = data.unlocklevel;				
				
				//new
				exp = data.exp;
				apCost = data.apcost;
				
				setDisplay();
				
				//trace( "[ISOOBJECT]: " , "sellPrice", sellPrice, "exp", exp, "apcost", apCost );
			}
		}					
		
		/*-----------------------------------------------------------------------Methods------------------------------------------------------------------------*/
		public function showInteractionPortrait(entry:String, routeData:Array, isChallenge:Boolean, fbid:String):void{
			_friendPortrait.show(entry, routeData, skin.height, isChallenge, fbid);
		}
		
		public function hideInteractionPortrait(tweening:Boolean = false):void{
			if (_friendPortrait != null){
				_friendPortrait.hide(tweening);
			}
		}
		
		private function updateCollected():void{
			if ( from == "shop" ){
				collected = false;
			}else if ( from == "inventory" ) {
				collected = false;
			}else if ( from == "initial" ){
				collected = true;
			}
		}
		
		private function setDisplay():void
		{		
			updateCollected();
			////////////////////////////////////////////////
			// hgd
			// init internal countdowntimer
			//
			if (type == GlobalData.ITEMCATEGORY_MACHINE && subType == GlobalData.ITEMTYPE_MACHINE_INCOME){
			
				var objectArr:Array = _gd.getOfficeStateDataByEntryID(entryid);
				var cooldown:int;
				
				if (collected){
					cooldown = objectArr[GlobalData.OFFICESTATE_ITEM_COOLDOWN];
					if (cooldown <= 0){
						_canCollect = true;
					}
					//cooldown = 15;
					
				} else {
					cooldown = machineDuration;
					_canCollect = false;
					//cooldown = 30;
				}
				Logger.tracer(this, "Item Name " + name + "collected?" + collected + " can collect?: " + _canCollect); 
				_countDownTimer = new CountdownTimer(1000);
				_countDownTimer.setMaxTime(cooldown,0,0);
				_countDownTimer.start();
				_countDownTimer.addEventListener(TimerEvent.TIMER, onCountdownUpdate);
				_countDownTimer.addEventListener(CountdownTimer.INTERVAL_ENDED, onCountdownEnded);
			}
			
			//
			////////////////////////////////////////////////
			_elementContainer = new Sprite();
			
			if( type == "staff" ){
				_bubbles = new Bubbles( -50, -50, "none" );
			}else if( type == "machine" && subType =="income" ){
				_bubbles = new Bubbles( 0, -55, "none" );
			}else{
				_bubbles = new Bubbles( -50, -50, "none" );
			}
			
			if( !_isDynamic ){
				skin = new Objects();			
			}else{
				//for dynamic loading of item image
				_imageStorage = ImageStorage.getInstance();	
				addPreloader();
				showDisplay();
				//for dynamic loading of item image
			}
			
			instance = new IsoSprite( );
			progressBar = new MiniProgressBar( -25, -skin.height );			
			progressBar.addEventListener( MiniProgressBarEvent.ON_PROGRESS_DONE, onProgressDone );
			
			_friendPortrait = new FriendInteractionPortraitPopup();		
			instance.setSize( w, l, h );
			
			//instance.addEventListener( MouseEvent.CLICK, onClickIsoObject );
			//instance.sprites[ 2 ].addEventListener( MouseEvent.CLICK, onClickIsoObject );
			//instance.sprites[ 1 ].addEventListener( MouseEvent.CLICK, onClickIsoObject );
			
			if ( !_isDynamic ) {
				if ( searchForId( id.toString() , skin ) ){
					skin.gotoAndStop( id.toString() );	
					//skin.gotoAndStop( id );
					instance.sprites = [_elementContainer, _friendPortrait, skin, _bubbles, progressBar ];
					instance.sprites[ 2 ].addEventListener( MouseEvent.CLICK, onClickIsoObject );
					
					if( subType =="window" || subType =="door"  ){
						instance.moveTo( _gd.CELL_SIZE + 1, _gd.CELL_SIZE + 1, GlobalData.ISO_WALL_DOOR_DEPTH );
					}else {
						instance.moveTo( _gd.CELL_SIZE + 1, _gd.CELL_SIZE + 1, GlobalData.ISO_OBJECT_DEPTH );
						//instance.moveTo( _gd.CELL_SIZE + 5 , _gd.CELL_SIZE, GlobalData.ISO_OBJECT_DEPTH );
					}		
					
					if( from == "shop" ){
						if ( type == "staff" ) {
							_bubbleType = "add";		
							_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
						}else {
							_bubbleType = "none";
						}
					}else if ( from == "inventory" ) {
						if ( type == "staff" ){						
							if ( state != "null" ){							
								_bubbleType = "none";
								showDeskStaff();							
							}else{
								_bubbleType = "add";
								_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
							}
						}else {
							_bubbleType = "none";
						}
					}else if ( from == "initial" ){
						updateRotation();
						
						if ( type == "staff" ) {						
							if ( state != "null" ){							
								_bubbleType = "none";							
								showDeskStaff();
								addObjectInteraction();
							}else {
								_bubbleType = "add";							
								_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
							}
						}else {
							_bubbleType = "none";
						}
					}
				}else {
					trace( "[IsoObject]: cant find that image in movieclip...." );
				}
			}else {						
				instance.sprites = [_elementContainer, _friendPortrait, skin, _bubbles, progressBar, _imageHolder ];
				
				if( subType =="window" || subType =="door"  ){
					instance.moveTo( _gd.CELL_SIZE + 1, _gd.CELL_SIZE + 1, GlobalData.ISO_WALL_DOOR_DEPTH );
				}else {
					instance.moveTo( _gd.CELL_SIZE + 1, _gd.CELL_SIZE + 1, GlobalData.ISO_OBJECT_DEPTH );
				}
				
				if( from == "shop" ){
					if ( type == "staff" ) {
						_bubbleType = "add";
						_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
					}else {
						_bubbleType = "none";
					}
				}else if ( from == "inventory" ) {
					if ( type == "staff" ){						
						if ( state != "null" ){							
							_bubbleType = "none";
							showDeskStaff();				
						}else{
							_bubbleType = "add";
							_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
						}
					}else {
						_bubbleType = "none";
					}
				}else if ( from == "initial" ){
					updateRotation();
					
					if ( type == "staff" ) {			
						if ( state != "null" ){							
							_bubbleType = "none";
							showDeskStaff();
							addObjectInteraction();
						}else {
							_bubbleType = "add";							
							_es.addEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
						}
					}else {
						_bubbleType = "none";
					}
				}
			}
			
			addObjectListener();
			
			if( subType == "window" || subType == "door"  ){
				if ( gridX == 0 ) {
					flip( false );
				}else {
					flip( true );
				}
			}
			if (rotation == 1){
				if (type == GlobalData.ITEMCATEGORY_MACHINE && subType == GlobalData.ITEMTYPE_MACHINE_INCOME){
					if (_collectionTimer != null){
						_collectionTimer.scaleX * -1;
						//_collectionTimer.x += (skin.width * 0.5)/2;
					}
					progressBar.scaleX *= -1;
					_bubbles.scaleX *= -1;
					if (_friendPortrait != null){
						_friendPortrait.scaleX *=-1;
					}
				}
			}
			
			// set the initial walkable (for now it is set to staff but once the data for l w is fixed for any object just remov the condition.
			if (type == "staff"){
				setWalkable();
			} 
		}	
		
		// this should be a temporary solution to setting the walkable path based on the space taken
		// up by the staff table
		public function setWalkable():void{
			
			if (rotation == 0){
				var xLen:int = gridX - gridW;
				var yLen:int = gridY + gridL;
				for (var x:int = gridX; x > xLen; x--){
					for (var y:int = gridY; y < yLen; y++){
						trace ("item non walkable: " + x + ":" + y);
						_gd.pathGrid.setWalkable(x, y, false);
					}
				}
			} else {
				xLen = gridX + gridW;
				yLen = gridY - gridL;
				for (var x:int = gridX; x < xLen; x++){
					for (var y:int = gridY; y> yLen; y--){
						trace ("item non walkable: " + x + ":" + y);
						_gd.pathGrid.setWalkable(x, y, false);
					}
				}
			}
		}
		
		public function removeWalkable():void{
			
			if (rotation == 0){
				xLen = gridX + gridW;
				yLen = gridY - gridL;
				for (var x:int = gridX; x < xLen; x++){
					for (var y:int = gridY; y> yLen; y--){
						trace ("item walkable: " + x + ":" + y);
						_gd.pathGrid.setWalkable(x, y, true);
					}
				}
			} else {
				var xLen:int = gridX - gridW;
				var yLen:int = gridY + gridL;
				for (var x:int = gridX; x > xLen; x--){
					for (var y:int = gridY; y < yLen; y++){
						trace ("item walkable: " + x + ":" + y);
						_gd.pathGrid.setWalkable(x, y, true);
					}
				}
			}
		}
		
		public function removeCurrentWalkable():void{
			
			if (rotation == 0){
				var xLen:int = gridX - gridW;
				var yLen:int = gridY + gridL;
				if (xLen >= 0 || xLen <_gd.expansion || yLen >= 0 || yLen <_gd.expansion){
					for (var x:int = gridX; x > xLen; x--){
						for (var y:int = gridY; y < yLen; y++){
							trace ("item walkable: " + x + ":" + y);
							_gd.pathGrid.setWalkable(x, y, true);
						}
					}
				}
			} else {
				xLen = gridX + gridW;
				yLen = gridY - gridL;
				if (xLen >= 0 || xLen <_gd.expansion || yLen >= 0 || yLen <_gd.expansion){
					for (var x:int = gridX; x < xLen; x++){
						for (var y:int = gridY; y> yLen; y--){
							trace ("item walkable: " + x + ":" + y);
							_gd.pathGrid.setWalkable(x, y, true);
						}
					}
				}
			}
		}
		
		private function onCountdownEnded(ev:Event):void{
			_countDownTimer.stop();
			_canCollect = true;
			if (_bubbles != null){
				_bubbles.showBubble("coin");
			}
			_countDownTimer.setMaxTime(0,0,0);
			/*if (_canShow){
			updateCollectioneTextTime();
			}*/
		}
		
		private function onCountdownUpdate(ev:TimerEvent):void{
			if (_canShow){
				updateCollectionTextTime();
			}
		}
		
		private function updateCollectionTextTime():void {
			if( _collectionTimer != null ){
				if (_countDownTimer.countTime > 0){
					_collectionTimer.timeTextField.text = "Ready: " + _countDownTimer.timeValue;
				} else {
					_collectionTimer.timeTextField.text = "Click to collect";
				}
			}
		}
		
		private function showCollectionTimer():void {
			if( !moving && _countDownTimer.countTime > 0 && !_gd.friendView){
				if (_collectionTimer == null && _canShowCollectionTimer){
					_collectionTimer = new TimeCounterMC02();
					_elementContainer.addChild(_collectionTimer);
					_collectionTimer.x -= skin.width/2; //skin.width/1.5;
					_collectionTimer.y -= skin.height;
					_collectionTimer.alpha = 0;
					updateCollectionTextTime();
					_canShow = true;
					TweenLite.to(_collectionTimer, .3, {alpha:1});
					if (int(rotation) == 1){
						_collectionTimer.scaleX *= -1;
						_collectionTimer.x += skin.width;
						//_collectionTimer.x += _collectionTimer.width / 1.25;
						if (_friendPortrait != null){
							_friendPortrait.scaleX *=-1;
						}
					}
				}
			}
		}
		
		public function set canShowCollectionTimer (value:Boolean):void{
			_canShowCollectionTimer = value;
		}
		
		public function get canShowCollectionTimer ():Boolean{
			return _canShowCollectionTimer;
		}
		
		private function onShowComplete():void{
			_collectionTimer.timeTextField.alpha = 1;
		}
		
		private function hideCollectionTimer():void{
			if (_collectionTimer != null){
				TweenLite.to(_collectionTimer, .3, {alpha:0, onComplete:onHideComplete});
			}
		}
		
		private function onHideComplete():void {
			if ( _collectionTimer != null ) {
				if ( _elementContainer.contains( _collectionTimer ) ) {
					_elementContainer.removeChild(_collectionTimer);
					_collectionTimer = null;
					_canShow = false;
				}
			}
		}
		
		private function searchForId( itemId:String , mc:MovieClip ):Boolean 
		{
			var labels:Array = mc.currentLabels;
			var found:Boolean = false;
			trace( "[IsoObject id]: searching", itemId );
			
			for (var i:uint = 0; i < labels.length; i++) {
				var label:FrameLabel = labels[i];
				//for checking obj.id				
				if ( label.name === itemId ) {
					found = true;
					trace( "[IsoObject id]: found itemId", itemId );
					break;
				}
			}
			
			return found;
		}		
		
		
		public function showBubble( type:String = null ):void 
		{
			if( type == null ){
				_bubbles.showBubble( _bubbleType );
			}else {
				_bubbles.showBubble( type );
			}
		}
		
		private function hireStaff():void 
		{
			//trace( "[ IsoObject ] hire staff........................................................................" );
			_popUpUIManager.loadWindow( WindowPopUpConfig.STAFF_WINDOW );			
			_es.dispatchESEvent(new StaffEvent (StaffEvent.UPDATE_STAFFITEMDATA, {itemEntryID:String (entryid), fn:fn, staffPositions:staff }));
			//trace( "[ IsoObject hire staff ] entry id", entryid );
			GlobalData.instance.currentEntryId = entryid;
		}
		
		public function hireContestant():void
		{
			//_popUpUIManager.loadWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW, 0, 0, false, 12 , 83 );
			_popUpUIManager.loadWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW );
			//trace( "[iso room hire staff ] can't hire already hired.....2", staff, state );	
		}	
		
		public function showDeskStaff(  ):void 
		{			
			trace( "[ IsoObject ]: show dekStaff: state", state, "type", type , "subType",  subType );
			if( type == "staff" ){
				if ( skin != null ){
					showBubble( "none" );
					if ( skin.mc != null ){
						if ( subType == "hire" ){							
							skin.mc.gotoAndStop( 3 );								
						}						
						state = "hired";
					}					
				}
			}			
		}	
		
		public function addObjectInteraction():void 
		{
			//trace( "add object interaction..........1" , instance, "state", state );
			if ( type == "staff" && subType == "hire" )
			{
				if ( instance != null && state != "null" ) 
				{
					if( subType =="hire" ){						
						_es.addEventListener( RingCommandEvent.ON_RECRUIT_CONTESTANT, onRecruitContestant );
					}else if ( subType == "fire" ) {
						_es.addEventListener( RingCommandEvent.ON_FIRE_CONTESTANT, onFireContestant );
					}
				}
			}			
		}			
		
		public function removeObjectInterAction():void 
		{
			if ( type == "staff" && subType == "hire" )
			{
				if ( instance != null && state != "null" ) 
				{
					//trace( "add object interaction..........2" );					
				}
			}
		}
		
		private function addObjectListener():void{
			
			instance.addEventListener( MouseEvent.MOUSE_OVER, onObjectOver );
			instance.addEventListener( MouseEvent.MOUSE_OUT, onObjectOut );
			
			// hgd
			if (type == GlobalData.ITEMCATEGORY_MACHINE && subType == GlobalData.ITEMTYPE_MACHINE_INCOME){
				skin.addEventListener( MouseEvent.ROLL_OUT, onItemOut );
				skin.addEventListener( MouseEvent.ROLL_OVER, onItemOver );
			}
		}
		
		private function onItemOut(ev:MouseEvent):void{
			hideCollectionTimer();
		}
		
		private function onItemOver(ev:MouseEvent):void{
			if (!_canCollect){
				showCollectionTimer();
			}
		}
		
		private function onObjectOver(ev:ProxyEvent):void{
			if (!select && instance != null ){
				skin.filters = [new GlowFilter( 0xEEEEE0, 1, 4, 4, 48 )];
			}
		}
		
		private function onObjectOut(ev:ProxyEvent):void{
			if (!select && instance != null ){
				skin.filters = [];
			}
		}
		
		public function updateTrainingArea():void 
		{
			if ( name == "bookcase" ) {
				
			}
			
			if( rotation == 0 ){
				sfxPos = gridX;
				sfyPos = gridY - 1;
			}else {
				sfxPos = gridX - 1;
				sfyPos = gridY;
			}
			
			//trace( "[isoObject Training out of bounds]" );
		}
		
		public function rotate():void 
		{
			//if x == 0 , right
			//y = 0, left
			//rot = 0 when its facing right
			//rot = 1 when its facing left
			
			if ( subType != "window" && subType != "door" ){		
				if ( rotation == 0 ) {
					instance.container.scaleX = -1;	
					//skin.scaleX = -(skin.scaleX);
					rotation = 1;
					//skin.x += ( skin.width / 2 * 2 );
					trace( "[IsoObject]: from 0 to 1 " );
				}else {
					rotation = 0;
					instance.container.scaleX = 1;
					//skin.scaleX = -(skin.scaleX);	
					//skin.x -= ( skin.width / 2 * 2 );
					trace( "[IsoObject]: from 1 to 0 " );
				}

				//not used
				updateTrainingArea();
			} 
			
			
			if (type == GlobalData.ITEMCATEGORY_MACHINE && subType == GlobalData.ITEMTYPE_MACHINE_INCOME){
				if (_collectionTimer != null){
					_collectionTimer.scaleX *= -1;
					//_collectionTimer.x += (skin.width * 0.5)/2;
				}
				_bubbles.scaleX *= -1;
				progressBar.scaleX *= -1;
				if (_friendPortrait != null){
					_friendPortrait.scaleX *=-1;
				}
			}
			
			if (type == "staff"){
				removeWalkable();
				setWalkable();
			}
			
			trace( "rotate!!!", rotation );
			trace( "gridX", gridX, "gridY",gridY, "sfxPos", sfxPos, "sfyPos",sfyPos , "new rotation", rotation );			
		}
		
		public function flip( right:Boolean ):void 
		{
			if ( right ) {
				//skin.scaleX = -1;
				instance.container.scaleX = -1;
				rotation = 1;
				//skin.x += ( skin.width / 2 * 2 );
			}else {
				//skin.scaleX = 1;
				instance.container.scaleX = 1;
				rotation = 0;
				//skin.x -= ( skin.width / 2 * 2 );
			}
		}
		
		
		private function updateRotation():void 
		{				
			if ( subType != "window" && subType != "door" ){
				if ( rotation == 1 ) {
					instance.container.scaleX = -1;
					//skin.scaleX = -(skin.scaleX);					
					//skin.x += ( skin.width * 2 );					
					//skin.scaleX = -(skin.scaleX);					
				}
			}
		}
		
		public function updateData( obj:Object ):void 
		{			
			//check?? buy,rotate,move
			trace('\nOBJECT DATA UPDATED\n');
			l = obj.l;
			w = obj.w;
			h = obj.h;
			x = obj.x;
			y = obj.y;
			z = obj.z;
			///gridX = l;
			//gridY = w;
			rotation = obj.rot;	
		}
		
		public function selected():void 
		{
			if (selectable && instance != null ){
				select = true;
				skin.filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 48 )];
			}
		}
		
		public function deselected():void 
		{
			if( instance != null ){
				select = false;
				skin.filters = [];
			}
		}
		
		
		public function isValidSpace( val:Boolean ):void 
		{
			if( !val ){
				skin.filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 64 * 0.75 )];
			} else {
				skin.filters = [new GlowFilter( 0x00FF00, 1, 4, 4, 64 * 0.75 )];
			}
		}
		
		public function destroy():void 
		{
			instance.removeEventListener( MouseEvent.MOUSE_OVER, onObjectOver );
			instance.removeEventListener( MouseEvent.MOUSE_OUT, onObjectOut );
			instance.removeEventListener( MouseEvent.CLICK, onClickIsoObject );
			_es.removeEventListener( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT, onHireStaff );
			_es.removeEventListener( RingCommandEvent.ON_RECRUIT_CONTESTANT, onRecruitContestant );	
			_es.removeEventListener( RingCommandEvent.ON_COLLECT_OFFICE_OBJECT, onCollectOfficeObject );
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTOBJECTROUTEREWARD, onCollectReward);
			_bubbles = null;
			skin = null;
			
			if( _collectionTimer != null  ){
				_countDownTimer.stop();
				_countDownTimer.removeListeners();
				_countDownTimer.removeEventListener(TimerEvent.TIMER, onCountdownUpdate);
				_countDownTimer.removeEventListener(CountdownTimer.INTERVAL_ENDED, onCountdownEnded);
				
				_collectionTimer = null;
			}			
		}
		
		public function onCollectReward(ev:FriendInteractionEvent):void{
			// collect reward if the jump is in here and reset timer
			var isoObject = ev.params.isoObject;
			if (isoObject == this){
				collectIncome();
			}
		}
		
		public function showHideProgressbar(val:Boolean):void 
		{			
			if( val ){
				progressBar.show();
			}else {
				progressBar.hide();
			}
		}		
		
		public function activateProgressbar():void 
		{
			progressBar.activate();
		}
		
		/*-----------------------------------------------------------------------Setters------------------------------------------------------------------------*/
		override public function set name(value:String):void 
		{
			super.name = value;
		}		
		
		override public function set rotation(value:Number):void 
		{
			super.rotation = value;
		}		
		
		override public function set x(value:Number):void 
		{
			super.x = value;
		}	
		
		override public function set y(value:Number):void 
		{
			super.y = value;
		}	
		
		override public function set z(value:Number):void 
		{
			super.z = value;
		}
		
		private function addPreloader():void 
		{
			_imageHolder = new Sprite();
			addChild( _imageHolder );
			
			_loadingMC = new LoadingMC();
			_imageHolder.addChild( _loadingMC );	
			//_loadingMC.x = ( 70 / 2 ) - ( ( _loadingMC.width / 2 ) + 20 );
			//_loadingMC.y = ( 36 / 2 ) -  ( ( _loadingMC.height / 2 ) + 25 );
			//_loadingMC.x = 15;
			//_loadingMC.y = 36;
			
			skin = new MovieClip();	
			
			_isSwf = false;			
			_imageName = "Deco_fan01";			
		}
		
		private function showDisplay( imageName:String = null ,url:String = null ):void 
		{
			if ( imageName != null ) {
				_imageName = imageName;
			}
			
			trace( "show display" );			
			var found:Boolean = _imageStorage.search( _imageName );
			if ( found ){
				_loadingMC.stop();
				_loadingMC.visible = false;
				var image:Bitmap = _imageStorage.getImage( _imageName );				
				trace( "[IsoObject]: show now!!!!!!!!!!!!!!!!!!!!!!!!!!!!" );
				
				//subtype door
				skin.x = ( ( skin.width / 2 ) ) * - 1 ;
				//skin.x += 16;
				skin.x -= skin.width;
				
				skin.y = ( ( skin.height / 2 ) ) * - 1 ;
				//skin.y -= 3;
				
				// for swf staff specially
				
				//skin.x = ( ( skin.width / 2 ) ) * - 1 ;
				//skin.x += 20;
				//
				//skin.y = ( ( skin.height / 2 ) ) * - 1 ;
				//skin.y -= 3;
				
				
				//two tiles none png
				/*
				skin.x = ( ( skin.width / 2 ) ) * - 1 ;
				skin.x += 20;
				
				skin.y = ( ( skin.height / 2 ) ) * - 1 ;
				skin.y -= 3;
				*/
				
				//png single tiles
				/*
				skin.x = ( skin.width / 2) * -1;				
				var perTile:int = Math.round( skin.height / 36 );			
				
				if ( perTile ==  1 ) {
					skin.y = ( ( skin.height / 2) - 8 ) * -1;
				}else if( perTile == 2 ){

					//skin.y = ( skin.height / 2) * -1;
					//skin.y = ( ( skin.height / 2) - 4 ) * -1;
					skin.y = ( ( skin.height / 2) - 1 ) * -1;

					skin.y = ( skin.height / 2) * -1;

				}else if( perTile == 3 ){
					skin.y = ( ( skin.height / 2) + 15 ) * -1;					
				}else if( perTile == 4 ){
					skin.y = ( ( skin.height / 2 ) + 4 ) * -1;					
				}else{
					skin.y = ( ( skin.height / 2) + 30 ) * -1;					
				}*/
				
			}else {
				if ( url != null ) {
					_url = url;
					start( _url );
				}else {
					var runingOn:String = Capabilities.playerType;
					//if (runingOn != 'StandAlone')
					//{
					//start( _gd.tileImage );						
					//}else {
					start(  );
					//}
				}				
			}
		}
		
		private function start( url:String = null ):void 
		{			
			trace( "[ISoObject]: start loading url ==>", url );
			var config:ImageLoaderVars = new ImageLoaderVars();
			config.container(skin);
			config.onComplete(_completeHandler);
			config.onProgress(_progressHandler);
			config.onIOError(_ioErrorHandler);
			config.onFail(_failHandler);
			config.autoDispose(true);
			config.name(_imageName);
			
			if ( !_isSwf ) {
				if ( url != null ){
					imageLoader = new ImageLoader( url, config);
				}else {
					//imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/images/Deco/Table/Deco_fan01.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_fan01.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/testraw3.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/testraw2.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_intrument01.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_moai.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_Table04.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_wall02.png", config);

					//imageLoader = new ImageLoader("images/Deco/Table/roundTable.png", config);					
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_stand_Air03.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/door01.png", config);

					//imageLoader = new ImageLoader("images/Deco/Table/Deco_stand_Air03.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/door01.png", config);
					//21size_Vending1

					//imageLoader = new ImageLoader("images/Deco/Table/21size_Vending1.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/testTwoTiles.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/testTwoTiles2.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Cabinet08.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/staff.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/door1sample.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/doorSample.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/door2.png", config);
					imageLoader = new ImageLoader("http://202.124.129.14/socialstars/public/data/imgs/obj/door/door2.png", config);					
					//
					//imageLoader = new ImageLoader("images/Deco/Table/11size_coffee0.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/greenTable.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/statue.png", config);
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_stand_Air03.png", config);					

					//imageLoader = new ImageLoader("images/Deco/Table/door01.png", config);
					//door01				
					
					//wrong
					//imageLoader = new ImageLoader("images/Deco/Table/Machine_Income_Vending03.png", config);					
					//imageLoader = new ImageLoader("images/Deco/Table/Deco_Plants07.png", config);					
					//imageLoader = new ImageLoader("images/Deco/Table/Machine_Income_ATM01.png", config);					
					//Machine_Income_ATM01
				}				
				imageLoader.load();
			}else {
				if ( url != null ) {
					_swfLoader = new SWFLoader( url, config);
				}else{
					_swfLoader = new SWFLoader("images/Deco/Table/sampleStaff.swf", config);
				}				
				_swfLoader.load();
			}			
			//addChild( imageLoader.content );		
		}
		
		/*-----------------------------------------------------------------------Getters------------------------------------------------------------------------*/
		
		override public function get rotation():Number 
		{
			return super.rotation;
		}
		
		override public function get x():Number 
		{
			return super.x;
		}
		
		override public function get y():Number 
		{
			return super.y;
		}
		
		override public function get z():Number 
		{
			return super.z;
		}
		
		override public function get name():String 
		{
			return super.name;
		}
		
		
		/*-----------------------------------------------------------------------EventHandlers------------------------------------------------------------------*/
		private function pixelToIso(_val:int):int
		{
			var _multiplier:int = _val / 36;
			var _newVal:int = _val / ( _multiplier * 36);
			return _newVal;
		}
		
		//private function onClickIsoObject(e:ProxyEvent) : void 
		private function onClickIsoObject(e:MouseEvent) : void 
		{
			//_sdc.setMiniGameResult( 1 , "singing");		
			//var progressBarManager:ProgressBarManagerProxy = ProgressBarManagerProxy.instance;
			//progressBarManager.addProgressBar( 5, this, null );
			
			trace( "GridX", gridX, "GridY", gridY, "x", x, "y" , y, "z", z );
			trace('\ndimension : ' + dimension);
			trace('position : ' + position);
			trace('width : ' + w);
			trace('length : ' + l);
			trace('height : ' + h);		
			trace( "machine stress", machineStress, "machine duration", machineDuration, "sing", sing, "int", intelligence, "health", health
				,"attraction", attraction, "acting", acting, "stress ", stress, "duration", duration , "isUsed", isUsed, "name", name );
			_gd.currentIsoObject = this;
			//update globalData currentSelected IsoObject here
			var ringCommandEvent:RingCommandEvent;
			
			if( !_gd.friendView && !_gd.npcView ){		
				if ( !moving && _gd.currentInterAction == "" ){						
					var commands:Array = [];
					if (  type == "machine" && subType == "income" ) {
						/*if ( !collected ) {*/
						//if (!isUsed){
						// changed to default 
						commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL , GlobalData.COMMAND_INVENTORY ];
						//}
						if( _countDownTimer != null ){
							/*if (_countDownTimer.countTime <= 0){
							
							}*/
							if (_canCollect){
								commands.push(GlobalData.COMMAND_COLLECT);
							}
						}
							/*}else {
							if (!isUsed){
								commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL ];
							}
							
							if( _countDownTimer != null ){
								/*if (_countDownTimer.countTime <= 0){
								
								}
								if (_canCollect){
									commands.push(GlobalData.COMMAND_COLLECT);
								}
							}
						}	*/
					}else if (  type == "staff" ) {
						
						if ( state == "null" ) {
							commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL, GlobalData.COMMAND_STAFF ];
						}else {
							if( subType == "hire" ){
								commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL, GlobalData.COMMAND_RECRUIT  ];
							}else if( subType == "fire" ){
								commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL, GlobalData.COMMAND_FIRE  ];
							}else {
								commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL ];
							}
						}						
					}else{
						if (!isUsed){
							commands = [ GlobalData.COMMAND_MOVE, GlobalData.COMMAND_ROTATE, GlobalData.COMMAND_SELL, GlobalData.COMMAND_INVENTORY ];
						}
					}
					
					_gd.currentIsoObject = this;
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SHOW_RING_COMMAND );
					var obj:Object = new Object();
					obj.commands = commands;
					_es.dispatchESEvent( ringCommandEvent, obj );
					trace( "[IsoRoom] dispatched ring command 1..............................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>> now!!"  );
				}else {
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_DROP_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );
					trace( "[IsoRoom] dispatched ring drop office object..............................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>> now!!"  );
				}
				
				trace( "check object moving==============>", moving );
			}else {
				var commands:Array;
				if (  type == "machine" /*&& subType == "income"*/ && collected) {
					if( _countDownTimer != null ){
						if (_countDownTimer.countTime <= 0){
							commands = [ GlobalData.COMMAND_COLLECT ];
							_gd.currentIsoObject = this;
							ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SHOW_RING_COMMAND );
							var obj:Object = new Object();
							obj.commands = commands;
							_es.dispatchESEvent( ringCommandEvent, obj );
						}
					}
				}					
			}			
		}	
		
		private function onProgressDone(e:MiniProgressBarEvent):void 
		{
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_DROP_REWARDS );
			var obj:Object = new Object();
			obj.x = x;
			obj.y = y;
			obj.z = z;
			_es.dispatchESEvent( isoRoomEvent, obj );
			trace( "[ isoobject]collection complete..............................>>>>>>>> xyz", x, y, z );
			//showCollectionTimer();
			_canShowCollectionTimer = true;
		}		
		
		private function onCollectOfficeObject(e:RingCommandEvent):void 
		{
			/*if ( entryid == _gd.currentIsoObject.entryid ) {
			trace( "[IsoObject Collect coin]:", machineRewardCoin );
			//_gd.coinReward = machineRewardCoin;
			//hack
			_gd.coinReward = 500;
			activateProgressbar();
			}		*/	
			trace ("target " + e.target);
			trace ("type " + e.type);
			if (!_gd.friendView){
				if (_canCollect && entryid == _gd.currentIsoObject.entryid ){
					// hgd revision
					var apAfter:int = 0;
					var objectData:Array = _gd.getOfficeStateDataByEntryID(entryid);
					if (objectData != null){
						apAfter = checkPopup(objectData[GlobalData.OFFICESTATE_APCOST]);
					}
					
					if (apAfter >=0){
						collectIncome();
					}
				}
			} else {
				if (_canCollect && entryid == _gd.currentIsoObject.entryid ){
					
					if (_gd.pHE >0){
						collectIncome();
					} else {
						// call or load that theres no more helping energy left
					}
				}
			}
		}
		
		private function collectIncome():void{
			if (_bubbles != null){
				_bubbles.showBubble("none");
			}
			updateCollectionTextTime();
			// set server call for collect
			if (_gd.friendView){
				if (_gd.selectedFriendFbId != null){
					_sdc.setOfficeItemUsage(entryid, _gd.selectedFriendFbId);
				}
			} else {
				_sdc.setOfficeItemUsage(entryid);
			}
			// set reward here
			collected = true;
			_gd.coinReward = 500;
			hideCollectionTimer();
			activateProgressbar();
			
			var objectArr:Array = _gd.getOfficeStateDataByEntryID(entryid);
			var maxtime:int = objectArr[GlobalData.OFFICESTATE_REST_DURATION];
			
			_canCollect = false;
			_countDownTimer.setMaxTime(maxtime, 0, 0);
			_countDownTimer.start();
			_canShowCollectionTimer = false;
			updateCollectionTextTime();
			
			_sdc.machineCollect( entryid );
		}
		
		private function onHireStaff(e:RingCommandEvent):void 
		{
			if( _gd.currentIsoObject.entryid == entryid ){
				hireStaff();
				var tut:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_BUBBLE );
				_es.dispatchESEvent( tut );
				//trace( "clicked  bubbles staff...................................state", state );				
			}
		}
		
		private function onRecruitContestant(e:RingCommandEvent):void 
		{
			_sdc.checkCharCount();
			_es.addEventListener( ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE, onCheckCharCountComplete );
		}
		
		private function onFireContestant(e:RingCommandEvent):void 
		{
			trace( "[ISoObject ]: fire contestant.!!" );
		}
		
		//new
		private function _progressHandler(event:LoaderEvent):void {
			//this.progress_mc.progressBar_mc.scaleX = event.target.progress;
			trace( "percernt loaded check: ", event.target.progress );
		}
		
		/**
		 * Checks the ap value and calls the ap popup when ap is below zero.
		 *	 
		 */
		
		public function checkPopup(apCost:int = 0):int{
			var apAfter:int = _gd.pAp - apCost;
			if (_gd.pAp <= 0 || apAfter < 0){
				_es.dispatchEvent(new SSEvent (SSEvent.ACTIONPOINT_POPUP));
			}
			return apAfter;
		}
		
		private function _completeHandler(event:LoaderEvent):void {
			//TweenLite.to(event.target.content, 1, 
			//{alpha:1, scaleX:1, scaleY:1, rotation:"360", 
			//ease:Back.easeOut});
			trace("Finished loading " + event.target);
			trace( "name please" + event.target.name , "content", event.target.content );			
			_imageStorage.addImage( event.target.name, skin );			
			showDisplay();
			
			var imageLoaderEvent:ImageLoaderEvent = new ImageLoaderEvent( ImageLoaderEvent.IMAGE_LOADED );
			imageLoaderEvent.obj.name = event.target.name;
			_es.dispatchESEvent( imageLoaderEvent  );
		}
		
		private function _ioErrorHandler(event:LoaderEvent):void {
			trace("Asset IOError:", event);
		}
		
		private function _failHandler(event:LoaderEvent):void {
			trace("Asset failed to load:", event);
		}
	
		private function onCheckCharCountComplete(e:ServerDataControllerEvent):void 
		{
			_es.removeEventListener( ServerDataControllerEvent.ON_CHECK_CHAR_COUNT_COMPLETE, onCheckCharCountComplete );
			if (  e.obj.count < e.obj.limit  ){
				if ( GlobalData.instance.officeId == GlobalData.instance.myFbId ){
					if ( _gd.currentInterAction != "sell" && _gd.currentInterAction != "move"  && _gd.currentInterAction != "rotate") {					
						var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
						_es.dispatchESEvent( ringCommandEvent );					
						hireContestant();
						var tut:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_STAFF );
						_es.dispatchESEvent( tut );
					}
				}
			}else {
				//show popup window thats telling you can't hire more character you reach max limit!!..
			}
			
		}		
	}
}