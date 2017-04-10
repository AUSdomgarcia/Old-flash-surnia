package com.surnia.socialStar.minigames.utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	/**
	 * ...
	 * @author domz
	 */
	public class TimerSlider extends Sprite
	{
		private var layer0:Sprite = new Sprite();
		private var layer01:Sprite = new Sprite();
		private var layer1:Sprite = new Sprite();
		private var layer2:Sprite = new Sprite();
		
		private var target:Sprite;
		// Background
		private var _bg:Sprite;
		private var bgY:Number;
		private var buttonCollision:Sprite;
		//model
		public var sliding_arr:Array = []; // hold mc of obstacle
		public var radomNumber:Number = 0; // length of array
		
		private var difficulty:Number = 0; // max number of obstacle
		private var lowerNum:Number = 0;  // lowest number of obstacle[limit]
		
		//Speed
		public var movementX:Number = 0; // movement to decrement
		public var couterDelay:Number = 0; // delay holder 60 - 180 possible
		
		//Counter
		private var counter:Number = 0;
		private var counter2:Number = 0;
		public var remainingNumber:Number = 0; // counter of timer
		public var defaultTime:Number = 0; // default timer when game start
		
		//Holders
		private var collider:Sprite; // collider holder
		public var holdHistory:Array = []; // hold history of click
		public var holdStatusResult:String; // hold string status [good,perfect]
		public var arrHolding_mc:Array = new Array(); // hold mc of obstacle
		
		//boolean
		private var isOnclick:Boolean = false;
		
		public function TimerSlider( sp:Sprite ) 
		{
			target = sp;
		}
		
		public function initSetup():void {
			radomNumber = Math.floor( ( Math.random () * difficulty ) + lowerNum );
			trace("Limit of Item: ", radomNumber);
			
			for (var i:int = 0; i < radomNumber; i++) 
			{
				arrHolding_mc.push( new slidingMC );
			}
		}
		
		public function setDifficulty( max:Number, low:Number, speed:Number, start:Number ):void {
			difficulty = max;
			lowerNum = low;
			defaultTime = start;
			movementX = speed;
			initSetup();
		}
		
		public function setBackGround( bg:Sprite, _x:Number, _y:Number ):void {
			bg.x = _x;
			bg.y = _y;
			
			_bg = bg;
			layer0.addChild( bg );
		}
		
		public function addCollider( mc:Sprite, _x:Number, _y:Number ):void {
			mc.x = _x;
			mc.y = _y;
			collider = mc;
			layer01.addChild( mc );
		}
		
		public function setCollidingMc( mc:Sprite , _x:Number, _y:Number ):void {
			mc.x = _x;
			mc.y = _y;
			sliding_arr.push( mc );
			layer1.addChild( mc );
		}
		
		
		public function setButton( button:Sprite, _x:Number, _y:Number ):void {
			buttonCollision = button;
			buttonCollision.alpha = .8;
			buttonCollision.x = _x;
			buttonCollision.y = _y;
	
			buttonCollision.addEventListener(MouseEvent.CLICK, onDown );
			layer2.addChild( buttonCollision );
		}
		
		public function onDown( e:MouseEvent ):void {
			isOnclick = true;
			
			for (var i:int = 0; i < sliding_arr.length; i++)
				{
					if ( collider.hitTestObject( sliding_arr[i]))
					{
						if ( sliding_arr[i].x >= collider.x - 8 && sliding_arr[i].x <= collider.x + 8 ) {
						holdStatusResult = "CENTER";
						trace(holdStatusResult);
						
						} else if ( collider.x - 11 >= sliding_arr[i].x ) {
						holdStatusResult = "LEFT";
						trace(holdStatusResult);
						
						} else if ( collider.x + 11 <= sliding_arr[i].x ) {
						holdStatusResult = "RIGHT";
						trace(holdStatusResult);
						}
						
						buttonCollision.removeEventListener(MouseEvent.CLICK, onDown );
					}
			}
			
		}
		
		public function onUpdate():void {
			counter++;
			show();
			check();
			updateSlidingMc();
			checkCollision();
			
		}
		
		private function updateSlidingMc():void {	
			
			if ( sliding_arr.length != 0 ) {
				if ( sliding_arr[i].x <= _bg.x + 40 ) {
					layer1.removeChild(sliding_arr[i]);
					sliding_arr.splice( i, 1 );
				}
				
				for (var i:int = 0; i < sliding_arr.length; i++) 
					{
						sliding_arr[i].x -= movementX;
					}
				} else { /*trace("ArrayLength: " + sliding_arr.length );*/ }
		}
		
		public function checkCollision():void {
		if ( buttonCollision.hasEventListener(MouseEvent.CLICK)) {
			buttonCollision.alpha = .8;
		} else { buttonCollision.alpha = .5; }
		
		if ( isOnclick ) {
				counter2++;
				if ( counter2 >= 30 ) {
					//trace("ready to click again ==============================================================================");
					buttonCollision.addEventListener(MouseEvent.CLICK, onDown );
					counter2 = 0;
					isOnclick = false;
				}
			}
		}
		
		public function show():void {
			target.addChild( layer0 );
			if (sliding_arr.length != 0) {
				target.addChild( layer1 );
			}
			target.addChild( layer01 );
			target.addChild( layer2 );
		}
		
		public function removeListeners():void {
			buttonCollision.removeEventListener(MouseEvent.CLICK, onDown );
		}
		
		private function check():void {
			
		if ( counter >= couterDelay ) {
				remainingNumber += 1;   // model basis
				if ( remainingNumber <= arrHolding_mc.length ) {	
					setCollidingMc( arrHolding_mc[ remainingNumber - 1 ] , _bg.x + _bg.width - 50, _bg.y + 43 );
					} else {
						//trace("nothing to add");
					}
			counter = 0;
			}
			
			// to end the game
			if( arrHolding_mc.length != 0 ){			
				if ( arrHolding_mc[ arrHolding_mc.length - 1 ].x != 0 ) {
					if ( arrHolding_mc[ arrHolding_mc.length - 1 ].x <= _bg.x + 40 ) {
						stopMe();
					}
				}
			}
		}
		
		private function stopMe():void {
			removeListeners();
			target.dispatchEvent( new Event("GAME_END"));
		}
	//end
	}
}