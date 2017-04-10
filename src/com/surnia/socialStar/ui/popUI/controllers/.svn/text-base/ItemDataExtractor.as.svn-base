package com.surnia.socialStar.ui.popUI.controllers 
{		
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.data.ShopItemData;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ItemDataExtractor extends EventDispatcher
	{
		
		/*----------------------------------------------------------------------------------Constant------------------------------------------------------------*/
		private static var _instance:ItemDataExtractor;
		
		/*----------------------------------------------------------------------------------Properties----------------------------------------------------------*/
		private var _shopItems:Array;
		private var _xmlExtractor:XMLExtractor;
		private var _popUIEvent:PopUIEvent;
		private var _xml:XML;		
		/*----------------------------------------------------------------------------------Constrcutor---------------------------------------------------------*/
		
		
		public function ItemDataExtractor( enforcer:SingletonEnforcer ) 
		{
			
		}
		
		public static function getInstance():ItemDataExtractor 
		{
			if ( ItemDataExtractor._instance == null ) {
				ItemDataExtractor._instance = new ItemDataExtractor( new SingletonEnforcer() );
			}
			
			return ItemDataExtractor._instance;
		}
		
		/*----------------------------------------------------------------------------------Methods------------------------------------------------------------*/
		
		public function init():void 
		{
			clearData();
			
		}
		
		public function clearData():void 
		{
			_shopItems = new Array();
		}	
		
		public function extractXMlData( url:String ):void 
		{
			trace( "url to be extract", url );
			_xmlExtractor = new XMLExtractor(  );
			
			if ( WindowPopUpConfig.isLive ) {				
				_xmlExtractor.extractXmlData( url);				
			}else {								
				//"http://monsterpatties.net/test/mallItem.xml"
				_xmlExtractor.extractXmlData( url );
			}					
			
			//_xmlExtractor.extractXmlData( "http://202.124.129.14/surnia/public/fb/fl.php" );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed );
		}		
		
		/*----------------------------------------------------------------------------------Setters------------------------------------------------------------*/
		
		
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		
		public function set shopItems(value:Array):void 
		{
			_shopItems = value;
		}
		/*----------------------------------------------------------------------------------Getters------------------------------------------------------------*/
		
		
		public function get xml():XML 
		{
			return _xml;
		}		
		
		public function get shopItems():Array 
		{
			return _shopItems;
		}
		
		
		/*----------------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "xml extraction failed!...." );
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{			
			_xml = _xmlExtractor.xml;
			trace( "xml extraction successfull....", _xml );
			
			var fLen:int = _xml.item.length();
			for (var i:int = 0; i < fLen; i++) 
			{				
				var shopItemData:ShopItemData = new ShopItemData();
				shopItemData.itemId = _xml.item[ i ].@id;
				shopItemData.itemName = _xml.item[ i ].@name;
				shopItemData.itemEffect = _xml.item[ i ].@effect;
				shopItemData.itemDesc = _xml.item[ i ].@desc;
				_shopItems.push( shopItemData );
				//trace( _shopItems[ i ].itemId,_shopItems[ i ].itemName, _shopItems[ i ].itemEffect, _shopItems[ i ].itemDesc  );
				//trace( "Friend controller# ", i, ": ", _xml.friend[ i ].@fbid,  _xml.friend[ i ].@name, _xml.friend[ i ].@pic );				
			}
			
			_popUIEvent = new PopUIEvent( PopUIEvent.SHOP_ITEM_DATA_READY );
			dispatchEvent( _popUIEvent );			
		}
	}
}


class SingletonEnforcer {}