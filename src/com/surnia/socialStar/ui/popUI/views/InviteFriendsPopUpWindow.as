package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;	
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;	
	import com.surnia.socialStar.utils.gotoUrl.UrlNavigator;	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class InviteFriendsPopUpWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:InviteFriendPopUpMC;
		private var _bm:ButtonManager;		
		private var _popUpUIevent:PopUIEvent;
		private var _popUpManager:PopUpUIManager;
		private var _jsm:JsManager;
		private var _sdc:ServerDataController;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		
		public function InviteFriendsPopUpWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init InviteFriends popup window" );
			_sdc = ServerDataController.getInstance();
			_popUpManager = PopUpUIManager.getInstance();
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();
			
		}
		
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_mc = new InviteFriendPopUpMC( );
			addChild( _mc );
			
			winWidth = _mc.width;
			winHeight = _mc.height;
			
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addBtnListener( _mc.inviteBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.closeBtn );
				_bm.removeBtnListener( _mc.inviteBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				if ( this.contains( _mc )){
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;			
			
			switch ( btnName ) 
			{
				case "closeBtn":
					trace( "close btn click..........." );					
					_popUpManager.removeWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
				break;
				
				case "inviteBtn":
					trace( "INVITE FRIENDS btn click..........." );
					_sdc.addNeighbor();
					_popUpManager.removeWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW );
				break;
				
				default:
				break;
			}		
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "closeBtn":
					_mc.closeBtn.gotoAndStop( 1 );
				break;
				
				case "inviteBtn":
					_mc.inviteBtn.gotoAndStop( 1 );
				break;
				
				default:					
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "closeBtn":
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				case "inviteBtn":
					_mc.inviteBtn.gotoAndStop( 2 );
				break;
				
				default:					
				break;
			}
		}
	}

}