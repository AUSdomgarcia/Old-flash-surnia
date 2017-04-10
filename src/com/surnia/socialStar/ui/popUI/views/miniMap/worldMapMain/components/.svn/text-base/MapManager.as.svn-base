package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.WorldMapMain;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author df
	 */
	public class MapManager extends Sprite
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES/CONSTANTS
		 * ----------------------------------------------------------------------------------------------------------*/
		private var _mapData:Array;
		private var _blurFilter:BlurFilter;
		
		private var _arrayMap:Array = [];
		
		private var _callbackBuilding:Function;
		private var _callbackZone:Function;
		private var _callbackClose:Function;
		
		private var _w:int;
		private var _h:int;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTORS
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MapManager( mapDetail:Array, callbackClose:Function, callbackZone:Function, callbackBuilding:Function) 
		{			
			_mapData			= mapDetail;
			
			_callbackClose		= callbackClose;
			_callbackBuilding	= callbackBuilding;
			_callbackZone		= callbackZone;
			
			initialization();		
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/		
		 public function setSize(w:int, h:int):void {
			_w = w;
			_h = h;
			
			for (var i:int = 0; i < _mapData.length; i++ ) {
				_arrayMap[i] = new MapComponent(_callbackClose, _callbackZone, _callbackBuilding, _mapData[i]);
				//set map size
				_arrayMap[i].setSize(_w, _h);
			}			
		}		
		private function initialization():void 
		{
			_blurFilter = new BlurFilter;
			_blurFilter.blurX = 10; 
			_blurFilter.blurY = 10; 
			_blurFilter.quality = BitmapFilterQuality.MEDIUM; 			
			
			
		}
		
		public function showMap(mapID:String):void {			
			removeAllMap();		
			for (var i:int = 0; i < _arrayMap.length; i++ ) {
				trace(this, "SEARCH MAP ID :", mapID, _arrayMap[i].mapID );
				if (mapID == _arrayMap[i].mapID) {
					trace(this, "SHOW MAP ID :", mapID);
					addChild(_arrayMap[i]);
					_arrayMap[i].x = (this.width / 2) - (_arrayMap[i].width / 2);
					_arrayMap[i].y = (this.height / 2) - (_arrayMap[i].height / 2);
				}
			}			
		}
		
		public function removeAllMap():void {				
			for (var i:int = 0; i < _arrayMap.length; i++ ) {
				if (_arrayMap[i] !=null) {
					if (this.contains(_arrayMap[i])) {
						removeChild(_arrayMap[i]);
					}
				}
			}
		}
		
		public function nullAllInstances():void {
			removeAllMap();
			for (var i:int = 0; i < _arrayMap.length; i++ ) {
				if (_arrayMap[i] != null) {
					_arrayMap[i].nullAllInstances();
					_arrayMap[i] = null;
				}
			}
			
			if (_blurFilter != null) {
				_blurFilter = null
			}
			trace("CLEAN", this);
		}
		
	}

}