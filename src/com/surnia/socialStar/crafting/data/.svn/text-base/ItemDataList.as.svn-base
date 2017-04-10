package com.surnia.socialStar.crafting.data 
{
	import com.surnia.socialStar.data.GlobalData;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class ItemDataList extends EventDispatcher
	{
		public var collIDLen:Array = [];
		
		public var _gd:GlobalData = GlobalData.instance;
		
		public var craftItemID:Array = [];
		public var craftItemIcon:Array = [];
		public var craftItemMaxQty:Array = [];
		public var craftItemHaveQty:Array = [];
		public var craftItemForceCraft:Array = [];
		public var craftItemStar:Array = [];
		
		
		public function ItemDataList( indexNum:Number ) 
		{
			trace('\nItemDataList initialized');
			//trace('indexNum=' + indexNum);
			
			collIDLen = _gd.getCollectionItemsByCollID( _gd.collectionListDataArray[ indexNum ][GlobalData.COLLECTIONLIST_ID] );
			//trace('collIDLen=' + collIDLen);
			
			for (var j:int = 0; j < collIDLen.length; j++) 
			{
				craftItemID[ j ] =  collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMID];
				craftItemIcon[ j ] =  collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMICON];
				craftItemHaveQty[ j ] = collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMCURRQUANTITY];
				craftItemMaxQty[ j ] = collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMMAXQUANTITY];
				craftItemForceCraft[ j ] = collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMFORCECRAFT];
				
				trace('\nItemDataList->ItemDataList, craftItemID=' + collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMID]);
				trace('ItemDataList->ItemDataList, craftItemIcon=' + collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMICON]);
				trace('ItemDataList->ItemDataList, craftItemHaveQty=' + collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMCURRQUANTITY]);
				trace('ItemDataList->ItemDataList, craftItemMaxQty=' + collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMMAXQUANTITY]);
				trace('ItemDataList->ItemDataList, craftItemForceCraft=' + collIDLen[ j ][GlobalData.COLLECTIONLIST_ITEMFORCECRAFT]);
			}
		}
		
	}

}