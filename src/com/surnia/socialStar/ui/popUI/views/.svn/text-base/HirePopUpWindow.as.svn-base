package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
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
	public class HirePopUpWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:HirePopUpWindowMC;
		private var _bm:ButtonManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _popUpManager:PopUpUIManager;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		
		public function HirePopUpWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init Hire popup window" );
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
			_mc = new HirePopUpWindowMC( );
			addChild( _mc );		
			
			_bm.addBtnListener( _mc.poorBtn );
			_bm.addBtnListener( _mc.normalBtn );
			_bm.addBtnListener( _mc.bestBtn );
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){
				_bm.removeBtnListener( _mc.poorBtn );
				_bm.removeBtnListener( _mc.normalBtn );
				_bm.removeBtnListener( _mc.bestBtn );
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
				case "poorBtn":
					trace( "poorBtn click..........." );
					_popUpUIEvent = new PopUIEvent( PopUIEvent.HIRE_POOR_CHARACTER );					
				break;
				
				case "normalBtn":
					_popUpUIEvent = new PopUIEvent( PopUIEvent.HIRE_NORMAL_CHARACTER );					
					trace( "normalBtn....click" );
				break;
				
				case "bestBtn":
					_popUpUIEvent = new PopUIEvent( PopUIEvent.HIRE_BEST_CHARACTER );					
					trace( "bestBtn....click" );
				break;
				
				case "closeBtn":
					//_popUpManager.removeCurrentWindow();
					//_popUpManager.removeWindow( WindowPopUpConfig.HIRE_POPUP_WINDOW );
				break;
				
				default:
					
				break;
			}
			
			if( _popUpUIEvent != null ){
				_es.dispatchESEvent( _popUpUIEvent  );
				//_popUpManager.removeWindow( WindowPopUpConfig.HIRE_POPUP_WINDOW );
			}
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{		
			_mc.gotoAndStop( 1 );	
			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
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
				case "poorBtn":					
					_mc.gotoAndStop( 2 );
				break;
				
				case "normalBtn":					
					_mc.gotoAndStop( 3 );
				break;
				
				case "bestBtn":
					_mc.gotoAndStop( 4 );
				break;
				
				case "closeBtn":
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}		
		}
	}

}