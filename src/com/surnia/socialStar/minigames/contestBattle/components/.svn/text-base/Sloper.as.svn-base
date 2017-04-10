package com.surnia.socialStar.minigames.contestBattle.components 
{
	import com.greensock.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class Sloper extends Sprite
	{
		private var _mc:MovieClip
		private var _frameDelay:int;
		
		public var localX:int;
		public var localY:int;
		
		private var _ctr:int = 0;
		private var _height:int;
		
		private var _onActive:Boolean = false;
	
		public function Sloper(frameDelay:int = 30) 
		{
			_frameDelay = frameDelay;
			
			_frameDelay = _frameDelay / 2;
			_height 	= _height / 2;
			
			instantiation();
			display();		
		}
		private function instantiation():void {	
			_mc = new MovieClip;			
		}
		
		private function display():void {
			
		}
		public function setDestination(X:int = 0, Y:int = 0, targetX:int = 0, targetY:int=0 ):void {
			if (_onActive == false) {
				_onActive = true
				_mc.x = X;
				_mc.y = Y;
				
				TweenLite.to(_mc, _frameDelay, {
					x: targetX,
					y: targetY,
					useFrames:true,
					onUpdate: function():void {
						localX = _mc.x;
						localY = _mc.y;
						trace(this, "LOCAL X/Y :",localX, " ",localY, " ",_frameDelay);
					},
					onComplete: function():void {
						_onActive = false;
					}
				});
		
			}
		}		

		
	}
}