package com.surnia.socialStar.utils.miniGameServerCall 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.utils.miniGameServerCall.data.ContestantModel;
	import com.surnia.socialStar.utils.miniGameServerCall.events.MiniGameServerCallEvent;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author ...
	 */
	public class MiniGameServerCall
	{
		
		/*-------------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Properties-----------------------------------------------------------*/
		private var _miniGameServerCallEvent:MiniGameServerCallEvent;
		private var _es:EventSatellite;
		/*-------------------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		public function MiniGameServerCall() 
		{
			
		}
		
		/*-------------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		
		public function getMiniGameData(  ):void 
		{			
			//http://1.234.2.179/socialstardev/game/getminigamedata
			_es = EventSatellite.getInstance();
			_xmlExtractor = new XMLExtractor(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onGetMiniGameDataComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onGetMiniGameDataFailed );
			_xmlExtractor.extractXmlData( "http://1.234.2.179/socialstardev/game/getminigamedata" );
		}		
		
		/*-------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		private function onGetMiniGameDataFailed(e:XMLExtractorEvent):void 
		{
			_miniGameServerCallEvent = new MiniGameServerCallEvent( MiniGameServerCallEvent.QUEST_DATA_LOADED_FAILED );
			_es.dispatchESEvent( _miniGameServerCallEvent );
		}
		
		private function onGetMiniGameDataComplete(e:XMLExtractorEvent):void 
		{
			_xml = _xmlExtractor.xml;
			if ( _xml != null ){
				if ( _xml.@ret == "true" ) {
					
					var obj:Object = new Object();
					obj.finalstring = _xml.@finalstring;					
					
					/*
					 202001040203002000000000000000000000000000002001010120202020202020000000000000002020202020200000000000000000000000000000030
					 4000000000000000000000000000000000000f8f4afcec43c775AA4775AA4FADCCCC67A6494CDD760B0B84A69A64A68A4C67A64C67A64F19D88F19D8879
					 57344637331f50291f50297232c67232c6ef83caef83caD44A6090313D_17_16_18_16_10_1373812866;02020402030300040400000000000000000000
					 00040101040204010402020101010000000000000003020404030301020000000000000000000000000402000000000000000000000000000000000000F
					 16038883632D7789FD7789FFADCCCC67A64EED7E03F36564A69A64A68A46E372E6E372EF8BAD1FAC9C9EED7E0C190A4df146adf146a235dac235dacab26
					 feab26feE5F5F960B0B8_16_12_13_15_15_700186557					  
					 */ 
					var str:String = obj.finalstring;
					var mainArr:Array = str.split(";");								
					
					var myContestantArr:String = mainArr[ 0 ];
					var friendContestantArr:String = mainArr[ 1 ];
					
					var myContestant:Array = myContestantArr.split("_");
					var myFriendContestant:Array = friendContestantArr.split("_");
					
					//var myContestant:ContestantModel = new ContestantModel();			
					 
					_miniGameServerCallEvent = new MiniGameServerCallEvent( MiniGameServerCallEvent.QUEST_DATA_LOADED_COMPLETE );
					//dispatchEvent( _miniGameServerCallEvent );
					_es.dispatchESEvent( _miniGameServerCallEvent, obj );
				}else {
					_miniGameServerCallEvent = new MiniGameServerCallEvent( MiniGameServerCallEvent.QUEST_DATA_LOADED_FAILED );
					_es.dispatchESEvent( _miniGameServerCallEvent );
				}
			}else {
				_miniGameServerCallEvent = new MiniGameServerCallEvent( MiniGameServerCallEvent.QUEST_DATA_LOADED_FAILED );
				_es.dispatchESEvent( _miniGameServerCallEvent );
			}
		}
	}

}