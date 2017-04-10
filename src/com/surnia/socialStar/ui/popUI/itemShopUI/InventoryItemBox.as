package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemCharData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemDressData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemPowerData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemStructureData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.InventoryEvent;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class InventoryItemBox extends Sprite
	{
		/*------------------------------------------------------------Constant----------------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------Properties--------------------------------------------------------------------------------*/
		private var _mc:InventoryItemBoxMC;
		private var _item:*;
		private var _bm:ButtonManager;
		private var _itemShopEvent:ItemShopEvent;
		private var _imageExtractor:ImageExtractor;
		private var _image:*;
		
		private var _officeData:ItemStructureData;
		private var _contestantData:ItemCharData;
		private var _powerData:ItemPowerData;
		private var _dressData:ItemDressData;
		
		private var _es:EventSatellite;
		private var _sdc:ServerDataController;
		private var _inventoryEvent:InventoryEvent;
		private var _popUpUIManager:PopUpUIManager;
		
		/*------------------------------------------------------------Constructor-------------------------------------------------------------------------------*/
		
		public function InventoryItemBox( item:* ) 
		{			
			_es = EventSatellite.getInstance();
			_sdc =  ServerDataController.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*------------------------------------------------------------Methods-------------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			_mc  = new InventoryItemBoxMC();
			addChild( _mc );
			_mc.gotoAndStop( "none" );			
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		public function update( item:* ):void 
		{	
			_item = item;
			if ( _item != null ) {
				
				if( _mc != null ){
					if ( _mc.loadingMC != null ){						
						_mc.loadingMC.visible = true;
					}
				}
				
				if ( _item.itemtype == "office" ){
					_officeData = _item;
					if ( _officeData != null && _mc != null ) {
						_mc.gotoAndStop( "office" );
						if( _mc.sellBtn != null && _mc.setBtn != null && _mc != null ){
							_bm.addBtnListener( _mc.sellBtn );
							_bm.addBtnListener( _mc.setBtn );						
							
							_mc.alpha = 1;
							_mc.txtName.text = _officeData.itemname;
							//_mc.txtDesc.text = _item.coincost;
							//_mc.txtQuantity = _item.qty;				
							//_mc.visible = true;
						}
					}
				}else if ( _item.itemtype == "dress" && _mc != null ) {
					_dressData = _item;
					if ( _dressData != null ) {
						_mc.gotoAndStop( "dress" );
						if( _mc.sellBtn != null && _mc != null ){							
							_bm.addBtnListener( _mc.sellBtn );							
							_mc.alpha = 1;
							_mc.txtName.text = _dressData.itemname;
							//_mc.txtDesc.text = _item.coincost;
							//_mc.txtQuantity = _item.qty;				
							//_mc.visible = true;
						}
					}
				}else if ( _item.itemtype == "power" && _mc != null ) {
					_powerData = _item;
					if ( _powerData != null ) {
						_mc.gotoAndStop( "power" );
						if( _mc.useBtn != null && _mc != null ){
							_bm.addBtnListener( _mc.useBtn );							
							_mc.alpha = 1;
							_mc.txtName.text = _powerData.itemname;
							//_mc.txtDesc.text = _item.coincost;
							//_mc.txtQuantity = _item.qty;				
							//_mc.visible = true;
						}
					}
				}else if ( _item.itemtype == "character" && _mc != null ) {
					_contestantData = _item;
					if ( _contestantData != null ) {
						_mc.gotoAndStop( "character" );
						if( _mc.fireBtn != null && _mc.hireBtn != null && _mc != null ){
							_bm.addBtnListener( _mc.fireBtn );
							_bm.addBtnListener( _mc.hireBtn );						
							_mc.alpha = 1;
							_mc.txtName.text = _contestantData.cname;
							//_mc.txtDesc.text = _item.coincost;
							//_mc.txtQuantity = _item.qty;				
							//_mc.visible = true;
						}
					}
				}else {
					if( _mc != null ){
						if ( _mc.loadingMC != null ){
							_mc.gotoAndStop( "none" );
							_mc.loadingMC.visible = false;
						}
						
						//if( _mc.sellBtn != null && _mc.setBtn != null ){
							//_bm.removeBtnListener( _mc.sellBtn );
							//_bm.removeBtnListener( _mc.setBtn );
							//_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
							//_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
							//_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );						
						//}
					}
				}
			}		
		}	
		
		public function loadImage(  ):void 
		{
			_imageExtractor = ImageExtractor.getInstance();
			
			if( _mc != null ){
				if ( _image != null && _mc.imageHolder != null ) {
					if ( _mc.imageHolder.contains( _image  ) ) {
						_mc.imageHolder.removeChild( _image );
						_image = null;
					}
				}
			}
			
			if( _item != null ){
				if ( _item.itemtype == "office" ) {			
					if ( _officeData != null ){					
						_image = _imageExtractor.getImage( _officeData.itemid  );
						
						if ( _image == null ) {
							_image = _imageExtractor.getImage( "0" );
						}			
					}
				}else if ( _item.itemtype == "dress" ){
					if ( _dressData != null ){					
						_image = _imageExtractor.getImage( _dressData.itemid  );
						
						if ( _image == null ) {
							_image = _imageExtractor.getImage( "0" );
						}			
					}
				}else if ( _item.itemtype == "power" ){
					if ( _powerData != null ) {
						trace( "[InventoryItemBox]_powerData.itemid", _powerData.itemid );
						_image = _imageExtractor.getImage( _powerData.itemid  );
						trace( "[InventoryItemBox] _image", _image );
						if ( _image == null ) {
							_image = _imageExtractor.getImage( "0" );
							trace( "[InventoryItemBox] _image show default: ", _image );
						}			
					}
				}else if ( _item.itemtype == "character" ){
					if ( _contestantData != null ){					
						_image = _imageExtractor.getImage( _contestantData.cid  );
						
						if ( _image == null ) {
							_image = _imageExtractor.getImage( "0" );
						}			
					}
				}
				
				if( _mc != null ){
					if ( _image != null && _mc.imageHolder != null ){					
						_mc.imageHolder.addChild( _image );
						_image.x = ( _mc.imageHolder.width / 2 ) - ( _image.width / 2 );
						_image.y = ( _mc.imageHolder.height / 2 ) - ( _image.height / 2 );
						//_image.alpha = 0;
						//TweenLite.to( _image, 0.3, { alpha:1 } );
					}else {
						trace( "office item _image can't found!....................................." );
					}
					
					if ( _mc.loadingMC != null ) {
						_mc.loadingMC.visible = false;
					}
				}
			}else{
				if( _mc != null ){
					//if ( _mc.sellBtn != null && _mc.setBtn != null ){
						//_bm.removeBtnListener( _mc.sellBtn );
						//_bm.removeBtnListener( _mc.setBtn );
						//_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
						//_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
						//_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );					
						//trace( "this inventory box is totally empty no item data found!!....................................." );
					//}
					
					if ( _mc.loadingMC != null ){
						_mc.loadingMC.visible = false;
						_mc.gotoAndStop( "none" );
					}
				}
			}
		}
		
		/*
		public function extactData( itemStructureData:ItemStructureData ):IsoObjectData 
		{
			var isoObectData:IsoObjectData = null;			
			for (var i:int = 0; i < GlobalData.instance.officeStoreDataArray.length; i++)
			{
				for (var j:int = 0; j < GlobalData.instance.officeStoreDataArray[i].length; j++) 
				{			
					//check for id
					if ( itemStructureData.itemid == GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ID])
					{						
						isoObectData = new IsoObjectData();
						isoObectData.id = itemStructureData.itemid;
						isoObectData.entryid = itemStructureData.entry;
						isoObectData.name = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_NAME];
						isoObectData.type = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_CATEGORY];
						isoObectData.subType = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TYPE];
						isoObectData.w = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].y;
						isoObectData.l = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].x;
						isoObectData.h = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].z;
						isoObectData.rotation = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ROTATABLE];
						isoObectData.fn = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_FRAMENUMBER];
						isoObectData.npc = itemStructureData.assignednpc;
						isoObectData.empty = "true";
						isoObectData.level = 0;
						isoObectData.fbid = "";
						isoObectData.npcid = "";
						isoObectData.gender = "";
						isoObectData.staff = "";
						isoObectData.state = "";						
						break;
					}
				}
			}			
			return isoObectData;
		}
		*/
		
		/*------------------------------------------------------------Setters----------------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------Getters----------------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------EventHandlers----------------------------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void
		{
			var serverController:ServerDataController = ServerDataController.getInstance();
			var btnName:String = e.obj.name;
			var popUpUiManager:PopUpUIManager = PopUpUIManager.getInstance();
			
			switch ( btnName )
			{				
				case "sellBtn":
					if ( _item.itemtype == "office" ){
						if ( _officeData != null ) {
							_sdc.setPlayerCoin( _officeData.sellprice );
							_sdc.sellItem( _officeData.entry , true );							
							trace( "[ Inventory box ]:sell item entryid", _officeData.entry  );
						}
					}else if ( _item.itemtype == "dress" ) {
						if( _dressData != null ){
							_sdc.sellDress( _dressData.entry );
							trace( "[ Inventory box ]:sell item dress entryid", _dressData.entry  );
						}
					}
				break;
				
				case "setBtn":
					if ( _officeData != null ) {
						//tile,staff,expansion,power,training,machine
						trace( "[ Inventory box ]:set item to office" );
						var isoObjectData:* = GlobalData.instance.extactData( _officeData, null );						
						if ( isoObjectData != null ) {
							_inventoryEvent = new InventoryEvent( InventoryEvent.SET_OFFICE_INVENTORY_ITEM );							
							_es.dispatchESEvent( _inventoryEvent, isoObjectData );							
							_popUpUIManager.removeWindow( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW );
						}else {
							trace( "[ Inventory box ]:set item to office isoObjectData", isoObjectData );
						}
						
						//var officeShopUIEvent:OfficeShopUIEvent =  new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
					}					
				break;
				
				case "hireBtn":
					if( _contestantData != null ){						
						_sdc.placeCharToOffice( _contestantData.cid );
						trace( "set char cid", _contestantData.cid );
					}				
				break;
				
				case "fireBtn":
					if( _contestantData != null ){
						_sdc.fireCharacter( _contestantData.cid);
						trace( "fire char cid", _contestantData.cid );
					}
				break;
				
				case "useBtn":
					if ( _powerData != null ) {
						//subtype - ap,coin
						_sdc.usePowerItem( _powerData.entry );
						trace( "use power item", _powerData.entry );
					}
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
	}

}