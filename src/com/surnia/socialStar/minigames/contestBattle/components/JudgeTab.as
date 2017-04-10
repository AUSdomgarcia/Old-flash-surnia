package com.surnia.socialStar.minigames.contestBattle.components 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class JudgeTab extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		public var judgeTableMC:JudgeTabMC;		
		public var callBack:Function;
		
		private var _iconComponent:IconComponent;
		private var _contestIcon:MovieClip;
		private var _judge:int;
		private var _iconType:int;		
		
		private var _judge1:MovieClip;
		private var _judge2:MovieClip;
		private var _judge3:MovieClip;
		
		private var _arrayJudge:Array = [];
		private var _arrayIconType:Array = [];
		private var _arrayIconComponent:Array = [null,null,null];	
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function JudgeTab(_callBack:Function) 
		{
			callBack = _callBack;
			
			initialization();
			display();
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization():void {
			judgeTableMC = new JudgeTabMC;
			_judge1 = new MovieClip;
			_judge2 = new MovieClip;
			_judge3 = new MovieClip;					
		}		
		
		private function display():void {
			var dis:int = 55
			
			addChild(judgeTableMC);
			
			_judge1.x = 80
			_judge1.y = 35;
			addChild(_judge1);
			
			_judge2.x = 80 + dis;
			_judge2.y = 35;
			addChild(_judge2);
			
			_judge3.x = 80 + (dis * 2);			
			_judge3.y = 35;
			addChild(_judge3);			
			
		}
		
		private function onIconClick(judge:int):void {		
			callBack(judge, _arrayJudge[judge]);		
		}		
		
		private function displayIconComponent(judge:int = 0):void {
			switch(judge) {
					case 0:						
						_judge1.addChild(_arrayIconComponent[judge]);
					
					break;
					case 1:						
						_judge2.addChild(_arrayIconComponent[judge]);
					
					break;
					case 2:						
						_judge3.addChild(_arrayIconComponent[judge]);
						
					break;				
				}		
		}
		
		private function removeIconComponent(judge:int = 0):void {			
			switch(judge) {
					case 0:		
					if (_arrayIconComponent[judge] != null) {
						if(_judge1.contains(_arrayIconComponent[judge])){
							_judge1.removeChild(_arrayIconComponent[judge]);
							
						}
					}
					break;
					case 1:						
						if (_arrayIconComponent[judge] != null) {
						if(_judge2.contains(_arrayIconComponent[judge])){
							_judge2.removeChild(_arrayIconComponent[judge]);
													
						}
					}
					break;
					case 2:						
						if (_arrayIconComponent[judge] != null) {
						if(_judge3.contains(_arrayIconComponent[judge])){
							_judge3.removeChild(_arrayIconComponent[judge]);
							
						}
					}
					break;				
				}		
				
				_arrayIconComponent[judge] = null;
				
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		
		 //PUBLIC METHOD SET JUDGE ICON

		public function setJudgeIcon(judge:int = 1, iconType:int = 1):void {		
			if (judge < 3 ) {				
				removeIconComponent(judge);	
				if (_arrayIconComponent[judge] == null) {	
					
					_arrayJudge[judge] = iconType;			
					
					_contestIcon = new ContestIcon;
					_contestIcon.gotoAndStop(iconType);						
					
					_arrayIconComponent[judge] = new IconComponent(_contestIcon, 0, 0, 0, 0, judge, onIconClick);
					
					if (iconType == _contestIcon.totalFrames ) {
						_arrayIconComponent[judge].removeListener();
					}
					else {
						_arrayIconComponent[judge].addListener();
					}
					
					displayIconComponent(judge);					
				}
			}				
		}
		
		public function getIsEmpty(judge:int = 0):Boolean {
			var isOccupied:Boolean = false
			if (_arrayIconComponent[judge] != null) {
				isOccupied = true;
			}
			
			return isOccupied;
		}
		
		public function nullAllInstances():void {	
			trace("CLEAN :", this);
			for (var i:int = 0; i < _arrayIconComponent.length; i++ ) {
				removeIconComponent(i);
			}
			
			if (judgeTableMC !=null) {
				if (this.contains(judgeTableMC)) {
					removeChild(judgeTableMC);					
				}
			}
			judgeTableMC = null;
			
			if (_judge1 !=null) {
				if (this.contains(_judge1)) {
					removeChild(_judge1);					
				}
			}
			_judge1 = null;
			
			if (_judge2 !=null) {
				if (this.contains(_judge2)) {
					removeChild(_judge2);					
				}
			}
			_judge2 = null;
			
			if (_judge3 !=null) {
				if (this.contains(_judge3)) {
					removeChild(_judge3);					
				}
			}	
			_judge3 = null;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onRemove(e:Event):void {
			//nullAllInstances();
		}
	}

}