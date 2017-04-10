package com.surnia.socialStar.ui.component.progressBar
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.component.progressBar.event.ProgressBarEvent;
	
	import flash.display.Sprite;

	public class ProgressBar extends Sprite
	{
		private var _progressBar:ProgressMC04;
		private var _duration:Number;
		
		private var _progressBarIndex:int;
		private var _itemObject:Object;
		private var _charObject:Object;
		
		public function ProgressBar(itemObject:Object = null, charObject:Object = null)
		{
			_itemObject = itemObject;
			_charObject = charObject;
		}

		public function get charObject():Object
		{
			return _charObject;
		}

		public function set charObject(value:Object):void
		{
			_charObject = value;
		}

		public function get itemObject():Object
		{
			return _itemObject;
		}

		public function set itemObject(value:Object):void
		{
			_itemObject = value;
		}

		public function get progressBarIndex():int
		{
			return _progressBarIndex;
		}

		public function set progressBarIndex(value:int):void
		{
			_progressBarIndex = value;
		}

		public function get duration():Number
		{
			return _duration;
		}

		public function set duration(value:Number):void
		{
			_duration = value;
		}

		public function get progress():Number
		{
			return _progressBar.progressBar.scaleX * 100;
		}

		public function set progress(value:Number):void
		{
			_progressBar.progressBar.scaleX = value / 100;
		}

		public function start(duration:Number):void{
			_duration = duration;
			_progressBar = new ProgressMC04();
			addChild(_progressBar);
			_progressBar.x = _progressBar.width/2;
			_progressBar.progressBar.scaleX = 0;
			TweenLite.to(_progressBar.progressBar, duration, {scaleX:1, onComplete:onProgressComplete});
		}
		
		private function onProgressComplete():void{
			dispatchEvent(new ProgressBarEvent(ProgressBarEvent.PROGRESSBAR_REMOVE));
		}
		
	}
}