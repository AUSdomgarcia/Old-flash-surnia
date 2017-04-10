package com.surnia.socialStar.minigames.contestBattle.components 
{
	import com.greensock.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class TalentTab extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/		 
		public static const FORMATION_180_DEGREES:int = 180;
		public static const FORMATION_360_DEGREES:int = 360;
		
		public var arrayTalentComponent:Array = [];
		public var arrayTalentIcon:Array = [];
		public var talentLayer:Array = [];	
		public var duration:int;
		public var locX:int;
		public var locY:int;
		public var skillRadius:int;
		
		public var activeSkill:TalentComponent;
		public var callBack:Function;
		
		private var _formation:int = 180;
		private var _activeID:int;
		private var _onAI:Boolean = false;
		
		private var _onStagePresent:Boolean = true;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function TalentTab(_callBack:Function, talentIcons:Array, talentDuration:int = 1, componentRadius:int = 100, X:int = 0, Y:int = 0) 
		{
			nullAllInstances();
			_onStagePresent = true;
			
			callBack = _callBack;
			arrayTalentIcon = talentIcons;
			duration = talentDuration;			
			skillRadius = componentRadius;
			locX = X;
			locY = Y;
			
			initialization();
			display();
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function initialization ():void {	
			for (var i:int = 0; i < arrayTalentIcon.length; i++) {
				arrayTalentComponent.push(new  TalentComponent(onActiveSkill,onTalentClick,i, arrayTalentIcon[i], duration));		
			}	
		}			
	
		private function display():void {
			var skillRot:int;
			var skillGap:int = _formation / (arrayTalentComponent.length - 1);
			
			//set icon position through radius
			skillRadius = 0 - skillRadius;
			for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {	
				
				talentLayer[i] = new MovieClip;
				talentLayer[i].addChild(arrayTalentComponent[i]);
				arrayTalentComponent[i].x = skillRadius;
				
				arrayTalentComponent[i].rotationZ = -skillRot;
				talentLayer[i].rotationZ =  skillRot;
				addChild(talentLayer[i]);				
				
				 skillRot += skillGap;				
			}			
		}
		
		private function displayAllIcon():void {
			for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {
				if(_onStagePresent == true){
					arrayTalentComponent[i].displayIcon();
					arrayTalentComponent[i].removeIconTimer();
					arrayTalentComponent[i].gotoAndPlayFrame(1);
				}
			}
		}
		
		private function removeAllIcon():void {
			for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {
				if(_onStagePresent == true){
					arrayTalentComponent[i].removeIcon();
				}
			}
		}	
		
		private function onTalentClick(talentID:int):void {	
			removeListener();
			arrayTalentComponent[_activeID].resetComponent();
			_activeID = talentID;
					
			activeSkill = arrayTalentComponent[_activeID];	
			compressDisplayActiveTab();
		}
		
		private function onActiveSkill():void {
			if (_onAI == false ) {
				addListener();
			}			
			
			if(callBack != null){
				callBack(_activeID);
				
				if(_onAI == false ){
					collapseTabActive();
				}
			}
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		//PUBLIC METHOD SET SELECT SKILL
	
		public function setSelectedSkill(talentID:int):void {
			onTalentClick(talentID);
		}	
		
		public function setAI(onAI:Boolean = true):void {
			_onAI = onAI;
			removeListener();
		}
		
		public function setTalentFormation(fomation:int = TalentTab.FORMATION_180_DEGREES):void {
			_formation = fomation;			
			if (_formation == TalentTab.FORMATION_360_DEGREES) {
			
				_formation = _formation - (TalentTab.FORMATION_360_DEGREES / arrayTalentComponent.length);
			}			
		}
		
		//SET COMPRESS ALL TALENT SKILLS
		
		public function compressDisplayActiveTab():void {	
			if(_onStagePresent == true){
				for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {				
					TweenLite.to(arrayTalentComponent[i], 1, {				
						x:skillRadius,	
						y:0,
						rotationZ: -90,					
						onComplete: function():void {	
						
							removeAllIcon();						
							if (activeSkill != null) {	
									TweenLite.to(activeSkill, 0.5, {
										scaleX:1.2,
										scaleY:1.2
									} );
								activeSkill.displayIcon();
								activeSkill.displayIconTimer();
							}
						}					
					} );
					
					TweenLite.to(talentLayer[i], 1, {
						rotationZ:90
					} );									
				}	
			}
		}		
	
		//PUBLIC METHOD COLLAPSE ALL TALENT SKILLS (DISPLAY ACTIVE SKILL GAUGE BAR)		 
		
		public function collapseTabActive():void {
			if(_onStagePresent == true){
				var skillRot:int;
				var skillGap:int = _formation / (arrayTalentComponent.length - 1);
							
				for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {
					if (arrayTalentComponent[i] != activeSkill) {
						
						//All none activeSkill
						arrayTalentComponent[i].displayIcon();
						arrayTalentComponent[i].removeIconTimer();
						arrayTalentComponent[i].gotoAndPlayFrame(1);
					}
					TweenLite.to(arrayTalentComponent[i], 1, { 					
						x:skillRadius,	
						y:0,
						rotationZ: -skillRot,
						scaleX:1,
						scaleY:1
						
					} );	
					
					TweenLite.to(talentLayer[i], 1, {
						rotationZ:skillRot
					} );						
					
					 skillRot += skillGap;		
				}	
			}
		}
		
		
		//PUBLIC METHOD COLLAPSE ALL TALENT SKILLS (CLEAR ALL GAUGE BAR)
		
		public function collapseTabClear():void {
			if (_onStagePresent == true) {				
			
				var skillRot:int;
				var skillGap:int = _formation / (arrayTalentComponent.length - 1);		
				
				removeAllIcon();
				displayAllIcon();		
				
				for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {			
					TweenLite.to(arrayTalentComponent[i], 1, { 					
						x:skillRadius,
						y:0,
						rotationZ: -skillRot,
						scaleX:1,
						scaleY:1
					} );
					
					TweenLite.to(talentLayer[i], 1, {
						rotationZ:skillRot
					} );					
					 skillRot += skillGap;		
				}	
			
			}
		}		
	
		//PUBLIC METHOD SET RADIUS
		
		public function setRadius(componentRadius:int = 100):void {
			skillRadius = componentRadius;
		}
		
	
		//PUBLIC METHOD ADD ALL SKILL LISTENERS
		
		public function addListener():void {
			for (var i:int = 0; i < arrayTalentComponent.length;i++ ) {
				arrayTalentComponent[i].addListener();			
			}
		}
		
		
		//PUBLIC METHOD REMOVE ALL SKILL LISTENERS(FOR AI)
	
		public function removeListener():void {
			for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {
				if(arrayTalentComponent[i] !=null){
					arrayTalentComponent[i].removeListener();		
				}
			}
		}		
		
		 //PUBLIC METHOD UPDATE(TO BE CALLED ON ENTERFRAME)
	
		public function onUpdate():void {
		
			for (var i:int = 0; i < arrayTalentComponent.length; i++ ) {
				if(_onStagePresent == true){
					arrayTalentComponent[i].onUpdate();
				}
			}
		}
		
		public function nullAllInstances():void {	
			removeListener();
			trace("CLEAN :", this);
			for (var j:int = 0; j < arrayTalentComponent.length; j++ ) {
				TweenLite.killTweensOf(arrayTalentComponent[i]);
				if (arrayTalentComponent[j] !=null) {
					if (talentLayer[j].contains(arrayTalentComponent[j])) {
						talentLayer[j].removeChild(arrayTalentComponent[j]);						
					}
					arrayTalentComponent[j].nullAllInstances();
					arrayTalentComponent[j] = null;
				}
			}
			
			for (var i:int = 0; i < talentLayer.length; i++ ) {
				TweenLite.killTweensOf(talentLayer[i]);
				if (talentLayer[i] !=null) {
					if (this.contains(talentLayer[i])) {
						removeChild(talentLayer[i]);						
					}
					talentLayer[i] = null;
				}
			}
			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *									EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/	
		private function onRemove(e:Event):void {
			_onStagePresent = false;
			//nullAllInstances();
		}
	}

}