package com.surnia.socialStar.crafting.components.plate.data 
{
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.components.plate.event.CraftingPlateEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	
	/**
	 * @author Windz
	 */
	
	public class CraftingPlateData extends EventDispatcher 
	{
		private var _es:EventSatellite;
		
		private var _plateName:String;
		
		private var _id:String;
		private var _desc:String;
		private var _reqLvl:String;
		private var _icon:String;
		private var _stack:int;
		private var _forceCraft:String;
		private var _rewardCat:String;
		private var _rewardId:String;
		private var _category:String;
		private var _materialList:Object;
		private var _counter:int;
		
		private var _totalCraftObjects:int;
		private var _craftQuantity:int;
		
		
		
		public function CraftingPlateData( _craftObjectData:Object )
		{
			_es = EventSatellite.getInstance();
			_plateName = _craftObjectData.plateName;
			
			_id = String(_craftObjectData.id);
			_desc = String(_craftObjectData.desc);
			_reqLvl = String(_craftObjectData.reqLvl);
			_icon = String(_craftObjectData.icon);
			_stack = parseInt(_craftObjectData.stack);
			_forceCraft = String(_craftObjectData.forceCraft);			
			_rewardCat = String(_craftObjectData.rewardCat);
			_rewardId = String(_craftObjectData.rewardId);
			_category = String(_craftObjectData.category);
			_materialList = _craftObjectData.materialList;
			_counter = _craftObjectData.counter;
			_totalCraftObjects = _craftObjectData.totalCraftObjects;
			
			/*
			trace('_id=' + _id);
			trace('_desc=' + _desc);
			trace('_reqLvl=' + _reqLvl);
			trace('_icon=' + _icon);
			trace('_stack=' + _stack);
			trace('_forceCraft=' + _forceCraft);
			trace('_rewardCat=' + _rewardCat);
			trace('_rewardId=' + _rewardId);
			trace('_category=' + _category);
			trace('_materialList=' + _materialList);
			trace('_counter=' + _counter);			
			trace('_totalCraftObjects=' + _totalCraftObjects);
			*/
			
			_craftQuantity = getCraftQuantity();
			
			addEventListener( CraftingPlateEvent.INCREASE_DATA_QUANTITY, _increaseDataQuantity );
			addEventListener( CraftingPlateEvent.DECREASE_DATA_QUANTITY, _decreaseDataQuantity );
			
			// _es.addEventListener( CraftingPlateEvent.INCREASE_DATA_QUANTITY, _increaseDataQuantity );
			// _es.addEventListener( CraftingPlateEvent.DECREASE_DATA_QUANTITY, _decreaseDataQuantity );
		}
		
		
		public function get plateName():String
		{
			return _plateName;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get desc():String
		{
			return _desc;
		}
		
		public function get reqLvl():String
		{
			return _reqLvl;
		}
		
		public function get icon():String
		{
			return _icon;
		}
		
		public function get stack():int
		{
			return _stack;
		}
		
		public function set stack( value:int ):void
		{
			trace('\nCraftingPlateData::stack');
			if ( _craftQuantity > 0 )
			{
				_craftQuantity--;
				_stack++;
				decreaseDataQuantity();
				
				dispatchEvent( new CraftingPlateEvent( CraftingPlateEvent.UPDATE_VIEW, true ) );
				
				// var _cpEvt:CraftingPlateEvent = new CraftingPlateEvent( CraftingPlateEvent.UPDATE_VIEW );
				// _es.dispatchESEvent( _cpEvt );
			}
			else
			{
				trace( '\nCraftingPlateData->stack, you do not have enough materials' );
			}
		}
		
		public function get forceCraft():String
		{
			return _forceCraft;
		}
		
		public function get rewardCat():String
		{
			return _rewardCat;
		}
		
		public function get rewardId():String
		{
			return _rewardId;
		}
		
		public function get category():String
		{
			return _category;
		}
		
		public function get materialList():Object
		{
			return _materialList;
		}
		
		public function get totalCraftObjects():int
		{
			return _totalCraftObjects;
		}
		
		public function get counter():int
		{
			return _counter;
		}
		
		public function get craftQuantity():int
		{
			return _craftQuantity;
		}
		
		public function set craftQuantity( value:int ):void
		{
			trace('CraftingPlateData::craftQuantity');
		}
		
		private function getCraftQuantity():int
		{
			trace('\nCraftingPlateData::getCraftQuantity');
			
			var _qty:int = 0;
			var _highestLen:int = getHighestLength();
			
			for (var i:int = 1; i <=  _highestLen; i++ )
			{
				var str:String = "";
				var str2:String = "";
				
				for (var j:int = 0; j < totalCraftObjects; j++ )
				{
					str += "1";
					// trace('haveQty='+materialList.craftItemHaveQty[j]+'&maxQty='+( materialList.craftItemMaxQty[j] * i   ));
					
					//trace('CraftingPlateData::getCraftQuantity, _str2=' + str2);
					str2 += String(_materialList.craftItemHaveQty[j] / ( _materialList.craftItemMaxQty[j] *  i   ));
					
					//trace('CraftingPlateData::getCraftQuantity, str=' + str + '&str2=' + str2);
					//trace('CraftingPlateData::getCraftQuantity, _materialList.craftItemHaveQty[' + j + ']=' + _materialList.craftItemHaveQty[j]);
					//trace('CraftingPlateData::getCraftQuantity, _materialList.craftItemMaxQty[' + j + ']=' + materialList.craftItemMaxQty[j]);
					//trace('CraftingPlateData::getCraftQuantity, str2=' + _materialList.craftItemHaveQty[j] / ( _materialList.craftItemMaxQty[j] *  i   ));
					
					if (str.length == totalCraftObjects)
					{
						if (parseInt(str2) >= parseInt(str))
						{
							_qty++;
						}
					}
				}
				// trace('\n');
			}
			
			trace('CraftingPlateData::getCraftQuantity, qty=' + _qty);
			// trace('\n');
			return _qty;
		}
		
		//------------------------------------------
		// returns the highest length
		//------------------------------------------
		private function getHighestLength():int
		{			
			var _hl:Number = 0;
			for (var i:int = 0; i < totalCraftObjects; i++ )
			{
				// trace('id=' + _craftPlateData.materialList.craftItemID[i]);
				// trace('icon url=' + _craftPlateData.materialList.craftItemIcon[i]);
				// trace('item required quantity=' + _craftPlateData.materialList.craftItemMaxQty[i]);
				// trace('item current quantity=' + _craftPlateData.materialList.craftItemHaveQty[i]);
				
				if (_hl < ( _materialList.craftItemHaveQty[i] / _materialList.craftItemMaxQty[i] ))
				{ 
					_hl = _materialList.craftItemHaveQty[i] / _materialList.craftItemMaxQty[i]; 
				}
				
			}
			return _hl;
		}
		
		private function increaseDataQuantity():void
		{
			_craftQuantity++;
			for (var i:int = 0; i < totalCraftObjects; i++ )
			{
				_materialList.craftItemHaveQty[i] += _materialList.craftItemMaxQty[i];
			}
			
			trace('\nCraftingPlateData::increaseDataQuantity');
			trace('_craftQuantity=' + _craftQuantity);
			
			/*var _craftEvent:CraftingPlateEvent = new CraftingPlateEvent( CraftingPlateEvent.UPDATE_VIEW );
			_es.dispatchESEvent( _craftEvent );*/
			
			var _e:CraftingEvent = new CraftingEvent( CraftingEvent.RESET_ALL );
			_es.dispatchESEvent( _e );
		}
		
		private function decreaseDataQuantity():void
		{
			_craftQuantity--;
			//trace('Crafting Plate Data::decreaseDataQuantity');
			for (var i:int = 0; i < totalCraftObjects; i++ )
			{
				// trace('_materialList.craftItemHaveQty[' + i + ']=' + _materialList.craftItemHaveQty[i] + ' - _materialList.craftItemMaxQty[' + i + ']=' + _materialList.craftItemMaxQty[i]);
				_materialList.craftItemHaveQty[i] -= _materialList.craftItemMaxQty[i];
			}
			
			trace('\nCraftingPlateData::decreaseDataQuantity');
			trace('_craftQuantity=' + _craftQuantity);
			
			ServerDataController.getInstance().buyMaterial( String( _id ) );
			
			var _craftEvent:CraftingPlateEvent = new CraftingPlateEvent( CraftingPlateEvent.UPDATE_VIEW );
			_es.dispatchESEvent( _craftEvent );
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		//	EVENT HANDLERS
		//-----------------------------------------------------------------------------------------------------------------------------
		private function _increaseDataQuantity(e:CraftingPlateData):void
		{
			// _es.removeEventListener( CraftingPlateEvent.INCREASE_DATA_QUANTITY, _increaseDataQuantity );
			increaseDataQuantity();
		}
		
		private function _decreaseDataQuantity(e:CraftingPlateData):void
		{
			// _es.removeEventListener( CraftingPlateEvent.DECREASE_DATA_QUANTITY, _decreaseDataQuantity );
			decreaseDataQuantity();
		}		
		
	}

}