package com.surnia.socialStar.tutorial.views 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.arrowManager.ArrowController;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * 
	 */
	public class Tutorial extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _es:EventSatellite;
		private var _mc:TutMC;
		private var _tutEvent:TutorialEvent;
		private var _popUpUIManager:PopUpUIManager;
		private var _sdc:ServerDataController;		
		/*----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function Tutorial() 
		{		
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{		
			_es = EventSatellite.getInstance();
			_sdc =  ServerDataController.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		
		/*----------------------------------------------------------------------Metthods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{			
			_mc = new TutMC(  );
			addChild( _mc );
			if( GlobalData.instance.tutLabel != "null" ){
				_mc.gotoAndStop( GlobalData.instance.tutLabel );			
			}
			_mc.closeBtn.addEventListener( MouseEvent.CLICK, onCloseTut );			
			_mc.closeBtn.buttonMode = true;
		}		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}			
		}		
		
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		public function set mc(value:TutMC):void 
		{
			_mc = value;
		}
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		public function get mc():TutMC 
		{
			return _mc;
		}
		
		/*----------------------------------------------------------------------EventHandlers----------------------------------------------------------------------*/
		
		private function onCloseTut(e:MouseEvent):void 
		{			
			var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.END_TUTORIAL );
			_es.dispatchESEvent( tutEvent );
			_popUpUIManager.removeWindow( WindowPopUpConfig.TUTORIAL_WINDOW );
		}		
	}

}