package com.surnia.socialStar.ui.friendUI.controller 
{	
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.friendUI.config.FriendUIConfig;
	import com.surnia.socialStar.ui.friendUI.data.FriendUIData;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FriendUIController extends EventDispatcher
	{
		
		/*----------------------------------------------------------------------------------Constant------------------------------------------------------------*/
		private static var _instance:FriendUIController;
		
		/*----------------------------------------------------------------------------------Properties----------------------------------------------------------*/
		private var _friends:Array;
		private var _xmlExtractor:XMLExtractor;
		private var _friendUIEvent:FriendUIEvent;
		private var _xml:XML;		
		private var _gd:GlobalData = GlobalData.instance;
		/*----------------------------------------------------------------------------------Constrcutor---------------------------------------------------------*/
		
		
		public function FriendUIController( enforcer:SingletonEnforcer ) 
		{
			
		}
		
		public static function getInstance():FriendUIController 
		{
			if ( FriendUIController._instance == null ) {
				FriendUIController._instance = new FriendUIController( new SingletonEnforcer() );
			}
			
			return FriendUIController._instance;
		}
		
		/*----------------------------------------------------------------------------------Methods------------------------------------------------------------*/
		
		public function init():void 
		{
			prepareDataHolders();			
		}
		
		public function clearData():void 
		{
			_friends = new Array();
		}		
		
		
		private function prepareDataHolders():void 
		{
			_friends = new Array();
		}
		
		//public function extractFriendXMlData( url:String ):void 
		//{
		//trace( "url to be extract", url );
		//_xmlExtractor = new XMLExtractor(  );
		//
		//if ( FriendUIConfig.isLive ){				
		//_xmlExtractor.extractXmlData( url);				
		//}else {								
		//_xmlExtractor.extractXmlData( "http://monsterpatties.net/test/player2.xml" );
		//}			
		//_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
		//_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed );
		//}
		
		public function extactFriendInfo( xml:XML = null):void 
		{
			trace( "xml extraction successfull....", _xml );
			
			//if( xml == null ){
			//_xml = GlobalData.instance.friendsDataXML;
			//}else {
			//
			//}
			var runningOn:String = Capabilities.playerType;
			
			if( runningOn != 'StandAlone' ){
				_xml = GlobalData.instance.friendsDataXML;			
				trace( "xml extraction successfull....", GlobalData.instance.friendsDataXML , _xml.f[ 0 ].@fbid );
				
				var fLen:int = _xml.f.length();
				var friendData:FriendUIData;
				
				for (var i:int = 0; i < fLen; i++) 
				{
					friendData = new FriendUIData();
					friendData.fbId = _xml.f[ i ].@fbid;
					friendData.name = _xml.f[ i ].@name;
					trace( "[FriendUIController]: friendlist name", _xml.f[ i ].@name, "index", i );
					friendData.imageUrl = _xml.f[ i ].@pic;
					friendData.level = _xml.f[ i ].@lvl;
					friendData.me = int( _xml.f[ i ].@me );
					
					friendData.he = int( _xml.f[ i ].@he );
					friendData.bug = int( _xml.f[ i ].@bug );
					friendData.boo = int( _xml.f[ i ].@boo );
					
					if ( friendData.me == 1  ) {
						GlobalData.instance.myFbId = friendData.fbId;
						GlobalData.instance.officeId = friendData.fbId;
						trace( "my fb id loaded...............", GlobalData.instance.myFbId );
					}
					
					_friends.push( friendData );
					//trace( _friends[ i ].fbId,_friends[ i ].name, _friends[ i ].imageUrl  );
					//trace( "Friend controller# ", i, ": ", _xml.friend[ i ].@fbid,  _xml.friend[ i ].@name, _xml.friend[ i ].@pic );				
				}			
				
				_friendUIEvent = new FriendUIEvent( FriendUIEvent.FRIENDS_DATA_READY );	
				dispatchEvent( _friendUIEvent );
				trace( "end friend UI Controller................................." );
			}
		}
		
		/*----------------------------------------------------------------------------------Setters------------------------------------------------------------*/
		public function set friends(value:Array):void 
		{
			_friends = value;
		}
		
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		/*----------------------------------------------------------------------------------Getters------------------------------------------------------------*/
		public function get friends():Array { return _friends; }
		
		public function get xml():XML 
		{
			return _xml;
		}		
		/*----------------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "xml extraction failed!....friendList" );
		}
		
		//private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		//{			
		//_xml = _xmlExtractor.xml;			
		//}
	}
}


class SingletonEnforcer {}