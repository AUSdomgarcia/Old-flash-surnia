package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.utils.assetLoader.AssetLoader;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class FbImageTest extends Sprite
	{
		private var _assetLoader:AssetLoader;
		/*--------------------------------------------------------------------------------constant--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Conttructor--------------------------------------------------------------*/
		
		
		public function FbImageTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_assetLoader = AssetLoader.getInstance();
			_assetLoader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onAssetLoadComplete );
			
			_assetLoader.loadImage( "url", true, true, "fbId"  );			
		}	
		
		/*--------------------------------------------------------------------------------methods--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		private function onAssetLoadComplete(e:AssetLoaderEvent):void 
		{
			_assetLoader = AssetLoader.getInstance();
			_assetLoader.getFbImage( "fbid"  );
		}
	}

}