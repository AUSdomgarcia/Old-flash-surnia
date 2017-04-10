package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.ui.officeshop.OfficeShopUI;
	import com.surnia.socialStar.ui.popUI.components.*;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ItemShopHolder extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _ofcShop:OfficeShopUI;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function  ItemShopHolder( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}		
		
		
		private function setDisplay ():void 
		{		
			_ofcShop = new OfficeShopUI();
			addChild(_ofcShop);
			_ofcShop.init();
		}
		
		private function removeDisplay():void 
		{
			if ( _ofcShop != null ){
				if ( this.contains( _ofcShop ) ) {
					this.removeChild( _ofcShop );
					_ofcShop = null;
				}
			}
		}
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}