package com.surnia.socialStar.minigames.SoundEffect 
{
	import com.surnia.socialStar.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author domz
	 */
	public class MinigameSoundManager extends Sprite
	{
		//sfx
		public var CROWDBOO:String = "2";
		public var CROWDHAPPY:String = "3";
		public var HEARTACQUIRED:String = "4";
		public var SKILLACTIVE:String = "5";
		
		//bgm
		public var SOUND1:String = "2";
		public var SOUND2:String = "3";
		public var SOUND3:String = "4";
		
		public var isPlaying:Boolean = false;
		
		
		//Just add skill state and sfx sound at SoundManagerConfig
		
		private var _soundManager:SoundManager;
		
		public function MinigameSoundManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );	
		}
		
		private function init( e:Event ):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init );
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			initSManager();
		}
		
		private function destroy( e:Event ):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			_soundManager.refreshSoundManager();
		}
		
		public function initSManager():void {
			_soundManager = SoundManager.getInstance();
		}
		
		//Sfx
		public function set setSfxSound( val:String ):void {
			_soundManager.selectSoundEffect( Number(val) );				
		}
		
		public function playSfx():void {
		_soundManager.playSoundSfx();
		}
		
		public function setSfxVolume( val:Number ):void {
			_soundManager.setSfxVolume( val );
		}
		
		//Bgm
		public function set setBgm( val:String ):void {
			_soundManager.selectBgMusic( Number( val ));
		}
		
		public function setBgmVolume( val:Number ):void {
			_soundManager.SetBgmVolume( val );
		}
		
		public function muteNull():void {
			_soundManager.stopBgMusic();
		}
		
		public function playBgm():void {
			_soundManager.playBgMusic();
		}
		
		
	//end
	}
}