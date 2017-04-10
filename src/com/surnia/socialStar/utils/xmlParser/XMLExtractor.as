package com.surnia.socialStar.utils.xmlParser 
{	
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class XMLExtractor extends EventDispatcher
	{
		/*---------------------------------------------------------------Constant--------------------------------------------*/		
		/*---------------------------------------------------------------Properties--------------------------------------------*/
		private var _xml:XML;
		private var _myLoader:URLLoader;
		private var _xmlExtractorEvent:XMLExtractorEvent;		
		/*---------------------------------------------------------------Constrcutor--------------------------------------------*/		
		public function XMLExtractor() 
		{
			
		}		
		/*---------------------------------------------------------------Methods--------------------------------------------*/
		public function extractXmlData( url:String ):void 
		{			
			//trace( "extract xml................. url to be extracted", url );
			_myLoader = new URLLoader();			
			_myLoader.load(new URLRequest(url) );
			_myLoader.addEventListener( Event.COMPLETE, onProcessXMLComplete );
			_myLoader.addEventListener( IOErrorEvent.IO_ERROR, onError );			
		}	
		
		
		/*---------------------------------------------------------------Setters--------------------------------------------*/
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		/*---------------------------------------------------------------Getters--------------------------------------------*/
		public function get xml():XML 
		{
			return _xml;
		}
		/*---------------------------------------------------------------EventHandlers--------------------------------------*/
		private function onProcessXMLComplete(e:Event):void {			
			try {
				_xml = new XML(e.target.data);
				_xml.ignoreWhite  = true;								
				_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_COMPLETE );
				_xmlExtractorEvent.obj = _xml;
				dispatchEvent( _xmlExtractorEvent );
			} catch (err:Error) {
				trace("Could not parse loaded content as XML:\n" + err.
				message);
				
				_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_FAILED );
				dispatchEvent( _xmlExtractorEvent );
			}			
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace( "XMLExtractor ioerror!!!..........." );
			_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_FAILED );
			dispatchEvent( _xmlExtractorEvent );
		}		
	}

}