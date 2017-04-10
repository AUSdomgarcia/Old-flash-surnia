package com.surnia.socialStar.views.display 
{
	import as3isolib.display.IsoView;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.ringCommand.events.RingCommandEvent;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import com.surnia.socialStar.data.GlobalData;
	
	/**
	 * ...
	 * @author Windz
	 */
	public class PanManager 
	{
		/*------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		
		// PROPERTIES
		private var _panPt:Point;
		private var _stage:Stage;
		private var _view:IsoView;
		private var _gd:GlobalData;
		private var _es:EventSatellite;
		private var _popUpUIManager:PopUpUIManager;
		
		public function PanManager(_root:Stage, iView:IsoView) 
		{
			_stage = _root;
			_view = iView;
			_gd = GlobalData.instance;
			addListeners();		
			_popUpUIManager = PopUpUIManager.getInstance();
		}			
		
		
		/*------------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		private function addListeners():void
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener( IsoRoomEvent.ON_START_PAN, startPanFloor );
			_es.addEventListener( IsoRoomEvent.ON_STOP_PAN, stopPanFloor );
			_es.addEventListener( IsoRoomEvent.ON_CLICK_FLOOR, onClickFloor );
			
			_gd.GameStage.addEventListener( MouseEvent.MOUSE_DOWN, onStartPan );
			_gd.GameStage.addEventListener( MouseEvent.MOUSE_UP, onStopPan );			
		}
		
		public function removeListeners():void 
		{
			_es.removeEventListener( IsoRoomEvent.ON_START_PAN, startPanFloor );
			_es.removeEventListener( IsoRoomEvent.ON_STOP_PAN, stopPanFloor );
			_es.removeEventListener( IsoRoomEvent.ON_CLICK_FLOOR, onClickFloor );
			
			_gd.GameStage.removeEventListener( MouseEvent.MOUSE_DOWN, onStartPan );
			_gd.GameStage.removeEventListener( MouseEvent.MOUSE_UP, onStopPan );
		}
		
		
		public function stopPan():void {
			_gd.GameStage.removeEventListener( MouseEvent.MOUSE_MOVE, onPan );
			_gd.GameStage.removeEventListener( MouseEvent.MOUSE_UP, onStopPan );
		}		
		
		
		private function pan():void 
		{			
			_panPt = new Point( _gd.GameStage.mouseX, _gd.GameStage.mouseY );
			_gd.GameStage.addEventListener( MouseEvent.MOUSE_MOVE, onPan, false, 0, true );
			_gd.GameStage.addEventListener( MouseEvent.MOUSE_UP, onStopPan, false, 0, true );
		}
		
		private function dispatchRemoveRingCommand():void 
		{
			var ringCommandEvent:RingCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
			_es.dispatchESEvent( ringCommandEvent );
		}
		
		/*------------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/		
		
		private function onStartPan( e:MouseEvent ):void
		{				
			pan();
		}
		
		private function onStopPan(e:MouseEvent):void 
		{
			stopPan();
		}		
		
		private function onPan( e:MouseEvent ):void
		{
			if (  !_gd.isDragging && !_popUpUIManager.isWindowActive && !_popUpUIManager.isSubWindowActive ){
				//_panPt = new Point( _gd.GameStage.mouseX, _gd.GameStage.mouseY );				
				_view.pan( _panPt.x - _gd.GameStage.mouseX, _panPt.y - _gd.GameStage.mouseY );				
				_panPt.x = _gd.GameStage.mouseX;
				_panPt.y = _gd.GameStage.mouseY;		
				dispatchRemoveRingCommand();			
			}
		}
		
		private function stopPanFloor(e:IsoRoomEvent):void 
		{
			stopPan();
			dispatchRemoveRingCommand();
		}
		
		private function startPanFloor(e:IsoRoomEvent):void 
		{
			pan();			
			dispatchRemoveRingCommand();
		}
		
		private function onClickFloor(e:IsoRoomEvent):void 
		{
			_popUpUIManager.removeWindow( WindowPopUpConfig.AVATAR_TOOL_WINDOW );
			dispatchRemoveRingCommand();			
		}
	}

}