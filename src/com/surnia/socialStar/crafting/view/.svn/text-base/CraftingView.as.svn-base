package com.surnia.socialStar.crafting.view
{
	import com.surnia.socialStar.crafting.data.CraftingData;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.crafting.controller.CraftingController;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.components.plate.CraftingPlate;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.crafting.Material.ListManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.display.Stage;
	import com.surnia.socialStar.config.GameConfig;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class CraftingView extends Sprite
	{		
		private var es:EventSatellite;
		
		private var craftUIData:CraftingData;
		private var craftUIController:CraftingController;
		public var craftUI:CraftingUIMainContainer;
		
		private var craftUIMaterial:ListManager;
		
		private var platesAry:Array;
		
		// temporary variable placements
		// will be transferred to the CraftUIData Class
		
		private var distX:int = 0;
		private var distY:int = 0;
		private var plateCtr:int = 0;
		
		private var furnituresList:Array;
		private var maleClothesList:Array;
		private var femaleClothesList:Array;
		
		
		public function CraftingView(_craftUIData:CraftingData, _craftController:CraftingController) 
		{			
			trace('\nCraftingView initialized');
			es = EventSatellite.getInstance();
			craftUIData = _craftUIData;
			craftUIController = _craftController;
			
			// es.addEventListener( CraftingEvent.UPDATE_DATA, _initItems );
			// es.addEventListener( CraftingEvent.REMOVE_ALL, _removeAll );
			
			initItems();
		}
		
		private function _initItems(e:CraftingEvent):void
		{
			initItems();
		}
		
		private function initItems():void
		{
			initValues();
			initContainer();
			initButtons();
			initPlates();
			initContents();
			initListeners();
			initTabButons();
		}
		
		private function initValues():void
		{
			furnituresList = new Array();
			maleClothesList = new Array();
			femaleClothesList = new Array();
		}
		
		private function initContainer():void
		{
			platesAry = new Array;
			craftUI = new CraftingUIMainContainer;
			
			/*craftUI.x = (760 - craftUI.width) / 2;
			craftUI.y = (630 - craftUI.height) / 2;*/
			
			addChild( craftUI );
			
			craftUIData.containerY = craftUI.container_mc.y;
			craftUIData.BOUNDS_X = craftUI.bounds_mc.x;
			craftUIData.BOUNDS_Y = craftUI.bounds_mc.y;
		}
		
		private function initButtons():void
		{
			craftUIData.scrollerBtnStartY = craftUI.scroller_btn.y;
			craftUI.container_mc.y = craftUIData.containerY;
			craftUI.close_btn.visible = true;
			craftUI.close_btn.gotoAndStop(1);
			craftUI.close_btn.buttonMode = true;
		}
		
		private function showScrollerButton():void
		{
			craftUI.scroller_btn.visible = true;
			craftUI.container_mc.y = craftUIData.containerY;
			craftUI.scroller_btn.buttonMode = true;
			craftUI.scroller_btn.y = craftUIData.scrollerBtnStartY;
		}
		
		private function hideScrollerButton():void
		{
			craftUI.scroller_btn.visible = false;
			craftUI.container_mc.y = craftUIData.containerY;
			craftUI.scroller_btn.buttonMode = false;
			craftUI.scroller_btn.y = craftUIData.scrollerBtnStartY;
		}
		
		private function initTabButons():void
		{			
			craftUI.materialTab_btn.gotoAndStop(1);
			craftUI.furnitureTab_btn.gotoAndStop(2);
			craftUI.maleClothesTab_btn.gotoAndStop(1);
			craftUI.femaleClothesTab_btn.gotoAndStop(1);
			
			craftUI.materialTab_btn.buttonMode = true;
			craftUI.furnitureTab_btn.buttonMode = true;
			craftUI.maleClothesTab_btn.buttonMode = true;
			craftUI.femaleClothesTab_btn.buttonMode = true;
			
			craftUIData.currentSelectedTab = "furnitureTab_btn";
		}
		
		private function initContents():void
		{
			trace('CraftingView->initContents');
			es.addEventListener( CraftingEvent.UPDATE_MATERIAL_VIEW, _onMaterialUiUpdate );
			craftUIMaterial = new ListManager();
		}
		
		private function _onMaterialUiUpdate( e:CraftingEvent ):void
		{
			trace('\nCraftingView->_onMaterialUiUpdate');
			es.removeEventListener( CraftingEvent.UPDATE_MATERIAL_VIEW, _onMaterialUiUpdate );
			craftUI.container_mc.addChild( craftUIMaterial );
			hideCollection();
		}
		
		private function initPlates():void
		{
			for (var i:int = 0; i < craftUIData.totalCraftObject; i++ ) 
			{
				trace('\nCraftingView->initPlates');
				trace('create new plate ' + i);
				var _craftObjectData:Object = new Object();
				
				_craftObjectData.id = craftUIData.idList[i]; 
				_craftObjectData.desc = craftUIData.descList[i]; 
				_craftObjectData.forceCraft = craftUIData.forceCraftList[i];
				// trace('CraftingView->initPlates, craftUIData.forceCraftList[i]=' + craftUIData.forceCraftList[i]);
				_craftObjectData.icon = craftUIData.iconList[i];
				_craftObjectData.reqLvl = craftUIData.reqLvlList[i];
				_craftObjectData.rewardCat = craftUIData.rewardCatList[i];
				_craftObjectData.rewardId = craftUIData.rewardIdList[i];
				_craftObjectData.category = craftUIData.categoryList[i];
				_craftObjectData.stack = craftUIData.stackList[i];
				_craftObjectData.materialList = craftUIData.materialList[i];
				
				// _craftObjectData.totalCraftObjects = craftUIData.getLength(i);
				// temporary value
				
				_craftObjectData.totalCraftObjects = 4;
				_craftObjectData.counter = i;
				
				/*
				trace('_craftObjectData.id='+craftUIData.idList[i]);
				trace('_craftObjectData.desc=' + craftUIData.descList[i]);
				trace('_craftObjectData.forceCraftList=' + craftUIData.forceCraftList[i]);
				trace('_craftObjectData.icon=' + craftUIData.iconList[i]);
				trace('_craftObjectData.reqLvl=' + craftUIData.reqLvlList[i]);
				trace('_craftObjectData.rewardCat=' + craftUIData.rewardCatList[i]);
				trace('_craftObjectData.rewardId=' + craftUIData.rewardIdList[i]);
				trace('_craftObjectData.category=' + craftUIData.categoryList[i]);
				trace('_craftObjectData.stack=' + craftUIData.stackList[i]);
				trace('_craftObjectData.materialList=' + craftUIData.materialList[i]);
				*/
				
				addPlate( _craftObjectData );
			}
		}
		
		private function addPlate( _craftObjectsData:Object ):void
		{
			_craftObjectsData.plateName = 'plate_' + (plateCtr);
			var _plate:CraftingPlate = new CraftingPlate ( _craftObjectsData );
			craftUI.container_mc.addChild( _plate );
			
			//---------------------------------------
			// with level requirement check
			/* 
			switch( _craftObjectsData.category )
			{
				case 'furniture':
					if ( _craftObjectsData.reqLvl > craftUIData.currentLvl )
					{
						furnituresList.push( _plate );
						_plate.x = distX;
						_plate.y = (furnituresList.length - 1) * 140;
					}
					break;
					
				case 'malecloths':
					if ( _craftObjectsData.reqLvl > craftUIData.currentLvl )
					{
						maleClothesList.push( _plate );
						_plate.x = distX;
						_plate.y = ( maleClothesList.length - 1 ) * 140;
					}
					break
				
				case 'femalecloths':
					if ( _craftObjectsData.reqLvl > craftUIData.currentLvl )
					{
						femaleClothesList.push( _plate );
						_plate.x = distY;
						_plate.y = ( femaleClothesList.length - 1 ) * 140;
					}
					break;
			}
			*/
			
			//---------------------------------------
			// no level requirement check
			switch( _craftObjectsData.category )
			{
				case 'furniture':
					furnituresList.push( _plate );
					_plate.x = distX;
					_plate.y = ( furnituresList.length - 1 ) * 140;
					break;
					
				case 'malecloths':
					maleClothesList.push( _plate );
					_plate.x = distX;
					_plate.y = ( maleClothesList.length - 1 ) * 140;
					break
				
				case 'femalecloths':
					femaleClothesList.push( _plate );
					_plate.x = distY;
					_plate.y = ( femaleClothesList.length - 1 ) * 140;
					break;
			}
			
			plateCtr++;
			
			// platesAry.push( _plate );
			
			// _plate.y = distY;
			// _plate.x = distX;
			// distY += 140;
		}
		
		private function showPlates():void
		{
			/*
			for (var i:int = 0; i < platesAry.length; i++ )
			{
				platesAry[i].visible = true;
			}
			*/
			
			hideAllList();
			
			switch(craftUIData.currentSelectedTab)
			{
				case 'furnitureTab_btn' :
					displayList( furnituresList );
					break;
					
				case 'maleClothesTab_btn' :
					displayList( maleClothesList );
					break;
					
				case 'femaleClothesTab_btn' :
					displayList( femaleClothesList );
					break;
			}
		}
		
		private function hideAllList():void
		{
			hidePlates( furnituresList );
			hidePlates( maleClothesList );
			hidePlates( femaleClothesList );
		}
		
		private function displayList( array:Array ):void
		{
			for (var i:int = 0; i < array.length; i++ ) 
			{
				array[i].visible = true; 
			}
			
			if (array.length > 3) 
			{
				showScrollerButton();
			} 
			else 
			{
				hideScrollerButton();
			}
		}
		
		private function hidePlates( array:Array ):void
		{
			hideScrollerButton();
			
			for (var i:int = 0; i < array.length; i++ ) 
			{
				array[i].visible = false; 
			}
			
			/*
			for (var i:int = 0; i < platesAry.length; i++ )
			{
				platesAry[i].visible = false;
			}
			*/
		}
		
		private function showCollection():void
		{
			craftUIMaterial.visible = true;
			if (craftUIMaterial.listLength > 3) 
			{
				showScrollerButton();
			} 
			else 
			{
				hideScrollerButton();
			}
		}
		
		private function hideCollection():void
		{
			craftUIMaterial.visible = false;
		}
		
		private function initListeners():void
		{
			craftUI.close_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			craftUI.close_btn.addEventListener(MouseEvent.MOUSE_OVER, craftUIController.buttonOver );
			craftUI.close_btn.addEventListener(MouseEvent.MOUSE_OUT, craftUIController.buttonOut );
			
			craftUI.scroller_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			craftUI.scroller_btn.addEventListener(MouseEvent.MOUSE_UP, craftUIController.buttonRelease );
			craftUI.scroller_btn.addEventListener(MouseEvent.MOUSE_OUT, craftUIController.buttonRelease );
			craftUI.scroller_btn.addEventListener(MouseEvent.MOUSE_MOVE, craftUIController.buttonMove );
			
			craftUI.materialTab_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			craftUI.furnitureTab_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			craftUI.maleClothesTab_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			craftUI.femaleClothesTab_btn.addEventListener(MouseEvent.MOUSE_DOWN, craftUIController.buttonPress );
			
			es.addEventListener( CraftingEvent.UPDATE_TABS, _updateTabs );
			es.addEventListener( CraftingEvent.UPDATE_SCROLLER, _updateScroller );
		}
		
		/*-----------------------------------------
		|	Event Handlers
		-----------------------------------------*/
		private function _onUpdate(e:Event):void
		{			
			if (craftUIData.isScrolling)
			{				
				var range:int = craftUI.bounds_mc.height - craftUI.scroller_btn.height;
				var percent:Number = (craftUI.scroller_btn.y - craftUI.bounds_mc.y) / range;
				var newY:int = craftUI.mask_mc.y - (percent * (craftUI.container_mc.height - craftUI.mask_mc.height));
				
				TweenLite.to(craftUI.container_mc, 0.3, { y : newY } );
			} 
			
		}
		
		private function _updateScroller(e:CraftingEvent):void
		{			
			if (craftUIData.isScrolling)
			{				
				var range:int = craftUI.bounds_mc.height - craftUI.scroller_btn.height;
				var percent:Number = ( craftUI.scroller_btn.y - craftUI.bounds_mc.y ) / range;
				var newY:int = craftUI.mask_mc.y - (percent * (craftUI.container_mc.height - craftUI.mask_mc.height));
				
				TweenLite.to(craftUI.container_mc, 0.3, { y : newY } );
			}
			
		}
		
		private function _updateTabs(e:CraftingEvent):void
		{			
			craftUI.materialTab_btn.gotoAndStop(1);
			craftUI.furnitureTab_btn.gotoAndStop(1);
			craftUI.maleClothesTab_btn.gotoAndStop(1);
			craftUI.femaleClothesTab_btn.gotoAndStop(1);
			
			switch (craftUIData.currentSelectedTab)
			{
				case 'materialTab_btn' :
					craftUI.materialTab_btn.gotoAndStop(2);
					hideAllList();
					showCollection();
					break;
					
				case 'furnitureTab_btn' :
					craftUI.furnitureTab_btn.gotoAndStop(2);
					hideCollection();
					showPlates();
					break;
					
				case 'maleClothesTab_btn' :
					craftUI.maleClothesTab_btn.gotoAndStop(2);
					hideCollection();
					showPlates();
					break;
					
				case 'femaleClothesTab_btn' :
					craftUI.femaleClothesTab_btn.gotoAndStop(2);
					hideCollection();
					showPlates();
					break;
			}
		}
		
		
		private function removePlates():void
		{
			clearPlate( furnituresList );
			clearPlate( maleClothesList );
			clearPlate( femaleClothesList );
		}
		
		private function clearPlate( array:Array ):void
		{			
			for (var i:int = 0; i < array.length; i++ )
			{
				array[i].removeComponents();
				craftUI.container_mc.removeChild( array[i] );
			}
			array = new Array();
		}
		
		public function removeAll() : void
		{
			removePlates( );
			if ( craftUIMaterial != null )
			{
				trace('\nCraftingView->removeAll');
				if ( craftUI.container_mc != null )
				{
					craftUI.container_mc.removeChild( craftUIMaterial );
				}
				trace( 'craftUIMaterial removed' );
			}
			
			if ( craftUI )
			{
				trace('\nCraftingView->removeAll');
				removeChild( craftUI );
				trace( 'craftUI removed' );
			}
		}
		
	}

}