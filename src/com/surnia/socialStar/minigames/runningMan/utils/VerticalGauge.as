package com.surnia.socialStar.minigames.utils 
{
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class VerticalGauge extends Sprite
	{
		
		public var mcBackGround:Sprite;
		public var addMinVal:Number = 0;
		public var mcBar:Sprite;
		private var masking:Shape = new Shape();
		private var sp:Sprite;
		private var percent:Number = 0;
		private var layer0:Sprite = new Sprite();
		private var layer1:Sprite = new Sprite();
		private var percent1:Number = 0;
		private var wholeVal:Number = 0;
		private var percentHolder:Number = 0;
		
		public function VerticalGauge( _mcBg:Sprite , _mcBar:Sprite, pudding:Number ,  bg_x:Number, bg_y:Number , _sp:Sprite ) 
		{
			sp = _sp;
	
			_mcBg.x = bg_x;
			_mcBg.y = bg_y;
			
			_mcBar.x = _mcBg.x + pudding;
			_mcBar.y = _mcBg.y + pudding;
			
			mcBackGround = _mcBg;
			mcBar = _mcBar;
			
			wholeVal = mcBar.height;
			
			layer0.addChild( mcBackGround );
			layer1.addChild( mcBar );
			
			initMasking();
			addChildItem();
		}
		private function addChildItem():void {
			sp.addChild(layer0);
			sp.addChild(layer1);
			layer1.mask = masking;
		}
		
		public function removeChildItem():void {
			sp.removeChild(layer0);
			sp.removeChild(layer1);
			sp.addChild(masking);
		}
		
		private function initMasking():void {
			masking.graphics.lineStyle();
			masking.graphics.beginFill(0x00FF00,1);
			masking.graphics.drawRect( mcBar.x , mcBar.y, mcBar.width , mcBar.height );
			masking.graphics.endFill();
		}
		
		public function setNumber( percent:Number, status:Number ):void {
				
			percent1 = (( percent / 100 ) * mcBar.height );
			trace( wholeVal );
			switch(status) {
				case 0:
					//TweenLite.to( mcBar, 1, { x: mcBar.x , y: mcBar.y - percent1 } );
					mcBar.y -= percent1;
				break;
				case 1:
					mcBar.y += percent1;
					//TweenLite.to( mcBar, 1, { x: mcBar.x , y: mcBar.y + percent1 } );
				break;
			}
			checkRemainingPercent( status );
		}

		public function checkRemainingPercent( val:Number):void {
			switch( val ) {
				case 0:
					wholeVal += percent1;
				break;
				case 1:
					wholeVal -= percent1;
				break;
			}
		}
		
		public function get remainingVal():Number {
			return wholeVal;
		}
//end
	}
}