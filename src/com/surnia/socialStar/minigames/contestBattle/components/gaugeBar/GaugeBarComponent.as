package com.surnia.socialStar.minigames.contestBattle.components.gaugeBar {
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class GaugeBarComponent extends MovieClip {
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		private var _txtDisplay:TextField;
		private var _txtValue:int;		
		private var _maxPosition:Number;		
		
		private var _bg:DisplayObject;
		private var _bar:DisplayObject;
		private var _mask:DisplayObject
		private var _minPosition:Number;
		private var _currentValue:int;
		private var _maxValue:int;		
		
		public const DURATION:Number = 1;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function GaugeBarComponent(bgBar:DisplayObject, gaugeBar:DisplayObject, mask:DisplayObject, initialValue:int = 0, maxValue:int = 100) {
			_bg = bgBar;
			_bar = gaugeBar;
			_mask =  mask;
			
			_maxValue = maxValue;			
			_currentValue = initialValue;
			
			initialization();
			display();
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			_txtDisplay = new TextField();						
		}
		
		private function display():void {
			addChild(_bg);
			
			//set guage bar
			_bar.x = (_bg.width / 2) - (_bar.width / 2);
			_bar.y = (_bg.height / 2) - (_bar.height / 2);
			
			//set gauge mask
			_mask.x = _bar.x;
			_mask.y = _bar.y;
			addChild(_mask);			
			
			_bar.mask = _mask;		
			
			addChild(_bar);
			
			_maxPosition = _bar.x;
			_minPosition = _bar.x - _bar.width;	

			_bar.x = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));	
			
			//set text display				
			setDisplayText(_currentValue);
			_txtDisplay.width = _bg.width;
			_txtDisplay.height = _bg.height;
			_txtDisplay.x = (_bg.width /2) - (_txtDisplay.textWidth / 2);
			_txtDisplay.y = (_bg.height / 2) - (_txtDisplay.textHeight / 2);
			addChild(_txtDisplay);	
			
			this.height = _bg.height;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER NAD GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function resetGauge(initialValue:int = 0):void {
			_currentValue = initialValue;
			_bar.x = _currentValue;
		}
		
		public function setCurrentValue(value:int):void {
		
			_currentValue = value;		
			
			var locX:Number = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));
			
			if(locX <= _maxPosition){
				TweenLite.to(_bar, 1, {
					x: locX,
					
					onUpdate: function():void {
						_txtValue = ((_bar.x - _minPosition) / (_maxPosition - _minPosition)) * _maxValue;
						setDisplayText(_txtValue);
					},
					onComplete: function():void {
					
						_txtValue = _currentValue;	
						setDisplayText(_txtValue);
					}
				});
			}
			
		}
		
		public function getCurrentValue():int {
			return _currentValue;
		}		
		
		public function setMaxValue(value:int):void {
			_maxValue = value;
		}	
		
		protected function setDisplayText(currentValue:int):void {
			_txtDisplay.text = String(currentValue);			
		}

	
		public function addListeners():void {
		}
		
		public function removeListeners():void {
		}
		
		public function setPosition(X:Number, Y:Number):void {
			this.x = X;
			this.y = Y;
		}
		
		public function getPosition():Point {
			return new Point(this.x, this.y);
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function nullAllInstances():void {
			trace("CLEAN :", this);
			if (_txtDisplay!=null) {
				if (this.contains(_txtDisplay)) {
					removeChild(_txtDisplay);					
				}
			}
			_txtDisplay = null;
			
			if (_bar!=null) {
				if (this.contains(_bar)) {
					removeChild(_bar);					
				}
			}
			_bar = null;
			
			if (_mask!=null) {
				if (this.contains(_mask)) {
					removeChild(_mask);					
				}
			}
			_mask = null;
			
			if (_bg !=null) {
				if (this.contains(_bg)) {
					removeChild(_bg);				
				}
			}
			_bg = null;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onRemove(e:Event):void {
			//nullAllInstances();
		}
	}
}