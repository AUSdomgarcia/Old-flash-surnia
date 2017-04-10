package com.surnia.socialStar.ui.component.progressBarProxy
{
	import as3isolib.display.IsoSprite;
	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.component.progressBarProxy.event.ProgressBarEventProxy;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author Hedrick David
	 * 
	 */
	
	public class ProgressBarManagerProxy extends Sprite
	{
		
		private var _progressBarArray:Array = [];
		private var _mainView:Sprite;
		
		private static var _instance:ProgressBarManagerProxy;
		
		public static function get instance():ProgressBarManagerProxy{
			if (_instance == null){
				_instance = new ProgressBarManagerProxy();
				return _instance;
			} else {
				return _instance;
			}
		}
		
		private function onProgressBarRemove(ev:ProgressBarEventProxy):void{
			var len:int = _progressBarArray.length;
			ev.currentTarget.removeEventListener(ProgressBarEventProxy.PROGRESSBAR_REMOVE, onProgressBarRemove);
			
			
			var objectInstance:IsoSprite ;
			var charInstance:Sprite;
			
			if (ev.currentTarget.objectNode != null) {
				objectInstance = ev.currentTarget.objectNode.instance;
			} else {
				objectInstance = null;
			}
			
			if (ev.currentTarget.charNode != null) {
				charInstance = ev.currentTarget.charNode.elementContainer;
			} else {
				charInstance = null;
			}
			
			var arr:Array = [ev.currentTarget, objectInstance , charInstance];
			TweenLite.to(ev.currentTarget, .3, {alpha:0, onComplete:removeProgressBar, onCompleteParams:arr});
			
			var params:Object = new Object();
			params.objectNode = ev.currentTarget.objectNode;
			params.charNode = ev.currentTarget.charNode;
			
			EventSatellite.getInstance().dispatchEvent(new ProgressBarEventProxy(ProgressBarEventProxy.PROGRESS_COMPLETE, params));
		}
		
		private function removeProgressBar(progressBar:ProgressBarProxy, objectInstance:IsoSprite, elementContainer:Sprite):void{
			if (objectInstance != null) {
				var len:int = _progressBarArray.length;
				for (var i:int = 0; i<len; i++){
					if (_progressBarArray[i] == progressBar){
						objectInstance.sprites.pop();
						_progressBarArray[i] = null;
					}
				}
			} else if (elementContainer != null){
				len = _progressBarArray.length;
				for (i = 0; i<len; i++){
					if (_progressBarArray[i] == progressBar){
						elementContainer.removeChild(_progressBarArray[i]);
						_progressBarArray[i] = null;
					}
				}
			} 
		}
		
		public function forceRemoveProgressBars():void{
			var len:int = _progressBarArray.length;
			for (var x:int = 0; x<len; x++){
				if (_progressBarArray[x] != null){
					var progressBar:ProgressBarProxy = _progressBarArray[x];
					progressBar.removeEventListener(ProgressBarEventProxy.PROGRESSBAR_REMOVE, onProgressBarRemove);
					if (progressBar.charNode != null){
						var characNode = progressBar.charNode;
						characNode.elementContainer.removeChild(progressBar);
					}
					_progressBarArray[x] = null;
				}
			}
		}
		
		public function addProgressBar(duration:Number , objectNode:IsoObject = null, charNode:CharacterNode = null):void {	
			trace( "sho progress bar.............................. 1", duration, objectNode, charNode );
			var progressBar:ProgressBarProxy = new ProgressBarProxy(objectNode, charNode);
			progressBar.addEventListener(ProgressBarEventProxy.PROGRESSBAR_REMOVE, onProgressBarRemove);
			if (charNode != null) {
				trace ("charMode");
				charNode.elementContainer.addChild(progressBar);
				progressBar.y -= 125;
			} else {
				trace ("objectMode");
				objectNode.instance.sprites.push(progressBar);	
				//progressBar.y = 125;
			}
			progressBar.alpha = 0;
			
			TweenLite.to(progressBar, .3, {alpha:1});
			_progressBarArray.push(progressBar);
			progressBar.start(duration);
			trace( "sho progress bar..............................2" );
		}
	}
}