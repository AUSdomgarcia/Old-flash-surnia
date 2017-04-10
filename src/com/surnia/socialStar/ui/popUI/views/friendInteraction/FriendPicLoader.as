package com.surnia.socialStar.ui.popUI.views.friendInteraction
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.utils.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class FriendPicLoader
	{
		public static const LOADER:int = 0;
		public static const FBID:int = 1;
		public static const ENTRY:int = 2;
		
		private static var _instance:FriendPicLoader;
		
		private var _loader:FriendLoader;
		private var _urlRequest:URLRequest;
		private var _isOnline:Boolean = true;
		private var _loaderContext:LoaderContext;
		
		private var _loaderArray:Array = [];
		private var _urlRequestArray:Array = [];
		
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		
		public static function get instance():FriendPicLoader{
			if (_instance == null){
				_instance = new FriendPicLoader();
				return _instance;
			} else {
				return _instance;
			}
		}
		
		public function loadFriendPic(entry:String, fbID:String, challenge:Boolean):void{
			if (!_gd.islocal){
				if (_isOnline == true){
					_loaderContext = new LoaderContext();
					_loaderContext.checkPolicyFile = true;
					_loaderContext.securityDomain = SecurityDomain.currentDomain;
				}
			}
			Logger.tracer(this, "friend pic to be loaded: " + entry);
			var fbPicLink:String = GlobalData.instance.getPicLinkByFID(fbID);
			var urlRequest:URLRequest = new URLRequest(fbPicLink);
			var loader:FriendLoader = new FriendLoader();
			var  params:Object = new Object();
			params.entry = entry;
			params.fbid = fbID;
			params.challenge = challenge;
			loader.params = params;
			
			loader.load(urlRequest, _loaderContext);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPicLoadError);
		}
		
		private function onPicLoaded(ev:Event):void{
			
			var loader:FriendLoader = ev.target.loader as FriendLoader;
			var friendPic:Bitmap = ev.target.content as Bitmap;
			
			var bm:Bitmap = new Bitmap( copyBitmap (friendPic) );
			trace ("created a bitmap: " + bm);
			
			var friendPicSprite:Sprite = new Sprite();
			
			ev.target.removeEventListener(Event.COMPLETE, onPicLoaded);
			ev.target.removeEventListener(IOErrorEvent.IO_ERROR, onPicLoadError);
			
			friendPicSprite.addChild(bm);
			var params:Object = new Object();
			params.friendPic = friendPicSprite;
			params.fbid = loader.params.fbid;
			params.entry = loader.params.entry;
			
			trace ("friend pic loaded " + params.friendPic + " " + params.fbid + " " + params.entry);
			
			_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_FRIENDPICLOADED, params));
		}
		
		private function copyBitmap(bitmap:Bitmap):BitmapData{
			var bmd:BitmapData = new BitmapData( bitmap.width, bitmap.height, true,0x000000  );
			bmd.draw( bitmap );						
			return bmd;		
		}
		
		private function onPicLoadError(ev:IOErrorEvent):void{
			Logger.tracer(this, "Error loading friend pic." + ev.text);
		}
	}
}