package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class ItemShopPopUp extends AbstractWindow
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
		/*---------------------------------------------------------------------------Constructor----------------------------------------------------------*/
		
		
		public function ItemShopPopUp( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		override public function initWindow():void 
		{
			super.initWindow();
			setDisplay();
			_popUpManager = PopUpUIManager.getInstance();
			addtab();
			addItemBox();
			extractOfficeItemData();			
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
			//_shopBg.InventoryShopBg.visible = false;
			//_shopBg.txtShopName.visible = false;
			_shopBg.txtShopName.text = "BuildShop";
			
			_bm.addBtnListener( _shopBg.closeBtn );
			
			//_bm.addBtnListener( _shopBg.tab1 );
			//_bm.addBtnListener( _shopBg.tab2 );
			//_bm.addBtnListener( _shopBg.tab3 );
			//_bm.addBtnListener( _shopBg.tab4 );
			//_bm.addBtnListener( _shopBg.tab5 );
			//_bm.addBtnListener( _shopBg.tab6 );
			//_bm.addBtnListener( _shopBg.tab7 );						
			
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
			
			var itemBox:OfficeItemBox;
			
			
			var index:int;
			//_start = 5; + 9
			
			for (var i:int = 0; i < row; i++) 
			{
				_itemBoxs[ i ] = new Array();
				for (var j:int = 0; j < col; j++) 
				{
					itemBox = new OfficeItemBox( null  );
					_itemBoxHolder.addChild( itemBox );
					itemBox.x = ( ( WindowPopUpConfig.OFFICE_ITEM_BOX_WIDTH + xPad ) * j );// + 42;
					itemBox.y = ( ( WindowPopUpConfig.OFFICE_ITEM_BOX_HEIGHT + yPad ) * i );// + 44;
					_itemBoxs[ i ][ j ] = itemBox;
					trace( "item box added!!!................" );
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
			
			_tabs = new Array();
			var tabNames:Array = [ "staff", "training", "machine","deco", "tile","expansion", "power" ];
			
			for (var i:int = 0; i < 7; i++) 
			{				
				var tab:ShopTab = new ShopTab( i + 1 , tabNames[ i ] );				
				_tabHolder.addChild( tab );				
				tab.addEventListener( ItemShopEvent.CHANGE_TAB, onChangeTab );
				tab.x = ( WindowPopUpConfig.TAB_WIDTH  + 30 ) * i;
				_tabs.push( tab );
			}			
			
			_tabHolder.x = 68;
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
		
		
		private function extractOfficeItemData():void 
		{
			_xmlExtractor = new XMLExtractor(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed ); 
			_xmlExtractor.extractXmlData( XMLLinkData.mainLink +  "shop/officeitems");
		}
		
		
		private function updateItem():void 
		{	
			if(  _start + 8 <= _items.length  ){
				enableRightBtn( true );
			}else {
				enableRightBtn( false );
			}
			
			if( _start == 0 ){
				enableLeftBtn( false );
			}else{
				enableLeftBtn( true );
			}
			
			if( _items != null ){
				var row:int = 2;
				var col:int = 4;			
				
				var index:int;
				//_start = 5; + 9
				
				for (var i:int = 0; i < row; i++) 
				{				
					for (var j:int = 0; j < col; j++) 
					{					
						_itemBoxs[ i ][ j ].update( _items[ index + _start ] );
						index++;
					}				
				}			
			}
		}
		
		private function nextItem():void 
		{
			if ( ( _start + 8 ) <= _items.length ) {
				_start += 8;
				updateItem();
				trace( "start",_start );
			}else {
				trace( "reach max right" );
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
			if( val ){
				_bm.addBtnListener( _shopBg.leftBtn );
				_shopBg.leftBtn.gotoAndStop( 1 );
			}else {
				_bm.removeBtnListener( _shopBg.leftBtn );
				_shopBg.leftBtn.gotoAndStop( 3 );
			}
		}		
		
		private function enableRightBtn( val:Boolean ):void 
		{
			if( val ){				
				_bm.addBtnListener( _shopBg.rightBtn );
				_shopBg.rightBtn.gotoAndStop( 1 );				
			}else{				
				_bm.removeBtnListener( _shopBg.rightBtn );
				_shopBg.rightBtn.gotoAndStop( 3 );
			}
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
					_popUpManager.removeCurrentWindow();
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
		
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "failed xml........................." );
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{
			_xml = _xmlExtractor.xml;
			//trace( "xml office item extraction successfull....", _xml );
			//trace( "see: ",_xml.item[ i ].@id );
			//trace( "xml extraction successfull....", _xml, "see", _xml.@bgm, _xml.@sfx, _xml.@gfx );
			//trace( "xml extraction successfull....", _xml, "see2", _xml.@bgm );
			
			_items = new Array();
			
			var len:int = _xml.item.length();
			var officeItem:OfficeItemData;
			
			//trace( "len", len );
			for ( var i:int = 0; i < len; i++) 
			{				
				officeItem = new OfficeItemData();
				officeItem.id = _xml.item[ i ].@id;
				officeItem.name = _xml.item[ i ].@name;
				officeItem.coincost = _xml.item[ i ].@coincost;
				_items.push( officeItem );
				//trace( "see: ",officeItem );
			}
			
			updateItem();			
		}
		
		private function onChangeTab(e:ItemShopEvent):void 
		{
			trace( "change tab............." );
			
			var len:int = _tabs.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _tabs[ i ].active && _tabs[ i ].tabName != e.obj.name ) {
					_tabs[ i ].setStatus( 0 );
				}				
			}
			
			_start = 0;
			updateItem();
		}
	}

}