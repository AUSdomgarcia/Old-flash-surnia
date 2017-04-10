package com.surnia.socialStar.sceneHandler 
{
	import flash.display.Sprite;
	
	import com.surnia.socialStar.sceneHandler.controller.SceneHandlerController;
	import com.surnia.socialStar.sceneHandler.data.SceneHandlerData;
	import com.surnia.socialStar.sceneHandler.view.SceneHandlerView;
	
	
	public class SceneHandlerMain extends Sprite
	{
		private var _sceneData:SceneHandlerData;
		private var _sceneController:SceneHandlerController;
		private var _sceneView:SceneHandlerView;
		
		public function SceneHandlerMain()
		{
			_sceneData = new SceneHandlerData;
			_sceneController = new SceneHandlerController( _sceneData ) ;
			_sceneView = new SceneHandlerView( _sceneData, _sceneController );
			addChild(_sceneView);
		}
		
		
		
		
		
		
	}

}