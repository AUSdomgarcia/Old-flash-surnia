package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class collectionTest extends Sprite
	{
		
		private var _popUpUIManager:PopUpUIManager;
		private var _gd:GlobalData;
		private var _es:EventSatellite;
		private var _totalMaterialsLength:int;
		
		
		
		
		
		public function collectionTest()
		{
			initCraftingWindow();
			//initMaterialWindow();
		}
		
		private function initCraftingWindow():void
		{
			_popUpUIManager = PopUpUIManager.getInstance();
			addChild( _popUpUIManager );
			_popUpUIManager.loadWindow( WindowPopUpConfig.COLLECTION_WINDOW );
		}
		
		private function initMaterialWindow():void
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			
			_es.addEventListener(SSEvent.MATERIALLISTXML_LOADED, _onMaterialsXmlLoaded);
			
			ServerDataExtractor.instance.updateData( GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.offlineMaterialListData );
		}
		
		private function _onMaterialsXmlLoaded(e:SSEvent):void
		{
			_totalMaterialsLength = _gd.materialListDataArray.length;
			trace('total materials length=' + _totalMaterialsLength);
			trace('material id=' + _gd.materialListDataArray[0][GlobalData.MATERIALLIST_ID]);
			trace('material name=' + _gd.materialListDataArray[0][GlobalData.MATERIALLIST_NAME]);
			trace('material pic=' + _gd.materialListDataArray[0][GlobalData.MATERIALLIST_PIC]);
			trace('material qty=' + _gd.materialListDataArray[0][GlobalData.MATERIALLIST_QTY]);
		}
		
	}

}