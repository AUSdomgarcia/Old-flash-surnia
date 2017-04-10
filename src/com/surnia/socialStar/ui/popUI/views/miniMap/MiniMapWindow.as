package com.surnia.socialStar.ui.popUI.views.miniMap 
{	
	import com.fluidLayout.FluidObject;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.events.WorldMapEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MiniMapWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
	
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		//private var _worldMap:MinimapMain;
		private var _worldMap:WorldMapMain;
		private var _popUiManager:PopUpUIManager;
		private var _es:EventSatellite;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function MiniMapWindow( windowName:String, windowSkin:MovieClip = null ) 
		{
			super( windowName, windowSkin );		
			
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		
		override public function initWindow():void 
		{
			super.initWindow();
			
		
			_es = EventSatellite.getInstance();
			_popUiManager = PopUpUIManager.getInstance();
			
			init();
			
			//trace( "init GetActionPoint popup window" );
				//if (stage) {
				//init();
			//} else {
				//addEventListener(Event.ADDED_TO_STAGE, init);
			//}
		}
		
		public function init (  ):void {
			//_worldMap = new MinimapMain();
			
		
			if (_worldMap != null) {
				_worldMap.nullAllInstances();
				if (this.contains(_worldMap)) {
					removeChild(_worldMap);
				}
				_worldMap = null;
			}		
			
			_worldMap = new WorldMapMain();				
			addChild(_worldMap);	
			_worldMap.init();						
			
			//_worldMap.addEventListener(MapEvent.GAME_CLOSE, onGameClose);
			_worldMap.addEventListener(WorldMapEvent.GAME_CLOSE, onGameClose);
		
			
			//-----------------------------------------------------------------------------test
			
			var mapParam:* = {
				x:0,
				y:0,
				offsetX:.5,
				offsetY:.5
			}
			new FluidObject(_worldMap, mapParam );
			
			//-----------------------------------------------------------------------------test			
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			
			if (_worldMap != null) {
				if(this.contains(_worldMap)){
					this.removeChild(_worldMap);	
					_worldMap = null;
				}
			}
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												MAP EVENT CLOSE GAME		
		 * ----------------------------------------------------------------------------------------------------------*/		
		
		public function onGameClose(e:WorldMapEvent):void {
			var _popUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.GO_BACK_HOME );
			_es.dispatchESEvent( _popUIEvent );
			
			_popUiManager.removeCurrentWindow();
			_popUiManager.removeCurrentSubWindow();
			//trace(this, "GAME CLOSE", this);
			//if (_worldMap != null) {
				//if(this.contains(_worldMap)){
					//removeChild(_worldMap);	
					//_worldMap = null;
				//}
			//}
		}	
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}