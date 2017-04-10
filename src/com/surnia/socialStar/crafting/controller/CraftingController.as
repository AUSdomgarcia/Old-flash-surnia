package com.surnia.socialStar.crafting.controller 
{
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.data.CraftingData;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Windz
	 */
	public class CraftingController extends Sprite
	{
		private var craftUIData:CraftingData;
		private var es:EventSatellite;
		private var _popUpUIManager:PopUpUIManager;
		
		
		public function CraftingController(_craftUIData:CraftingData ) 
		{
			trace('\nCraftingController initialized');
			craftUIData = _craftUIData;
			es = EventSatellite.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
		}
		
		public function buttonPress(e:MouseEvent):void
		{
			//trace('crafting UI button pressed=' + e.currentTarget.name);
			switch(e.currentTarget.name)
			{
				case 'close_btn':
					craftUIData.removeAll();
					_popUpUIManager.removeWindow( WindowPopUpConfig.COLLECTION_WINDOW );
					break;
					
				case 'scroller_btn':
					craftUIData.isScrolling = true;
					e.currentTarget.startDrag(false, new Rectangle(craftUIData.BOUNDS_X, craftUIData.BOUNDS_Y, craftUIData.BOUNDS_WIDTH, craftUIData.BOUNDS_HEIGHT));
					break;
					
				case 'materialTab_btn':
					craftUIData.currentSelectedTab = 'materialTab_btn';
					break;
					
				case 'furnitureTab_btn':
					craftUIData.currentSelectedTab = 'furnitureTab_btn';
					break;
					
				case 'maleClothesTab_btn':
					craftUIData.currentSelectedTab = 'maleClothesTab_btn';
					break;
					
				case 'femaleClothesTab_btn':
					craftUIData.currentSelectedTab = 'femaleClothesTab_btn';
					break;
					
			}
		}
		
		public function buttonRelease(e:MouseEvent):void
		{
			//trace('crafting UI button released=' + e.currentTarget.name);
			switch(e.currentTarget.name)
			{
				case 'close_btn':
					
					break;
					
				case 'scroller_btn':
					craftUIData.isScrolling = false;
					e.currentTarget.stopDrag();
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
		
		public function buttonMove(e:MouseEvent):void
		{
			craftUIData.scrollerY = e.currentTarget.y;
		}
		
		
	}

}