package com.surnia.socialStar.ui.popUI.views.friendInteraction
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IsoScene;
	
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class FriendInteractionPopup extends IsoSprite
	{
		private var _friendViewPopup:FriendVisitPopup;
		private var _routeArray:Array = [];
		private var _fbid:String = "";
		private var _routeCount:int = 0;
		private var _isChallenge:Boolean = false;
		private var _elementContainer:Sprite;
		private var _gd:GlobalData = GlobalData.instance;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _charData:Array = [];
		private var _isItem:Boolean = false;
		private var _objectDimension:Point;
		private var _characterPos:Point;
		private var _charNodeArray:Array;
		private var _scene:IsoScene;
		private var _entry:String;
		private var _counter:int = -1;
		private var _canHover:Boolean = true;
		private var _tweenYPos:int = 0;
		private var _jumpCounter:int = 0;
		private var _fpl:FriendPicLoader = FriendPicLoader.instance;
		
		public function FriendInteractionPopup(entry:String, routeArray:Array, fbid:String, routeCount:int, isChallenge:Boolean, isItem:Boolean = false, scene:IsoScene = null, objectDimension:Point = null, charNodeArray:Array = null)
		{
			_scene = scene;
			_entry = entry;
			_objectDimension = objectDimension;
			_isItem = isItem;
			_routeArray = routeArray;
			_fbid = fbid;
			_routeCount = routeCount;
			_isChallenge = isChallenge;
			_charNodeArray = _charNodeArray;
		}
		
		public function init():void{
			initAssets();
			//initFriendPic();
			addListeners();
		}
		
		public function show():void{
			init();
		}
		
		public function hide():void{
			removeListeners();
		}
		
		private function addListeners():void{
			_friendViewPopup.confWindow.ok.addEventListener(MouseEvent.CLICK, onConfirmClick);
			_friendViewPopup.confWindow.cancel.addEventListener(MouseEvent.CLICK, onConfirmClick);
			_friendViewPopup.viewPortrait.addEventListener(MouseEvent.ROLL_OVER, onPortraitHover);
			_friendViewPopup.confWindow.addEventListener(MouseEvent.ROLL_OUT, onPortraitHover);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_FRIENDPICLOADED, onFriendPicLoaded);
		}
		
		private function onConfirmClick(ev:MouseEvent):void{
			switch(ev.target)
			{
				case _friendViewPopup.confWindow.ok:
				{
					// start route animation
					if (_isChallenge){
						
					} else {
						startRoute();		
						_canHover = false;
					}
					break;
				}
				
				case _friendViewPopup.confWindow.cancel:
				{
					// reject help and remove instance
					var params:Object = new Object();
					params.popup = this;
					if (_isChallenge){
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_REJECTREVENGE, params));
					} else {
						_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_REJECTHELP, params));
					}
					break;
				}
			}
		}
		
		public function onPortraitHover(ev:MouseEvent):void{
			switch(ev.type)
			{
				case MouseEvent.ROLL_OVER:
				{
					if(_canHover){
						TweenLite.to(_friendViewPopup.confWindow, .2,{x:20});
						//_friendViewPopup.confWindow.alpha = 1;
						_friendViewPopup.confWindow.mouseChildren = true;
						_friendViewPopup.confWindow.mouseEnabled = true;
						break;
					}
				}
					
				case MouseEvent.ROLL_OUT:
				{
					TweenLite.to(_friendViewPopup.confWindow, .2,{x:-106.7});
					//_friendViewPopup.confWindow.alpha = 0;
					_friendViewPopup.confWindow.mouseChildren = false;
					_friendViewPopup.confWindow.mouseEnabled = false;
					break;
				}
			}
		}
		
		private function removeListeners():void{
			_friendViewPopup.confWindow.ok.removeEventListener(MouseEvent.CLICK, onConfirmClick);
			_friendViewPopup.confWindow.cancel.removeEventListener(MouseEvent.CLICK, onConfirmClick);
			_friendViewPopup.viewPortrait.removeEventListener(MouseEvent.ROLL_OVER, onPortraitHover);
			_friendViewPopup.confWindow.removeEventListener(MouseEvent.ROLL_OUT, onPortraitHover);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_FRIENDPICLOADED, onFriendPicLoaded);
		}
		
		private function initAssets():void{
			
			_elementContainer = new Sprite();
			
			sprites = [_elementContainer];
			
			_friendViewPopup = new FriendVisitPopup();
			_elementContainer.addChild(_friendViewPopup);
			
			/*_friendViewPopup.x = -68.5;
			_friendViewPopup.y = 13.55;*/
			//_friendViewPopup.confirmationWindow.mask = _friendViewPopup.confMask; 
			// have the initial y value based on the height of the character and item
			
			if (_isItem){
				_friendViewPopup.y -= _objectDimension.y/2;
			} else {
				_friendViewPopup.y -= 100;
			}
			
			if (_isChallenge){
				_friendViewPopup.viewPortrait.gotoAndPlay(2);
			} 
			
			_friendViewPopup.confWindow.mask = _friendViewPopup.confMask;
			
			//_friendViewPopup.confWindow.alpha = 0;
			_friendViewPopup.confWindow.mouseChildren = false;
			_friendViewPopup.confWindow.mouseEnabled = false;
		}
		
		private function initFriendPic():void{
			_fpl.loadFriendPic(_entry, _fbid, _isChallenge);
		}
		
		private function onFriendPicLoaded(ev:FriendInteractionEvent):void{
			
			var friendPic:Sprite = ev.params.friendPic as Sprite;
			var fbid:String = ev.params.fbid as String;
			var entry:String = ev.params.entry as String;
			Logger.tracer(this, "friend pic: " + friendPic);
			if (_entry == entry){
				_friendViewPopup.viewPortrait.addChild(friendPic);
				friendPic.x = 13;
				friendPic.y = 8;
			}
		}
		
		public function get routePopup():FriendVisitPopup{
			return _friendViewPopup;
		}
		
		private function get hover ():Boolean{
			return _canHover;
		}
		
		private function set hover (value:Boolean):void{
			_canHover = value;
		}
		
		private function startRoute():void{
			_counter++;
			var routeData:Array = _routeArray[_counter];
			//var arr:Array = [];
			if (_counter != _routeArray.length){
				if (routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM] == "true"){
					var pos:Point = routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_POSITION];
					//arr = [pos.x  * _gd.CELL_SIZE, pos.y  * _gd.CELL_SIZE];
					Tweener.addTween(this, {time:1, x:pos.x  * _gd.CELL_SIZE , y:pos.y  * _gd.CELL_SIZE, transition:"linear", onUpdate:onTweenerUpdate, onComplete:onTweenerComplete});
				} else {
					var charNode:CharacterNode = getCharNodeByCharID(routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
					//arr = [charNode.x * _gd.CELL_SIZE, charNode.y * _gd.CELL_SIZE]; 
					Tweener.addTween(this, {time:1, x:charNode.x * _gd.CELL_SIZE, y:charNode.y * _gd.CELL_SIZE, transition:"linear",  onUpdate:onTweenerUpdate, onComplete:onTweenerComplete});
				}
			} else if (_counter == _routeArray.length){
				var params:Object = new Object();
				params.popup = this;
				if (_isChallenge){
					_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_ROUTEHELPFINISHED, params));
				} else {
					_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_ROUTECHALLENGEFINISHED, params));
				}
			}
		}
		
		private function jumpTween():void{
			_jumpCounter++;
			var routeData:Array = _routeArray[_counter];
			if (_jumpCounter == 1){
				TweenLite.to(_friendViewPopup, .4, {y:_friendViewPopup.y - 25, onComplete:jumpTween});
			} else if (_jumpCounter == 2){	
				TweenLite.to(_friendViewPopup, .4, {y:_friendViewPopup.y + 25, onComplete:startRoute});
			}
		}
		
		private function onTweenerUpdate():void{
			_scene.render();
		}
		
		private function onTweenerComplete():void{
			_jumpCounter = 0;
			jumpTween();
		}
		
		private function checkIfItem(isItem:String):Boolean{
			if (isItem == "true"){
				return true;
			} else {
				return false;
			}
		}
		
		private function getCharNodeByCharID(charID:String):CharacterNode{
			var len:int = _charNodeArray.length;
			for (var x:int = 0; x<len; x++){
				if (_charNodeArray[x].charID == charID){
					return _charNodeArray[x];
				}
			}
			return null;
		}
		
		public function get elementContainer():Sprite{
			return _elementContainer;
		}
	}
}