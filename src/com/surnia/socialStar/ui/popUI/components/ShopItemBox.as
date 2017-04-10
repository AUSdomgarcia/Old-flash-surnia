package com.surnia.socialStar.ui.popUI.components 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.data.ShopItemData;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class ShopItemBox extends Sprite
	{
		/*-----------------------------------------------------------------------------------Constant---------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Properties-------------------------------------------------------*/
		private var _mc:shopItemBoxMC;
		private var _itemId:String;
		private var _itemName:String;
		private var _itemEffect:String;
		private var _itemDesc:String;
		
		private var _bm:ButtonManager;
		private var _es:EventSatellite;
		private var _popUpUIEvent:PopUIEvent;
		
		/*-----------------------------------------------------------------------------------Constructor------------------------------------------------------*/		
		
		public function ShopItemBox( shopItemData:ShopItemData = null  )
		{
			if( shopItemData != null ){
				_itemId = shopItemData.itemId;
				_itemName = shopItemData.itemName;
				_itemEffect = shopItemData.itemEffect;
				_itemDesc = shopItemData.itemDesc;
			}
			
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
		
		/*-----------------------------------------------------------------------------------Methods---------------------------------------------------------*/
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_mc = new shopItemBoxMC();
			addChild( _mc );
			_mc.icon.txtPrice.text = "0";
			
			if( _itemId != null ){
				_mc.icon.txtPrice.text = _itemName;			
				
				switch ( _itemId ) 
				{				
					case "000":
						_mc.image.gotoAndStop( 2 );
					break;
					
					case "001":
						_mc.image.gotoAndStop( 3 );
					break;
					
					case "002":
						_mc.image.gotoAndStop( 4 );
					break;
					
					case "003":
						_mc.image.gotoAndStop( 5 );
					break;
					
					case "004":
						_mc.image.gotoAndStop( 6 );
					break;
					
					case "005":
						_mc.image.gotoAndStop( 7 );
					break;
					
					case "006":
						_mc.image.gotoAndStop( 8 );
					break;
					
					case "007":
						_mc.image.gotoAndStop( 9 );
					break;
					
					case "008":
						_mc.image.gotoAndStop( 10 );
					break;
					
					case "009":
						_mc.image.gotoAndStop( 11 );
					break;
					
					case "010":
						_mc.image.gotoAndStop( 12 );
					break;
					
					default:					
					break;
				}
			}	
			
			_bm.addBtnListener( _mc.buyBtn );			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.buyBtn );				
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		
		/*-----------------------------------------------------------------------------------Setters---------------------------------------------------------*/
		public function set mc(value:shopItemBoxMC):void 
		{
			_mc = value;
		}
		/*-----------------------------------------------------------------------------------Getters---------------------------------------------------------*/
		public function get mc():shopItemBoxMC 
		{
			return _mc;
		}
		/*-----------------------------------------------------------------------------------EventHandlers---------------------------------------------------*/
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "buyBtn":
					trace( "Buy btn click..........." );				
					_popUpUIEvent = new PopUIEvent( PopUIEvent.BUY_SHOP_ITEM );
					_es.dispatchESEvent( _popUpUIEvent  );
				break;				
				
				default:
					
				break;
			}			
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "buyBtn":					
					_mc.buyBtn.gotoAndStop( 1 );
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
				case "buyBtn":					
					_mc.buyBtn.gotoAndStop( 2 );
				break;				
				
				default:
					
				break;
			}
		}		
	}

}