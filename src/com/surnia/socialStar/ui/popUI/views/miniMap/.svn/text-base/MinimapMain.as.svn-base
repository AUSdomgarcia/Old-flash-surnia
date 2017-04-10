package com.surnia.socialStar.ui.popUI.views.miniMap
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.ui.popUI.views.miniMap.data.MiniMapModel;
	import com.surnia.socialStar.ui.popUI.views.miniMap.views.MiniMapView;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	[SWF(width = '760', height = '630')]
	public class MinimapMain extends Sprite	
	{	
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/
		private var _model:MiniMapModel;
		private var _view:MiniMapView;
		private var _stage:Stage;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MinimapMain() {	
			
		}
		
		public function init(ev:Event = null):void {		
			trace("stage1: " + stage);
			_stage = stage;		
			initWindow();			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												ADD LISTENERS		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function addListener():void {			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												REMOVE LISTENERS		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function removeListener():void {	
		}
		/*------------------------------------------------------------------------------------------------------------
		 *												PUBLIC MOETHOD CLASS DISPLAY GAME		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function initWindow():void {
			for (var i:int = 0; i < 1;i++ ) {
				clearWindow();
				//trace(this, " NULL CTR", i)
				_model = new MiniMapModel();	
				_view = new MiniMapView(_stage, this,  _model);				
				addChild(_view);				
			}			
			//memoryTest();
		}		
		
		private function memoryTest():void {
			//memory management display
			if (mem !=null) {
				if (this.contains(mem)) {
					removeChild(mem);
					mem = null;
				}
			}
			if (frame !=null) {
				if (this.contains(frame)) {
					removeChild(frame);
					frame = null;
				}
			}
			
			var mem:MemoryProfiler = new MemoryProfiler();
			addChild(mem);
			mem.x = GameConfig.GAME_WIDTH - mem.width;
			var frame:FrameRateViewer = new FrameRateViewer();
			addChild(frame);
			frame.x = GameConfig.GAME_WIDTH - (frame.width + 50);
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												PUBLIC METHOD CLASS CLOSE GAME		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function clearWindow():void {
			trace(this, "GAME CLOSE");
			if (_view != null) {
				if (this.contains(_view) ) {
					removeChild(_view);	
					_view.nullAllInstances();
					_view = null;
				}
			}		
			
			if (_model != null) {
				if (this.contains(_model) ) {
					removeChild(_model);	
					_model = null;
				}
			}			
		}		
	}
}