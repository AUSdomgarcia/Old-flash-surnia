package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author JC
	 */
	public class OfficeInventoryPopUp extends AbstractWindow
	{
		/*---------------------------------------------------------------------------Constant-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Properties-----------------------------------------------------------*/
		private var _shopBg:ShopBGMC;
		private var _bm:ButtonManager;
		private var _popUpManager:PopUpUIManager;		
		
		//used when not online
		private var _xmlExtractor:XMLExtractor;
		private var _xml:XML;
		private var _items:Array;
		private var _start:int;		
		
		private var _tabHolder:Sprite;
		private var _tabs:Array;
		
		private var _itemBoxHolder:Sprite;
		private var _itemBoxs:Array;		
		
		private var _tile_tile:Array;
		private var _tile_wall:Array;
		
		private var _currentTab:String = "structure";	
		private var _es:EventSatellite;
		
		private var _isItemLoaded:Boolean;
		private var _currentItems:Array;
		
		private var _sellPopUp:SellPopUp;
		
		private var _imageExtractor:ImageExtractor;		
		private var _sdc:ServerDataController;
		
		//new
		private var _office:Array;
		private var _contestant:Array;
		private var _power:Array;
		private var _dress:Array;		
		//new
		
		private var _gd:GlobalData;
		/*---------------------------------------------------------------------------Constructor----------------------------------------------------------*/
		
		
		public function OfficeInventoryPopUp( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		override public function initWindow():void 
		{
			super.initWindow();
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			_popUpManager = PopUpUIManager.getInstance();
			_sdc = ServerDataController.getInstance();
			
			_es.addEventListener( ServerDataControllerEvent.INVENTORY_DATA_LOAD_COMPLETE, onInventoryDataLoaded );
			_es.addEventListener( ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE, onLoadImages );
			
			setDisplay();			
			addtab();
			addItemBox();
			
			var runingOn:String = Capabilities.playerType;
			
			if ( runingOn != 'StandAlone' ) {								
				if ( _gd.inventoryItemDataLoaded ) {
					trace( "data has been loaded already load directly.............................." );					
					extractItemdata();
				}else {
					//check 1st if data is has been change till last load
					_sdc.getInventoryList();					
				}
			}else {
				trace( "running on offline no data will be loaded............." );
			}			
			trace(  "init inventory ....................." );
			
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN );
			_es.dispatchESEvent( isoRoomEvent );
		}					
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();			
		}
		
		/*---------------------------------------------------------------------------Methods-----------------------------------------------------------*/
		private function setDisplay():void 
		{			
			_bm = new ButtonManager();
			_shopBg = new ShopBGMC();
			addChild( _shopBg );			
			
			//_shopBg.buildShopBg.visible = false;
			//_shopBg.txtShopName.visible = true;
			//_shopBg.txtShopName.text = "Inventory";
			
			_bm.addBtnListener( _shopBg.closeBtn );		
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			enableRightBtn( false );
			enableLeftBtn( false );
		}		
		
		
		private function addItemBox():void 
		{
			_itemBoxHolder = new Sprite();
			addChild( _itemBoxHolder );
			
			_itemBoxs = new Array();
			
			var row:int = 2;
			var col:int = 4;
			var yPad:Number = 5;
			var xPad:Number = 7;
			
			var itemBox:InventoryItemBox;			
			
			var index:int;
			//_start = 5; + 9
			
			for (var i:int = 0; i < row; i++) 
			{
				_itemBoxs[ i ] = new Array();
				for (var j:int = 0; j < col; j++) 
				{
					itemBox = new InventoryItemBox( null  );
					_itemBoxHolder.addChild( itemBox );
					itemBox.addEventListener( ItemShopEvent.SELL_OFFICE_ITEM, onSellItem );
					itemBox.addEventListener( ItemShopEvent.SHOW_SELL_POPUP, onShowSellPopUp );					
					
					itemBox.x = ( ( WindowPopUpConfig.OFFICE_ITEM_BOX_WIDTH + xPad ) * j );// + 42;
					itemBox.y = ( ( WindowPopUpConfig.OFFICE_ITEM_BOX_HEIGHT + yPad ) * i );// + 44;
					_itemBoxs[ i ][ j ] = itemBox;
					//trace( "item box added!!!................" );
					index++;
				}				
			}
			
			_itemBoxHolder.x = 52;
			_itemBoxHolder.y = 175;
		}					
		
		private function addtab():void 
		{			
			_tabHolder = new Sprite();
			addChild( _tabHolder );
			var spacing:Number = 37;
			
			_tabs = new Array();
			//var tabNames:Array = [ "staff", "training", "machine","deco", "tile","expansion", "power" ];
			var tabNames:Array = [ "structure", "contestant", "dress","power"];
			var len:int = tabNames.length;
			for (var i:int = 0; i < len; i++) 
			{				
				var tab:ShopTab = new ShopTab( i + 1 , tabNames[ i ] );				
				_tabHolder.addChild( tab );				
				tab.addEventListener( ItemShopEvent.CHANGE_TAB, onChangeTab );
				tab.x = ( WindowPopUpConfig.TAB_WIDTH  + spacing ) * i;				
				_tabs.push( tab );
			}			
			
			_tabHolder.x = 80;
			_tabHolder.y = 100;
		}		
		
		private function removeDisplay():void 
		{
			if ( _shopBg != null ) {
				if (  this.contains( _shopBg ) ) {
					this.removeChild( _shopBg );
					_shopBg = null;
				}
			}
		}	
		
		private function updateItemBoxImages():void 
		{
			trace( "on show images.....................!!!!!!!!!!!" );
			var row:int = 2;
			var col:int = 4;
			
			var index:int;
			
			for (var i:int = 0; i < row; i++) 
			{				
				for (var j:int = 0; j < col; j++) 
				{
					if( _itemBoxs[ i ][ j ] != null ){
						_itemBoxs[ i ][ j ].loadImage(  );
						index++;
					}
				}
			}			
		}
		
		private function updateItem(  ):void 
		{	
			if ( _gd.inventoryItemDataLoaded ) {
				//_start = 0;
				var row:int = 2;
				var col:int = 4;			
				
				if ( _currentTab == "structure" && _office != null ) {
					_currentItems = _office;
				}else if ( _currentTab == "dress" && _dress != null ) {
					_currentItems = _dress;
				}else if ( _currentTab == "power" && _power != null ) {
					_currentItems = _power;
				}else if ( _currentTab == "contestant" && _contestant != null ) {
					_currentItems = _contestant;
				}				
				
				if( _currentItems != null ){
				
					if(  _start + 8 < _currentItems.length  ){
						enableRightBtn( true );
					}else {
						enableRightBtn( false );
					}
					
					if( _start == 0 ){
						enableLeftBtn( false );
					}else{
						enableLeftBtn( true );
					}			
						
					var index:int;
					//_start = 5; + 9
					
					for (var i:int = 0; i < row; i++) 
					{				
						for (var j:int = 0; j < col; j++) 
						{							
							_itemBoxs[ i ][ j ].update( _currentItems[ index + _start ] );						
							index++;
						}
					}		
					
				}
			}
			
			updateItemBoxImages();
		}
		
		private function nextItem(  ):void 
		{
			if( _currentItems != null ){
				if ( ( _start + 8 ) < _currentItems.length ) {
					_start += 8;
					updateItem();
					trace( "start",_start );
				}else {
					trace( "reach max right" );
				}
			}			
		}
		
		private function prevItem():void 
		{
			if( ( _start - 8 ) >= 0  ){
				_start -= 8;
				updateItem();
			}else {
				trace( "reach max left item......" );
			}
		}
		
		private function enableLeftBtn( val:Boolean ):void 
		{
			if( _shopBg != null && _bm != null ){
				if( val ){
					_bm.addBtnListener( _shopBg.leftBtn );
					_shopBg.leftBtn.gotoAndStop( 1 );
				}else {
					_bm.removeBtnListener( _shopBg.leftBtn );
					_shopBg.leftBtn.gotoAndStop( 3 );
				}
			}
		}		
		
		private function enableRightBtn( val:Boolean ):void 
		{
			if( _shopBg != null && _bm != null ){
				if ( val ) {
					if( _shopBg.rightBtn != null ){
						_bm.addBtnListener( _shopBg.rightBtn );
						_shopBg.rightBtn.gotoAndStop( 1 );				
					}
				}else {				
					if( _shopBg.rightBtn != null ){
						_bm.removeBtnListener( _shopBg.rightBtn );
						_shopBg.rightBtn.gotoAndStop( 3 );
					}
				}
			}
		}		
		
		private function addSellPopUp( item:OfficeItemData ):void 
		{
			if ( _sellPopUp != null  ) {
				removeSellPopUp();
			}
			_sellPopUp = new SellPopUp(  item  );
			addChild( _sellPopUp );			
			_sellPopUp.addEventListener( ItemShopEvent.REMOVE_SELL_POPUP, onRemoveSellPopUp );
			_sellPopUp.addEventListener( ItemShopEvent.SELL_OFFICE_ITEM, onSellItem );
			
			_sellPopUp.x = ( GameConfig.GAME_WIDTH / 2 ) - ( _sellPopUp.width / 2 );
			_sellPopUp.y = ( ( GameConfig.GAME_HEIGHT / 2 ) - ( _sellPopUp.height / 2 ) ) - 100;
		}
		
		private function removeSellPopUp():void 
		{
			if ( _sellPopUp != null ) {
				if ( this.contains( _sellPopUp ) ) {
					this.removeChild( _sellPopUp );
					_sellPopUp = null;
				}
			}
		}
		
		private function extractItemdata():void 
		{	
			_office = GlobalData.instance.inventoryStructure;
			_dress = GlobalData.instance.inventoryDress;
			_power = GlobalData.instance.inventoryPower;
			_contestant = GlobalData.instance.inventoryContestant;
			
			_gd.inventoryItemDataLoaded = true;
			updateItem();
			removeSellPopUp();
			
			if( _gd.inventoryThumbImagesLoaded ){
				updateItemBoxImages();
			}
			
			//if( !_gd.inventoryThumbImagesLoaded ){
				//_imageExtractor = ImageExtractor.getInstance();
				//_imageExtractor.extractXml();
			//}
		}
		
		/*---------------------------------------------------------------------------Setters-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Getters-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{			
				case "closeBtn":
					//_popUpManager.removeCurrentWindow();
					_popUpManager.removeWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW );
				break;
				
				case "leftBtn":
					prevItem();
				break;
				
				case "rightBtn":
					nextItem();
				break;
				
				case "closeBtn":
					_popUpManager.removeCurrentWindow();
				break;
				
				default:					
				break;
			}
		}
		
		private function onButtonRollOut(e:ButtonEvent):void 
		{
			e.obj.btn.gotoAndStop( 1 );
		}
		
		private function onButtonRollOver(e:ButtonEvent):void 
		{
			e.obj.btn.gotoAndStop( 2 );			
		}
		
		//private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		//{
			//trace( "failed xml........................." );
		//}
		//
		//private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		//{
			//_xml = _xmlExtractor.xml;			
			//trace(  "inventory item complete extracted............", _xml );			
			//extractItemdata();
		//}
		
		private function onChangeTab(e:ItemShopEvent):void 
		{
			trace( "change tab.............", e.obj.name );
			removeSellPopUp();
			if( _tabs != null ){
				var len:int = _tabs.length;
				
				for (var i:int = 0; i < len; i++) 
				{
					if ( _tabs[ i ].active && _tabs[ i ].tabName != e.obj.name ) {
						_tabs[ i ].setStatus( 1 );
					}
				}
				
				_start = 0;
				//tabName
				_currentTab = e.obj.name;			
				updateItem();
			}
		}	
		
		private function onSellItem(e:ItemShopEvent):void 
		{
			if( e.obj.entry != null ){
				trace( "entry id ", e.obj.entry );
			}else {
				trace( "item sell is null ");
			}			
		}
		
		private function onShowSellPopUp(e:ItemShopEvent):void 
		{
			addSellPopUp( e.obj.item );
		}
		
		private function onRemoveSellPopUp(e:ItemShopEvent):void 
		{
			removeSellPopUp();
		}
		
		private function onLoadImages(e:ImageExtractorEvent):void 
		{
			trace( "load images now!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" );			
			_gd.inventoryThumbImagesLoaded = true;
			updateItemBoxImages();
		}
		
		private function onInventoryDataLoaded(e:ServerDataControllerEvent):void 
		{			
			extractItemdata();
		}
	}

}