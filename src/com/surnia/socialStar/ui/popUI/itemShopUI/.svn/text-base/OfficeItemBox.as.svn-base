package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class OfficeItemBox extends Sprite
	{
		
		/*----------------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _mc:OfficeItemBoxMC;
		private var _item:OfficeItemData;
		private var _bm:ButtonManager;
		private var _popUIManager:PopUpUIManager;
		/*----------------------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		public function OfficeItemBox( item:OfficeItemData ) 
		{			
			_item = item;			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(  Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*----------------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_mc = new OfficeItemBoxMC();
			addChild( _mc );
			_bm.addBtnListener( _mc.buyBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			if( _item != null ){
				_mc.txtName.text = _item.name;
				_mc.txtPrice.text = _item.coincost;
				//_mc.imageHolder.addChild( _item.image );
			}
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
		
		public function update( item:OfficeItemData ):void 
		{
			if( item != null ){
				_item = item;
				_mc.txtName.text = _item.name;
				_mc.txtPrice.text = _item.coincost;
				//_mc.imageHolder.addChild( _item.image );
				_mc.visible = true;
			}else {
				_mc.visible = false;
			}
		}
		
		
		private function buyItem():void 
		{
			_popUIManager = PopUpUIManager.getInstance();
			_popUIManager.loadSubWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW );
			//_popUIManager.loadSubWindow( WindowPopUpConfig.COIN_POPUP_WINDOW );
					
			//trace( "buy this item", _item.name, "for coin", _item.coincost );
			//var es:EventSatellite = EventSatellite.getInstance();
			//var itemShopEvent:ItemShopEvent = new ItemShopEvent( ItemShopEvent.BUY_ITEM );			
			//es.dispatchESEvent( itemShopEvent , _item );
		}
		
		/*----------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "buyBtn":
					buyItem();
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