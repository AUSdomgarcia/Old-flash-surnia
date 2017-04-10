package com.surnia.socialStar.ui.popUI.views.friendInteraction
{
	import as3isolib.display.IsoSprite;
	
	//import com.adobe.air.filesystem.VolumeMonitor;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	
	import flash.debugger.enterDebugger;
	import flash.display.Sprite;

	public class FriendInteractionPortraitSingle extends IsoSprite
	{
		private var _friendPortrait:Portrait;
		private var _fbId:String;
		private var _height:Number;
		private var _entry:String;
		private var _container:Sprite;
		private var _friendPic:Sprite;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _fpl:FriendPicLoader = FriendPicLoader.instance;
		
		public function FriendInteractionPortraitSingle(friendPic:Sprite, entry:String, fbid:String, height:Number)
		{
			_fbId = fbid;
			_height = height;
			_entry = entry;
			_friendPic = friendPic;
			init();
		}
		
		private function init():void{
			_container = new Sprite()
			_container.y -= _height;
			sprites = [_container];
		}
		
		public function get portraitHeight():Number{
			return _height;
		}
		
		public function set portraitHeight(value:Number):void{
			_height = value;
			_container.y = 0;
			_container.y -= _height;
		}
		
		public function get instance():Sprite{
			return _friendPortrait;
		}
		
		public function set instance(sprite:Sprite):void{
			_friendPortrait = sprite as Portrait;
		}
		
		public function show():void{
			_friendPortrait = new Portrait();
			_container.addChild(_friendPortrait);
			setFriendPic();
		}
		
		private function setFriendPic():void{
			_friendPortrait.addChild(_friendPic);
			_friendPic.x = -37;
			_friendPic.y = -78;
		}
		
		public function destroy():void{
			TweenLite.to(_friendPortrait, .3,{alpha:0, onComplete:remove});
		}
		
		private function remove():void{
			_container.removeChild(_friendPortrait);
			_friendPortrait = null;
		}
	}
}