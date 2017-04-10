package com.surnia.socialStar.views.display 
{
	import as3isolib.display.IsoView;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import caurina.transitions.Tweener;
	import com.surnia.socialStar.ui.settingUI.events.SettingUIEvent;
	
	/**
	 * ...
	 * @author Windz
	 */
	public class ZoomManager 
	{
		//-----------------------------------
		// PROPERTIES
		private var _view:IsoView;
		private var _gd:GlobalData;
		private var _zoom:Number;
		private var _es:EventSatellite;
		
		
		//-----------------------------------
		// CONSTRUCTOR
		public function ZoomManager(iView:IsoView) 
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			_view = iView;
			_zoom = 1;
			addListeners();
		}
		
		
		public function addListeners():void
		{
			_es.addEventListener(SettingUIEvent.ZOOM_IN_CLICK, _onSettingsZoomOutBtnPress);
			_es.addEventListener(SettingUIEvent.ZOOM_OUT_CLICK, _onSettingsZoomInBtnPress);	
		}
		
		public function removeListeners():void 
		{
			_es.removeEventListener(SettingUIEvent.ZOOM_IN_CLICK, _onSettingsZoomOutBtnPress);
			_es.removeEventListener(SettingUIEvent.ZOOM_OUT_CLICK, _onSettingsZoomInBtnPress);
		}
		
		
		public function _onSettingsZoomInBtnPress(e:SettingUIEvent):void
		{
			if (_view.currentZoom >= _gd.MAX_ZOOM_IN) {
				
			} else {
				_zoom += 0.1;
			}
			
			Tweener.addTween( _view, { currentZoom:_zoom, time:0.5 } );
		}
		
		
		public function _onSettingsZoomOutBtnPress(e:SettingUIEvent):void
		{
			if (_view.currentZoom <= _gd.MAX_ZOOM_OUT) {
				
			}else{
				_zoom -= 0.1;
			}
			
			Tweener.addTween( _view, { currentZoom:_zoom, time:0.5 } );
		}
		
		
		
	}

}