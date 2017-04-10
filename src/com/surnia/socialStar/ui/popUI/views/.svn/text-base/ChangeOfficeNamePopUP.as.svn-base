package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
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
	public class ChangeOfficeNamePopUP extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:ChangeOfficeNamePopUpMC;
		private var _bm:ButtonManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _popUpManager:PopUpUIManager;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		
		public function ChangeOfficeNamePopUP( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init Change office name popup window" );
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
			_mc = new ChangeOfficeNamePopUpMC( );
			addChild( _mc );
			
			if ( GlobalData.instance.officeName != null ) {
				_mc.txtOfficeName.text = GlobalData.instance.officeName;
			}else{
				_mc.txtOfficeName.text = "yourOfficeNameHere";
			}
			
			stage.focus = _mc.txtOfficeName;
			
			winWidth = _mc.width;
			winHeight = _mc.height;
			trace( "office wh: ", winHeight, winWidth );
			
			_bm.addBtnListener( _mc.okBtn );
			_bm.addBtnListener( _mc.cancelBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){
				_bm.removeBtnListener( _mc.cancelBtn );
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
				case "okBtn":
					trace( "ok btn click..........." );
					if( _mc.txtOfficeName.text != "" ){
						_popUpUIEvent = new PopUIEvent( PopUIEvent.CHANGE_OFFICE_NAME );						
						_es.dispatchESEvent( _popUpUIEvent , _mc.txtOfficeName.text  );
					}
				break;
				
				case "cancelBtn":					
					trace( "cancel btn click..........." );
				break;
				
				default:
					
				break;
			}
			
			//_popUpManager.removeCurrentWindow();
			_popUpManager.removeWindow( WindowPopUpConfig.CHANGE_OFFICE_NAME_POP_UP );
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "okBtn":					
					_mc.okBtn.gotoAndStop( 1 );
				break;
				
				case "cancelBtn":					
					_mc.cancelBtn.gotoAndStop( 1 );
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
				case "okBtn":					
					_mc.okBtn.gotoAndStop( 2 );
				break;
				
				case "cancelBtn":					
					_mc.cancelBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
	}

}