package com.surnia.socialStar.minigames.contestBattle.components 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author DF
	 */
	public class IconComponent extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *													VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		public var iconMC:MovieClip;		
		public var destinationX:int;
		public var destinationY:int;
		
		public var iconValue:int;
		public var callBack:Function;
		
		private	var _gf:GlowFilter = new GlowFilter(0xFCD116, 1.0, 6, 6, 50);	
		
		/*------------------------------------------------------------------------------------------------------------
		 *													CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function IconComponent(_iconMC:MovieClip=null,_destinationX:int = 0, _destinationY:int = 0, X:int = 0, Y:int = 0, _iconValue:int = 0, _callBack:Function = null) 
		{
			iconMC = _iconMC;
			destinationX = _destinationX;
			destinationY = _destinationY;
			
			this.x = X;
			this.y = Y;
			
			iconValue = _iconValue;
			callBack = _callBack;
			
			initialization();
			display();
			addListener();
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);	
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *													METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		
		private function initialization():void {
			
		}
		
		private function display():void {
			addChild(iconMC);
		}
		
		private function onIconClick():void {			
			flyTargetPosition(destinationX, destinationY);				
			if (callBack != null) {
				callBack(iconValue);
			}
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *													SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function setDestination(_destinationX:int = 0, _destinationY:int = 0):void {
			destinationX = _destinationX;
			destinationY = _destinationY;
		}
		
		public function flyTargetPosition(destinationX:int = 0, destinayionY:int = 0):void {
			
			TweenLite.to(iconMC, 1, {
				x:destinationX, 
				y:destinayionY, 
				rotation:0, 
				alpha:.5, 
				ease:Elastic.easeOut,
				onComplete:function ():void {
					if (iconMC != null) {
						removeChild(iconMC);						
					}
				}				
			});
		}
		
		public function addListener():void {
			iconMC.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			iconMC.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			iconMC.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function removeListener():void {
			if (iconMC != null) {
				if(this.contains(iconMC)){
					iconMC.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					iconMC.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
					iconMC.removeEventListener(MouseEvent.CLICK, onMouseClick);
				}
			}
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *													EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function onMouseOver(e:MouseEvent):void {
			iconMC.filters = [_gf];
		}
		private function onMouseOut(e:MouseEvent):void {
			iconMC.filters = [];
		}
		
		private function onMouseClick(e:MouseEvent):void {
			onIconClick();			
		}
		
		private function onRemove(e:Event):void {
			nullAllInstances();
		}
		
		public function nullAllInstances():void {
			removeListener();
			if (iconMC !=null) {
				if (this.contains(iconMC)) {
					removeChild(iconMC);									
				}
			}
			iconMC = null;
		}
	}

}