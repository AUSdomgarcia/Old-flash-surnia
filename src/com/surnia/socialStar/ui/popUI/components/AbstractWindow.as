package com.surnia.socialStar.ui.popUI.components 
{		
	import com.surnia.socialStar.utils.interfaces.IWindow;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class AbstractWindow extends MovieClip implements IWindow
	{
		
		/*------------------------------------------------------------Constant------------------------------------------------------------*/
		
		/*------------------------------------------------------------Properties------------------------------------------------------------*/		
		private var _windowName:String;
		private var _winWidth:Number;
		private var _winHeight:Number;		
		/*------------------------------------------------------------Constructor------------------------------------------------------------*/
		
		public function AbstractWindow( windowName:String, windowSkin:MovieClip = null ) 
		{			
			if ( windowSkin == null ) {
				_winWidth = 0;
				_winHeight = 0;
			}else{
				_winWidth = windowSkin.width;
				_winHeight = windowSkin.height;
				trace( "abstarct window: ", windowSkin.width, windowSkin.height );
			}
			_windowName = windowName;
		}
		
		/*------------------------------------------------------------Mehods------------------------------------------------------------*/	 		
		
		public function initWindow():void 
		{
			//init some thinsg here.......
			//setUpStage();
		}
		
		public function clearWindow():void 
		{
			//clear some thinsg here.......
		}
		
		//private function setUpStage():void 
		//{	
			//if ( stage != null ){				
				//stage.stageFocusRect = false;
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				//stage.focus = this;
			//}
		//}	
		/*------------------------------------------------------------Setters------------------------------------------------------------*/
		public function set windowName(value:String):void 
		{
			_windowName = value;
		}
		
		public function set winWidth(value:Number):void 
		{
			_winWidth = value;
		}
		
		public function set winHeight(value:Number):void 
		{
			_winHeight = value;
		}	
		
		/*------------------------------------------------------------Getters------------------------------------------------------------*/
		public function get windowName():String 
		{
			return _windowName;
		}
		
		public function get winWidth():Number 
		{
			return _winWidth;
		}		
		
		public function get winHeight():Number 
		{
			return _winHeight;
		}
		
		/*------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		
	}

}