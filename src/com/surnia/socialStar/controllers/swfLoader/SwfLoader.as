package com.surnia.socialStar.controllers.swfLoader 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SwfLoader extends Sprite
	{
		
		private var _mc:MovieClip;
		
		public function SwfLoader() 
		{
			loadSwf( "wibox.swf" );
		}
		
		public function loadSwf( url:String ):void
		{
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(url);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			mLoader.load(mRequest);
		}

		private function onCompleteHandler(loadEvent:Event):void
		{
			trace( "has definition",ApplicationDomain.currentDomain.hasDefinition( loadEvent.currentTarget.content )) ;  //getDefinition("Box1");
			//addChild(loadEvent.currentTarget.content);
			//addChild(obj as MovieClip );
			
			_mc = loadEvent.currentTarget.content as MovieClip;;
			var mc1:MovieClip = _mc.getChildByName( "wibox" ) as MovieClip;
			addChild(  mc1 );
			mc1.play();
			
		}
		
		private function onProgressHandler(mProgress:ProgressEvent):void
		{
			var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
			trace( "loading swf: ",  percent , "%" );
		}		
	}

}