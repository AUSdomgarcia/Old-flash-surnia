package com.surnia.socialStar.ui.popUI.views 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author JC
	 */
	public class FriendPopUp extends AbstractWindow
	{
		/*----------------------------------------------------------------------constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _mc:FriendPopUpMC;
		private var _bm:ButtonManager;
		private var _xmlExtractor:XMLExtractor;
		private var _xml:XML;
		private var _jsManager:JsManager;
		
		private var _popUpUiManager:PopUpUIManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _dialogue:DialogueEvent;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		/*----------------------------------------------------------------------construct----------------------------------------------------------------------*/
		
		public function FriendPopUp( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );			
		}
		
		override public function initWindow():void 
		{
			super.initWindow();						
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_gd = GlobalData.instance;
			_sdc = ServerDataController.getInstance();
			_es = EventSatellite.getInstance();
			_popUpUiManager = PopUpUIManager.getInstance();
			_mc = new FriendPopUpMC();
			addChild( _mc );			
			
			_mc.addEventListener( MouseEvent.ROLL_OUT, onRollOutFriendPopUp );
			_mc.addEventListener( MouseEvent.ROLL_OVER, onRollOverFriendPopUp );
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.challengeBtn );
			_bm.addBtnListener( _mc.sendGiftBtn );
			_bm.addBtnListener( _mc.visitBtn );			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
		}				
		
		private function removeDisplay():void 
		{
			if (  _mc != null ) {
				_bm.removeBtnListener( _mc.challengeBtn );
				_bm.removeBtnListener( _mc.sendGiftBtn );
				_bm.removeBtnListener( _mc.visitBtn );		
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function callChallengeNewsFeed( fbId:String ):void 
		{
			_xmlExtractor = new XMLExtractor(  );
			//_xmlExtractor = XMLExtractor.getInstance(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed );
			_xmlExtractor.extractXmlData( _gd.absPath + "game/newsfeed/versus/" + fbId );
			trace( "call challenge new feed!!!!!" );
		}
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void
		{			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "challengeBtn":
					trace( "challengeBtn...........!!!!!!!!!!!!!!!!!!!!!!!" );
					//_popUpUiManager.loadWindow( WindowPopUpConfig.CONTESTANT_SELECION_WINDOW );
					_gd.isChallenge = true;
					visitFriendOffice();
				break;
				
				case "sendGiftBtn":
					trace( "SendGiftBtn..........." );
				break;
				
				case "visitBtn":
					_gd.isChallenge = false;
					visitFriendOffice();
				break;
				
				default:				
				break;
			}
		}
		
		private function visitFriendOffice():void 
		{
			_gd.friendOfficeStateDataArray = [new Array()];
			_gd.friendCharListDataArray = [new Array()];
			
			if ( !_gd.isNpcTabSelected ){						
				//_gd.isChallenge = false;
				_popUpUiManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );
				_dialogue = new DialogueEvent( DialogueEvent.FRIEND_VISIT_DIALOGUE );
				_es.dispatchEvent( _dialogue );
				
				_sdc.updateFriendVisitViewData(GlobalData.instance.selectedFriendFbId );
				_sdc.updateFriendCharlist(GlobalData.instance.selectedFriendFbId);		
			}else {
				_popUpUiManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0,0 );
				_dialogue = new DialogueEvent( DialogueEvent.NPC_VISIT_DIALOGUE );
				_es.dispatchEvent( _dialogue );
				
				_gd.friendView = false;						
				_gd.selectedFriendFbId = null;
				_gd.officeId = null;
				
				//_gd.isChallenge = false;
				_sdc.updateNpcCharlist();
				_sdc.updateNPCVisitViewData();							
			}
		}
		
		private function onButtonRollOut(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			if ( btnName == "sendGiftBtn" ) {				
				_mc.icon.gotoAndStop( 1 );
			}else {
				e.obj.btn.gotoAndStop( 1 );
			}
		}
		
		private function onButtonRollOver(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			
			if ( btnName == "sendGiftBtn" ) {				
				_mc.icon.gotoAndStop( 2 );
			}else {
				e.obj.btn.gotoAndStop( 2 );
			}
		}
		
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "failed xml........................." );
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{
			_xml = _xmlExtractor.xml;
			//trace( "xml extraction successfull....", _xml );
			
			var runingOn:String = Capabilities.playerType;
			
			if( runingOn != 'StandAlone' ){
				_jsManager = JsManager.getInstance();
				_jsManager.callJs( "newsfeed", _xml.@nf );
			}else {
				trace( "this game is running on local computer no challenge popup newsfeed will call!!, upload and run your game inside facebook to see the actual action" );
			}
		}
		
		private function onRollOutFriendPopUp(e:MouseEvent):void 
		{			
			_popUpUiManager.removeWindow( WindowPopUpConfig.FRIEND_POPUP_WINDOW );
		}
		
		private function onRollOverFriendPopUp(e:MouseEvent):void 
		{
			//_popUpUiManager.loadWindow(  WindowPopUpConfig.FRIEND_POPUP_WINDOW , 0,0,false, this.x + 50 , this.y + 445 );
		}
	}

}