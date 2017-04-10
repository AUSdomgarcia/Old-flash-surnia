package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;	
	import com.surnia.socialStar.ui.popUI.components.ShopItemBox;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.controllers.ItemDataExtractor;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ItemShopWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _mc:ItemShopPopUpWindowMC;
		private var _bm:ButtonManager;
		private var _popUpUIEvent:PopUIEvent;
		private var _es:EventSatellite;
		private var _popUpManager:PopUpUIManager;
		
		private var _shopItemBoxHolder:Sprite;
		private var _shopItemBoxs:Array;		
		
		private var _itemDataExtractor:ItemDataExtractor;
		private var _start:int;
		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function ItemShopWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			trace( "init GetActionPoint popup window" );
			_popUpManager = PopUpUIManager.getInstance();
			initItemShopData();
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();			
		}
		
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_mc = new ItemShopPopUpWindowMC( );
			addChild( _mc );					
			
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addBtnListener( _mc.plusBtn );			
			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
			
			//addShopItemBox();
		}	
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){				
				_bm.removeBtnListener( _mc.closeBtn );
				_bm.removeBtnListener( _mc.plusBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				if ( this.contains( _mc )){
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		
		private function addShopItemBox():void 
		{
			_shopItemBoxHolder = new Sprite();
			addChild( _shopItemBoxHolder );
			
			_shopItemBoxs = new Array();
			
			var row:int = 3;
			var col:int = 3;
			var shopItemBox:ShopItemBox;
			
			
			var index:int;
			//_start = 5; + 9
			
			for (var i:int = 0; i < row; i++) 
			{
				_shopItemBoxs[ i ] = new Array();
				for (var j:int = 0; j < col; j++) 
				{
					shopItemBox = new ShopItemBox( _itemDataExtractor.shopItems[ index + _start ]  );
					_shopItemBoxHolder.addChild( shopItemBox );
					shopItemBox.x = ( ( WindowPopUpConfig.ITEM_BOX_WIDTH + 7 ) * j ) + 42;
					shopItemBox.y = ( ( WindowPopUpConfig.ITEM_BOX_HEIGHT - 2 ) * i ) + 44;
					_shopItemBoxs[ i ][ j ] = shopItemBox;
					trace( "item box added!!!................" );
					index++;
				}
				
			}
			
		}
		
		
		private function initItemShopData():void 
		{
			_itemDataExtractor = ItemDataExtractor.getInstance();
			_itemDataExtractor.clearData();
			_itemDataExtractor.extractXMlData( "http://monsterpatties.net/test/mallItem.xml" );
			_itemDataExtractor.addEventListener(  PopUIEvent.SHOP_ITEM_DATA_READY, onShopItemDataReady );			
		}		
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "plusBtn":
					trace( "ok btn click..........." );
					_popUpUIEvent = new PopUIEvent( PopUIEvent.SHOW_FACEBOOK_PAY_WINDOW );
					_es.dispatchESEvent( _popUpUIEvent  );
				break;				
				
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
				break;
				
				default:
					
				break;
			}			
			_popUpManager.removeCurrentWindow();
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "plusBtn":
					trace( "ok btn click..........." );					
					_mc.plusBtn.gotoAndStop( 1 );
				break;				
				
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
					_mc.closeBtn.gotoAndStop( 1 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "plusBtn":
					trace( "ok btn click..........." );					
					_mc.plusBtn.gotoAndStop( 2 );
				break;				
				
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onShopItemDataReady(e:PopUIEvent):void 
		{
			trace( "shopItemData ready......................" );
			addShopItemBox();
		}
	}

}