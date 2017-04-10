package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class GameObject extends MovieClip
	{
		private var game:RunningManTutorial = new RunningManTutorial;	
		private var _parentDisplay:DisplayObjectContainer;	
		private var _parent:Sprite;
		private var _playerData:Array = []
		
		private var _result:String = "EXCELLENT"
		public function GameObject(parent:Sprite) 
		{			
			_parent = parent;		
			this.addChild(game);			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			dispatchResult();	
			remove();
		}
		
		/* INTERFACE com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame */
		
		public function dispatchResult():void 
		{
			var params:Object = new Object;
			
			params.game = this;
			params.result = _result;
			_parent.dispatchEvent(new MapEvent(MapEvent.TUTORIAL_FINISHED, params));		
		}
	
		public function get gameResult():Object {
			return _result;
		}
		
		public function show(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void 
		{
			_parentDisplay = parentDisplay;
			
			//hide();
			_parentDisplay.addChild(this);
			
			this.x = X;
			this.y = Y;
		}
	
		public function remove():void 
		{			
			if (_parentDisplay != null) {			
				if (_parentDisplay.contains(this)) {						
					_parentDisplay.removeChild(this);
				}
			}
		}
		
		public function get visibility():Boolean 
		{
			return this.visible;
		}
		
	}

}