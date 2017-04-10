package com.surnia.socialStar.ui.component.progressBarProxy
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.component.progressBar.event.ProgressBarEvent;
	import com.surnia.socialStar.ui.component.progressBarProxy.event.ProgressBarEventProxy;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.Sprite;

	public class ProgressBarProxy extends Sprite
	{
		private var _progressBar:ProgressMC04;
		private var _duration:Number;
		
		private var _progressBarIndex:int;
		private var _objectNode:IsoObject;
		private var _charNode:CharacterNode;
		
		public function ProgressBarProxy(objectNode:IsoObject = null, charNode:CharacterNode = null)
		{
			_objectNode = objectNode;
			_charNode = charNode;
		}

		public function get charNode():CharacterNode
		{
			return _charNode;
		}

		public function set charNode(value:CharacterNode):void
		{
			_charNode = value;
		}

		public function get objectNode():IsoObject
		{
			return _objectNode;
		}

		public function set objectNode(value:IsoObject):void
		{
			_objectNode = value;
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
			_progressBar.x -= _progressBar.width / 2;
			_progressBar.progressBar.scaleX = 0;
			TweenLite.to( _progressBar.progressBar, _duration, {scaleX:.99, onComplete:onProgressComplete});
		}
		
		private function onProgressComplete():void {
			trace("charNode = " + _charNode + " | " + "objectNode = " + _objectNode);
			dispatchEvent(new ProgressBarEventProxy(ProgressBarEventProxy.PROGRESSBAR_REMOVE));
		}
		
	}
}