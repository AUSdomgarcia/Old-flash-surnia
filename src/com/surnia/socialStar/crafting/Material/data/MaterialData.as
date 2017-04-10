package com.surnia.socialStar.crafting.Material.data 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class MaterialData extends EventDispatcher
	{
		private var _es:EventSatellite;
		private var _runningOn:String;
		
		private var _idList:Array;
		private var _nameList:Array;
		private var _picList:Array;
		private var _qtyList:Array;		
		
		private var _materialDataLength:int;
		
		public static const MATERIAL_DATA_UPDATE:String = 'material data updated';
		
		
		public function MaterialData() 
		{
			//trace('\nMaterialData, initialized');
			
			_idList = new Array();;
			_nameList = new Array();
			_picList = new Array();
			_qtyList = new Array();
			
			_es = EventSatellite.getInstance();
			_runningOn = Capabilities.playerType;
			
			if ( _runningOn != 'StandAlone' )
			{
				//_isOnline = true;
				_es.addEventListener( SSEvent.MATERIALLISTXML_LOADED, _onMaterialXmlLoaded );
				loadOnlineXML();
			}
			else 
			{
				//_isOnline = false;
				_es.addEventListener( SSEvent.MATERIALLISTXML_LOADED, _onMaterialXmlLoaded );
				loadOfflineXML();
			}
		}
		
		private function loadOnlineXML():void
		{
			//trace('MaterialData::loadOnlineXML');
			ServerDataExtractor.instance.updateData( GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.onlineMaterialListData );
		}
		
		private function loadOfflineXML():void
		{
			//trace('MaterialData::loadOfflineXML');
			ServerDataExtractor.instance.updateData( GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.offlineMaterialListData );
		}
		
		private function _onMaterialXmlLoaded( e:SSEvent ):void 
		{
			trace('\nMaterialData::_onMaterialXmlLoaded');
			_es.removeEventListener( SSEvent.COLLECTIONLISTXML_LOADED, _onMaterialXmlLoaded );
			
			_materialDataLength = GlobalData.instance.materialListDataArray.length;
			for (var i:int = 0; i < _materialDataLength; i++ )
			{
				_idList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_ID]);
				_nameList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_NAME]);
				_picList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_PIC]);
				_qtyList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_QTY]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_ID]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_ID]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_NAME]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_NAME]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_PIC]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_PIC]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_QTY]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_QTY]);
			}
			
			//var _e:CraftingEvent = new CraftingEvent( CraftingEvent.UPDATE_MATERIAL_DATA );
			//_es.dispatchESEvent( _e );
			
			var _e:Event = new Event( MaterialData.MATERIAL_DATA_UPDATE );
			_es.dispatchESEvent( _e );
		}
		
		public function get length():int
		{
			return _materialDataLength;
		}
		
		public function get idList():Array
		{
			return _idList;
		}
		
		public function get nameList():Array
		{
			return _nameList;
		}
		
		public function get picList():Array
		{
			return _picList;
		}
		
		public function get qtyList():Array
		{
			return _qtyList;
		}
		
		
		
		
	}

}