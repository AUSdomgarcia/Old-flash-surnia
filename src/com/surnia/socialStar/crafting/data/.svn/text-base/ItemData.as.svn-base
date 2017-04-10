package com.surnia.socialStar.crafting.data 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	public class ItemData extends Sprite
	{
		private var _runningOn:String;
		public var data_arr:Array = [];
		private var _es:EventSatellite;
		private var _gd:GlobalData;
		private var _isOnline:Boolean;
		private var _totalCraftObjects:int;
		
		//Crafting variables 
		public var craftId:Array = [];
		public var craftIcon:Array = [];
		public var craftDesc:Array = [];
		public var craftreqLvl:Array = [];
		public var craftStack:Array = [];
		public var craftForceCraft:Array = [];
		public var craftRewardCat:Array = [];
		public var craftRewardID:Array = [];
		public var craftCategory:Array = [];
		public var craftList:Array = [];
		
		public static const ITEM_DATA_UPDATE:String = 'item data updated';
		
		
		public function ItemData()
		{
			//trace('ItemData initialized');
			_es = EventSatellite.getInstance();
			addListener();
			_runningOn = Capabilities.playerType;
			
			if ( _runningOn != 'StandAlone' ) 
			{				
				_isOnline = true;
				onLineXML();
			} 
			else 
			{
				_isOnline = false;
				offLineXML();
			}		
		}
		
		private function offLineXML():void 
		{
			//trace( "Craft System::ItemData use offline ");
			ServerDataExtractor.instance.updateData( GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.offlineCollectionListData );
		}
		
		public function onLineXML():void
		{
			//trace( "Craft System::ItemData use online ");			
			ServerDataExtractor.instance.updateData( GlobalData.COLLECTIONLIST_DATA, XMLLinkData.instance.onlineCollectionListData );
		}
		
		public function addListener():void
		{
			_es.addEventListener( SSEvent.COLLECTIONLISTXML_LOADED, onXMLLoadedCollectionList );
		}
		
		private function onXMLLoadedCollectionList( e:SSEvent ):void 
		{
			_es.removeEventListener( SSEvent.COLLECTIONLISTXML_LOADED, onXMLLoadedCollectionList );
			//trace('ItemData::onXMLLoadedCollectionList');
			
			clearArray();
			_gd = GlobalData.instance;
			_totalCraftObjects = _gd.collectionListDataArray.length;
			insertArrayContents();
			
			/*
			if ( _isOnline ) 
			{
				clearArray();
				trace('ItemData extracting data online');
				_gd = GlobalData.instance;
				_totalCraftObjects = _gd.collectionListDataArray.length;
				insertArrayContents();
			} 
			else 
			{
				trace('ItemData extracting data offline');
				_gd = GlobalData.instance;
				_totalCraftObjects = _gd.collectionListDataArray.length;
				insertArrayContents();			
				
				  
				//	@ Sample To get properties of a Collection ID  2dimensional 
				//	@ you can use craftList.collIDLen.length reference in looping each properties
				
				// trace( craftList[0].craftItemIcon[0] );
				// trace( craftList[0].craftItemMaxQty[0] );
				// trace( craftList[0].craftItemHaveQty[0] );
				// trace( craftList[0].craftItemForceCraft[0] );
				
				var _e:Event = new Event( ItemData.ITEM_DATA_UPDATE );
				_es.dispatchESEvent( _e );
			}
			*/
			
		}
		
		public function get totalCraftObjects():int
		{
			return _totalCraftObjects;
		}
		
		private function clearArray():void 
		{	
			craftId = new Array();
			craftDesc = new Array();
			craftreqLvl= new Array();
			craftIcon = new Array();
			craftStack = new Array();
			craftForceCraft = new Array();
			craftRewardCat = new Array();
			craftRewardID = new Array();	
		}
		
		private function insertArrayContents():void
		{
			var len:int = _gd.collectionListDataArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				/* reffering to Collection ID */
				craftList[ i ] = new ItemDataList( i );
				craftId[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ID];
				//trace('ItemData->insertArrayContents, collection id[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ID]);
				
				craftDesc[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_DESCRIPTION];
				//trace('ItemData->insertArrayContents, collection list[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_DESCRIPTION]);
				
				craftreqLvl[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_LVLREQ];
				//trace('ItemData->insertArrayContents, level requirement[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_LVLREQ]);
				
				craftIcon[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ICON];
				//trace('ItemData->insertArrayContents, icon[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ICON]);
				
				craftStack[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_STACK];
				//trace('ItemData->insertArrayContents, stack[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_STACK]);
				
				craftForceCraft[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_FORCECRAFT];
				//trace('ItemData->insertArrayContents, forceCraft[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_FORCECRAFT]);
				
				craftRewardCat[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_REWARDCATEGORY];
				//trace('ItemData->insertArrayContents, reward category[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_REWARDCATEGORY]);
				
				craftRewardID[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_REWARDID];
				//trace('ItemData->insertArrayContents, reward id[' + i + ']=' + _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_REWARDID]);
				craftCategory[ i ] = _gd.collectionListDataArray[i][GlobalData.COLLECTIONLIST_CATEGORY];
				// trace( craftId[ i ] );
			}
			
			var _e:Event = new Event( ItemData.ITEM_DATA_UPDATE );
			_es.dispatchESEvent( _e );
		}
		
	}
	//end
}