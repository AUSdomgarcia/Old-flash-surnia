package com.surnia.socialStar.ui.friendUI.view 
{		
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.friendUI.controller.FriendUIController;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.tooltip.MiniTooltipManager;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FriendUI extends Sprite
	{
		/*-----------------------------------------------------------Constant-----------------------------------------------------------------------------*/		
		
		/*-----------------------------------------------------------Properties-----------------------------------------------------------------------------*/
		private var _friendUIController:FriendUIController;
		private var _friendUIScroller:FriendUIScroller;
		private var _bg:MainbgMC;
		private var _friendUIEvent:FriendUIEvent;
		private var _es:EventSatellite;
		private var _mtm:MiniTooltipManager = MiniTooltipManager.instance;
		
		/*-----------------------------------------------------------Constructor-----------------------------------------------------------------------------*/
		
		public function FriendUI() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );			
			initControllers();
			setDisplay();
			registerTooltipItem();
			trace( "Friend UI init....................." );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-----------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		
		private function initControllers():void 
		{
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( PopUIEvent.CHANGE_OFFICE_NAME, onChangeOfficeName );
		}		
		
		private function setDisplay():void 
		{
			
			addBg();
			//addChild( new FriendUIBox( "asaka!!!","77",new Sprite() ) );			
			addFriendUIScroller( null );
		}
		
		private function registerTooltipItem():void{
			_mtm.registerItem(_bg.shopNameBtn, "Studio Name", - _bg.shopNameBtn.x + (_bg.shopNameBtn.width * .85), (-_bg.shopNameBtn.height / 2) +10  -_bg.shopNameBtn.y);
		}
		
		private function removeDisplay():void 
		{			
			removeBg();
			removeFriendUIScroller();
		}		
		
		private function addFriendUIScroller( friends:Array ):void 
		{
			if( _friendUIScroller == null ){
				_friendUIScroller = new FriendUIScroller(  );
				addChild( _friendUIScroller );
				_friendUIScroller.y = 18;				
			}
			
			_friendUIController = FriendUIController.getInstance();
			_friendUIController.addEventListener( FriendUIEvent.FRIENDS_DATA_READY, onFriendsDataReady );
			_friendUIController.init();
			_friendUIController.extactFriendInfo();
			//else {
				//_friendUIScroller.updateFriendUIBox();
			//}
		}
		
		private function removeFriendUIScroller():void 
		{
			if ( _friendUIScroller !=null ) {
				if ( this.contains( _friendUIScroller ) ){
					this.removeChild( _friendUIScroller );
					_friendUIScroller = null;
				}
			}
		}
		
		private function addBg():void 
		{
			_bg = new MainbgMC();
			addChild( _bg );
			_bg.addEventListener( MouseEvent.ROLL_OVER, onRollOverLowerGUI );
			_bg.y = 60;
			_bg.shopNameBtn.txtShopName.text = "Entertainment";			
			_bg.shopNameBtn.addEventListener( MouseEvent.CLICK, onClickShopName );
			_bg.shopNameBtn.buttonMode = true;
			
			if( GlobalData.instance.officeName != "" ){
				_bg.shopNameBtn.txtShopName.text = GlobalData.instance.officeName;
			}else {
				_bg.shopNameBtn.txtShopName.text = "MyOfficeName";
			}
		}				
		
		
		private function removeBg():void 
		{
			if ( _bg != null ) {
				if ( this.contains( _bg ) ) {
					this.removeChild( _bg );
					_bg = null;
				}
			}
		}		
		
		private function updateOfficeName( officeName:String ):void 
		{			
			_bg.shopNameBtn.txtShopName.text = officeName;			
			var sdc:ServerDataController  = ServerDataController.getInstance();
			sdc.setOfficeName( officeName );
		}
		
		/*-----------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------EventHandlers------------------------------------------------------------------------*/
		private function onFriendsDataReady(e:FriendUIEvent):void 
		{
			trace( "updated friends data  xml last!!!! .................................", _friendUIController.friends );
			if( _friendUIScroller != null ){
				_friendUIScroller.updateFriendUIBoxText( _friendUIController.friends );
				//_friendUIScroller.loadImages( _friendUIController.friends );
			}
			
			
			//_friendUIEvent = new FriendUIEvent( FriendUIEvent.FRIEND_DATA_COMPLETE );
			//_es.dispatchESEvent( _friendUIEvent );			
			
			//_friendUIScroller.updateFriendUIBox( _friendUIController.friends  );
			//_friendUIScroller.loadImages( _friendUIController.friends );
			//addFriendUIScroller( _friendUIController.friends );
		}
		
		private function onClickShopName(e:MouseEvent):void 
		{
			trace( "click" );			
			_friendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_SHOP_NAME );
			_es.dispatchESEvent( _friendUIEvent );
		}
		
		private function onChangeOfficeName(e:PopUIEvent):void 
		{
			trace( "new office name", e.obj );
			updateOfficeName( e.obj as String );
		}
		
		private function onRollOverLowerGUI(e:MouseEvent):void 
		{
			var rect:Rectangle = _bg.getBounds( this );
			if ( rect.contains( mouseX, mouseY ) ) {
				var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN );
				_es.dispatchESEvent( isoRoomEvent );
			}
		}
	}

}