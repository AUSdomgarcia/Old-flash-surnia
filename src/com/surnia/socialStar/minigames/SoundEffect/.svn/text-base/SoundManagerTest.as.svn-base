package com.surnia.socialStar.minigames.SoundEffect 
{
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class SoundManagerTest extends Sprite
	{
		
		private var _s:MinigameSoundManager = new MinigameSoundManager();
		private var fp:FrameRateViewer=new FrameRateViewer();
		private var sx:MemoryProfiler=new MemoryProfiler();
		
		private var sq_arr:Array = [];
		
		public function SoundManagerTest()
		{
			init();
			initMemoryProfiler();
			makeShapeForButton();
		}
		
		private function init():void {
			// instanciation of sound class 'initSManager'
			_s.initSManager();
			//setting volume
			_s.setSfxVolume( 1 );
			_s.setBgmVolume( 1 );	
		}
		
		private function makeShapeForButton():void {
			var square:MovieClip;
			var sq_arr:Array = [];
			
			for ( var i:int = 0; i < 5; i++ ) {
				square = new MovieClip();
				sq_arr.push( square );
				
				square.indexnum = i;
				sq_arr[i].y = 300;
				sq_arr[i].x = ( 50 * i ) + 100;
				
				sq_arr[i].graphics.beginFill(0x0000FF);
				sq_arr[i].graphics.drawRect(0,0,40,40);
				sq_arr[i].graphics.endFill();
				sq_arr[i].addEventListener(MouseEvent.CLICK, onClick); 
				
				addChild( sq_arr[i] );
			}
		}
		
		private function onClick( e:Event ):void {
			// this is how to set bgm
			_s.setBgm = e.target.indexnum;
			_s.playBgm();
			// this is how to set sfx sound
			_s.setSfxSound = e.target.indexnum;
			_s.playSfx();
		}
		
		private function initMemoryProfiler():void {
			addChild(fp);
			addChild(sx);
		}
		
//end
	}
}