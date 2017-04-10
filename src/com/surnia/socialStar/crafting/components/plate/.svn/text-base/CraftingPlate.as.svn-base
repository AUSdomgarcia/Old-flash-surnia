package com.surnia.socialStar.crafting.components.plate 
{
	import com.surnia.socialStar.crafting.components.plate.controller.CraftingPlateController;
	import com.surnia.socialStar.crafting.components.plate.data.CraftingPlateData;
	import com.surnia.socialStar.crafting.components.plate.view.CraftingPlateView;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class CraftingPlate extends Sprite
	{
		private var _craftPlateData:CraftingPlateData;
		private var _craftPlateView:CraftingPlateView;
		private var _craftPlateController:CraftingPlateController;
		
		public function CraftingPlate( _craftObjectData:Object ) 
		{
			_craftPlateData = new CraftingPlateData ( _craftObjectData );			
			_craftPlateController = new CraftingPlateController( _craftPlateData );
			_craftPlateView = new CraftingPlateView( _craftPlateData, _craftPlateController );
			addChild( _craftPlateView );
		}
		
		public function get plate():MovieClip
		{
			return _craftPlateView;
		}
		
		public function get reqLvl():int
		{
			return parseInt(_craftPlateData.reqLvl);
		}
		
		public function removeComponents():void
		{
			_craftPlateView.removeComponents();
		}
		
	}

}