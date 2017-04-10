package com.surnia.socialStar.crafting.components.plate.controller 
{
	import com.surnia.socialStar.crafting.components.plate.data.CraftingPlateData;
	import com.surnia.socialStar.crafting.components.plate.event.CraftingPlateEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class CraftingPlateController extends Sprite
	{
		private var _es:EventSatellite;
		private var _craftPlateData:CraftingPlateData;
		
		
		public function CraftingPlateController( _data:CraftingPlateData ) 
		{
			_es = EventSatellite.getInstance();
			_craftPlateData = _data;
		}
		
		public function buttonPress(e:MouseEvent):void
		{
			trace('button pressed=' + e.currentTarget.name);
			
			switch (e.currentTarget.name)
			{					
				case 'total_btn':
					//_craftPlateEvent = new CraftingPlateEvent( CraftingPlateEvent.TOTAL_BUTTON_PRESS );
					break;
			}
		}
		
		public function buttonOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
		}
		
		public function buttonOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		public function _craftPlateMakeBtnPress(e:MouseEvent):void
		{
			// _craftPlateData.stack--;
			ServerDataController.getInstance().buyMaterial( _craftPlateData.id );
		}
		
		public function _craftPlateTotalBtnPress(e:MouseEvent):void
		{
			ServerDataController.getInstance().buyMaterial( _craftPlateData.id );
		}
		
	}

}