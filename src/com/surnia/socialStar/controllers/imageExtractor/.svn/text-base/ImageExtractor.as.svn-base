package com.surnia.socialStar.controllers.imageExtractor 
{
	import as3isolib.graphics.BitmapFill;
	import as3isolib.graphics.Stroke;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	//import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import com.surnia.socialStar.utils.assetLoader.AssetLoader;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import com.surnia.socialStar.utils.assetLoader.ImageAssetLoader;
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import com.surnia.socialStar.utils.xmlParser.XMLExtractor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author JC
	 */
	public class ImageExtractor extends Sprite
	{
		//new
		/*--------------------------------------------------------------------Constant------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private var _xmlExtractor:XMLExtractor;
		private var _xml:XML;
		private var _dict:Dictionary;
		
		private var _loader:ImageAssetLoader;	
		
		private var _nextImage:int;
		private var _allOfficeImageLoaded:Boolean;
		
		private var _es:EventSatellite;
		private var _imageExtractorEvent:ImageExtractorEvent;
		
		private static var _instance:ImageExtractor;;
		private var _gd:GlobalData = GlobalData.instance;
		/*--------------------------------------------------------------------Constructor---------------------------------------------------------------------*/
		
		public function ImageExtractor( enforcer:SingletonEnforcer ) 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
			prepareStorage();
		}
		
		private function init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();			
		}		
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		
		public static function getInstance():ImageExtractor 
		{
			if ( ImageExtractor._instance == null ) {
				ImageExtractor._instance = new ImageExtractor( new SingletonEnforcer() );
			}
			
			return ImageExtractor._instance;
		}
		/*--------------------------------------------------------------------Methods-------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			trace( "init image extractor...." );
			//extractXml();			
		}
		
		private function removeDisplay():void 
		{
			
		}
		
		public function extractXml():void 
		{
			trace( "extract office item images........................" );
			_xmlExtractor = new XMLExtractor(  );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_COMPLETE, onXMLExtractionComplete );
			_xmlExtractor.addEventListener( XMLExtractorEvent.XML_EXTRACTION_FAILED, onXMLExtractionFailed ); 			
			_xmlExtractor.extractXmlData( _gd.absPath + "public/data/officeitemlinks.xml" );			
		}
		
		private function loadAsset( url:String , id:String):void 
		{
			//hit me now
			_loader = new ImageAssetLoader();
			_loader.loadImage( url, true, false, "",id );			
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onLoadComplete );
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_FAILED, onAssetLoadFailed );
		}		
		
		private function prepareStorage():void 
		{
			_dict = new Dictionary();
		}
		
		//marker
		private function loadItemImage( xml:XML = null ):void 
		{
			var url:String;
			var id:String;
			
			if( xml != null ){
				_xml = xml;
			}
			
			if ( !_allOfficeImageLoaded ) {		
				if(  _xml.item[ _nextImage ].@pngresized != null && _xml.item[ _nextImage ].@id != null  ){
					//url = _xml.item[ _nextImage ].@png;				
					url = _xml.item[ _nextImage ].@pngresized;
					id = _xml.item[ _nextImage ].@id;
					
					//url = _xml.deco.water.item[ _nextImage ].@png;
					//id = _xml.deco.water.item[ _nextImage ].@id;
					//url = _xml.deco.water.item[ 2 ].@png;
					//id = _xml.deco.water.item[ 2 ].@id;
					loadAsset( url , id );
				}
			}else {
				trace( "all deco water is loaded" );
				_es = EventSatellite.getInstance();
				_imageExtractorEvent = new ImageExtractorEvent( ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE );
				_es.dispatchESEvent( _imageExtractorEvent );				
			}
		}		
		
		public function getImage( id:String ):* 
		{
			if( _dict[ id ] != null ){
				var bmd:BitmapData = new BitmapData( _dict[ id ].width, _dict[ id ].height, true , 0 );
				var bm:Bitmap = new Bitmap( bmd );
				bmd.draw( _dict[ id ] );
				return bm;
			}else {
				return null;
			}
		}	
		
		public function getImagePackage( ids:Array ):Array
		{		
			var images:Array = new Array();
			
			for (var i:int = 0; i < ids.length; i++) 
			{
				images.push( _dict[ ids[ i ] ]  );
			}
			
			return images;
		}	
		
		private function test():void 
		{
			var image:* = getImage( "J6VfAalX8e8HXkg7Fq2h" );
			
			if( image != null ){				
				addChild( image );
			}else {
				trace( "no image found!!!!!!!!!!!!!!!!" );
			}			
		}
		
		/*----------------------------------------------------------1----------Setters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Getters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Eventhandlers-------------------------------------------------------------------*/
		private function onXMLExtractionFailed(e:XMLExtractorEvent):void 
		{
			trace( "failed xml........................." );
		}
		
		private function onXMLExtractionComplete(e:XMLExtractorEvent):void 
		{
			
			var xml:XML = ( e.obj as XML);
			if (xml != null)
			{
				loadItemImage( xml );
			}
			
			//_xml = _xmlExtractor.xml;		
			//loadItemImage();
		}
		
		private function onLoadComplete(e:AssetLoaderEvent):void 
		{
			//ar arr:Array = _loader.loadedAsset;
			//addChild( arr[ 0 ] );
			//addChild( e.obj.image );
			
			if( e.obj != null ){
				//trace( "item id..................................", e.obj.id );				
				_dict[ e.obj.id ] = e.obj.image;
				//var item:* = _dict[ e.obj.id ];
				//addChild( item  );			
				//item.x = 100 * _nextImage; 
			}
			
			if ( !_allOfficeImageLoaded ){				
				if( _nextImage <  ( _xml.item.length() - 1 ) ){
					_nextImage++;
					loadItemImage();
				}else{					
					_allOfficeImageLoaded = true;
					loadItemImage();					
				}
			}			
		}
		
		private function onAssetLoadFailed(e:AssetLoaderEvent):void 
		{
			if ( _nextImage <  ( _xml.item.length() - 1 ) ) {
				//trace( "asset load failed invalid path will load another asset..." );
				_nextImage++;
				loadItemImage();
			}else {
				//trace( "asset load failed invalid path no more asset to load!!..." );
				_allOfficeImageLoaded = true;
				loadItemImage();
				//_es.dispatchESEvent( ImageExtractorEvent.OFFICE_ITEM_IMAGE_LOAD_COMPLETE );		
			}
		}	
	}
}

class SingletonEnforcer {}