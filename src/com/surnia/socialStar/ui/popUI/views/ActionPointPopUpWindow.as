package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;	
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ActionPointPopUpWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:ActionPointWindowPopUpMC;
		private var _bm:ButtonManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _popUpManager:PopUpUIManager;
		
		private var _sdc:ServerDataController;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function ActionPointPopUpWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init GetActionPoint popup window" );
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
			_mc = new ActionPointWindowPopUpMC( );
			addChild( _mc );
			
			winWidth = _mc.width;
			winHeight = _mc.height;
			trace( "office wh: ", winHeight, winWidth );
			
			_bm.addBtnListener( _mc.askFriendBtn );
			_bm.addBtnListener( _mc.getActionBtn );
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){
				_bm.removeBtnListener( _mc.askFriendBtn );
				_bm.removeBtnListener( _mc.getActionBtn );
				_bm.removeBtnListener( _mc.closeBtn );				
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
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
			_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "askFriendBtn":
					trace( "ok btn click..........." );
					
					_sdc.askFriend( true, false );					
					_popUpUIEvent = new PopUIEvent( PopUIEvent.ASK_ACTION_POINT );
					_es.dispatchESEvent( _popUpUIEvent  );
				break;
				
				case "getActionBtn":					
					trace( "cancel btn click..........." );
					_popUpUIEvent = new PopUIEvent( PopUIEvent.GET_ACTION_POINT );
					_es.dispatchESEvent( _popUpUIEvent  );
				break;
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
				break;
				
				default:
					
				break;
			}		
			
			_popUpManager.removeWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW );			
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName )
			{
				case "askFriendBtn":					
					_mc.askFriendBtn.gotoAndStop( 1 );
				break;
				
				case "getActionBtn":
					_mc.getActionBtn.gotoAndStop( 1 );
				break;
				
				case "closeBtn":					
					_mc.closeBtn.gotoAndStop( 1 );
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
				case "askFriendBtn":					
					_mc.askFriendBtn.gotoAndStop( 2 );
				break;
				
				case "getActionBtn":
					_mc.getActionBtn.gotoAndStop( 2 );
				break;
				
				case "closeBtn":					
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
	}
//mc_shop
}