package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.*;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MessageWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:MessageWindowMC;
		private var _bm:ButtonManager;
		private var _popUpUIManager:PopUpUIManager;
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		private var _msg:String;
		//playerstatusEvent
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function MessageWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();		
			_gd = GlobalData.instance;
			_sdc = ServerDataController.getInstance();
			_es = EventSatellite.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			setDisplay();			
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}		
		
		
		private function setDisplay():void 
		{
			_mc = new MessageWindowMC();
			addChild( _mc );			
			
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.acceptBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
			
			_es.addEventListener( PopUIEvent.ON_UPDATE_MESSAGE_WINDOW, onUpdate );
		}		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_es.removeEventListener( PopUIEvent.ON_UPDATE_MESSAGE_WINDOW, onUpdate );
				_bm.removeBtnListener( _mc.acceptBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				
				if ( this.contains( _mc ) ) {
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
				case "acceptBtn":					
					if ( _msg == GameDialogueConfig.SERVER_SYNC_ERROR ) {
						_sdc.refreshGame();
					}
					trace( "cancel btn click..........." );
					_popUpUIManager.removeWindow( WindowPopUpConfig.MESSAGE_WINDOW );					
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
				case "acceptBtn":					
					_mc.acceptBtn.gotoAndStop( 1 );
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
				case "acceptBtn":					
					_mc.acceptBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onUpdate(e:PopUIEvent):void 
		{
			_msg = e.obj.msg as String;			
			_mc.txtmessage.defaultTextFormat = new TextFormat("Tahoma", 18, 0);
			_mc.txtmessage.embedFonts = true;
			_mc.txtmessage.antiAliasType = AntiAliasType.ADVANCED;
			_mc.txtmessage.text = _msg;
		}
	}

}