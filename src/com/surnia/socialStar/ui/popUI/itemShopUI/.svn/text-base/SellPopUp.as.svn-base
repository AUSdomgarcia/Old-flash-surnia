package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class SellPopUp extends Sprite
	{
		
		/*------------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		private var _mc:SellPopUpMC;
		private var _bm:ButtonManager;
		private var _itemShopEvent:ItemShopEvent;
		private var _item:OfficeItemData;
		/*------------------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		public function SellPopUp( item:OfficeItemData ) 
		{
			_item = item;
			trace( "sellpopup: data:" , _item );
			addEventListener( Event.ADDED_TO_STAGE,init );
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
		
		/*------------------------------------------------------------------------------Methods------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new SellPopUpMC();
			addChild( _mc );
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.okBtn );
			_bm.addBtnListener( _mc.cancelBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			showBtn( true );
			
			if( _item != null ){
				_mc.txtMsg.text = "do you really want to sell " + _item.name + " for " + _item.sellPrice + " coin?";
			}else {
				_mc.txtMsg.text = "do you really want to sell this item? ";
			}
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.okBtn );
				_bm.removeBtnListener( _mc.cancelBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function showBtn( val:Boolean ):void 
		{			
			_mc.okBtn.visible = val;
			_mc.cancelBtn.visible = val;			
		}
		/*------------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void
		{			
			var btnName:String = e.obj.name;
			var serverController:ServerDataController = ServerDataController.getInstance();
			
			switch ( btnName )
			{				
				case "okBtn":				
					if( _item != null ){
						serverController.sellItem( _item.entry );
						//_mc.alpha = 0.5;
						_mc.txtMsg.text = "Selling item Please wait...";
						showBtn( false );
						
						_itemShopEvent = new ItemShopEvent( ItemShopEvent.SELL_OFFICE_ITEM );
						_itemShopEvent.obj.entry = _item.entry;
						dispatchEvent( _itemShopEvent );					
					}else {
						trace( "selling a null item................" );
					}
					trace( "okBtn..........." );					
				break;
				
				case "cancelBtn":
					_itemShopEvent = new ItemShopEvent( ItemShopEvent.REMOVE_SELL_POPUP );
					dispatchEvent( _itemShopEvent );
					trace( "cancelBtn..........." );
					
				break;
				
				default:				
				break;
			}
		}
		
		private function onButtonRollOut(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			e.obj.btn.gotoAndStop( 1 );			
		}
		
		private function onButtonRollOver(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;		
			e.obj.btn.gotoAndStop( 2 );			
		}
	}

}