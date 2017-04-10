package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
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
	public class ThanksForVisitingWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:ThankForVisitingMC;
		private var _bm:ButtonManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _popUpManager:PopUpUIManager;
		private var _gd:GlobalData = GlobalData.instance;
		
		private var _sdc:ServerDataController;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function ThanksForVisitingWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init Thanks for visiting window" );
			_es = EventSatellite.getInstance();
			_es.addEventListener( ServerDataControllerEvent.ON_GET_VISITING_REWARD_COMPLETE, onUpdateWindow );
			_sdc = ServerDataController.getInstance();
			_sdc.getVisitingReward( _gd.myFbId );
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
			_mc = new ThankForVisitingMC( );
			addChild( _mc );
			
			winWidth = _mc.width;
			winHeight = _mc.height;			
			
			_bm.addBtnListener( _mc.postBtn );			
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){				
				_bm.removeBtnListener( _mc.postBtn );
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
		
		private function update( coin:int, ap:int ):void 
		{
			trace( "[ThanksForVisitingWindow]: coin", coin, "ap: ", ap );
			_mc.txtAP.text = "" + ap;
			_mc.txtCoin.text = "" + coin;
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
				case "postBtn":					
					_sdc.postVisitingReward( _gd.selectedFriendFbId );
					trace( "post btn click........." );					
				break;
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
					_popUpManager.removeWindow( WindowPopUpConfig.THANKS_FOR_VISITING_WINDOW );
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
				case "postBtn":
					_mc.postBtn.gotoAndStop( 1 );
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
				case "postBtn":
					_mc.postBtn.gotoAndStop( 2 );
				break;
				
				case "closeBtn":					
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onUpdateWindow(e:ServerDataControllerEvent):void 
		{
			trace( "[ThanksForVisitingWindow]: coin", e.obj.coin, "ap: ", e.obj.ap );
			update( e.obj.coin, e.obj.ap );
		}
	}

}