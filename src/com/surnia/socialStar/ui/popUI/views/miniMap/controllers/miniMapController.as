package com.surnia.socialStar.ui.popUI.views.miniMap.controllers 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.data.MiniMapModel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.views.MiniMapView;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author DF
	 */
	public class miniMapController 
	{
		private var _model:MiniMapModel;
		private var _view:MiniMapView;
		private var _stage:Stage;
		private var _mainParent:Sprite;
		public function miniMapController(stage:Stage,mainParent:Sprite, model:MiniMapModel, view:MiniMapView) 
		{
			_model = model;
			_view = view;
			
		}
		
	}

}