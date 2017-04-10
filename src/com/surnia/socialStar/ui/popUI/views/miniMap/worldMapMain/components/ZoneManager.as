package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author df
	 */
	public class ZoneManager extends Sprite
	{
		private var _mapCtr:int;
		private var _zoneID:String;
		private var _zoneData:Array = [];
		private var _arrayZone:Array = [];
		
		private var _blurFilter:BlurFilter;
		private var _parentLayer:DisplayObjectContainer;
		
		private var _isOut:Boolean = false;	
	
		private var _w:int;
		private var _h:int;
		
		private var _callbackBuilding:Function;
		public function ZoneManager(zoneDetail:Array, callbackBuilding:Function) 
		{
			//_mapCtr		= mapCtr
			_zoneData 	= zoneDetail;		
			_callbackBuilding = callbackBuilding;
			
			initialization();
		}
		
		public function setSize(w:int, h:int):void {
			_w = w;
			_h = h;
		}
		
		private function initialization():void 
		{			
			_blurFilter = new BlurFilter;
			_blurFilter.blurX = 10; 
			_blurFilter.blurY = 10; 
			_blurFilter.quality = BitmapFilterQuality.MEDIUM; 
			
			for (var i:int = 0; i < _zoneData.length; i++ ) {
				_arrayZone[i] = new ZoneComponent(null,null, _callbackBuilding, _zoneData[i], ZoneComponent.DISPLAY_BUILDING);
			}
		}
		
		public function showZone(zoneID:String, parentLayer:DisplayObjectContainer):void {		
			_isOut = false;
			
			_parentLayer = parentLayer;					
			removeAllZone();
			_parentLayer.filters = [_blurFilter];
			for (var i:int = 0; i < _arrayZone.length; i++ ) {				
				if (zoneID == _arrayZone[i].id) {					
					trace(this, "RETURN SHOW ZONE:");
					addChild(_arrayZone[i]);
					_arrayZone[i].x = (_w / 2) - (_arrayZone[i].width / 2);
					_arrayZone[i].y = (_h / 2) - (_arrayZone[i].height / 2);
				}
			}			
		}		
		
		public function removeAllZone():void {
			trace(this, "RETURN REMOVE ZONE!");
			if(_parentLayer != null){
				_parentLayer.filters = [];
			}
			
			for (var i:int = 0; i < _arrayZone.length; i++ ) {
				if (_arrayZone[i] !=null) {
					if (this.contains(_arrayZone[i])) {
						removeChild(_arrayZone[i]);
					}
				}
			}
		}	
		
		public function nullAllInstances():void {
			removeAllZone();
			for (var i:int = 0; i < _arrayZone.length; i++ ) {
				if (_arrayZone[i] != null) {
					_arrayZone[i].nullAllInstances();
					_arrayZone[i] = null;
				}
			}
			
			if (_blurFilter != null) {
				_blurFilter = null;
			}
			trace("CLEAN", this);
		}
	}
}