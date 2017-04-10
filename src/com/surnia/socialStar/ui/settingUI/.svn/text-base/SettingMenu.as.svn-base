package com.surnia.socialStar.ui.settingUI 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.tooltip.MiniTooltipManager;
	import com.surnia.socialStar.ui.settingUI.events.SettingUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SettingMenu extends Sprite
	{
		/*--------------------------------------------------------------------Constant-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Properties-----------------------------------------------------------------------*/
		private var _mc:SettingMenuMC;
		private var _bm:ButtonManager;
		private var _soundManager:SoundManager;
		private var _es:EventSatellite;
		private var _settingUIEvent:SettingUIEvent;
		private var _mtm:MiniTooltipManager = MiniTooltipManager.instance;
		/*--------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function SettingMenu() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			prepareControllers();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
			registerTooltipItem()
			checkSettings();
		}
		
		private function destroy(e:Event):void 
		{
			unregisterTooltipItem();
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*--------------------------------------------------------------------Methods-------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new SettingMenuMC();
			addChild( _mc );
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.fullScreenBtn );
			_bm.addBtnListener( _mc.musicBtn );
			_bm.addBtnListener( _mc.soundBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if (  _mc != null ) {
				_bm.removeBtnListener( _mc.fullScreenBtn );
				_bm.removeBtnListener( _mc.musicBtn );
				_bm.removeBtnListener( _mc.soundBtn );				
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function prepareControllers():void 
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener( ServerDataControllerEvent.SETTINGS_CHANGE, onSettingChange );
			
			_soundManager = SoundManager.getInstance();
			_soundManager.SetBgmVolume( .4 );
			_soundManager.setSfxVolume( .3 );
			_soundManager.selectBgMusic( 0 );				
			_soundManager.playBgMusic();
			
			//new
			_soundManager.muteBgm();
			_soundManager.muteSfx();
		}
		
		private function checkSettings():void {
			if (  GlobalData.instance.appBGM == 1 ) {
				_soundManager.unMuteBgm();
			}else {
				_soundManager.muteBgm();
			}
			
			if (  GlobalData.instance.appSFX == 1 ) {
				_soundManager.unMuteSfx();
			}else {
				_soundManager.muteSfx();
			}
			
			if ( _soundManager.bgmOff  ){
				_mc.musicBtn.gotoAndStop( 3 );
			}else{
				_mc.musicBtn.gotoAndStop( 1 );
			}
			
			if ( _soundManager.sfxOff  ){
				_mc.soundBtn.gotoAndStop( 3 );
			}else{
				_mc.soundBtn.gotoAndStop( 1 );
			}
		}	
		
		private function unregisterTooltipItem():void{						
			_mtm.unregisterItem(_mc.musicBtn);
			_mtm.unregisterItem(_mc.soundBtn);
			//_mtm.unregisterItem(_mc.zoomInBtn);
			//_mtm.unregisterItem(_mc.zoomOutBtn);
			_mtm.unregisterItem(_mc.fullScreenBtn);
		}
		
		private function registerTooltipItem():void{			
			_mtm.registerItem(_mc.musicBtn, "Toggle Music", -_mc.musicBtn.width*2.5, -_mc.musicBtn.y);
			_mtm.registerItem(_mc.soundBtn, "Toggle Sound",  -_mc.soundBtn.width*2.5, -_mc.soundBtn.y);
			//_mtm.registerItem(_mc.zoomInBtn, "Zoom In", -_mc.zoomInBtn.width*2.5, -_mc.zoomInBtn.y);
			//_mtm.registerItem(_mc.zoomOutBtn, "Zoom Out", -_mc.zoomOutBtn.width*2.5, -_mc.zoomOutBtn.y);
			_mtm.registerItem(_mc.fullScreenBtn, "Toggle Full Screen", -_mc.fullScreenBtn.width * 3.5, -_mc.fullScreenBtn.y);
		}
		/*--------------------------------------------------------------------Setters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Getters-------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------EventHandlers-------------------------------------------------------------------*/
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			//_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "fullScreenBtn":
					_settingUIEvent = new SettingUIEvent( SettingUIEvent.FULL_SCREEN_CLICK );
					trace( "[SettingUI]: Click FullScreen Toggle" );
				break;
				
				case "musicBtn":										
					trace( "see",_soundManager.bgmOff );
					if ( !_soundManager.bgmOff ) {
						_soundManager.muteBgm();
						_mc.musicBtn.gotoAndStop( 3 );
					}else {
						_mc.musicBtn.gotoAndStop( 1 );
						_soundManager.unMuteBgm();
						_soundManager.selectBgMusic( 0 );
						_soundManager.playBgMusic();						
					}
					
					_settingUIEvent = new SettingUIEvent( SettingUIEvent.MUSIC_ENABLE );
					trace( "musicBtn..." );
					break;
				break;				
				
				case "soundBtn":
					if ( !_soundManager.sfxOff ) {
						_soundManager.muteSfx();
						_mc.soundBtn.gotoAndStop( 3 );
					}else {
						_mc.soundBtn.gotoAndStop( 1 );
						_soundManager.unMuteSfx();
					}
					
					_soundManager.selectSoundEffect( 0 );				
					_soundManager.playSoundSfx();
					_settingUIEvent = new SettingUIEvent( SettingUIEvent.SOUND_ENABLE );
					trace( "soundBtn..." );
				break;
				
				//case "zoomInBtn":
					//_settingUIEvent = new SettingUIEvent( SettingUIEvent.ZOOM_OUT_CLICK );					
					//break;			
				//
				//case "zoomOutBtn":
					//_settingUIEvent = new SettingUIEvent( SettingUIEvent.ZOOM_IN_CLICK );					
					//break;
				
				default:
				break;
			}
			
			if( _settingUIEvent != null ){
				_es.dispatchESEvent( _settingUIEvent );
			}
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "fullScreenBtn":
					_mc.fullScreenBtn.gotoAndStop( 1 );
				break;
				
				case "musicBtn":					
					if ( _soundManager.bgmOff  ){
						_mc.musicBtn.gotoAndStop( 3 );
					}else{
						_mc.musicBtn.gotoAndStop( 1 );
					}
				break;				
				
				case "soundBtn":					
					if ( _soundManager.sfxOff  ){
						_mc.soundBtn.gotoAndStop( 3 );
					}else{
						_mc.soundBtn.gotoAndStop( 1 );
					}
				break;
				
				default:
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "fullScreenBtn":
					_mc.fullScreenBtn.gotoAndStop( 2 );
				break;
				
				case "musicBtn":					
					if ( _soundManager.bgmOff  ){
						_mc.musicBtn.gotoAndStop( 4 );
					}else{
						_mc.musicBtn.gotoAndStop( 2 );
					}
				break;				
				
				case "soundBtn":					
					if ( _soundManager.sfxOff  ){
						_mc.soundBtn.gotoAndStop( 4 );
					}else{
						_mc.soundBtn.gotoAndStop( 2 );
					}
				break;
				
				default:
				break;
			}
		}
		
		private function onSettingChange(e:ServerDataControllerEvent):void 
		{			
			checkSettings();
		}
	}

}