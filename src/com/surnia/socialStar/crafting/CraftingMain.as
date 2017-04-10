package com.surnia.socialStar.crafting
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.data.CraftingData;
	import com.surnia.socialStar.crafting.controller.CraftingController;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.crafting.view.CraftingView;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Windz
	 * @email jan.surnia@gmail.com
	 */
	 
	public class CraftingMain extends Sprite 
	{
		private var craftUIData:CraftingData;
		private var craftUIView:CraftingView;
		private var craftUIController:CraftingController;
		
		private var _es:EventSatellite;
		
		public function CraftingMain():void 
		{
			_es = EventSatellite.getInstance();
			initAll();
		}
		
		private function _onSdcEventHandler( e:ServerDataControllerEvent ):void
		{
			_es.removeEventListener( ServerDataControllerEvent.ON_BUY_MATERIAL_COMPLETE, _onSdcEventHandler );
			// Called from ServerDataController->onBuyMaterialComplete
			reset();
		}
		
		private function _onCraftingEventHandler( e:CraftingEvent ):void
		{
			_es.removeEventListener( CraftingEvent.RESET_ALL, _onCraftingEventHandler ); 
			// This is called from BoxDataHolder class
			// This is also called from CraftingPlateData->increaseDataQuantity
			reset();
		}
		
		private function reset():void
		{
			removeAll();
			initAll();
		}
		
		private function initAll():void
		{
			_es.addEventListener( CraftingEvent.UPDATE_DATA, _initOthers );
			_es.addEventListener( CraftingEvent.REMOVE_ALL, _removeAll );
			_es.addEventListener( CraftingEvent.RESET_ALL, _onCraftingEventHandler );
			_es.addEventListener( ServerDataControllerEvent.ON_BUY_MATERIAL_COMPLETE, _onSdcEventHandler );
			
			trace('\nCraftingMain initialized');
			
			craftUIData = new CraftingData;
		}
		
		private function _initOthers(e:CraftingEvent):void
		{
			_es.removeEventListener( CraftingEvent.UPDATE_DATA, _initOthers );
			craftUIController = new CraftingController(craftUIData);
			craftUIView = new CraftingView(craftUIData, craftUIController);
			addChild( craftUIView );
		}
		
		private function _removeAll(e:CraftingEvent):void
		{
			_es.removeEventListener( CraftingEvent.REMOVE_ALL, _removeAll );
			removeAll();
		}
		
		private function removeAll():void
		{
			craftUIView.removeAll();
			if (craftUIView != null)
			{
				removeChild( craftUIView );
			}
		}
		
	}
	
}