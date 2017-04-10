package com.surnia.socialStar.ui.friendUI.view 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.points.Points;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;	
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FriendUIBox extends Sprite
	{
		/*----------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		private var _mc:FriendUIBoxMC;
		private var _name:String;		
		private var _level:String;
		private var _image:*;
		private var _me:int;
		private var _he:int;
		
		
		private var _friendUIEvent:FriendUIEvent;
		private var _es:EventSatellite;
		
		//private var _friendPopUp:FriendPopUp;
		private var _popUIManager:PopUpUIManager;
		
		//new 
		private var _fbId:String;
		private var _serverDataController:ServerDataController;
		private var _dialogue:DialogueEvent;
		private var _gd:GlobalData;
		/*----------------------------------------------------------------------------Constrcutor------------------------------------------------------------*/
		
		public function FriendUIBox( name:String = null, level:String = null, image:* = null ) 
		{			
			_gd = GlobalData.instance;
			
			_name = name;
			_level = level;
			_image = image;			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			prepareControllers();
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*----------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_serverDataController = ServerDataController.getInstance();
			_popUIManager = PopUpUIManager.getInstance();
			
			_mc = new FriendUIBoxMC();
			addChild( _mc );
			
			_mc.txtName.text = "...";
			_mc.levelMC.txtLevel.text = "...";
			if ( _name != null && _level != null  ){
				_mc.txtName.text = _name;
				_mc.levelMC.txtLevel.text = _level;
			
				_mc.addChild( _image );
				_image.x = ( ( _mc.width / 2 ) - ( _image.width / 2 ) );
				_image.y = ( ( _mc.height / 2 ) - ( _image.height / 2 ) ) - 10;
				_mc.swapChildren( _image, _mc.levelMC );				

				//_mc.preloader.visible = false;
				//_mc.addFriendBtn.visible = false;
			}
			
			//else {
				//_mc.preloader.visible = false;
				//_mc.gotoAndStop( 2 );
				//var rnd:int = ( Math.random() * 2 ) + 1;				
				//_mc.addFriend.gotoAndStop( rnd );
				//_mc.addFriendBtn.addEventListener( MouseEvent.CLICK, onAddFriend );
				//_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				//_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );				
				//_mc.addFriendBtn.buttonMode = true;
				//_mc.addEventListener( MouseEvent.CLICK, onClickFriendBox );
			//}
			
			if ( _name == "npc"  ) {
				_mc.preloader.visible = false;
				_mc.gotoAndStop( 1 );				
				_mc.imageHolder.alpha = 1;
				_mc.buttonMode = true;				
				_mc.addEventListener( MouseEvent.CLICK, onShowNpcView );
				_mc.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				_mc.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );				
				
				_mc.he.visible = false;
				_mc.bug.visible = false;
				_mc.defeat.visible = false;
			}else if ( _name == "add" ) {
				_mc.preloader.visible = false;
				_mc.gotoAndStop( 2 );
				var rnd:int = ( Math.random() * 2 ) + 1;				
				_mc.addFriend.gotoAndStop( rnd );
				_mc.addFriendBtn.addEventListener( MouseEvent.CLICK, onAddFriend );				
				_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );				
				_mc.addFriend.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				_mc.addFriend.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );				
				_mc.friendPlate.mouseChildren = false;
				_mc.friendPlate.mouseEnabled = false;
				_mc.imageHolder.mouseChildren = false;
				_mc.imageHolder.mouseEnabled = false;
				//_mc.addFriend.addFriendBtn.buttonMode = true;
				_mc.levelMC.txtLevel.visible = false;
				_mc.imageHolder.visible = false;
				
				_mc.he.visible = false;
				_mc.bug.visible = false;
				_mc.defeat.visible = false;
			}else{			
				_mc.imageHolder.npcImage.visible = false;
				_mc.addEventListener( MouseEvent.CLICK, onShowFriendBoxPopUp );
				_mc.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				_mc.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );
			}						
			
			
			_mc.buttonMode = true;
		}											
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		//public function updateData( name:String, level:String, image:*, fbId:String, me:String  ):void 
		//{
			//_name = name;
			//_level = level;
			//_image = image;
			//_fbId = fbId;
			//_me = me;
			//
			//trace( "update!!!.." , name, level, image );
			//
			//if ( name != null && level != null && image != null ) {				
				//if( _name != "add" ){
					//if( _mc.txtName != null ){
						//_mc.txtName.text = name;
					//}
					//
					//if( _mc.levelMC != null ){
						//_mc.levelMC.txtLevel.text = level;
					//}
					//
					//_mc.addChild( image );
					//image.x = (  ( _mc.width / 2 ) - ( image.width / 2 ) );
					//image.y = ( ( _mc.height / 2 ) - ( image.height / 2 ) ) - 10;			
					//_mc.swapChildren( image, _mc.levelMC );			
					//_mc.preloader.visible = false;				
				//}
			//}else {
				//_mc.imageHolder.npcImage.visible = false;
				//_mc.removeEventListener( MouseEvent.CLICK, onShowFriendBoxPopUp );
				//_mc.removeEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				//_mc.removeEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );
				//
				//
				//_mc.preloader.visible = false;
				//_mc.gotoAndStop( 2 );
				//var rnd:int = ( Math.random() * 2 ) + 1;				
				//_mc.addFriend.gotoAndStop( rnd );
				//_mc.addFriendBtn.addEventListener( MouseEvent.CLICK, onAddFriend );				
				//_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				//_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );				
				//_mc.addFriend.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				//_mc.addFriend.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );				
				//_mc.friendPlate.mouseChildren = false;
				//_mc.friendPlate.mouseEnabled = false;
				//_mc.imageHolder.mouseChildren = false;
				//_mc.imageHolder.mouseEnabled = false;
				//_mc.addFriend.addFriendBtn.buttonMode = true;
				//_mc.levelMC.txtLevel.visible = false;
				//_mc.imageHolder.visible = false;
			//}
		//}
		
		public function updateData( name:String, level:String, image:*, fbId:String, me:int , he:int, bug:int, defeat:int  ):void 
		{
			_name = name;
			_level = level;
			_image = image;
			_fbId = fbId;
			_me = me;
			_he = he;
			
			trace( "update!!!.." , name, level, _image );
			
			if ( name != null && level != null /*&& _image != null*/  ) {				
				if( _name != "add" ){
					if( _mc.txtName != null ){
						_mc.txtName.text = name;
					}
					
					if( _mc.levelMC != null ){
						_mc.levelMC.txtLevel.text = level;
					}
					
					if ( he > 0 ){
						_mc.he.visible = true;
					}else {
						_mc.he.visible = false;
					}
					
					if ( bug > 0 ) {
						_mc.bug.visible = true;
					}else {
						_mc.bug.visible = false;
					}
					
					if ( defeat > 0 ){
						_mc.defeat.visible = true;
					}else {
						_mc.defeat.visible = false;
					}
					
					if( _image != null ){
						_mc.addChild( _image );
						_image.x = (  ( _mc.width / 2 ) - ( _image.width / 2 ) );
						_image.y = ( ( _mc.height / 2 ) - ( _image.height / 2 ) ) - 10;			
						_mc.swapChildren( _image, _mc.levelMC );			
						_mc.preloader.visible = false;
					}					
				}
			}else {
				
				if ( _image != null ){ 
					if ( _mc.contains( _image ) ) {
						_mc.removeChild( _image );
						_image = null;
					}
				}
				
				_mc.he.visible = false;
				_mc.bug.visible = false;
				_mc.defeat.visible = false;
				
				_mc.imageHolder.npcImage.visible = false;
				_mc.removeEventListener( MouseEvent.CLICK, onShowFriendBoxPopUp );
				_mc.removeEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				_mc.removeEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );
				
				
				_mc.preloader.visible = false;
				_mc.gotoAndStop( 2 );
				var rnd:int = ( Math.random() * 2 ) + 1;				
				_mc.addFriend.gotoAndStop( rnd );
				_mc.addFriendBtn.addEventListener( MouseEvent.CLICK, onAddFriend );				
				_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				_mc.addFriendBtn.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );				
				_mc.addFriend.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriend );
				_mc.addFriend.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriend );				
				_mc.friendPlate.mouseChildren = false;
				_mc.friendPlate.mouseEnabled = false;
				_mc.imageHolder.mouseChildren = false;
				_mc.imageHolder.mouseEnabled = false;
				//_mc.addFriend.addFriendBtn.buttonMode = true;
				_mc.levelMC.txtLevel.visible = false;
				_mc.imageHolder.visible = false;
			}
		}
		
		private function prepareControllers():void 
		{
			_es = EventSatellite.getInstance();
		}
		
		//private function addFriendPopUp():void 
		//{
			//if(  _friendPopUp == null ){
				//_friendPopUp = new FriendPopUp();
				//addChild( _friendPopUp );
			//}else {
				//removeFriendPopUp();
			//}
		//}
		//
		//private function removeFriendPopUp():void 
		//{
			//if ( _friendPopUp != null ) {
				//if ( this.contains( _friendPopUp ) ) {
					//this.removeChild( _friendPopUp );
					//_friendPopUp = null;
				//}
			//}
		//}
		
		/*----------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		private function onAddFriend(e:MouseEvent):void 
		{
			trace( "add Friend............................" );			
			_friendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_ADD_FRIENDS );
			_es.dispatchESEvent( _friendUIEvent );
		}
		
		private function onRollOutBtn(e:MouseEvent):void 
		{
			_mc.addFriendBtn.gotoAndStop( 1 );
			trace( "roll out!........." );
		}
		
		private function onRollOverBtn(e:MouseEvent):void 
		{
			_mc.addFriendBtn.gotoAndStop( 2 );
			trace( "roll over!........." );			
		}
		
		//private function onClickNPC(e:MouseEvent):void 
		//{
			//trace( "go to NPC.............." );
			//_friendUIEvent = new FriendUIEvent( FriendUIEvent.GO_TO_NPC );
			//_es.dispatchESEvent( _friendUIEvent );
		//}
		
		private function onRollOutFriend(e:MouseEvent):void 
		{	
			var rect:Rectangle = _popUIManager.getBounds( this );
			if ( rect.contains( mouseX, mouseY ) ) {
				
			}else {			
				_popUIManager.removeWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW );
			}			
			
			if( _mc != null ){
				_mc.filters = null;
			}
			e.currentTarget.filters = null;
		}
		
		private function onRollOverFriend(e:MouseEvent):void 
		{
			e.currentTarget.filters = [ new GlowFilter( 0xFFB007, 1, 10, 10, 3, BitmapFilterQuality.MEDIUM, false, false )  ];
			_popUIManager.removeWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW );			
		}	
		
		private function onShowFriendBoxPopUp(e:MouseEvent):void 
		{
			_gd.isNpcTabSelected = false;
			//GlobalData.instance.npcView = false;
			GlobalData.instance.selectedFriendFbId = _fbId;
			trace( "click friends box..............", _fbId, "me", _me );			
			
			if ( _me == 1 ){				
				if ( GlobalData.instance.officeId != GlobalData.instance.selectedFriendFbId  ) {
					_serverDataController.loadMyOfficeData();
					//_gd.friendOfficeStateDataArray = [new Array()];
					//_gd.friendCharListDataArray = [new Array()];
					//
					//_serverDataController.updateHomeViewData();
					//_serverDataController.updateMyCharlist();
					//trace( "go to home!!" );
					//
					//_popUIManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );
					//_dialogue = new DialogueEvent( DialogueEvent.HOME_DIALOGUE );
					//_es.dispatchEvent( _dialogue );
				}
			}else{
				if ( GlobalData.instance.officeId != GlobalData.instance.selectedFriendFbId ) {
					var xPos:int;
					var yPos:int;
					//var point:Point = this.parent.localToGlobal( new Point( this.parent.x , this.parent.y ) );
					//var point:Point = _mc.localToGlobal( new Point( _mc.x , _mc.y ) );
					var point:Point = Points.getGlobalPoints( _mc );
					xPos = point.x + 50;
					yPos = point.y - 8;
					
					if( _he > 0 ){
						_gd.showVisitingReward = true;
					}else {
						_gd.showVisitingReward = false;
					}
					
					_popUIManager.loadWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW , 0, 0, false, xPos , yPos );								
					trace( "go to others show friend pop!!" );					
				}else {
					trace( "already in that friend office no new office will be loaded!!....................." );					
				}
				
			}
		}
		
		private function onShowNpcView(e:MouseEvent):void 
		{
			_gd.isNpcTabSelected = true;
			trace( "[FriendUIBox]: npcview", GlobalData.instance.friendView, "friendview", GlobalData.instance.friendView, "selectedFriendFbId", GlobalData.instance.selectedFriendFbId
			 ,"officeId", GlobalData.instance.officeId );
			
			var xPos:int;
			var yPos:int;
			//var point:Point = _mc.localToGlobal( new Point( _mc.x , _mc.y ) );
			var point:Point = Points.getGlobalPoints( _mc );
			 
			 
			 if ( !GlobalData.instance.npcView ){				
				xPos = point.x + 50;
				yPos = point.y - 8;
				_popUIManager.loadWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW , 0, 0, false, xPos , yPos );
				//_popUIManager.loadWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW , 0, 0, false, this.x + 50 , this.y + 445 );
			 }
			 
			/*			
			if ( !GlobalData.instance.npcView ) {
				GlobalData.instance.friendView = false;
				GlobalData.instance.npcView = true;
				GlobalData.instance.selectedFriendFbId = null;
				GlobalData.instance.officeId = null;				
				
				_serverDataController.updateNpcCharlist();
				_serverDataController.updateNPCVisitViewData();				
			
				_popUIManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );
				_dialogue = new DialogueEvent( DialogueEvent.NPC_VISIT_DIALOGUE );
				_es.dispatchEvent( _dialogue );
				trace( "[ friend box ]: show npc office................................" );
			}*/
		}
	}

}