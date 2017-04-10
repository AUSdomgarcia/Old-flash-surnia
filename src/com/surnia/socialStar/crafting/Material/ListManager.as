package com.surnia.socialStar.crafting.Material 
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.crafting.data.ItemData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.data.GlobalData;
	import flash.system.Capabilities;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	
	/**
	 * ...
	 * @author dHOMZKIe
	 */	 
	
	public class ListManager extends Sprite
	{
		private var _es:EventSatellite;
		private var _runningOn:String;
		
		private var sprt:Sprite;
		public var canvass:MovieClip;
	
		private var boxBase_arr:Array;
		private var boxBase:BoxBlueBase;
		private var sprtBoxBase:Sprite;
		private var materialLen:Number;
		
		private var _idList:Array;
		private var _nameList:Array;
		private var _picList:Array;
		private var _qtyList:Array;
		
		private var _tester:int;
		private var _gd:GlobalData;
		
		private var materialsList:Array;
		
		
		//private var bDataClass:BoxDataHolder;
		private var boxData:Array = [];
		private var sample:Array = [
									"df", "domz", "jan", "rez", "churva",
									"title6", "title7", "title8", "title9", "title0",
									"title11", "title12", "title13", "title14", "title15",
									"title16", "title17", "title18", "title19", "title20",
									"title21", "title22", "title23", "title24", "title25",
									"title26", "title27", "title28", "title29", "title30"
									];
									
									
									
		public function ListManager() 
		{
			_es = EventSatellite.getInstance();
			_runningOn = Capabilities.playerType;
			
			_es.addEventListener( SSEvent.MATERIALLISTXML_LOADED, _onMaterialXmlLoaded );
			
			_idList = new Array();;
			_nameList = new Array();
			_picList = new Array();
			_qtyList = new Array();
			
			sprt = new Sprite();
			boxBase_arr = new Array;
			boxBase = new BoxBlueBase;
			sprtBoxBase = new Sprite;
			materialLen = 0;
			boxData = new Array;
			
			_runningOn = Capabilities.playerType;
			
			if ( _runningOn != 'StandAlone' )
			{
				//_isOnline = true;
				loadOnlineXML();
			}
			else 
			{
				//_isOnline = false;
				loadOfflineXML();
			}
		}
		
		private function loadOnlineXML():void
		{
			trace('ListManager->loadOnlineXML');
			ServerDataExtractor.instance.updateData( GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.onlineMaterialListData );
		}
		
		private function loadOfflineXML():void
		{
			trace('ListManager->loadOfflineXML');
			ServerDataExtractor.instance.updateData( GlobalData.MATERIALLIST_DATA, XMLLinkData.instance.offlineMaterialListData );
		}
		
		private function _onMaterialXmlLoaded( e:SSEvent ):void 
		{
			trace('\nMaterialData::_onMaterialXmlLoaded');
			_tester += 1;
			
			trace('ListManager::_tester=' + _tester);
			
			_es.removeEventListener( SSEvent.COLLECTIONLISTXML_LOADED, _onMaterialXmlLoaded );
			
			_gd = GlobalData.instance;
			
			/*
			_materialDataLength = GlobalData.instance.materialListDataArray.length;
			for (var i:int = 0; i < _materialDataLength; i++ )
			{
				_idList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_ID]);
				_nameList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_NAME]);
				_picList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_PIC]);
				_qtyList.push(GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_QTY]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_ID]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_ID]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_NAME]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_NAME]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray['+i+'][GlobalData.MATERIALLIST_PIC]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_PIC]);
				trace('MaterialData->_onMaterialXmlLoaded, GlobalData.instance.materialListDataArray[' + i + '][GlobalData.MATERIALLIST_QTY]=' + GlobalData.instance.materialListDataArray[i][GlobalData.MATERIALLIST_QTY]);
			}
			*/
			
			materialLen = _gd.materialListDataArray.length;
			
			if ( _tester < 2 )
			{
				canvass = new MovieClip();
				materialsList = new Array();
				
				var row:Number = 0;
				var col:Number = 0;
				
				if ( materialLen > 0 )
				{			
					for (var i:int = 0; i < materialLen; i++) 
					{
						trace('MaterialData->_onMaterialXmlLoaded, _gd.materialListDataArray[' + i + '][GlobalData.MATERIALLIST_ID]=' 
						+ _gd.materialListDataArray[i][GlobalData.MATERIALLIST_ID]);
						trace('MaterialData->_onMaterialXmlLoaded, _gd.materialListDataArray[' + i + '][GlobalData.MATERIALLIST_NAME]=' 
						+ _gd.materialListDataArray[i][GlobalData.MATERIALLIST_NAME]);
						trace('MaterialData->_onMaterialXmlLoaded, _gd.materialListDataArray[' + i + '][GlobalData.MATERIALLIST_PIC]=' 
						+ _gd.materialListDataArray[i][GlobalData.MATERIALLIST_PIC]);
						trace('MaterialData->_onMaterialXmlLoaded, _gd.materialListDataArray[' + i + '][GlobalData.MATERIALLIST_QTY]=' 
						+ _gd.materialListDataArray[i][GlobalData.MATERIALLIST_QTY]);
						
						var bDataClass:BoxDataHolder = new BoxDataHolder(
																			_gd.materialListDataArray[i][GlobalData.MATERIALLIST_ID], // ID
																			_gd.materialListDataArray[i][GlobalData.MATERIALLIST_PIC], // URL
																			_gd.materialListDataArray[i][GlobalData.MATERIALLIST_NAME], // title
																			0, // max quantity
																			_gd.materialListDataArray[i][GlobalData.MATERIALLIST_QTY] , // current quantity
																			"material", // material or craft or main
																			0  // star value
																		);
																		
						bDataClass.boxMC.x = col * ( bDataClass.boxMC.width + 8 );
						bDataClass.boxMC.y = row * ( bDataClass.boxMC.height + 25 );
						canvass.addChild( bDataClass );
						materialsList.push( bDataClass );	
						
						col++;						
						
						if (col > 5 && materialLen - 1)
						{
							col = 0;
							row++;
						}				
					}
					
					addItem();
				}
			}
		}
		
		private function _onMaterialDataUpdated( e:Event ):void
		{
			//trace('\nListManager->_onMaterialDataUpdated');		
			//materialLen = _materialData.length;
			//onLoaded();
		}
		
		/*
		private function onLoaded():void 
		{
			trace('\nListManager->onLoaded');
			var row:Number = 0;
			var col:Number = 0;
			
			for (var i:int = 0; i < _materialData.length; i++) 
			{
				trace('ListManager::BoxDataHolder, parameters:' + 'counter=' + "000" + i + '&pic=' + _materialData.picList[i] + '&name=' + _materialData.nameList[i]);
				var bDataClass:BoxDataHolder = new BoxDataHolder(("000" + i), _materialData.picList[i], _materialData.nameList[i], i, 1 , "material", 3 );
				
				bDataClass.boxMC.x = col * ( bDataClass.boxMC.width + 8 );
				bDataClass.boxMC.y = row * ( bDataClass.boxMC.height + 25 );
				sprt.addChild( bDataClass );
				boxData.push( bDataClass );			
				
				col++;
				
				
				boxBase = new BoxBlueBase();
				boxBase_arr.push( boxBase );
				boxBase_arr[row].y = row * 118;
				sprtBoxBase.addChild( boxBase_arr[row] );
				
				
				if (col > 5 && materialLen - 1)
				{
					col = 0;
					row++;
				}				
			}		
			addItem();
		}
		*/
		
		private function addItem():void 
		{
			//sprt.x = canvass.x + 60;
			//sprt.y = canvass.y + 150;
			
			//sprt.x = 35;
			//sprt.y = 5;
			
			/*
			sprtBoxBase.y = sprt.y - 8;
			sprtBoxBase.x = sprt.x - 30;
			*/
			
			//canvass.addChild( sprtBoxBase );
			
			//canvass.addChild( sprt );			
			
			canvass.x = 35;
			canvass.y = 5;
			
			addChild( canvass );
			
			var _e:CraftingEvent = new CraftingEvent( CraftingEvent.UPDATE_MATERIAL_VIEW );
			_es.dispatchESEvent( _e );
		}
		
		public function removeItems():void 
		{
			/*
			for (var i:int = 0; i < boxBase_arr.length; i++) 
			{
				if ( boxBase_arr[i] != null ) 
				{
					this.removeChild( boxBase_arr[i] );
					boxBase_arr.splice( i , 1 );
				}
			}
			
			for (var j:int = 0; j < boxData.length; j++) 
			{
				boxData[j].removeItem();
			}
			
			if (canvass != null)
			{
				removeChild( canvass );
			}
			*/
			
			while ( boxBase_arr.length < 0 )
			{
				sprtBoxBase.removeChild( boxBase_arr.pop() );
			}
			
			while (boxData.length > 0)
			{
				sprt.removeChild( boxData.pop() );
			}
			
			/*
			if ( sprtBoxBase != null )
			{
				canvass.removeChild( sprtBoxBase );
			}
			*/
			
			if ( sprt != null )
			{
				canvass.removeChild( sprt );
			}
			
			if (canvass != null) 
			{
				removeChild( canvass );
			}
		}
		
		private function onCurrentIndex( e:MouseEvent ):void 
		{
			for (var i:int = 0; i < boxData.length; i++) 
			{	
				if ( e.currentTarget == boxData[i])
				{
					trace( boxData[i].title );
				}
			}
		}
		
		public function get listLength():Number
		{
			return materialLen / 6;
		}
		
		
		
		
	//end	
	}
}