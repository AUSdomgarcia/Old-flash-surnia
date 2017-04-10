package com.surnia.socialStar.sceneHandler.data 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.sceneHandler.event.SceneHandlerEvent;
	import com.surnia.socialStar.ui.popUI.events.XMLEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	
	public class SceneHandlerData 
	{
		/*-------------------------------------
		 * PROPERTIES
		-------------------------------------*/
		private var _xml:XML;
		private var _xmlExtractor:XMLExtractor;
		private var _es:EventSatellite;
		
		private var _scene:Array;
		private var _sequence:Array;
		
		private var _currentSceneNumber:int;
		private var _currentSequenceNumber:int;
		
		private var _maxSceneNumber:int;
		private var _maxSequenceNumber:int;
		
		private var _buttonVisible:String;
		
		
		/*-------------------------------------
		 * CONSTRUCTOR
		-------------------------------------*/
		public function SceneHandlerData() 
		{
			_currentSceneNumber = 0;
			_currentSequenceNumber = 0;
			
			_es = EventSatellite.getInstance();
			
			
			_xmlExtractor = new XMLExtractor();
			
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, _onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, _onXMLExtractionFailed );
			
			_xmlExtractor.extractXmlData( 'testXML/scenehandler.xml' );
		}
		
		/*-------------------------------------
		 * XML Methods
		-------------------------------------*/
		private function _onXMLExtractionComplete(e:XMLExtractorEvent):void
		{
			//trace('xml=' + _xml.children()[0].children().length());
			//trace('speaker=' + _xml.scene.children()[0].@speaker );
			//trace('speaker=' + _xml.scene.children()[1].@speaker );
			//scenes->scene->npc
			
			_scene = new Array();
			
			_xml = _xmlExtractor.xml;
			
			//trace('scenes length='+_xml.scene.length());
			for (var i:int = 0; i < _xml.scene.length(); i++ )
			{
				//trace('npc length=' + _xml.scene[i].sequence.length());
				_sequence = new Array();
				for (var j:int = 0; j < _xml.scene[i].sequence.length(); j++ )
				{
					// trace('\navatar=' + _xml.scene[i].sequence[j].attributes()[0]);
					// trace('name=' + _xml.scene[i].sequence[j].attributes()[1]);
					// trace('script=' + _xml.scene[i].sequence[j].attributes()[2]);
					
					var attribObj:Object = new Object();
					for (var k:int = 0; k < _xml.scene[i].sequence[j].attributes().length(); k++ )
					{
						//trace('sequence[' + j + ']=' +_xml.scene[i].sequence[j].attributes().length());
						attribObj.id = _xml.scene[i].sequence[j].attributes()[0];
						attribObj.avatar = _xml.scene[i].sequence[j].attributes()[1];
						attribObj.name = _xml.scene[i].sequence[j].attributes()[2];
						attribObj.script = _xml.scene[i].sequence[j].attributes()[3];
						attribObj.coordinate = _xml.scene[i].sequence[j].attributes()[4];
					}					
					_sequence.push(attribObj);
				}
				_scene.push(_sequence);
			}
			
			
			var _sceneEvent:SceneHandlerEvent = new SceneHandlerEvent( SceneHandlerEvent.DATA_LOADED );
			_es.dispatchESEvent( _sceneEvent );
		}
		
		
		private function _onXMLExtractionFailed(e:XMLExtractorEvent):void
		{
			trace('SceneHandlerData::failed to load ' + 'testXML/scenehandler.xml' );
		}		
		
		
		public function get scene():Array
		{
			return _scene;
		}
		
		/*-----------------------------------------
		| NPC Attributes
		-----------------------------------------*/
		public function getNpcName( sceneNum:int, sequenceNum:int ):String
		{
			var _obj:Object = scene[sceneNum][sequenceNum];
			return _obj.name;
		}
		
		public function getNpcAvatar( sceneNum:int, sequenceNum:int ):String
		{
			var _obj:Object = scene[sceneNum][sequenceNum];
			return _obj.avatar;
		}
		
		public function getNpcScript( sceneNum:int, sequenceNum:int ):String
		{
			var _obj:Object = scene[sceneNum][sequenceNum];
			return _obj.script;
		}
		
		/*-----------------------------------------
		| Current Scene Methods
		-----------------------------------------*/
		public function get currentSceneNumber():int
		{
			return _currentSceneNumber;
		}
		
		public function set currentSceneNumber(value:int):void
		{
			// trace('CURRENT SCENE NUMBER=' + currentSceneNumber + ' & MAX SCENE NUMBER=' + maxSceneNumber);
			_currentSceneNumber = value;
			if (currentSceneNumber < maxSceneNumber)
			{
				currentSequenceNumber = 0;
				var _sceneEvent:SceneHandlerEvent = new SceneHandlerEvent( SceneHandlerEvent.CURRENT_SCENE_CHANGE );
				_es.dispatchESEvent( _sceneEvent );
			}
			else 
			{
				currentSceneNumber = 0;
				currentSequenceNumber = 0;
			}
		}
		
		/*-----------------------------------------
		| Current Sequence Methods
		-----------------------------------------*/
		public function get currentSequenceNumber():int
		{
			return _currentSequenceNumber;
		}
		
		public function set currentSequenceNumber(value:int):void
		{			
			_currentSequenceNumber = value;
			buttonVisible = 'continue_btn';
			
			// trace('_currentSequenceNumber=' + _currentSequenceNumber + '&currentSequenceNumber=' + currentSequenceNumber);
			// trace('&_maxSequenceNumber=' + _maxSequenceNumber + '&maxSequenceNumber=' + maxSequenceNumber);
			
			if (currentSequenceNumber < maxSequenceNumber)
			{
				if (currentSequenceNumber == maxSequenceNumber-1)
				{
					buttonVisible = 'done_btn';
				}
				var _sceneEvent:SceneHandlerEvent = new SceneHandlerEvent( SceneHandlerEvent.CURRENT_SEQUENCE_CHANGE );
				_es.dispatchESEvent( _sceneEvent );				
			}
			else
			{
				// ORIGINAL CODE
				//_currentSequenceNumber = maxSceneNumber-1;
				
				// TRIAL CODE
				currentSceneNumber++;
				currentSequenceNumber = 0;
			}
		}
		
		
		/*-----------------------------------------
		| FOR Max Scene and Sequence Values
		-----------------------------------------*/
		public function get maxSceneNumber():int
		{
			return _xml.scene.length();
		}
		
		public function get maxSequenceNumber():int
		{
			var value:int = _xml.scene[_currentSceneNumber].sequence.length();
			return value;
		}
		
		
		/*-----------------------------------------
		| FOR BUTTONS
		-----------------------------------------*/
		public function get buttonVisible():String
		{
			return _buttonVisible;
		}
		
		public function set buttonVisible( value:String ):void
		{
			_buttonVisible = value;
			var _sceneEvent:SceneHandlerEvent = new SceneHandlerEvent( SceneHandlerEvent.BUTTON_CHANGE );
			_es.dispatchESEvent( _sceneEvent );
		}
		
		
		
	}

}