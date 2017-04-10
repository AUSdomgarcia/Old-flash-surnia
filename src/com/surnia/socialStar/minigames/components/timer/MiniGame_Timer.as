package com.surnia.socialStar.minigames.components.timer
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Droids
	 */
	public class MiniGame_Timer extends EventDispatcher
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		public static const GAME_LOOP:String = "GameLoop";
		public static const TIME_UPDATED:String = "TimeUpdated";
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		public var timerSeconds:int=0;
		public var timerMinutes:int=0;
		private var _gameTick:int;
		private var _timer:Timer;
		private var _gameSpeed:Timer;
		private var _speed:int;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function MiniGame_Timer(gameSpeed:int=10, base:int=100)
		{
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, timeLoop);
			//
			_gameSpeed =new Timer(base-gameSpeed)
			_gameSpeed.addEventListener(TimerEvent.TIMER, gameLoop);
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		public function startGameTimer():void
		{
			_gameSpeed.start();
		}
		public function startClockTimer():void
		{
			_timer.start();
		}
		public function stopGameTimer():void
		{
			_gameSpeed.stop();
		}
		public function stopClockTimer():void
		{
			_timer.stop();
		}
		public function destroyMe():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, timeLoop);
			_gameSpeed.removeEventListener(TimerEvent.TIMER, gameLoop);
			_timer=null;
			_gameSpeed=null;
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		private function gameLoop(evt:TimerEvent):void
		{
			dispatchEvent(new Event(GAME_LOOP));
		}
		private function timeLoop(evt:TimerEvent):void
		{
			_gameTick += 1;
			if (_gameTick==(60))
			{
				_gameTick = 0;
				var tempSec:int = this.timerSeconds;
				if (tempSec>59)
				{
					this.timerMinutes += 1; //optional
					tempSec = 1;
				}
				else
				{
					tempSec += 1;
				}
				this.timerSeconds = tempSec;
				dispatchEvent(new Event(TIME_UPDATED));
			}
		}
	}
}