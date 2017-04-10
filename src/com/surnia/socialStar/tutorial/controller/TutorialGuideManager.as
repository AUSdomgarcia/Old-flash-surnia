package com.surnia.socialStar.tutorial.controller 
{
	import com.surnia.socialStar.tutorial.components.TutNpcGuide;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TutorialGuideManager extends Sprite
	{
		/*---------------------------------------------------------------Constant---------------------------------------------------------------------*/
		private static var _instance:TutorialGuideManager;
		/*---------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _tutGuideHolder:MovieClip;
		private var _tutGuideArray:Array;
		/*---------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		public function TutorialGuideManager( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		
		public static function getInstance():TutorialGuideManager 
		{
			if ( TutorialGuideManager._instance == null  ) {
				TutorialGuideManager._instance = new TutorialGuideManager( new SingletonEnforcer() );
			}
			
			return TutorialGuideManager._instance; 
		}
		
		private function destroy():void 
		{	
			removeTutGuide();
		}
		
		/*---------------------------------------------------------------Methods---------------------------------------------------------------------*/
		private function init():void 
		{
			_tutGuideHolder = new MovieClip();
			addChild( _tutGuideHolder );
			
			_tutGuideArray = new Array();
		}
		
		
		public function addTutGuide( type:String, script:String, xPos:Number, yPos:Number, offsetX:int, offsetY:int ):void 
		{
			var tutGuide:TutNpcGuide = new TutNpcGuide( type , script,xPos,yPos, offsetX, offsetY );
			_tutGuideHolder.addChild( tutGuide );
			_tutGuideArray.push( tutGuide );		
		}
		
		
		public function showTutGuide():void 
		{
			var len:int = _tutGuideArray.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _tutGuideArray[ i ] != null ) {					
					_tutGuideArray[ i ].visible = true;
				}
			}
		}
		
		public function hideTutGuide():void 
		{
			var len:int = _tutGuideArray.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _tutGuideArray[ i ] != null ) {					
					_tutGuideArray[ i ].visible = false;
				}
			}
		}
		
		public function removeTutGuide():void 
		{
			var len:int = _tutGuideArray.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _tutGuideArray[ i ] != null ) {
					if ( _tutGuideHolder.contains( _tutGuideArray[ i ]  ) ) {
						_tutGuideHolder.removeChild( _tutGuideArray[ i ]  );
						_tutGuideArray[ i ] = null;
						_tutGuideArray.splice( i, 1 );
					}
				}
			}
		}
		
		public function updateTutGuide( type:String, script:String, xPos:Number, yPos:Number, offsetX:int, offsetY:int  ):void 
		{
			var len:int = _tutGuideArray.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _tutGuideArray[ i ] != null ) {
					if ( _tutGuideArray[ i ].type == type ) {						
						_tutGuideArray[ i ].updateDisplay( script, xPos, yPos, offsetX, offsetY  );
					}
				}
			}
		}
		
		/*---------------------------------------------------------------Setters---------------------------------------------------------------------*/
		/*---------------------------------------------------------------Getters---------------------------------------------------------------------*/
		/*---------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		
	}
}

class SingletonEnforcer {}