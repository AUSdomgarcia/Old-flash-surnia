package com.surnia.socialStar.crafting.data 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	// url for the online source of URL is @
	// http://202.124.129.14/socialstars/offices/collectionlist
	 
	public class CraftingData extends EventDispatcher
	{
		private var es:EventSatellite;
		private var _isScrolling:Boolean;
		private var _BOUNDS_WIDTH:int;
		private var _BOUNDS_HEIGHT:int;
		private var _BOUNDS_X:int;
		private var _BOUNDS_Y:int;
		private var _scrollerY:int;
		private var _containerY:int;
		private var _TOTAL_ITEMS_SAMPLE:int;
		private var _currentTabSelected:String;
		
		private var _itemData:ItemData;
		private var _craftObjectsList:Object;
		private var _totalCraftObjects:int;
		
		private var _idList:Array;
		private var _descList:Array;
		private var _forceCraftList:Array;
		private var _iconList:Array;
		private var _reqLvlList:Array;
		private var _rewardCatList:Array;
		private var _rewardIdList:Array;
		private var _stackList:Array;
		private var _categoryList:Array;
		private var _materialList:Array;
		
		private var _currentLvl:int;
		
		private var _scrollerBtnStartY:int;
		
		
		
		
		
		public function CraftingData()
		{
			trace('\nCraftingData initialized');
			es = EventSatellite.getInstance();
			
			_isScrolling = false;
			_scrollerY = 0;
			_BOUNDS_WIDTH = 0;
			_BOUNDS_HEIGHT = 325;
			_BOUNDS_X = 0;
			_BOUNDS_Y = 0;
			_containerY = 0;
			_TOTAL_ITEMS_SAMPLE = 10;
			_currentTabSelected = "";
			
			_itemData = new ItemData;
			_craftObjectsList = new Object;
			
			_currentLvl = GlobalData.LEVEL;
			
			es.addEventListener( ItemData.ITEM_DATA_UPDATE, _dataUpdated );
			
			_idList = new Array();
			_descList = new Array();
			_forceCraftList = new Array();
			_iconList = new Array();
			_reqLvlList = new Array();
			_rewardCatList = new Array();
			_rewardIdList = new Array();
			_stackList = new Array();
			_categoryList = new Array();
			_materialList = new Array();
		}
		
		public function get TOTAL_ITEMS_SAMPLE():int
		{
			return _TOTAL_ITEMS_SAMPLE;
		}
		
		/*------------------------------
		|  ITEM DATA PROPERTIES
		-------------------------------*/
		public function get scrollerY ():int
		{
			return _scrollerY;
		}
		
		public function set scrollerY ( value:int ):void
		{
			_scrollerY = value;
			var _craftUIEvent:CraftingEvent = new CraftingEvent( CraftingEvent.UPDATE_SCROLLER );
			es.dispatchEvent( _craftUIEvent );
		}
		
		/*------------------------------
		|  SCROLLING STATE PROPERTIES
		-------------------------------*/
		public function get isScrolling () : Boolean
		{
			return _isScrolling;
		}
		
		public function set isScrolling ( value:Boolean ) : void
		{
			_isScrolling = value;
		}
		
		/*------------------------------
		|  BOUNDS PROPERTIES
		-------------------------------*/
		public function get BOUNDS_X () : int
		{
			return _BOUNDS_X;
		}
		
		public function set BOUNDS_X ( value:int ) : void
		{
			_BOUNDS_X = value;
		}
		
		public function get BOUNDS_Y () : int
		{
			return _BOUNDS_Y;
		}
		
		public function set BOUNDS_Y ( value:int ) : void
		{
			_BOUNDS_Y = value;
		}
		
		public function get BOUNDS_WIDTH ():int
		{
			return _BOUNDS_WIDTH;
		}
		
		public function get BOUNDS_HEIGHT ():int
		{
			return _BOUNDS_HEIGHT;
		}
		
		/*-----------------------------
		|  CONTAINER PROPERTIES
		/*---------------------------*/
		public function get containerY():int
		{
			return _containerY;
		}
		
		public function set containerY(value:int):void
		{
			_containerY = value;
		}
		
		/*-----------------------------
		|  TAB PROPERTIES
		/*---------------------------*/
		public function get currentSelectedTab():String
		{
			return _currentTabSelected;
		}
		
		public function set currentSelectedTab( value:String ):void
		{
			_currentTabSelected = value;
			var _craftUIEvent:CraftingEvent = new CraftingEvent( CraftingEvent.UPDATE_TABS );
			es.dispatchEvent( _craftUIEvent );
		}
		
		/*-----------------------------
		|  CRAFT OBJECT LIST PROPERTIES
		/*---------------------------*/
		public function get idList():Array
		{
			return _idList;
		}
		
		public function get descList():Array
		{
			return _descList;
		}
		
		public function get forceCraftList():Array
		{
			return _forceCraftList;
		}
		
		public function get iconList():Array
		{
			return _iconList;
		}
		
		public function get reqLvlList():Array
		{
			return _reqLvlList;
		}
		
		public function get rewardCatList():Array
		{
			return _rewardCatList;
		}
		
		public function get rewardIdList():Array
		{
			return _rewardIdList;
		}
		
		public function get stackList():Array
		{
			return _stackList;
		}
		
		public function get materialList():Array
		{
			return _materialList;
		}
		
		public function get totalCraftObject():Object 
		{
			return _totalCraftObjects;
		}
		
		public function get categoryList():Object
		{
			return _categoryList;
		}
		
		public function get currentLvl():int
		{
			return _currentLvl;
		}
		
		/*-----------------------------------------
		 *  EVENT HANDLERS
		-----------------------------------------*/
		private function _dataUpdated(e:Event):void
		{
			es.removeEventListener( ItemData.ITEM_DATA_UPDATE, _dataUpdated );
			
			trace('\nCraftingData::_dataUpdated');
			_totalCraftObjects = _itemData.totalCraftObjects;
			
			_idList = _itemData.craftId;
			_descList = _itemData.craftDesc;
			_reqLvlList = _itemData.craftreqLvl;
			_iconList = _itemData.craftIcon;
			_stackList = _itemData.craftStack;
			_forceCraftList = _itemData.craftForceCraft;
			_rewardCatList = _itemData.craftRewardCat;
			_rewardIdList = _itemData.craftRewardID;
			_categoryList = _itemData.craftCategory;
			_materialList = _itemData.craftList;
			
			trace('current user level=' + _currentLvl);
			trace('_itemData.craftId=' + _itemData.craftId);
			trace('_itemData.craftDesc=' + _itemData.craftDesc);
			trace('_itemData.craftreqLvl=' + _itemData.craftreqLvl);
			trace('_itemData.craftIcon=' + _itemData.craftIcon);
			trace('_itemData.craftStack=' + _itemData.craftStack);
			trace('_itemData.craftForceCraft=' + _itemData.craftForceCraft);
			trace('_itemData.craftRewarcCat=' + _itemData.craftRewardCat);
			trace('_itemData.craftRewardID=' + _itemData.craftRewardID);
			trace('_itemData.craftCategory=' + _itemData.craftCategory);
			trace('_itemData.totalCraftObjects=' + _itemData.totalCraftObjects);
			trace('_itemData.craftList=' + _itemData.craftList);
			trace('_totalCraftObjects=' + _itemData.totalCraftObjects);
			
			var _craftEvent:CraftingEvent = new CraftingEvent( CraftingEvent.UPDATE_DATA );
			es.dispatchESEvent( _craftEvent );
		}
		
		public function get scrollerBtnStartY():int
		{
			return _scrollerBtnStartY;
		}
		
		public function set scrollerBtnStartY( value:int ):void
		{
			_scrollerBtnStartY = value;
		}
		
		public function removeAll():void
		{
			var _craftEvent:CraftingEvent = new CraftingEvent( CraftingEvent.REMOVE_ALL );
			es.dispatchESEvent( _craftEvent );
		}
		
	}

}