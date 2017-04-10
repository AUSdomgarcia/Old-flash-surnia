package com.surnia.socialStar.minigames.contestBattle.components 
{
	import com.greensock.*;
	import com.surnia.socialStar.minigames.contestBattle.components.gaugeBar.GaugeBarComponent;	
	import com.surnia.socialStar.minigames.contestBattle.components.timeComponent.TimeComponent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author DF
	 */
	public class TalentComponent extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/

		public var callBack:Function;
		public var callBackActive:Function;
		public var talentID:int;
		public var talentIcon:MovieClip;
		public var talentDuration:int;
		
		private var _time:TimeComponent;
		private var _progressBar:GaugeBarComponent;
		private var _bg:MovieClip;
		private var _mask:MovieClip;		
				
		private var _dur:int;
		private var _onGo:Boolean = false;
		private	var _gf:GlowFilter = new GlowFilter(0xFCD116, 1.0, 6, 6, 50);	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/

		public function TalentComponent(_callBackActive:Function,_callBack:Function, _talentID:int, _talentIcon:MovieClip, _talentDuration:int = 10) 
		{
			callBack = _callBack;
			callBackActive = _callBackActive;
			talentID 	= _talentID;
			talentIcon  = _talentIcon
			talentDuration = _talentDuration;
			
			initialization();
			displayIcon();
			
			addListener();
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			
			_time = new TimeComponent();			
			
			_bg = new SkillGaugeBarMC;
			_bg.alpha = 0;
			
			_mask = new SkillGaugeBarMC;
			_mask.alpha = 0;		
			
			_progressBar = new GaugeBarComponent(_bg, new SkillGaugeBarMC, _mask, 0, talentDuration);		
		}
		
		private function gotoAndtopFrame(val:int):void {
			talentIcon.gotoAndStop(val);
		}
		
		private function playFrame():void {
			talentIcon.play();
		}
		
		private function displayProgressBar():void {
			
			removeProgressBar();
			_progressBar.x = -(_bg.width/2);
			_progressBar.y =  18;					
			addChild(_progressBar);
		}
		
		private function removeProgressBar():void {
			if (_progressBar != null) {
				if (this.contains(_progressBar)) {
					removeChild(_progressBar);
				}
			}
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function gotoAndPlayFrame(val:int):void {
			talentIcon.gotoAndPlay(val);
		}		
		
		public function displayIcon():void {
			
			addChild(talentIcon);	
		}
		
		public function removeIcon():void {
			if (talentIcon !=null) {
				if (this.contains(talentIcon)) {
					removeChild(talentIcon);
				}
			}
		}
		
		public function displayIconTimer():void {
			gotoAndtopFrame(talentIcon.totalFrames);
			displayProgressBar();			
			_onGo = true;
			
			gotoAndPlayFrame(1);
		}
		
		public function removeIconTimer():void {
			playFrame();
			removeProgressBar();				
			_onGo = false;		
		}	
		
		public function addListener():void {
			talentIcon.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			talentIcon.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			talentIcon.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function removeListener():void {
			if (talentIcon != null) {
				if(this.contains(talentIcon)){
					talentIcon.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					talentIcon.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					talentIcon.removeEventListener(MouseEvent.CLICK, onMouseClick);
				}
			}
		}		
		
		public function resetComponent():void {
			_onGo = false;
			_time.resetTimer();
			_dur = _time.getPerSecond;
			_progressBar.setCurrentValue(_dur);
		}
		
		public function onUpdate():void {				
			if (_onGo == true) {		
				_time.updateTimer();
				_dur = _time.getPerSecond;
				_progressBar.setCurrentValue(_dur);
				
				
				if (_dur > talentDuration) {
					if (callBack != null) {
						_onGo = false;							
						_time.resetTimer();
					
						trace(this, "STOP TIMER");
						callBackActive();
					}
				}				
			}
		}
		
		public function nullAllInstances():void {
			removeListener();
			trace("CLEAN :", this);
			if (talentIcon != null) {
				if (this.contains(talentIcon)) {
					removeChild(talentIcon);				
				}
			}
			talentIcon = null;
			
			
			if (_progressBar != null) {				
				if (this.contains(_progressBar)) {					
					removeChild(_progressBar);	
					_progressBar.nullAllInstances();
				}
			}			
			_progressBar = null;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onMouseOver(e:MouseEvent):void {
			talentIcon.filters = [_gf];
		}
		
		private function onMouseOut(e:MouseEvent):void {
			talentIcon.filters = [];
		}
		
		private function onMouseClick(e:MouseEvent):void {
			talentIcon.filters = [];
			if (callBack != null) {					
				callBack(talentID);				
			}
		}
		
		private function onRemove(e:Event):void {
			nullAllInstances();
		}
		
		
	}

}