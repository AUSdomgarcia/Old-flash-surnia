package com.surnia.socialStar.ui.popUI.views 
{	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class HireCharWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:mc_hire;
		private var _popUpUIManager:PopUpUIManager;
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		private var _gd:GlobalData;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function HireCharWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();			
			_sdc = ServerDataController.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			setDisplay();
			
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN );
			_es.dispatchESEvent( isoRoomEvent );			
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();
		}
		
		private function setDisplay():void 
		{
			_mc =  new mc_hire();
			_mc._maleavatar = _gd.absPath + "swf/male01.swf"
			//https://202.124.129.14/socialstars/swf/female01.swf"
			_mc._femaleavatar= _gd.absPath + "swf/female01.swf"
			_mc._purchaselink= _gd.absPath + "characters/make/";
			_mc._charnamelink= _gd.absPath + "characters/ren/";
			addChild( _mc );			
			
			_mc.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_mc.addEventListener( "ready2", onReadyToHire );			
			_mc.addEventListener("closed",onCloseHireCharWindow );
			_mc.addEventListener("hired",onHiredChar );
			_mc.addEventListener("charselected",onSelectChar );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){
				_mc.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
				_mc.removeEventListener( "ready2", onReadyToHire );			
				_mc.removeEventListener("closed",onCloseHireCharWindow );
				_mc.removeEventListener("hired",onHiredChar );
				_mc.removeEventListener("charselected",onSelectChar );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
		private function onSelectChar(e:Event):void 
		{
			trace( "character selected..................................." );
		}
		
		private function onHiredChar(e:Event):void 
		{
			var sdcEvent:ServerDataControllerEvent = new ServerDataControllerEvent( ServerDataControllerEvent.ON_HIRE_CONTESTANT_COMPLETE );
			_es.dispatchESEvent( sdcEvent );
			
			_sdc.setPlayerCoin(  -_gd.CONTESTANT_NORMAL_COIN_PRICE );
			_sdc.updateMyCharlist();
			_sdc.checkCharCount();
			_popUpUIManager.removeWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW );
			trace( "character hired!! selected..................................." );
			
		}
		
		private function onCloseHireCharWindow(e:Event):void 
		{
			//_sdc.updateMyCharlist();
			//_sdc.checkCharCount();
			_popUpUIManager.removeWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW );			
			trace( " on close window character selected..................................." );					
			//ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData );			
			//TweenLite.delayedCall( 2, updateQuestXml );
		}
		
		private function updateQuestXml():void 
		{
			ServerDataExtractor.instance.updateData(GlobalData.QUESTLIST_DATA, XMLLinkData.instance.onlineQuestListData );
			trace( "update quest xml after buying contestant ======================================================================================>>>> ^^)" );
		}
		
		private function onReadyToHire(e:Event):void 
		{
			trace( "dwadawdwadwadawdwa................");			
			var runingOn:String = Capabilities.playerType;			
			if( _mc != null ){				
				_mc.loadXML( _gd.absPath + "characters/create");				
				trace( "new ako........................................................................." );
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( " Hire char window on error!!!!!!!!!!!!!!!!!!" );
		}
	}

}