package com.surnia.socialStar.ui.popUI.views.friendInteraction
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.flash_proxy;

	public class FriendInteractionPortraitPopup extends Sprite
	{
		private var _initialRouteData:Array = [];
		private var _fbId:String;
		private var _entry:String;
		private var _picLink:String;
		private var _friendVisitPic:Sprite;
		private var _friendChallengePic:Sprite;
		private var _popUp:FriendVisitPopup;
		private var _isChallenge:Boolean = false;
		private var _height:Number;
		private var _canHover:Boolean = true;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _fpl:FriendPicLoader = FriendPicLoader.instance;
		private var _gd:GlobalData = GlobalData.instance;
		private var _sdc:ServerDataController = ServerDataController.getInstance();
		
		public function FriendInteractionPortraitPopup():void{
			
		}
		
		public function show(entry:String, routeData:Array, height:Number, isChallenge:Boolean, fbid:String, tweening:Boolean = false):void{
			Logger.tracer(this,  "Show picture: " + "entry " + entry + ", fbid" + fbid);
			_initialRouteData = routeData;
			_isChallenge = isChallenge;			
			_height = height;
			_fbId = fbid;
			_entry = entry;
			
			initAsset();
			_popUp.y -= height;
			if (!tweening){
				_popUp.alpha = 1;
			} else {
				TweenLite.to(_popUp, .3,{alpha:1});
			}
			_popUp.mouseEnabled = true;
			_popUp.mouseChildren = true;
			setFriendPic();
			addListeners();
		}
		
		private function setFriendPic():void{
			_fpl.loadFriendPic(_entry, _fbId, _isChallenge);
		}
		
		private function onFriendPicLoaded(ev:FriendInteractionEvent):void{
			
			var entry:String = ev.params.entry as String;
			var challenge:Boolean = ev.params.entry as Boolean;
			
			if (_entry == entry){
				var friendPic:Sprite = ev.params.friendPic as Sprite;
				var fbid:String = ev.params.fbid as String;
				
				Logger.tracer (this, "friend pic added " + friendPic + " " + fbid + entry + " to portrait with entry" + _entry);
				var pic:Sprite;
				
				if (challenge){
					_friendChallengePic = new Sprite();
					_friendChallengePic.addChild(friendPic);
					pic = _friendChallengePic;
				} else {
					_friendVisitPic = new Sprite();
					_friendVisitPic.addChild(friendPic);
					pic = _friendVisitPic;
				}
				
				_popUp.viewPortrait.addChild(pic);
				friendPic.x = 13;
				friendPic.y = 8;
			}
		}
		
		public function hide(tweening:Boolean = false):void{
			if( _popUp != null ){
				if (!tweening){
					_popUp.alpha = 0;
				} else {
					TweenLite.to(_popUp, .3,{alpha:0, x:-106.7});
				}
				_popUp.mouseEnabled = false;	
				_popUp.mouseChildren = false;
				
				removeListeners();
				removeInstance();
			}
		}
		
		public function removeInstance():void{
			removeChild(_popUp);
			_popUp = null;
		}
		
		public function addListeners():void{
			_popUp.confWindow.ok.addEventListener(MouseEvent.CLICK, onHandleClick);
			_popUp.confWindow.cancel.addEventListener(MouseEvent.CLICK, onHandleClick);

			_popUp.viewPortrait.addEventListener(MouseEvent.ROLL_OVER, onPortraitHover);
			_popUp.confWindow.addEventListener(MouseEvent.ROLL_OUT, onPortraitHover);
			
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_FRIENDPICLOADED, onFriendPicLoaded);
			_es.addEventListener(CharacterPanelEvent.REVENGE_ACCEPTED, onRevengeAccepted);
		}
		
		private function onRevengeAccepted(ev:CharacterPanelEvent):void{
			var fbid:String = ev.params.fbid; 
			if (fbid == _fbId){
				_sdc.routeChallenge(fbid);
				hide(true);
			}
		}
		
		public function onPortraitHover(ev:MouseEvent):void{
			switch(ev.type)
			{
				case MouseEvent.ROLL_OVER:
				{
					if (_canHover) {
						if( _popUp.confWindow != null ){
							TweenLite.to(_popUp.confWindow, .2, { x:20 } );						
							//_friendViewPopup.confWindow.alpha = 1;
							_popUp.confWindow.mouseChildren = true;
							_popUp.confWindow.mouseEnabled = true;
							_gd.isRevenge = true;
							_gd.isRevengeFbid = _fbId;
							_gd.isRevengeCharID = _initialRouteData[GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHALLENGERCHARID];
						}
					}
					break;
				}
					
				case MouseEvent.ROLL_OUT:
				{
					TweenLite.to(_popUp.confWindow, .2,{x:-106.7});
					//_friendViewPopup.confWindow.alpha = 0;
					_popUp.confWindow.mouseChildren = false;
					_popUp.confWindow.mouseEnabled = false;
					break;
				}
			}
		}
		
		public function onHandleClick(ev:MouseEvent):void{
			switch(ev.target)
			{
				case _popUp.confWindow.ok:
				{
					Logger.tracer(this, "Friend route confirmation ok clicked");
					
					var params:Object = new Object();
					params.popup = this;
					params.challenge = _isChallenge;
					params.fbid = _fbId;
					params.height = _height;
					params.entry = _entry;
					
					if (_isChallenge){
						params.friendPic = _friendChallengePic;
					} else {
						params.friendPic = _friendVisitPic;
					}
					
					if (!_isChallenge){
						_canHover = false;
						params.id = _initialRouteData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID];
						params.item = _initialRouteData[GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM];
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_STARTROUTE, params));
						trace(this, "RETURN 1 params.id /_isChallenge:", params.id, _isChallenge);
					} else {
						params.id = _initialRouteData[GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHARID];
						params.item = "false";
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_STARTCHALLENGE, params));
						trace(this, "RETURN 2 params.id /_isChallenge:", params.id, _isChallenge);
					}
					break;
				}
				
				case _popUp.confWindow.cancel:
				{
					Logger.tracer(this, "Friend route confirmation cancel clicked");
					// reject help and remove instance
					var params:Object = new Object();
					params.popup = this;
					
					
					params.challenge = _isChallenge;
					if (!_isChallenge){
						params.id = _initialRouteData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID];
						if (_initialRouteData[GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM] == 1){
							params.item = true;
						} else {
							params.item = false;
						}
					} else {
						params.id = _initialRouteData[GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHARID];
						params.item = false;
					}
					params.fbid = _fbId;
					params.height = _height;
					params.entry = _entry;
					if (_isChallenge){
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_REJECTREVENGE, params));
					} else {
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_REJECTHELP, params));
					}
					break;
				}
			}
		}
		
		public function initAsset():void{
			_popUp = new FriendVisitPopup();
			addChild(_popUp);
			
			if (!_isChallenge){
				_popUp.confWindow.confTextField.text = "Accept friend help?";
				_popUp.viewPortrait.gotoAndStop(1);
			} else {
				_popUp.confWindow.confTextField.text = "Get revenge?";
				_popUp.viewPortrait.gotoAndStop(2);
			}
			
			_popUp.confWindow.mask = _popUp.confMask;
			
			_popUp.confWindow.mouseChildren = false;
			_popUp.confWindow.mouseEnabled = false;
		}
		
		public function removeListeners():void{
			_popUp.confWindow.ok.removeEventListener(MouseEvent.CLICK, onHandleClick);
			_popUp.confWindow.cancel.removeEventListener(MouseEvent.CLICK, onHandleClick);
			
			_popUp.viewPortrait.removeEventListener(MouseEvent.ROLL_OVER, onPortraitHover);
			_popUp.confWindow.removeEventListener(MouseEvent.ROLL_OUT, onPortraitHover);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_FRIENDPICLOADED, onFriendPicLoaded);
			_es.removeEventListener(CharacterPanelEvent.REVENGE_ACCEPTED, onRevengeAccepted);
		}
		
	}
}