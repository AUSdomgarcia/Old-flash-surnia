package com.surnia.socialStar.test 
{	
	import com.adobe.serialization.json.JSON;
	import com.surnia.socialStar.controllers.jsManager.JsManager;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class XmlExtractorTest extends Sprite
	{
		
		/*-------------------------------------------------------------------------------Constant-----------------------------------------------------------*/		
		
		/*-------------------------------------------------------------------------------Properties---------------------------------------------------------*/		
		private var _xmlExtractor:XMLExtractor;
		private var _xml:XML;
		private var _jsManager:JsManager;
		/*-------------------------------------------------------------------------------Constructor--------------------------------------------------------*/		
		
		
		public function XmlExtractorTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );					
		}	
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_xmlExtractor = new XMLExtractor(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed ); 
			//_xmlExtractor.extractXmlData( "http://monsterpatties.net/test/player2.xml" );
			//_xmlExtractor.extractXmlData( "http://202.124.129.14/surnia/data/fl");
			//_xmlExtractor.extractXmlData( "http://1.234.2.179/socialstardev/data/job/start/as4d87fsa76f/asfg57asd5f85dsa5" );			
			//_xmlExtractor.extractXmlData( "http://1.234.2.179/socialstardev/data/job/end/as4d87fsa76f/asfg57asd5f85dsa5" );
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/data/settings/bgm/0");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/data/settings/sfx/0");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/data/settings/bgx/0");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/data/settings");		
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/shop/officeitems");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/data/ap/");		
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/players/fl");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/game/newsfeed/sample");			
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/callback/askap");
			//_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/public/data/officeshop.xml");			
			
			var itemId:String = "fffasdasd698asd";
			_xmlExtractor.extractXmlData("http://1.234.2.179/socialstardev/offices/expand/"+ itemId );			
		}
		
		
		private function extractJsonEncodedData( data:* ):void 
		{
			//trace( "data complete...", JSON.decode( _loader.data ).name, JSON.decode( _loader.data ).last  );
			trace( "extract json" );
			
			var obj:Object = JSON.decode ( data );
			
			for ( var prop:* in obj ) 
			{
				trace( "see", prop, obj[ prop ] );
			}
			
			if ( prop =="ret" && obj[ prop ] == "true" ) {
				trace( "hiyaaaaaaaaahhhhh!!!!!!!! ^^)" );
				_jsManager = JsManager.getInstance();
				_jsManager.callJs( "makerequest", "1_Ask AP_askap" );
				//_jsManager.callJs( "alert", "1_Ask AP_askap" );
			}
		}
		/*-------------------------------------------------------------------------------Methods-----------------------------------------------------------*/		
		
		public function getOfficeItemData( itemId:String ):void 
		{
			var obj:Object;
			for each ( var a:* in _xml.deco.cabinet.item ) 
			{
				if ( itemId ==  a.@id ) {
					trace( "see ", a.@id );
					obj = new Object();
					obj.id = a.@id;
					obj.name = a.@name;
					obj.coin = a.@coin;
					obj.star = a.@ap;
					obj.sellprice = a.@sellprice;
					break;
				}
				
			}
			
			trace( "see me ",obj  );
		}
		
		/*-------------------------------------------------------------------------------Settters-----------------------------------------------------------*/		
		
		/*-------------------------------------------------------------------------------Getters-----------------------------------------------------------*/		
		
		/*-------------------------------------------------------------------------------Eventhandlers------------------------------------------------------*/		
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "failed xml........................." );
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{
			_xml = _xmlExtractor.xml;
			trace( "xml extraction successfull ^^)....", _xml, "ret", _xml.@ret, _xml.@rows, _xml.@cols );
			//trace( "xml extraction successfull....", _xml.deco.cabinet.item[ 0 ].@id );
			//trace( "xml extraction successfull....", _xml.tile.tile.item[ 0 ].@id );
			//trace( "xml extraction successfull....", _xml.children()[ 3 ].toXMLString() );
			//trace( "xml extraction successfull....", _xml.children().length() );			
			//trace( "xml extraction successfull....", _xml.child( "deco" ).cabinet.item.@id );
			//getOfficeItemData( "cjoltHOmggjAqsQfiMYV" );
			//extractJsonEncodedData( _xml );
			
			//_jsManager = JsManager.getInstance();
			//_jsManager.callJs( "newsfeed", _xml.@nf );
			//trace( _xml.item[ 0 ].@id );
			//trace( "xml extraction successfull....", _xml, "see", _xml.@bgm, _xml.@sfx, _xml.@gfx );
			//trace( "xml extraction successfull....", _xml, "see2", _xml.@bgm );
		}
	}

}