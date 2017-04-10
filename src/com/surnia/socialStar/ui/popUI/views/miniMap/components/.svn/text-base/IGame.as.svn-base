package com.surnia.socialStar.ui.popUI.views.miniMap.components
{
	import flash.display.DisplayObjectContainer;

	/**
	 * Interface for popups
	 */
	public interface IGame {		
		/**
		 * dispatches the result using 'MapEvent.GAME_FINISHED'
		 */
		function dispatchResult():void;
		/**
		 * returns the result using constant 'MiniGameManager.POOR, MiniGameManager.GOOD, etc'
		 */
		function get gameResult():Object
		/**
		 * Show on parent
		 */
		function show(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void;
		/**
		 *Remove
		 */
		function remove():void;
		/**
		 * True if it is on display, false if not
		 */
		function get visibility():Boolean;
	}
}