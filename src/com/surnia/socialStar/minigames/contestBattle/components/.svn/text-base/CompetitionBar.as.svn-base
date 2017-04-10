package com.surnia.socialStar.minigames.contestBattle.components 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class CompetitionBar extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		private var _bar:MovieClip;
		private var _mask:MovieClip;
		private var _levelBar:MovieClip;
		
		private var _barA:MovieClip;
		private var _barB:MovieClip;
		
		private var _barLayer:MovieClip
		
		private var _maxPosition:int;
		private var _minPosition:int;
		private var _midPosition:int;		
		private var _currentPosition:int;
		
		private var _currentValue:int;
		private var _maxValue:int;
		
		private var _callBack:Function;
		
		private var _currentTweening:Boolean = false;	
		
		private var _allowanceX:int = 80; 
		
		private var _levelBarWidth:int;
		private var _onStagePresent:Boolean = true;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function CompetitionBar(callBack:Function, gaugeBar:MovieClip, gaugeMask:MovieClip, levelBar:MovieClip, barA:MovieClip, barB:MovieClip, currentValue:int = 0,maxValue:int = 0 ) 
		{		
			nullAllInstances();
			_onStagePresent = true;
			_callBack 	= callBack;
			_bar  		= gaugeBar;
			_mask   	= gaugeMask;
			
			_levelBar	= levelBar;				
			_levelBarWidth = _levelBar.width;
			
			_barA = barA;
			_barB = barB;
			
			_currentValue	= currentValue;
			_maxValue 		= maxValue;
			
			
			display();
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function display():void {
			_barLayer = new MovieClip;
			_mask.alpha = 0;
			_minPosition = 0;
			_maxPosition = (_mask.width);
			_midPosition = (_mask.width / 2) - (_levelBarWidth / 2);	
			
			//display gauge background
			addChild(_bar);			
			
			//set and add mask
			_mask.x = _bar.x;
			_mask.y = _bar.y;
			addChild(_mask);	
			
			
			_barLayer.mask = _mask;
			addChild(_barLayer);			
			_barLayer.addChild(_barA);
			_barB.x = _barA.width;
			_barLayer.addChild(_barB);	
			_barLayer.y = (_bar.height / 2) - (_barLayer.height / 2);
			//set nad add levelBar				
			addChild(_levelBar);			
			
			_currentPosition = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));		

			_levelBar.x = _currentPosition + 10;//_currentPosition - 10;			
			_levelBar.y = (_bar.height /2) - 10;//(_bar.height /2) - (_levelBar.height / 2);		
				
			TweenLite.to(_levelBar, 1, { x:_currentPosition, ease:Expo.easeOut,
				onUpdate: function():void {
					//setTextMeter(String(_currentValue));
				},
					onComplete: function():void {
					//setTextMeter(String(_currentValue));
				}
			
			} );
			
			_barLayer.x = (0 - _barB.width) + (_currentPosition) -10 ;
			TweenLite.to(_barLayer, 1, { x:(0 - _barB.width) + (_currentPosition ), ease:Expo.easeOut} );	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function setMaxValue(value:int):void {
			_maxValue = value;
		}
		
		public function setCurrentValue(value:int):void {
			if(_onStagePresent == true){
				_currentValue = value;
				
				TweenLite.to(_levelBar, 1, { x:_currentPosition, ease:Bounce.easeOut,
					onUpdate: function():void {
						//setTextMeter(String(_currentValue));
					},
						onComplete: function():void {
						//setTextMeter(String(_currentValue));
					}
				
				} );
			}
		}
		
		public function setMaxPosition(pos:int):void {
			_maxPosition = pos;
		}
		
		public function setMinPosition(pos:int):void {
			_minPosition = pos;			
		}
		
		public function setTextMeter(text:String):void {			
			_levelBar.txtMeter.text = text;
		}
		
		public function addPoints(val:int):void {
			if(_onStagePresent == true){
				_currentValue += val;		
				
				if(_currentValue > _maxValue){			
					_currentValue = _maxValue;
					 _callBack(0)
				}
				
				var locX:int = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));	
				
				
				TweenLite.to(_levelBar, 1, { 
					x:locX,
					ease:Expo.easeOut,
					onUpdate: function():void {
						//setTextMeter(String(_currentValue));
					},
					onComplete: function():void {
						//setTextMeter(String(_currentValue));
					}			
				} );			
				TweenLite.to(_barLayer, 1, { ease:Expo.easeOut, x:(0 - _barB.width) + (locX ) } );
			}
		}
		
		public function deductPoints(val:int):void {
			if(_onStagePresent == true){
				_currentValue -= val;				
				
				if (_currentValue < 0 ) {						
					_currentValue = 0;
					 _callBack(1)
				}
				var locX:int = _minPosition + ((_currentValue / _maxValue) * (_maxPosition - _minPosition));				
				
				TweenLite.to(_levelBar, 1, { 
						x:locX,
						ease:Expo.easeOut,
						onUpdate: function():void {
						//setTextMeter(String(_currentValue));
					},
						onComplete: function():void {
						//setTextMeter(String(_currentValue));
					}
				
				} );
				TweenLite.to(_barLayer, 1, { ease:Expo.easeOut, x:(0 - _barB.width) + (locX) } );
			}
		
		}
		
		public function get getCurrentPoints():int {
			return _currentValue;
		}
		
		public function nullAllInstances():void {			
			trace(this, "NULL ALL INSTANCES");
			
			TweenLite.killTweensOf(_levelBar);
			TweenLite.killTweensOf(_barLayer);
			
			if (_levelBar !=null) {
				if (this.contains(_levelBar)) {
					removeChild(_levelBar);					
				}
			}
			_levelBar = null;
			
			if (_mask !=null) {
				if (this.contains(_mask)) {
					removeChild(_mask);					
				}
			}
			_mask = null;
			
			if (_bar !=null) {
				if (this.contains(_bar)) {
					removeChild(_bar);				
				}
			}
			_bar = null;
			
			if (_barB !=null) {
				if (_barLayer.contains(_barB)) {
					_barLayer.removeChild(_barB);					
				}
			}
			_barB = null;
			
			if (_barA !=null) {
				if (_barLayer.contains(_barA)) {
					_barLayer.removeChild(_barA);					
				}
			}
			_barA = null;
			
			if (_barLayer != null) {
				if (this.contains(_barLayer)) {
					removeChild(_barLayer);					
				}
			}
			_barLayer = null;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLER
		 * ----------------------------------------------------------------------------------------------------------*/
		
		private function onRemove(e:Event):void {
			_onStagePresent = false;
			//nullAllInstances();
		}
	}

}