package com.surnia.socialStar.test 
{	
	import com.surnia.socialStar.utils.assetLoader.AssetLoader;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TestLoadSwf extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _loader:AssetLoader;
		/*----------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		public function TestLoadSwf() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			loadAsset(  );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function loadAsset():void 
		{
			_loader = AssetLoader.getInstance();			
			//_loader.loadImage( "http://monsterpatties.net/stargazer/credits.swf" );
			//_loader.loadImage( "lib/credits.swf" );
			//_loader.loadImage( "../lib/assets/credits.swf" );			
			//_loader.loadImage( "http://1.234.2.179/socialstardev/public/data/imgs/item/cabinet01.png", true, false, ""  );
			//http://1.234.2.179/socialstardev/public/data/imgs/obj/water/Water02.png
			_loader.loadImage( "http://1.234.2.179/socialstardev/public/data/imgs/obj/water/Water02.png", true, false, ""  );
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onLoadComplete );
		}
		
		
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventhHandlers----------------------------------------------------------------------*/
		private function onLoadComplete(e:AssetLoaderEvent):void 
		{
			var arr:Array = _loader.loadedAsset;
			addChild( arr[ 0 ] );			
		}
	}

}