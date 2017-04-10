package com.surnia.socialStar.ui.component.progressBar
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.component.progressBar.event.ProgressBarEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class ProgressBarManager
	{
		
		private var _progressBarArray:Array = [];
		private var _mainView:Sprite;
		
		public function ProgressBarManager(mainView:Sprite):void{
			_mainView = mainView;
			addListeners();
		}
		
		public function addListeners():void{
			
		}
		
		private function onProgressBarRemove(ev:ProgressBarEvent):void{
			var len:int = _progressBarArray.length;
			ev.currentTarget.removeEventListener(ProgressBarEvent.PROGRESSBAR_REMOVE, onProgressBarRemove);
			var arr:Array = [ev.currentTarget.progressBarIndex, ev.currentTarget.itemObject.movieclip];
			TweenLite.to(ev.currentTarget, .3, {alpha:0, onComplete:removeProgressBar, onCompleteParams:arr});
			
			var params:Object = new Object();
			params.itemObject = ev.currentTarget.itemObject;
			params.charObject = ev.currentTarget.charObject;
			
			EventSatellite.getInstance().dispatchEvent(new ProgressBarEvent(ProgressBarEvent.PROGRESS_COMPLETE, params));
		}
		
		private function removeProgressBar(progressBarIndex:int, movieclip:MovieClip):void{
			if (movieclip != null){
				movieclip.removeChild(_progressBarArray[progressBarIndex]);
				_progressBarArray[progressBarIndex] = null;
				_progressBarArray.splice(progressBarIndex ,1);
			}
		}
		
		public function addProgressBar(duration:Number , itemObject:Object = null, charObject:Object = null):void{	
			
			var progressBar:ProgressBar = new ProgressBar(itemObject, charObject);
			progressBar.addEventListener(ProgressBarEvent.PROGRESSBAR_REMOVE, onProgressBarRemove);
			itemObject.movieclip.addChild(progressBar);
			progressBar.alpha = 0;
			progressBar.y -= 100;
			TweenLite.to(progressBar, .3, {alpha:1});
			_progressBarArray.push(progressBar);
			progressBar.progressBarIndex  = _progressBarArray.length - 1;
			progressBar.start(duration);
		}
	}
}