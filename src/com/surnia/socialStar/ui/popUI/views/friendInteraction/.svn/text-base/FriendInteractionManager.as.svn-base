package com.surnia.socialStar.ui.popUI.views.friendInteraction
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;

	public class FriendInteractionManager
	{
		private var _friendInteractionPopup:FriendInteractionPopup;
		private var _gd:GlobalData = GlobalData.instance;
		
		private var _isoScene:IsoScene;
		private var _isoView:IsoView;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _helpInstanceArray = [];
		private var _challengeInstanceArray = [];
		private var _characterNodes:Array = [];
		private var _objectNodes:Array = [];
		
		private var _sdc:ServerDataController = ServerDataController.getInstance();
		
		public function FriendInteractionManager(isoScene:IsoScene, isoView:IsoView, characterNodes:Array, objectNodes:Array)
		{
			_objectNodes = objectNodes;
			_isoScene = isoScene;
			_isoView = isoView;
			_characterNodes = characterNodes;
		}
		
		public function updateCharNodesArray(characterNodes:Array):void{
			_characterNodes = characterNodes;
		}
		
		public function init():void{
			//initRoutes();
			initDisplay();
			addListeners();
		}
		
		private function initDisplay():void{
			var runningOn:String = Capabilities.playerType;
			
			if ( runningOn != 'StandAlone' ){
				var x:int = 0;
				var helpLen:int = _gd.friendRoutesHelpArray.length;
				var challengeLen:int = _gd.friendRoutesChallengeArray.length;
				
				var routeCount:int; 
				var fbid:String;
				var data:Array;
				var entry:String;
				
				var isoObject:IsoObject;
				var charNode:CharacterNode;
	
				if (_gd.totalRoute > 0){
					for (x = 0; x<helpLen; x++){
						routeCount = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_COUNT];
						fbid = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_FBID];
						data = _gd.getFriendHelpRouteData(fbid);
						entry = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_ENTRY];
						
						if (data[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM] == 1){
							isoObject = getIsoObjectByEntryID(data[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
							isoObject.showInteractionPortrait(entry, data[0], false, fbid );
						} else {
							charNode = getCharNodeOnCharID(data[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
							charNode.showHelpInteractionPortrait(entry, data[0], false, fbid);
						}
					}
					
					for (x = 0; x<challengeLen; x++){
						routeCount = _gd.friendRoutesChallengeArray[x][GlobalData.FRIENDROUTES_CHALLENGE_COUNT];
						fbid = _gd.friendRoutesChallengeArray[x][GlobalData.FRIENDROUTES_CHALLENGE_FBID];
						data = _gd.getFriendChallengeRouteData(fbid);
						entry = _gd.friendRoutesChallengeArray[x][GlobalData.FRIENDROUTES_CHALLENGE_ENTRY];
				
						charNode = getCharNodeOnCharID(data[0][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHARID]);
						if (charNode != null){
							charNode.showChallengeInteractionPortrait(entry, data[0], true, fbid);
						}
					}
				}
			}
		}

		private function getCharNodeOnCharID(charId:String):CharacterNode{
			var len:int = _characterNodes.length;
			var x:int = 0;
			for (x; x<len; x++){
				var charNode:CharacterNode = _characterNodes[x];
				if (charNode.charID == charId){
					return charNode;
				}
			}
			return null;
		}
		
		private function initRoutes():void{
			_helpInstanceArray = [];
			_challengeInstanceArray = [];
			var x:int = 0;
			var helpLen:int = _gd.friendRoutesHelpArray.length;
			var challengeLen:int = _gd.friendRoutesChallengeArray.length;
			
			if (_gd.totalRoute > 0){
				for (x = 0; x<helpLen; x++){
					
					var helpRouteCount = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_COUNT];
					var helpFBID:String = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_FBID];
					var helpEntry:String = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_HELP_ENTRY];
					var helpData:Array = _gd.getFriendHelpRouteData(helpFBID);
					var isItem:Boolean;
					if (helpData[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM] == 1){
						isItem = true; 	
					} else {
						isItem = false;
					}
					
					if (isItem){
						var isoObject:IsoObject = getIsoObjectByEntryID(helpData[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
						var containerSprite:MovieClip = isoObject.skin;
						_friendInteractionPopup = new FriendInteractionPopup(helpEntry, helpData, helpFBID, helpRouteCount, false, isItem, _isoScene, new Point(containerSprite.width, containerSprite.height), _characterNodes);
					} else {
						_friendInteractionPopup = new FriendInteractionPopup(helpEntry, helpData, helpFBID, helpRouteCount, false, isItem,  _isoScene, null, _characterNodes);
					}
					
					_friendInteractionPopup.init();
					_friendInteractionPopup.setSize(_gd.CELL_SIZE, _gd.CELL_SIZE, 11);
					_isoScene.addChild(_friendInteractionPopup);
					_helpInstanceArray.push(_friendInteractionPopup);
					
					if (isItem){
						var objectData:Array = _gd.getOfficeStateDataByEntryID(helpData[x][GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
						var objectDimension:Vector3D = objectData[GlobalData.OFFICESTATE_DIMENSION];
						var objectPosition:Point = helpData[0][GlobalData.FRIENDROUTES_HELP_ROUTE_POSITION];
						_friendInteractionPopup.moveTo(objectPosition.x * _gd.CELL_SIZE, objectPosition.y * _gd.CELL_SIZE, 11);
					} else {
						var charNode:CharacterNode = getCharNodeOnCharID(helpData[0][GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
						_friendInteractionPopup.moveTo(charNode.xPos, charNode.yPos, 11);
					}
					_isoScene.render();
				}
				
				for (x = 0; x<challengeLen; x++){
					var challengeRouteCount = _gd.friendRoutesChallengeArray[x][GlobalData.FRIENDROUTES_CHALLENGE_COUNT];
					var challengeFBID:String = _gd.friendRoutesChallengeArray[x][GlobalData.FRIENDROUTES_CHALLENGE_FBID];
					var challengeEntry:String = _gd.friendRoutesHelpArray[x][GlobalData.FRIENDROUTES_CHALLENGE_ENTRY];
					var challengeData:Array = _gd.getFriendChallengeRouteData(helpFBID);						
					_friendInteractionPopup = new FriendInteractionPopup(challengeEntry, challengeData, challengeFBID, challengeRouteCount, true);
					_isoScene.addChild(_friendInteractionPopup);
					_challengeInstanceArray.push(_friendInteractionPopup);
					
					var charNode:CharacterNode = getCharNodeOnCharID(challengeData[0][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE_CHARID]);
					
					_friendInteractionPopup.x = charNode.xPos * _gd.CELL_SIZE;
					_friendInteractionPopup.y = charNode.yPos  * _gd.CELL_SIZE;
					
					_isoView.render();
				}
			}
		}
		
		private function onFriendInteractionReject(ev:FriendInteractionEvent):void{
			var target:FriendInteractionPopup = ev.params.popup as FriendInteractionPopup;
			var challenge:Boolean = ev.params.challenge;
			var item:Boolean = ev.params.item;
			var id:String = ev.params.id;
			var arr:Array = [target];
			var fbid:String = ev.params.fbid;
			var isoObject:IsoObject = getIsoObjectByEntryID(id);
			var charNode:CharacterNode = getCharNodeOnCharID(id);
			
			if (item){
				isoObject.hideInteractionPortrait(true);
			} else {
				if (!challenge){
					charNode.hideHelpInteractionPortrait(true);
				} else {
					charNode.hideChallengeInteractionPortrait(true);
				}
			}
			
			switch(ev.type)
			{
				case FriendInteractionEvent.FRIENDINTERACT_REJECTHELP:
				{
					//TweenLite.to(target.elementContainer, .3,{alpha:0, onComplete:onFriendInteractionRemove, onCompleteParams:arr});
					
					// server call that the help was rejected
					_sdc.routeHelp(fbid);
					break;
				}
				
				case FriendInteractionEvent.FRIENDINTERACT_REJECTREVENGE:
				{
					//TweenLite.to(target.elementContainer, .3,{alpha:0, onComplete:onFriendInteractionRemove, onCompleteParams:arr});
					
					// server call that the challenge was rejected
					_sdc.routeChallenge(fbid);
					break;
				}
			}
		}
		
		private function onFriendInteractionFinished(ev:FriendInteractionEvent):void{
			var target:FriendInteractionPortraitSingle = ev.params.target as FriendInteractionPortraitSingle;
			var arr:Array = [target];
			
			switch(ev.type)
			{
				case FriendInteractionEvent.FRIENDINTERACT_ROUTEHELPFINISHED:
				{
					target.destroy();
					break;
				}
					
				case FriendInteractionEvent.FRIENDINTERACT_ROUTECHALLENGEFINISHED:
				{
					//TweenLite.to(target, .3,{alpha:0, onComplete:onFriendInteractionRemove, onCompleteParams:arr});
					break;
				}
			}
		}
		
		private function addListeners():void{
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_REJECTHELP, onFriendInteractionReject);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_REJECTREVENGE, onFriendInteractionReject);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_ROUTEHELPFINISHED , onFriendInteractionFinished);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_ROUTECHALLENGEFINISHED, onFriendInteractionFinished);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTROUTE, onStartRoute);
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTCHALLENGE, onStartChallenge);
		}
		
		public function removeListeners():void{
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_REJECTHELP, onFriendInteractionReject);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_REJECTREVENGE, onFriendInteractionReject);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_ROUTEHELPFINISHED, onFriendInteractionFinished);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_ROUTECHALLENGEFINISHED, onFriendInteractionFinished);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTROUTE, onStartRoute);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTCHALLENGE, onStartChallenge);
		}
		
		private function onStartChallenge(ev:FriendInteractionEvent):void{
			//var fbid:String = ev.params.fbid as String;
			//var charNode:CharacterNode = getCharNodeByCharID(ev.params.id);
			//charNode.hideChallengeInteractionPortrait(true);
			//_sdc.routeChallenge(fbid);
		}
		
		private function onStartRoute(ev:FriendInteractionEvent):void{
			var target:FriendInteractionPopup = ev.params.popup as FriendInteractionPopup;
			var challenge:Boolean = ev.params.challenge;
			var item:int = ev.params.item;
			var id:String = ev.params.id;
			var fbid:String = ev.params.fbid;
			var height:Number = ev.params.height;
			var entry:String = ev.params.entry;
			var friendPic:Sprite = ev.params.friendPic;
			if (item == 1){
				var isoObject:IsoObject = getIsoObjectByEntryID(id);
			} else {
				var charNode:CharacterNode = getCharNodeOnCharID(id);
			}
			
			var routeData:Array = [];
			var portraitInstance:FriendInteractionPortraitSingle = new FriendInteractionPortraitSingle(friendPic, entry, fbid, height);
			portraitInstance.show();
			_isoScene.addChild(portraitInstance);
			portraitInstance.setSize(_gd.CELL_SIZE, _gd.CELL_SIZE, 11);
		
			if (item == 1){
				isoObject.hideInteractionPortrait();
				portraitInstance.moveTo(isoObject.gridX * _gd.CELL_SIZE,  isoObject.gridY * _gd.CELL_SIZE, 11);
			} else {
				if (challenge){
					charNode.hideChallengeInteractionPortrait();
				} else {
					charNode.hideHelpInteractionPortrait();
				}
				portraitInstance.moveTo(charNode.xPos * _gd.CELL_SIZE,  charNode.yPos * _gd.CELL_SIZE, 11);
			}
			
			_isoScene.render();
			routeData = _gd.getFriendHelpRouteData(fbid);
			startRouteAnimation(fbid, routeData, portraitInstance);
		}
		
		private function startRouteAnimation(fbid:String, routeArray:Array, portraitInstance:FriendInteractionPortraitSingle , counter:int = -1, jumpCounter:int = 0):void{	
			counter++;
			if (counter < routeArray.length){
				var arr:Array = [];
				var routeData:Array = routeArray[counter];
				var item:int = routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM];
				var tweenTime:Number = 1;
			}
			
			if (counter != 0){
				if (counter != routeArray.length){
					if (item == 1){
						Logger.tracer(this, "Next Friend Route: ITEM");
						var pos:Point = routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_POSITION];
						var isoObject:IsoObject = getIsoObjectByEntryID(routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
						arr = [fbid, routeArray, portraitInstance, counter, jumpCounter];
						TweenLite.to(portraitInstance, tweenTime, {portraitHeight:isoObject.skin.height});
						Tweener.addTween(portraitInstance, {time:tweenTime, x:pos.x  * _gd.CELL_SIZE , y:pos.y  * _gd.CELL_SIZE, transition:"linear", onUpdate:onTweenerUpdate, onComplete:jumpTween, onCompleteParams:arr});
					} else {
						Logger.tracer(this, "Next Friend Route: CHARACTER");
						var charNode:CharacterNode = getCharNodeByCharID(routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
						TweenLite.to(portraitInstance, tweenTime, {portraitHeight:charNode.char.height});
						arr = [fbid, routeArray, portraitInstance, counter, jumpCounter];
						Tweener.addTween(portraitInstance, {time:tweenTime, x:charNode.xPos * _gd.CELL_SIZE, y:charNode.yPos * _gd.CELL_SIZE, transition:"linear",  onUpdate:onTweenerUpdate, onComplete:jumpTween, onCompleteParams:arr});
					}
				} else if (counter == routeArray.length){
					var params:Object = new Object();
					params.target = portraitInstance;
					_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_ROUTEHELPFINISHED, params));
				}
			} else if (counter == 0){
				jumpTween(fbid, routeArray, portraitInstance, counter, jumpCounter);
				_sdc.routeHelp(fbid);
			}
		}
		
		private function jumpTween(fbid:String, routeArray:Array, portraitInstance:FriendInteractionPortraitSingle , counter:int = 0, jumpCounter:int = 0):void{
			
			Logger.tracer(this, "Friend Interaction Jump");
			jumpCounter++;
			var arr:Array = [];
			var routeData:Array = routeArray[counter];
			var item:int = routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ISITEM];
			if (jumpCounter == 1){
				arr = [fbid, routeArray, portraitInstance, counter, jumpCounter];
				TweenLite.to(portraitInstance.container, .4, {y:portraitInstance.container.y - 25, onComplete:jumpTween, onCompleteParams:arr});
			} else if (jumpCounter == 2){
				jumpCounter = 0;
				arr = [fbid, routeArray, portraitInstance, counter, jumpCounter];
				var params:Object = new Object();
				
				if (item == 1){
					var isoObject:IsoObject = getIsoObjectByEntryID(routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
					params.isoObject = isoObject;
					_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_STARTOBJECTROUTEREWARD, params));
				} else {
					var charNode:CharacterNode = getCharNodeByCharID(routeData[GlobalData.FRIENDROUTES_HELP_ROUTE_ID]);
					params.charNode = charNode;
					_es.dispatchEvent(new FriendInteractionEvent(FriendInteractionEvent.FRIENDINTERACT_STARTCHARACTERROUTEREWARD, params));				
				}
				TweenLite.to(portraitInstance.container, .4, {y:portraitInstance.container.y + 25, onComplete:startRouteAnimation, onCompleteParams:arr});
			}
		}
		
		private function onTweenerUpdate():void{
			_isoScene.render();
		}
		
		private function getIsoObjectByEntryID(entryID:String):IsoObject{
			var len:int = _objectNodes.length;
			for (var x:int = 0; x<len; x++){
				if (_objectNodes[x].entryid == entryID){
					return _objectNodes[x];
				}
			}
			return null;
		}

		private function getDimensionByIsoObject(isoObject:IsoObject):Point{
			var element:Sprite = isoObject.instance.container as Sprite;
			var dimension:Point;
			return (dimension = new Point(element.width , element.height));
		}
		
		private function getCharNodeByCharID(charID:String):CharacterNode{
			var len:int = _characterNodes.length;
			for (var x:int = 0; x<len; x++){
				if (_characterNodes[x].charID == charID){
					return _characterNodes[x];
				}
			}
			return null;
		}
	}
}