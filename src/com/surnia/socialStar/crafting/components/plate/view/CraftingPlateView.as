package com.surnia.socialStar.crafting.components.plate.view 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.components.plate.controller.CraftingPlateController;
	import com.surnia.socialStar.crafting.components.plate.data.CraftingPlateData;
	import com.surnia.socialStar.crafting.Material.BoxDataHolder;
	import com.surnia.socialStar.crafting.components.plate.event.CraftingPlateEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class CraftingPlateView extends MovieClip
	{
		private var _craftPlate:CraftingUIPlate;
		private var _craftPlateData:CraftingPlateData;
		private var _craftPlateController:CraftingPlateController;
		
		private var _name:String;
		private var _craftMainImage:BoxDataHolder;
		
		private var _materialsAry:Array;
		
		private var _es:EventSatellite;
		
		private var _craftPlateMakeBtn:CraftingPlateMakeButton;
		private var _craftPlateTotalBtn:CraftingPlateTotalButton;
		
		
		public function CraftingPlateView( _data:CraftingPlateData, _controller:CraftingPlateController ) 
		{
			_craftPlate = new CraftingUIPlate;
			addChild(_craftPlate);
			
			_craftPlateData = _data;
			_craftPlateController = _controller;
			
			_es = EventSatellite.getInstance();
			
			_materialsAry = new Array();
			
			initUI();
		}
		
		private function initUI():void
		{
			initMainObjectUI();
			initMaterialsUI();
			initButtons();
			addListeners();
		}
		
		private function initMainObjectUI():void
		{
			_craftMainImage = new BoxDataHolder(
												_craftPlateData.id,		// id
												_craftPlateData.icon,	// url
												"",//_craftPlateData.desc,	// title, commented because the plate title is now applied on the main plate title_txt text container
												100,					// max quantity
												0,						// current quantity
												'main',					// main
												0						// star value
												);
												
			//-------------------------------
			// Initialize Plate Title
			//-------------------------------
			_craftPlate.title_txt.text = String( _craftPlateData.desc );
			
			_craftMainImage.x = 55;
			_craftMainImage.y = 10;

			addChild( _craftMainImage );
			_craftMainImage.container.amtDisplay.text = String( _craftPlateData.stack );
		}
		
		//------------------------------------//
		//	Initialize Materials List	      //
		//------------------------------------//
		private function initMaterialsUI():void
		{
			var _startX:int = 215;
			var _startY:int = 35;
			
			for (var j:int = 0; j < _craftPlateData.totalCraftObjects; j++ )
			{
				var _txt:String = _craftPlateData.materialList.craftItemForceCraft[j];
				var _i:int = _txt.indexOf('_');
				var _val:int = parseInt(_txt.slice((_i + 1), _txt.length));
				
				var _craftItemBox:BoxDataHolder = new BoxDataHolder(
																	_craftPlateData.materialList.craftItemID[j],		// id
																	_craftPlateData.materialList.craftItemIcon[j],		// url
																	( 'material_' + j ),								// title
																	_craftPlateData.materialList.craftItemMaxQty[j],	// max quantity
																	_craftPlateData.materialList.craftItemHaveQty[j],	// current quantity user have
																	'craft',											// material/craft
																	_val												// star value
																	);
				addChild( _craftItemBox );
				_craftItemBox.name = _craftPlateData.plateName + "_Material_" + j;
				_craftItemBox.x = _startX;
				_craftItemBox.y = _startY;
				
				_startX += 110;
				
				_materialsAry.push( _craftItemBox );
			}
		}
		
		private function initButtons():void
		{			
			if ( _craftPlateData.craftQuantity < 1 )
			{
				// _craftPlateMakeBtn.visible = false;
				_craftPlateTotalBtn = new CraftingPlateTotalButton;
				_craftPlateTotalBtn.x = 60;
				_craftPlateTotalBtn.y = 100;
				_craftPlateTotalBtn.name = 'CraftPlateTotalBtn_' + _craftPlateData.counter;
				addChild( _craftPlateTotalBtn );
				
				_craftPlateTotalBtn.gotoAndStop(1);
				_craftPlateTotalBtn.buttonMode = true;
				
				_craftPlateTotalBtn.addEventListener(MouseEvent.MOUSE_OVER, _craftPlateController.buttonOver );
				_craftPlateTotalBtn.addEventListener(MouseEvent.MOUSE_OUT, _craftPlateController.buttonOut );
				_craftPlateTotalBtn.addEventListener(MouseEvent.MOUSE_DOWN, _craftPlateController._craftPlateTotalBtnPress );
				
				var _str:String = String( _craftPlateData.forceCraft );
				var _i:int = _str.indexOf('_');
				var _starPt:String = _str.slice((_i+1), _str.length);
				
				_craftPlateTotalBtn.caption_txt.text = String( _starPt );
			}
			else
			{
				_craftPlateMakeBtn = new CraftingPlateMakeButton;
				_craftPlateMakeBtn.x = 60;
				_craftPlateMakeBtn.y = 100;
				_craftPlateMakeBtn.name = 'CraftPlateMakeBtn_' + _craftPlateData.counter;
				addChild( _craftPlateMakeBtn );
				
				_craftPlateMakeBtn.gotoAndStop( 1 );
				_craftPlateMakeBtn.buttonMode = true;
				
				_craftPlateMakeBtn.addEventListener(MouseEvent.MOUSE_OVER, _craftPlateController.buttonOver );
				_craftPlateMakeBtn.addEventListener(MouseEvent.MOUSE_OUT, _craftPlateController.buttonOut );
				_craftPlateMakeBtn.addEventListener(MouseEvent.MOUSE_DOWN, _craftPlateController._craftPlateMakeBtnPress );
			}
		}		
		
		
		
		private function addListeners():void
		{
			_es.addEventListener( CraftingPlateEvent.UPDATE_VIEW, _updateView );
		}
		
		private function _updateView(e:CraftingPlateEvent):void
		{
			trace('CraftingPlatyeView::_updateView');
			_craftMainImage.container.amtDisplay.text = String(_craftPlateData.stack);
			
			for (var i:int = 0; i < _materialsAry.length; i++ )
			{
				trace('_craftPlateData.materialList.craftItemHaveQty[' + i + ']=' + _craftPlateData.materialList.craftItemHaveQty[i] + ' / ' + '_craftPlateData.materialList.craftItemMaxQty[' + i + ']=' + _craftPlateData.materialList.craftItemMaxQty[i]);
				_materialsAry[i].container.amtDisplay.text =  String(_craftPlateData.materialList.craftItemHaveQty[i]) + '/' + String(_craftPlateData.materialList.craftItemMaxQty[i]);
			}
		}
		
		
		public function removeComponents():void
		{
			/*
			if ( _craftPlateMakeBtn != null ) {
				removeChild( _craftPlateMakeBtn );
			}
			
			if ( _craftMainImage != null ) {
				removeChild( _craftMainImage );
			}
			*/
			
			/*
			if ( _craftPlateTotalBtn != null )
			{
				removeChild( _craftPlateTotalBtn );
			}
			
			if ( _craftPlateMakeBtn != null )
			{
				removeChild( _craftPlateMakeBtn );
			}
			*/
			
			while (_materialsAry.length > 0)
			{
				removeChild(_materialsAry.pop());
			}
			
			_materialsAry = new Array();
		}
		
		
	}
	
	
	
	
	
	
	

}