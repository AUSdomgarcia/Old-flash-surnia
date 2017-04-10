package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.minigames.components.miniGameTemplate.miniGameTemplate;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class MiniGameManager extends Sprite
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTANTS		
		 * ----------------------------------------------------------------------------------------------------------*/
		public static const POOR:int = 0;
		public static const GOOD:int = 1;
		public static const EXCELLENT:int = 2;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/
		public var arrayGames:Array = [];
		public var arrayLogoIndex:Array = [];
		
		private var _parentLayer:Sprite;	
		private var _game:Game;
		
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MiniGameManager(parentLayer:Sprite) 
		{			
			_parentLayer = parentLayer;						
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												ADD MINIGAME TO ARRAY		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function showGame(games:Game):void {
			var X:int, Y:int;
			_game = games;				
			//arrayGames.push(games);
			X = (GameConfig.GAME_WIDTH  / 2) - (miniGameTemplate._GAME_CENTER_WIDTH) ;
			Y = (GameConfig.GAME_HEIGHT  / 2) - (miniGameTemplate._GAME_CENTER_HEIGHT);
			_game.showGame(_parentLayer, X, Y)
		}
		
		
		/*------------------------------------------------------------------------------------------------------------
		 *												DISPLAY MINIGAME		
		 * ----------------------------------------------------------------------------------------------------------*/	
		/*
		public function displayGame(game:int):void {
			var X:int, Y:int;
			
			if (arrayGames[game] != null) {					
				X = (GameConfig.GAME_WIDTH  / 2) - (miniGameTemplate._GAME_CENTER_WIDTH) ;
				Y = (GameConfig.GAME_HEIGHT  / 2) - (miniGameTemplate._GAME_CENTER_HEIGHT);
				//trace(this, "GAME ACTIVE ",arrayGames[game] );
				arrayGames[game].showGame(_parentLayer, X, Y);
			}
		}			
		*/
		/*------------------------------------------------------------------------------------------------------------
		 *												CLEAR ALL MINIGAME TO ARRAY		
		 * ----------------------------------------------------------------------------------------------------------*/
		/*------------------------------------------------------------------------------------------------------------
		 *												CLEAR ALL POPUP TO ARRAY		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function removeGame():void {				
			_game = null;			
		}	
		
	}

}