package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.surnia.socialStar.config.GameConfig;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class PopupManager extends Sprite
	{		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTANTS		
		 * ----------------------------------------------------------------------------------------------------------*/
		public static const POPUP_YES:Boolean = true;	
		public static const POPUP_NO:Boolean = false;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/
		public var arrayPopup:Array = [];		
		private var _parent:Sprite;
		private var _parentLayer:Sprite;	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function PopupManager(parentLayer:Sprite) 
		{
			_parentLayer = parentLayer;				
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												ADD POPUP TO ARRAY		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function addPopup(popup:MovieClip):void {			
			arrayPopup.push(popup);		
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												DISPLAY POPUP		
		 * ----------------------------------------------------------------------------------------------------------*/	
		public function displayPopup(popup:int):void {
			var X:int, Y:int;
			trace(this, "Array Popup Length ", arrayPopup.length);
			if (arrayPopup[popup] != null) {				
				X =  (GameConfig.GAME_WIDTH /2)-(arrayPopup[popup].width /2) ;
				Y =  (GameConfig.GAME_HEIGHT  /2)-(arrayPopup[popup].height /2);
				arrayPopup[popup].show(_parentLayer,X, Y);
			}
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CLEAR ALL MINIGAME TO ARRAY		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function emptyPopup():void {	
			for (var i:int = arrayPopup.length; i > 0; i-- ) {				
				arrayPopup.pop();
				trace(this, "POP :", arrayPopup.length );
			}				
		}
		
	}

}