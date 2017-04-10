package com.surnia.socialStar.ui.popUI.data 
{
	/**
	 * ...
	 * @author JC
	 */
	public class ShopItemData 
	{
		
		/*------------------------------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		private var _itemId:String;
		private var _itemName:String;
		private var _itemEffect:String;
		private var _itemDesc:String;
		/*------------------------------------------------------------------------------Constructor------------------------------------------------------------*/
		
		public function ShopItemData() 
		{
			
		}	
		
		/*------------------------------------------------------------------------------Methods---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Setters---------------------------------------------------------------*/
		public function set itemId(value:String):void 
		{
			_itemId = value;
		}
		
		public function set itemName(value:String):void 
		{
			_itemName = value;
		}
		
		public function set itemEffect(value:String):void 
		{
			_itemEffect = value;
		}
		
		public function set itemDesc(value:String):void 
		{
			_itemDesc = value;
		}
		/*------------------------------------------------------------------------------Getters---------------------------------------------------------------*/
		public function get itemId():String 
		{
			return _itemId;
		}		
		
		public function get itemName():String 
		{
			return _itemName;
		}		
		
		public function get itemEffect():String 
		{
			return _itemEffect;
		}		
		
		public function get itemDesc():String 
		{
			return _itemDesc;
		}		
		/*------------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		
	}

}