package com.surnia.socialStar.test
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.playerStatus.PlayerStatusManager;
	import com.surnia.socialStar.ui.playerStatus.event.PlayerStatusEvent;
	
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	[SWF (height = "630", width="760")]
	public class PlayerStatusTest extends Sprite
	{
		private var _playerStatusManager:PlayerStatusManager;
		private var _tokenHideShow:TextField;
		private var _toggleStars:TextField;
		private var _toggle:Boolean = true;
		private var _starRedStarShown:Boolean = true;
		private var _starsAddPoints:TextField;
		private var _helpingReduce:TextField;
		
		public function PlayerStatusTest()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		
		public function init(ev:Event = null):void{
			_tokenHideShow = new TextField();
			addChild(_tokenHideShow)
			_tokenHideShow.x = 400;
			_tokenHideShow.y = 300;
			_tokenHideShow.text = "click to hide or show";
			_tokenHideShow.width = 200;
			
			_toggleStars = new TextField();
			addChild(_toggleStars)
			_toggleStars.x = 400;
			_toggleStars.y = 350;
			_toggleStars.text = "click to toggle Stars";
			_toggleStars.width = 200;
			
			_starsAddPoints = new TextField();
			addChild(_starsAddPoints)
			_starsAddPoints.x = 400;
			_starsAddPoints.y = 400;
			_starsAddPoints.text = "click to add star points";
			_starsAddPoints.width = 200;
			
			_helpingReduce = new TextField();
			addChild(_helpingReduce)
			_helpingReduce.x = 400;
			_helpingReduce.y = 450;
			_helpingReduce.text = "click to remove helping energy";
			_helpingReduce.width = 200;
			
			//_tokenHideShow.mouseEnabled = false;
			_tokenHideShow.addEventListener(MouseEvent.CLICK, onClick);
			_toggleStars.addEventListener(MouseEvent.CLICK, onToggleClick);
			_starsAddPoints.addEventListener(MouseEvent.CLICK, onAddPoints);
			_helpingReduce.addEventListener(MouseEvent.CLICK, onRemoveEnergyPoints);
			//ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, "http://1.234.2.179/socialstardev/players/ui");
			ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, "testXML/playerui.xml");
			EventSatellite.getInstance().addEventListener(SSEvent.PLAYERXML_LOADED, onLoaded);
		}
		
		public function onRemoveEnergyPoints(ev:MouseEvent):void{
			GlobalData.instance.pHE = 4;
			EventSatellite.getInstance().dispatchEvent(new ServerDataControllerEvent(ServerDataControllerEvent.PLAYER_HELPINGENERGY_CHANGE));
		}
		
		public function onAddPoints(ev:MouseEvent):void{
			if (_starRedStarShown == true){
				ServerDataController.getInstance().setRedStarPoint(75);
			} else {
				ServerDataController.getInstance().setBlackStarPoint(75);
			}
		}
		
		public function onClick(ev:MouseEvent):void{
			
			if (_toggle == false){
				_toggle = true;
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_PLAYERSTATUS));
			} else {
				_toggle = false;
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_PLAYERSTATUS));
			}
		}
		
		private function onToggleClick(ev:MouseEvent):void{
			if (_starRedStarShown == true){
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_REDSTAR, {tweening:true}));
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_BLACKSTAR, {tweening:true}));
				_starRedStarShown = false;
			} else {
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.HIDE_BLACKSTAR, {tweening:true}));
				EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_REDSTAR, {tweening:true}));
				_starRedStarShown = true;
			}
		}
		
		public function onLoaded(ev:SSEvent):void{
			_playerStatusManager = new PlayerStatusManager(this);
			_playerStatusManager.start();
			EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_REDSTAR, {tweening:true}));
			EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_HELPINGENERGY));
			//EventSatellite.getInstance().dispatchEvent(new PlayerStatusEvent(PlayerStatusEvent.SHOW_BLACKSTAR, {tweening:true}));
		}
	}
}