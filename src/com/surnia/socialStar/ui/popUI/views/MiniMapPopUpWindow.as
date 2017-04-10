package com.surnia.socialStar.ui.popUI.views 
{
	import com.surnia.socialStar.test.CharacterPanelTest;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.MiniMapPopUpDialogEvent;
	import com.surnia.socialStar.ui.popUI.events.XMLEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.MinimapMain;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MiniMapPopUpWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/
		private var _minimapMain:MinimapMain;
		private var _charPanel:CharacterPanelTest;
		
		//array character data		
		public var id:String;
		public var level:int;
		public var exp:int;
		
		public var gender:int;
		
		private var _windowName:String;
		
		private var _popUpManager:PopUpUIManager;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		
		public function MiniMapPopUpWindow( windowName:String, windowSkin:MovieClip = null ) 
		{
			super( windowName,windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init mini pop up window" );
			addMiniMap();
			_popUpManager = PopUpUIManager.getInstance();
		}
		
		override public function clearWindow():void 
		{			
			super.clearWindow();
			trace( "clear miniPopUP window.........." );
			
			
			
			
			
			//new
			if ( _minimapMain != null ) {
				this.removeEventListener(XMLEvent.LOAD_XML_VALUES, _minimapMain.faceInfo);			
				this.removeEventListener( MiniMapPopUpDialogEvent.CLICKED_CLOSE_MAP, onMapClose);
				this.removeEventListener(MapEvent.WORK_FINISHED, onWorkFinished);
				if ( this.contains( _minimapMain ) ) {
					this.removeChild( _minimapMain );
					_minimapMain = null;
				}
			}
			
			if ( _charPanel != null ) {
				if ( this.contains( _charPanel ) ) {
					this.removeChild( _charPanel );
					_charPanel = null;
				}
			}
		}
		
		
		
		private function addMiniMap():void 
		{
			_minimapMain = new MinimapMain(stage, this);			
			this.addChild(_minimapMain);	
			
			_charPanel = new CharacterPanelTest(stage, this);
			addChild(_charPanel);
			
			
			//<<<<<<<<<<<<<--------------Listeners from custtom Events-------------------->>>>>>>>>>>>>>>>>>>
			//this where miniMapMain class and CharacterPanel communicate
			this.addEventListener(XMLEvent.LOAD_XML_VALUES, _minimapMain.faceInfo);
			
			// event when Closing the MiniMap (Can be set to listen from outer class)
			this.addEventListener( MiniMapPopUpDialogEvent.CLICKED_CLOSE_MAP, onMapClose);
			
			// event that returns a new value for character ID, LEVEL, and EXPERIENCE (Can set to listen from outer class)
			this.addEventListener(MapEvent.WORK_FINISHED, onWorkFinished);
			
			//<<<<<<<<<<<<<--------------Listeners from custtom Events-------------------->>>>>>>>>>>>>>>>>>>		
		}
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/
		private function addListener():void {
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onWorkFinished(e:MapEvent):void {			
			id 		= e.params[0];
			level 	= e.params[1];
			exp 	= e.params[2];		
			
			FlashConnect.atrace(this + "character id/lvl/exp is :" + id + " " + level + " " + exp);
		}
		
		private function onEnter(e:Event):void {
			_minimapMain.onUpdate();
		}
		
	
		public function onMapClose( e:MiniMapPopUpDialogEvent ):void {
			//FlashConnect.atrace( e.obj.str );
			
			_popUpManager.removeWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW );
			
			/*
			if (_minimapMain.parent != null) {
				if (_minimapMain !=null) {
					this.removeChild(_minimapMain);
				}
			}
			if (_charPanel.parent != null) {
				if (_charPanel != null) {
					this.removeChild(_charPanel);
				}
			}
			*/
		}
	}

}