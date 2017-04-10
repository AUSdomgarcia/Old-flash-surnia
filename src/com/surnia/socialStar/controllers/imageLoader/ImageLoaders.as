package com.surnia.socialStar.controllers.imageLoader 
{
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import com.surnia.socialStar.utils.assetLoader.ImageAssetLoader;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ImageLoaders extends Sprite
	{
		
		/*-------------------------------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Properties--------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Constructor-------------------------------------------------------*/
		
		private static var _instance:ImageLoaders;		
		private var _xmlExtractor:XMLExtractor;
		private var _loader:ImageAssetLoader;
		
		private var _dict:Array;
		private var _urlQueue:Array;
		private var _isLoading:Boolean;
		
		private var _currentLoadedUrl:String;
		private var _currentLoadedImageId:String;
		private var _gd:GlobalData = GlobalData.instance;
		
		public function ImageLoaders( enforcer:SingletonEnforcer ) 
		{			
			prepareStorage();
		}		
		
		public static function getInstance():ImageLoaders {
			if ( ImageLoaders._instance == null ) {
				ImageLoaders._instance = new ImageLoaders( new SingletonEnforcer() );
			}
			//trace( "es get instance" );
			return ImageLoaders._instance;			
		}
		
		/*-------------------------------------------------------------------------------Methods----------------------------------------------------------*/
		
		public function extractXml( url:String ):void 
		{
			trace( "extract office item images........................" );
			_xmlExtractor = new XMLExtractor(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed ); 			
			_xmlExtractor.extractXmlData( _gd.absPath + "public/data/officeitemlinks.xml" );						
		}
		
		public function extractXmlByid( id:String ):void 
		{
			if( id != null  ){
				var url:String = _gd.absPath + "game/fetchpic/" + id;
				_urlQueue.push( url );
				
				if ( !_isLoading ){
					if ( !searchId( id ) ) {			
						trace( "[imageloaded]: img is not on the quee it will downloaded now" );
						_isLoading = true;
						_xmlExtractor = new XMLExtractor(  );
						_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractQuestGraphicComplete );
						_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractQuestGraphicFailed ); 			
						trace( "[ImageLoader] loading image url", _urlQueue[ 0 ] );
						_xmlExtractor.extractXmlData( _urlQueue[ 0 ] );	
						//https://202.124.129.14/socialstars/game/fetchpic/qicon003			
					}else {
						var imageLoaderEvent:ImageLoaderEvent = new ImageLoaderEvent( ImageLoaderEvent.IMAGE_LOADED );
						imageLoaderEvent.obj.id = id;
						dispatchEvent( imageLoaderEvent );						
						//_urlQueue.shift();
						_isLoading = false;
						trace( "[imageloaded]: img is already on the quee you can get it now" );
					}
				}else {
					trace( "[ImageLoader] still loading image url", _urlQueue[ 0 ] );
					trace( "[ImageLoader] new image url will be qeue", url );
				}
			}else {
				trace( "[Imageloader]: will not load anything id to be extract null" );
			}			
		}		
		
		private function loadAsset( url:String , id:String):void 
		{			
			_loader = new ImageAssetLoader();
			_loader.loadImage( url, true, false, "",id );			
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onLoadComplete );
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_FAILED, onAssetLoadFailed );
		}	
		
		private function prepareStorage():void 
		{
			_dict = new Array();
			_urlQueue = new Array();
		}
		
		
		private function searchId( id:String ):Boolean 
		{
			var found:Boolean = false;			
			var len:int = _dict.length;				
			for (var i:int = 0; i < len; i++) 
			{
				if ( _dict[ i ].id == id ) {
					found = true;
					trace( "[ImageLoader]: found imgid!!" );
					break;
				}
			}
			
			return found;		
		}
		
		
		public function getImage( id:String , url:String = null ):Bitmap 
		{
			var found:Boolean = searchId( id );
			var bm:Bitmap = null;
			
			if( found ){				
				if ( _dict != null ) {
					
					var len:int = _dict.length;
					
					for (var i:int = 0; i < len; i++) 
					{
						if ( _dict[ i ].id == id ) {
							var bmd:BitmapData = new BitmapData( _dict[ i ].image.width, _dict[ i ].image.height, true , 0 );
							bm = new Bitmap( bmd );
							bmd.draw( _dict[ i ].image );						
						}
					}
				}
				
				//var imageLoaderEvent:ImageLoaderEvent = new ImageLoaderEvent( ImageLoaderEvent.IMAGE_LOADED );
				//imageLoaderEvent.obj.id = id;
				//dispatchEvent( imageLoaderEvent );
				
			}else {
				loadAsset( url, id );
			}
			
			return bm;		
		}	
		
		/*-------------------------------------------------------------------------------Setters----------------------------------------------------------*/
		/*-------------------------------------------------------------------------------Getters----------------------------------------------------------*/
		/*-------------------------------------------------------------------------------EventHandlers----------------------------------------------------*/
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{
			
		}
		
		private function onXMLExtractQuestGraphicFailed(e:XMLExtractorEvent):void 
		{
			trace( "[ ImageLoad ] extract xml failed epic fail " );
		}
		
		private function onXMLExtractQuestGraphicComplete(e:XMLExtractorEvent):void 
		{		
			var xml:XML = ( e.obj as XML);
			if (xml != null)
			{
				if ( xml.@ret == "true")
				{
					_currentLoadedUrl = xml.@url;
					_currentLoadedImageId = xml.@imgid;
					loadAsset( xml.@url, xml.@imgid );					
					trace( "[ ImageLoad ] extract xml complete true " );
				}else {
					trace( "[ ImageLoad ] extract xml failed false " );
				}
			}else {
				
			}
		}
		
		private function onAssetLoadFailed(e:AssetLoaderEvent):void 
		{
			
		}
		
		private function onLoadComplete(e:AssetLoaderEvent):void 
		{
			if( e.obj != null ){
				trace( "[Imageloader]: image loaded complete imge id..................................", e.obj.id );
				var imgObj:Object = new Object();
				imgObj.image = e.obj.image;
				imgObj.id = e.obj.id;
				_dict.push( imgObj );
				
				var imageLoaderEvent:ImageLoaderEvent = new ImageLoaderEvent( ImageLoaderEvent.IMAGE_LOADED );
				imageLoaderEvent.obj.id = e.obj.id;
				dispatchEvent( imageLoaderEvent );
				
				
				if( _currentLoadedImageId == e.obj.id && _currentLoadedUrl == e.obj.url ){
					_urlQueue.shift();
					_isLoading = false;
				}
			}
		}
	}
}

class SingletonEnforcer{}