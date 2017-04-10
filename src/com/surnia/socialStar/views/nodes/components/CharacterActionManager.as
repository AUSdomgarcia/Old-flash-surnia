package com.surnia.socialStar.views.nodes.components
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IsoScene;
	
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.TrainingData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.test.PopUIManagerTest;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.PopupManager;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	import com.surnia.socialStar.views.nodes.effects.CurtainFX;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class CharacterActionManager extends EventDispatcher
	{
		private var  _characterNodesArray:Array = []; 
		private var _scene:IsoScene;
		private var _selectedCharNode:CharacterNode;
		
		private var _sdc:ServerDataController = ServerDataController.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _pm:PopUpUIManager = PopUpUIManager.getInstance();
		
		private var _movement:CharacterMovementManager;
		
		private var _objectArray:Array = [];
		
		public function CharacterActionManager(characterNodesArray:Array, scene:IsoScene, movement:CharacterMovementManager, objectArray:Array)
		{
			_characterNodesArray = characterNodesArray;
			_scene = scene;
			_movement = movement;
			_objectArray = objectArray;
		}
		
		/**
		 * Updates the characterNodeArray where the characters are contained
		 * @param pathGrid - the pathgrid used in the iso world.
		 */	
		
		public function updateCharacterNodeContainer(characterNodesArray:Array):void{
			_characterNodesArray = characterNodesArray;
		}
		
		public function updateObjectArray(objectArray:Array):void{
			_objectArray = objectArray;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Soothing or cry character
		
		/**
		 * Soothes a character and updates the server
		 * @param charNode - the character node to be soothed.
		 * 
		 */
		
		public function soothCharacter(charNode:CharacterNode = null):void{
			
			if (charNode){
				var char:CharacterNode = charNode;	
			} else if (_selectedCharNode){
				char = _selectedCharNode;
				_sdc.soothChar(charNode.charID, _gd.myFbId);
			}
			char.removeStatus(GlobalData.CHARACTER_EXPRESSION_CRY);
		}
		
		/**
		 * Makes the character cry. 
		 * @param charID - the characters ID.
		 * 
		 */		
		
		public function cryCharacter(charID:String):void{
			var charNode:CharacterNode = getCharacterNodeOnCharID(charID);
			charNode.addStatus(GlobalData.CHARACTER_EXPRESSION_CRY);
			charNode.addHoveringTextField(GlobalData.TFTYPE_CRY);
			_sdc.cryChar(charID);
		}
		
		
		/**
		 * Soothes a friend character and updates the server.
		 * @param charNode - the character node.
		 * 
		 */
		
		public function soothFriendCharacter(charNode:CharacterNode = null):void{
			if (charNode){
				var char:CharacterNode = charNode;
			} else if (_selectedCharNode){
				char = _selectedCharNode;
			}
			char.removeStatus(GlobalData.CHARACTER_EXPRESSION_CRY);
			_sdc.soothChar(char.charID, _gd.selectedFriendFbId);
			//char.addHoveringTextField(GlobalData.TFTYPE_SOOTHED);
		}
		
		/**
		 * Makes the character of a friend add the cry status and calls the specific status. 
		 * @param charID - the character's id
		 * 
		 */		
		
		public function cryFriendCharacter(charID:String):void{
			var charNode:CharacterNode = getCharacterNodeOnCharID(charID);
			charNode.addStatus(GlobalData.CHARACTER_EXPRESSION_CRY);
			_sdc.cryChar(_selectedCharNode.charID);
			charNode.addHoveringTextField(GlobalData.TFTYPE_CRY);
			// todo: soothing call to sdc
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Reduce stress
		/**
		 * Adds the stress level to a character. 
		 * @param charNode - the character node.
		 * @param value - the value to be added.
		 * @param entryID - the entry id the training object which caused the stress.
		 * 
		 */
		
		private function addStress(charNode:CharacterNode, value:int = 5, entryID:String = ""):void{
			if (charNode){
				if (value <= 0 && !_gd.friendView){
					if (entryID == ""){
						_sdc.stressDownByClick(charNode.charID, _gd.myFbId );
					} else {
						_sdc.stressDownByItem(charNode.charID, entryID);
					}
				} else if (_gd.friendView){
					if (entryID == ""){
						_sdc.stressDownByClick(charNode.charID, _gd.selectedFriendFbId);
					} else {
						_sdc.stressDownByItem(charNode.charID, entryID);
					}
					//value = _gd.pSDP;
				}
				var currStressLevel:Number = charNode.stressLevel;
				if (charNode.stressLevel != 100){
					charNode.addedStressValue = checkRemainingValue(charNode.stressLevel,value);
				}
				charNode.addStressLevel(value);
				
				if (charNode.stressLevel >= 100){
					charNode.addStatus(GlobalData.CHARACTER_EXPRESSION_STRESSED);
				} else if (charNode.stressLevel < 100 && charNode.stressLevel >= 0) {
					charNode.removeStatus(GlobalData.CHARACTER_EXPRESSION_STRESSED);
				}
				
				//if (currStressLevel + value != _selectedCharNode.stressLevel + value && charNode.action != GlobalData.CHARACTER_ACTION_TRAINING){
				//	charNode.addStressTextField(value, 1);
				//}
			}
		}
		
		/**
		 * Cheacks the remaining value of the stress.
		 * @param stressValue - the current stress value.
		 * @param addedValue - the value to be added
		 * @return - the real number to be added.
		 * 
		 */		
		
		public function checkRemainingValue(stressValue:Number, addedValue:Number):Number{
			var remVal:Number = 0;
			if (stressValue + addedValue > 100){
				remVal = 100 - stressValue;
				return remVal;
			} else if (stressValue + addedValue < 0){
				return stressValue
			} else {
				return addedValue;
			}
		}
		
		/**
		 * Checks the ap value and calls the ap popup when ap is below zero.
		 *	 
		 */
		
		public function checkPopup(apCost:int = 0):int{
			var apAfter:int = _gd.pAp - apCost;
			if (_gd.pAp <= 0 || apAfter < 0){
				_es.dispatchEvent(new SSEvent (SSEvent.ACTIONPOINT_POPUP));
			}
			return apAfter;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Set resting 
		/**
		 * Starts the character resting.
		 * @param isoObject - the resting object.
		 * 
		 */
		
		public function characterRest(isoObject:IsoObject):Boolean{
			var resting:Boolean = false;
			var xPos:int = 0;
			var yPos:int = 0;
			var restPos:Point = getCharPosByIsoObject(isoObject);
			var canRest:Boolean = false;
			
			if (_selectedCharNode){
				if (_selectedCharNode.selected){
					xPos = restPos.x;
					yPos = restPos.y;
					if (xPos >= 0 && xPos < _gd.expansion && yPos >= 0 && yPos < _gd.expansion){
						if (_gd.pathGrid.getWalkable(xPos, yPos)){
							canRest = true;
						}
						if (_selectedCharNode.xPos == xPos && _selectedCharNode.yPos == yPos ){
							canRest = true;
						}
					} 
					
					if (canRest == false) {
						_pm.loadWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
						_es.dispatchEvent(new DialogueEvent(DialogueEvent.CHARACTER_RESTING_DIALOGUE));
					}
				}
			}
			
			var apAfter:int = 0;
			var objectData:Array = _gd.getOfficeStateDataByEntryID(isoObject.entryid);
			if (objectData != null){
				apAfter = checkPopup(objectData[GlobalData.OFFICESTATE_APCOST]);
			}
	
			if (canRest && _selectedCharNode && _selectedCharNode.selected  && _gd.pAp > 0 && _selectedCharNode.stressLevel > 0 && apAfter >=0){
				if (_selectedCharNode.action == GlobalData.CHARACTER_ACTION_IDLE ){
					trace ("charcter resting.... " + _selectedCharNode.name + " with " + isoObject.name);
					resting = true;
					_movement.stopRandomMovementPerCharacter(_selectedCharNode);
					if (!_gd.friendView){
						if (_selectedCharNode.stressLevel - objectData[GlobalData.OFFICESTATE_REST_STRESS] > 0) {
							addStress(_selectedCharNode, -1 * objectData[GlobalData.OFFICESTATE_REST_STRESS], isoObject.entryid);
						} else {
							addStress(_selectedCharNode, -1 * _selectedCharNode.stressLevel, isoObject.entryid);
						}
					}
					
					_selectedCharNode.selectable = false;
					_selectedCharNode.action = GlobalData.CHARACTER_ACTION_RESTING;
					_selectedCharNode.restObject = isoObject;
					isoObject.selectable = false;
					isoObject.isUsed = 1;
					
					// set direction
					setCharacterDirection(isoObject, _selectedCharNode);
					
					var charNode:CharacterNode = checkAndGetNodeOnTraining(xPos, yPos);
					if (charNode != null){
						if (charNode != _selectedCharNode &&  charNode.action == GlobalData.CHARACTER_ACTION_TRAINING){
							_movement.setRandomPath(charNode);
						}
					}
					
					Logger.tracer(this, "Resting started: " + _selectedCharNode.charID + " - " + isoObject.entryid);
					curtainCall(_selectedCharNode, _selectedCharNode.x / _gd.CELL_SIZE, _selectedCharNode.y / _gd.CELL_SIZE, restPos, true);
					
					_selectedCharNode.resting = true;
					_gd.pathGrid.getNode(_selectedCharNode.xPos, _selectedCharNode.yPos).walkable = true;
					var arr:Array = [_selectedCharNode, restPos];
					TweenLite.to(_selectedCharNode.char, 1.0, {onComplete:onCharTransportComplete, onCompleteParams:arr});
					//TweenLite.to(_selectedCharNode.elementContainer, .5, {alpha:0});
					
					_selectedCharNode.removeBubble();
					_selectedCharNode.xPos = xPos;
					_selectedCharNode.yPos = yPos;
				}
			}
			return resting;
		}
		
		public function restingDone(charNode:CharacterNode):void{
			if (!_gd.friendView){
				var charData:Array = _gd.getCharDataOnCharID(charNode.charID);
				var objectData:Array = _gd.getOfficeStateDataByEntryID(charNode.restObject.entryid);
				charNode.addHoveringTextField(GlobalData.TFTYPE_STRESS, " " + -1 * objectData[GlobalData.OFFICESTATE_REST_STRESS]);
			} else {
				charData = _gd.getFriendCharDataOnCharID(charNode.charID);
				objectData = _gd.getOfficeStateDataByEntryID(charNode.restObject.entryid);
				charNode.addHoveringTextField(GlobalData.TFTYPE_STRESS, " " + -1 * objectData[GlobalData.FRIENDOFFICESTATE_REST_STRESS]);
			}
			charNode.setCharacterAnimation(GlobalData.PLAYER_STAND, 3);
			charNode.restObject.selectable = true;
			charNode.selectable = true;
			charNode.resting = false;
			charNode.characterRestResume = false;
			charNode.action = GlobalData.CHARACTER_ACTION_IDLE;
			charNode.stopRestTimer();
			charNode.restObject.isUsed = 0;
			_movement.startRandomMovementPerCharacter(charNode);
			
			var arr:Array = [charNode];
			TweenLite.to(charNode, 1, {onComplete:_movement.setRandomPath, onCompleteParams:arr});
			
			charNode.restObject = null;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Set training
		
		/**
		 * Starts the character training .
		 * @param isoObject - the training object.
		 * @param trainingType - the training type (sing, int, act, etc).
		 * 
		 */		
		
		public function characterTraining(isoObject:IsoObject, trainingType:String):Boolean{
			var trained:Boolean = false;
			var xPos:int = 0;
			var yPos:int = 0;
			var canTrain:Boolean = false;
			var trainingPos:Point = getCharPosByIsoObject(isoObject);
			if (_selectedCharNode){
				if (trainingType != "" && _selectedCharNode.selected){
					xPos = trainingPos.x;
					yPos = trainingPos.y;
					if (xPos >= 0 && xPos < _gd.expansion && yPos >= 0 && yPos < _gd.expansion){
						if (_gd.pathGrid.getWalkable(xPos, yPos)){
							canTrain = true;
						}
						if (_selectedCharNode.xPos == xPos && _selectedCharNode.yPos == yPos ){
							canTrain = true;
						}
					} 
					
					if (canTrain == false) {
						_pm.loadWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
						_es.dispatchEvent(new DialogueEvent(DialogueEvent.CHARACTER_TRAINING_DIALOGUE));
					}
				}
			}
			var apAfter:int = 0;
			var objectData:Array = _gd.getOfficeStateDataByEntryID(isoObject.entryid);
			if (objectData != null){
				apAfter = checkPopup(objectData[GlobalData.OFFICESTATE_APCOST]);
			}
			// changed to expansion
			if (canTrain){
				var charData:Array = _gd.getCharDataOnCharID(_selectedCharNode.charID);
				var charLevel:int = charData[GlobalData.CHARLIST_LEVEL];
				
				if (_selectedCharNode && !_gd.friendView &&  charLevel < 30 && _selectedCharNode.selected && _gd.pAp > 0 && apAfter >=0){
					if (_selectedCharNode.action == GlobalData.CHARACTER_ACTION_IDLE  && _selectedCharNode.stressLevel != 100 /*&& !_selectedCharNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY)*/){
						trained = true;
						trace ("charcter training.... " + _selectedCharNode.name + " with " + isoObject.name);
						
						//_sdc.updatePlayerHelpingEnergy(_gd.selectedFriendFbId, -1 + "");
						isoObject.selectable = false;
						_selectedCharNode.selectable = false;
						isoObject.isUsed = 1;
						_selectedCharNode.trainingObject = isoObject;
						
						// set direction
						setCharacterDirection(isoObject, _selectedCharNode);
						
						if (!_gd.friendView ){
							var objectDataArr:Array =  _gd.getOfficeStateDataByEntryID(isoObject.entryid);
							addStress( _selectedCharNode, objectDataArr[GlobalData.OFFICESTATE_TRAINING_STRESS]);
							trace ("Object training stress " + objectDataArr[GlobalData.OFFICESTATE_TRAINING_STRESS]);
						} else {
							objectDataArr =  _gd.getFriendOfficeStateDataByEntryID(isoObject.entryid);
							addStress( _selectedCharNode, objectDataArr[GlobalData.FRIENDOFFICESTATE_TRAINING_STRESS]);
							trace ("Object training stress " + objectDataArr[GlobalData.FRIENDOFFICESTATE_TRAINING_STRESS]);
						}
						
						var charNode:CharacterNode = checkAndGetNodeOnTraining(xPos, yPos);
						if (charNode != null){
							if (charNode != _selectedCharNode && charNode.action == GlobalData.CHARACTER_ACTION_TRAINING){
								_movement.setRandomPath(charNode);
							}
						}
						
						// start training (call start train function for _sdc
						_selectedCharNode.stressValueBeforeAdd = _selectedCharNode.stressLevel;
						Logger.tracer(this, "Training started: " + _selectedCharNode.charID + " - " + isoObject.entryid);
						
						curtainCall(_selectedCharNode, _selectedCharNode.x / _gd.CELL_SIZE, _selectedCharNode.y / _gd.CELL_SIZE, trainingPos, true);
						_selectedCharNode.trainingEntryID = isoObject.entryid;
						
						_selectedCharNode.action = GlobalData.CHARACTER_ACTION_TRAINING;
						_selectedCharNode.trainingType = trainingType;
						
						_sdc.startTrain(_selectedCharNode.charID, isoObject.entryid, getNewCharacterStatus(_selectedCharNode));						
						
						var len:int = _gd.trainingQeuee.length;
						var trainData:TrainingData;
						
						for (var i:int = 0; i < len; i++) 
						{
							trainData = _gd.trainingQeuee[ i ];
							if ( trainData.cid == _selectedCharNode.charID ) {
								_gd.trainingQeuee[ i ] = null;
								_gd.trainingQeuee.splice( i, 1 );
								break;
							}
						}
						
						var trainingdata:TrainingData = new TrainingData();
						trainingdata.cid = _selectedCharNode.charID;
						trainingdata.xpos = isoObject.x;
						trainingdata.ypos = isoObject.y;
						trainingdata.zpos = isoObject.z;
						_gd.trainingQeuee.push( trainingdata  );					
						
						
						// addStress(isoObject.stress)
						_gd.pathGrid.getNode(_selectedCharNode.xPos, _selectedCharNode.yPos).walkable = true;
						var arr:Array = [_selectedCharNode, trainingPos];
						TweenLite.to(_selectedCharNode.char, 1.0, {onComplete:onCharTransportComplete, onCompleteParams:arr});
						//TweenLite.to(_selectedCharNode.elementContainer, .5, {alpha:0});
						_movement.stopRandomMovementPerCharacter(_selectedCharNode);
						_selectedCharNode.removeBubble();
						_selectedCharNode.xPos = xPos;
						_selectedCharNode.yPos = yPos;
					}
				}
			}
			
			return trained;
		}
		
		/*	public function characterTrainingIndie(xPos:int , yPos:int , trainingType:String, stressUpValue:Number = 0, entryID:String = "pEDvBjPmN8BaFO7491IQ"):void{
		var charNode:CharacterNode = checkAndGetNodeOnTraining(xPos, yPos);
		if (charNode != null){
		if (charNode.action == GlobalData.CHARACTER_ACTION_TRAINING){
		setRandomPath(charNode);
		}
		}
		if (_selectedCharNode && _pathGrid.getNode(xPos, yPos).walkable){
		if (_selectedCharNode.action == GlobalData.CHARACTER_ACTION_IDLE  && _selectedCharNode.stressLevel != 100 && !_selectedCharNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY)){
		_selectedCharNode.trainingEntryID = entryID;
		_selectedCharNode.action = GlobalData.CHARACTER_ACTION_TRAINING;
		_selectedCharNode.trainingType = trainingType;
		_selectedCharNode.action = GlobalData.CHARACTER_ACTION_TRAINING;
		addStress(_selectedCharNode, stressUpValue);
		//_selectedCharNode.addedStressValue = 
		// pathfinding training system
		_selectedCharNode.destinationReached = false;
		_pathGrid.setStartNode(_selectedCharNode.xPos, _selectedCharNode.yPos);
		_pathGrid.setEndNode( xPos, yPos);
		
		findPath(_selectedCharNode);
		_pathGrid.getNode(_selectedCharNode.xPos, _selectedCharNode.yPos).walkable = true;
		var arr:Array = [_selectedCharNode];
		curtainCall(_selectedCharNode, _selectedCharNode.xPos, _selectedCharNode.yPos, true);
		TweenLite.to(_selectedCharNode.char, 2.5, {onComplete:onCharTransportComplete, onCompleteParams:arr});
		//TweenLite.to(_selectedCharNode.elementContainer, 0, {alpha:0});
		stopRandomMovementPerCharacter(_selectedCharNode);
		_selectedCharNode.removeBubble();
		_selectedCharNode.xPos = xPos;
		_selectedCharNode.yPos = yPos;
		}
		}
		}*/
		
		/**
		 * Gets the character position by the given IsoObject 
		 * @param isoObject - the iso object
		 * @return - the position of the free space
		 * 
		 */		
		
		private function getCharPosByIsoObject(isoObject:IsoObject):Point{
			var point:Point = new Point();
			if (isoObject.type == GlobalData.ITEMCATEGORY_TRAINING && (isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_HEALTH || isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_INT || isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_ATTRACTION)){
				if (isoObject.rotation == 0){
					point.x = isoObject.gridX + 1;
					point.y = isoObject.gridY;
				} else {
					point.x = isoObject.gridX;
					point.y = isoObject.gridY + 1;
				}
			} else if (isoObject.type == GlobalData.ITEMCATEGORY_MACHINE && isoObject.subType == GlobalData.ITEMTYPE_MACHINE_REST){
				if (isoObject.rotation == 0){
					point.x = isoObject.gridX;
					point.y = isoObject.gridY - 1;
				} else {
					point.x = isoObject.gridX - 1;
					point.y = isoObject.gridY;
				}
			} else {
				if (isoObject.rotation == 0){
					point.x = isoObject.gridX - 1;
					point.y = isoObject.gridY;
				} else {
					point.x = isoObject.gridX;
					point.y = isoObject.gridY - 1;
				}
			}
			return point;
		}
		
		/**
		 * Gets the object freespace based on the position of the object.
		 * @param objectData - the obeject data.
		 * @param friendMode - if the view is in friends view.
		 * @return - the position of the free space where the character will act.
		 * 
		 */		
		
		private function getCharPosByObjectData(objectData:Array, friendMode:Boolean = false):Point{
			var point:Point = new Point();
			if (!friendMode){
				if (objectData[GlobalData.OFFICESTATE_ROTATION] == 0){
					point.x = objectData[GlobalData.OFFICESTATE_POSITION].x;
					point.y = objectData[GlobalData.OFFICESTATE_POSITION].y - 1;
				} else {
					point.x = objectData[GlobalData.OFFICESTATE_POSITION].x - 1;
					point.y = objectData[GlobalData.OFFICESTATE_POSITION].y;
				}
			} else {
				if (objectData[GlobalData.FRIENDOFFICESTATE_ROTATION] == 0){
					point.x = objectData[GlobalData.FRIENDOFFICESTATE_POSITION].x;
					point.y = objectData[GlobalData.FRIENDOFFICESTATE_POSITION].y - 1;
				} else {
					point.x = objectData[GlobalData.FRIENDOFFICESTATE_POSITION].x - 1;
					point.y = objectData[GlobalData.FRIENDOFFICESTATE_POSITION].y;
				}
			}
			return point;
		}
		
		private function checkAndGetNodeOnTraining(xPos:int, yPos:int):CharacterNode{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i<len; i++){
				if (_characterNodesArray[i].xPos == xPos && _characterNodesArray[i].yPos == yPos){
					return _characterNodesArray[i];
					break;
				}
			}
			return null;
		}
		
		/**
		 * Calls a curtain instance. 
		 * @param charNode - the character node.
		 * @param xPos - the x position in grid spacce.
		 * @param yPos - the y position in grid spacce.
		 * @param isStart - if it is the start of the transportation.
		 * 
		 */		
		
		private function curtainCall(charNode:CharacterNode, xPos:int, yPos:int, position:Point, isStart:Boolean):void{
			// switched to expansion
				var gridTotalSizeX:int;
				var gridTotalSizeY:int;
				
			if (!isStart){
				//gridTotalSizeX = (_gd.CELL_SIZE * itemGridX) / 2 ;
				//gridTotalSizeY = (_gd.CELL_SIZE * itemGridY) / 2 - (_gd.CELL_SIZE * 2);
				gridTotalSizeX = _gd.CELL_SIZE * position.x;
				gridTotalSizeY = _gd.CELL_SIZE * position.y;
			} else {
				//gridTotalSizeX = (_gd.CELL_SIZE * xPos) / 2 ;
				//gridTotalSizeY = (_gd.CELL_SIZE * yPos) / 2 - (_gd.CELL_SIZE * 2);
				
				gridTotalSizeX = _gd.CELL_SIZE * xPos;
				gridTotalSizeY = _gd.CELL_SIZE * yPos;
			}
			//gridTotalSizeX = _gd.CELL_SIZE;
			//gridTotalSizeY = _gd.CELL_SIZE;
			var curtainSprite:IsoSprite = new IsoSprite();
			var curtain:CurtainFX = new CurtainFX();
			curtain.charNode = charNode;
			curtain.start = isStart;
			curtain.addEventListener(Event.ENTER_FRAME, onCurtainEnterFrame);
			//TweenLite.to(charNode.char, .2, {alpha:0, delay:.1});
			curtain.x += 7;
			var arr:Array = [curtainSprite, curtain];
			_scene.addChild(curtainSprite);
			curtainSprite.sprites = [curtain];
			curtain.y += 80;
			curtain.play();
			//curtain.addFrameScript(15, onCurtainHalf(charNode, isStart));
			curtainSprite.setSize(_gd.CELL_SIZE, _gd.CELL_SIZE, _gd.CELL_SIZE /*GlobalData.ISO_SPECIAL_OBJECT_DEPTH*/);
			//curtainSprite.moveTo((_gd.CELL_SIZE * xPos) - gridTotalSizeX, (_gd.CELL_SIZE * yPos) - gridTotalSizeY,  GlobalData.ISO_SPECIAL_OBJECT_DEPTH + 99);
			curtainSprite.moveTo(gridTotalSizeX, gridTotalSizeY,  GlobalData.ISO_CONTESTANT_EFFECTS + 40/*GlobalData.ISO_SPECIAL_OBJECT_DEPTH + 99*/);
			trace(_gd.CELL_SIZE);
			/*var targetX:int = xPos * _gd.CELL_SIZE;
			var targetY:int = yPos * _gd.CELL_SIZE;*/
			_scene.render();
			Tweener.addTween(curtainSprite, { delay:0, time:2.5, transition:"linear", onUpdate:onCharacterInstantTransition, onComplete:curtainRemove, onCompleteParams:arr});
		}
		
		/**
		 * Renders the scene. 
		 * 
		 */
		
		private function onCharacterInstantTransition():void{
			//_scene.render();
		}
		
		private function onCurtainEnterFrame(ev:Event):void{
			var target:CurtainFX = ev.target as CurtainFX;
			var currFrame:int = target.instance.currentFrame; 
			var halfFrame:int = target.instance.totalFrames / 2;
			if (target.start){
				if (currFrame > halfFrame){
					target.charNode.char.alpha = 0;
				} else {
					target.charNode.char.alpha = 1;
				}
				//trace ("character alpha on curtain call: " +  target.charNode.char.alpha);
			} else {
				if (currFrame < halfFrame){
					target.charNode.char.alpha = 0;
				} else {
					target.charNode.char.alpha = 1;
				}
				//trace ("character alpha on curtain call: " +  target.charNode.char.alpha);
			}
			if (currFrame == halfFrame){
				
			} else if (currFrame == target.instance.totalFrames){
				target.removeEventListener(Event.ENTER_FRAME, onCurtainEnterFrame);
			}
		}
		
		
		/*	private function onCurtainHalf(charNode:CharacterNode, isStart:Boolean):void{
		if (isStart){
		charNode.char.alpha = 0;
		charNode.elementContainer.alpha = 0;
		} else {
		charNode.char.alpha = 1;
		charNode.elementContainer.alpha = 1;
		}
		}*/
		
		/**
		 * Removes the curtain instance 
		 * @param curtainSprite - the curtain sprite instance. 
		 * @param curtain - the curtain mc instance.
		 * 
		 */		
		
		private function curtainRemove(curtainSprite:IsoSprite, curtain:CurtainFX):void{
			curtain = null;
			_scene.removeChild(curtainSprite);
			curtainSprite = null;
		} 
		
		/**
		 * Sets the attributes and calls the necessary 
		 * functions when character finishes transporting when training 
		 * @param charNode
		 * 
		 */		
		
		private function onCharTransportComplete(charNode:CharacterNode, position:Point):void{
			_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable = false;
			charNode.char.alpha = 0;
			var targetX:int = charNode.xPos * _gd.CELL_SIZE;
			var targetY:int = charNode.yPos * _gd.CELL_SIZE;
			//charNode.elementContainer.alpha = 0;
			//charNode.char.alpha = 0;
			Tweener.removeTweens(charNode);
			curtainCall(charNode, charNode.xPos, charNode.yPos, position, false);
			Tweener.addTween(charNode, { x:targetX, y:targetY, delay:0, time:0, transition:"linear", onUpdate:onCharacterInstantTransition});
			// for curtain timer only
			var arr:Array = [charNode];
			TweenLite.to(charNode.elementContainer, 1, { onComplete:statusProgress, onCompleteParams:arr});
			//TweenLite.to(charNode.char, .5, {alpha:1});
			//TweenLite.to(charNode.elementContainer, .5, {alpha:1});
		}
		
		/**
		 * Sets the appropriate animation and functions after curtain call is completed.  
		 * @param charNode - the character node.
		 * 
		 */	
		
		private function statusProgress(charNode:CharacterNode):void{
			//charNode.elementContainer.alpha = 1;
			//TweenLite.to(charNode.char, .2, {alpha:1});
			//var characterNode:CharacterNode = charNode;
			switch(charNode.action)
			{
				case GlobalData.CHARACTER_ACTION_TRAINING:
				{
					var objectData:Array = _gd.getOfficeStateDataByEntryID(charNode.trainingObject.entryid);
					charNode.setCharacterAnimation(charNode.trainingType, objectData[GlobalData.OFFICESTATE_TRAINING_DURATION] + 5);
					activateProgressBar(charNode);
					break;
				}
				case GlobalData.CHARACTER_ACTION_RESTING:
				{
					var objectData:Array = _gd.getOfficeStateDataByEntryID(charNode.restObject.entryid);
					var friendObjectData:Array = _gd.getFriendOfficeStateDataByEntryID(charNode.restObject.entryid);
					charNode.setCharacterAnimation(GlobalData.PLAYER_MOTIONGAMEPLAY, -1);
					activateProgressBar(charNode);
					/*if (!_friendViewMode){
					charNode.startRestTimer(objectData[GlobalData.OFFICESTATE_REST_DURATION]);
					} else {
					charNode.startRestTimer(objectData[GlobalData.FRIENDOFFICESTATE_REST_DURATION]);
					}*/
					break;
				}
			}
		}
		
		/**
		 * Flips the direction of the character based on the item.
		 * 
		 * @param isoObject - the training or resting object.
		 * @param charNode - the character under training or resting.
		 * 
		 */
		
		public function setCharacterDirection(isoObject:IsoObject, charNode:CharacterNode):void{
			Logger.tracer(this, "||---------------------------------------|| Get facing: " + charNode.getFacing());
			Logger.tracer(this, "||---------------------------------------|| Get item rotation: " + isoObject.rotation);
			Logger.tracer(this, "||---------------------------------------|| Character Flipped" );
			if (isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_SING || isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_ACTING){
				if (isoObject.rotation <= 0){
					//if (charNode.getFacing() == 0){
						charNode.characterFlip();
						charNode.isFlipped = true;
					//}
				}
			} else if (isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_HEALTH || isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_INT || isoObject.subType == GlobalData.ITEMCATEGORY_TRAINING_ATTRACTION){
				if (isoObject.rotation >= 1){
					//if (charNode.getFacing() == 1){
						charNode.characterFlip();
						charNode.isFlipped = true;
					//}
				} 
			} else if (isoObject.subType == GlobalData.ITEMTYPE_MACHINE_REST){
				if (isoObject.rotation >= 1){
					//if (charNode.getFacing() == 0){
					charNode.characterFlip();
					charNode.isFlipped = true;
					//}
				}
			}
		}
		
		/**
		 * Returns the original direction of the character based on the item.
		 * 
		 * @param isoObject - the training or resting object. 
		 * @param charNode - the chracter under training or resting.
		 * 
		 */
		
		public function returnCharacterDirection(charNode:CharacterNode):void{
			if (charNode.isFlipped){
				charNode.characterFlip();
				charNode.isFlipped = false;
			} 
		}
		
		private function activateProgressBar(characterNode:CharacterNode):void{
			EventSatellite.getInstance().dispatchEvent(new CharacterNodeEvent(CharacterNodeEvent.CHARACTER_PROGRESSBAR, {charNode:characterNode}));
		}
		
		/**T
		 * Retrieves the data pertaining to training.
		 *  
		 * @param charNode - the character node.
		 * @param charID - the character id.
		 * @param trainingType - the training type.
		 * @return - the Object containing the parameters.
		 * 
		 */		
		
		public function getTrainTypes(charNode:CharacterNode, charID:String = "", trainingType:String = ""):Object{
			var params:Object = new Object();
			var charID:String = charNode.charID;
			var trainingType:String = charNode.trainingType;
			
			if (!_gd.friendView){
				var trainArr:Array = _gd.getCharDataOnCharID(charID);
				var objectDataArr:Array =  _gd.getOfficeStateDataByEntryID(charNode.trainingEntryID);
				params.trainStress = objectDataArr[GlobalData.OFFICESTATE_TRAINING_STRESS];
			} else {
				trainArr = _gd.getFriendCharDataOnCharID(charID);
				objectDataArr = _gd.getFriendOfficeStateDataByEntryID(charNode.trainingEntryID);
				params.trainStress = objectDataArr[GlobalData.FRIENDOFFICESTATE_TRAINING_STRESS];
			}
			
			switch(trainingType)
			{
				case GlobalData.PLAYER_MOTIONACTING:
				{
					if (!_gd.friendView){
						var trainConst:int = GlobalData.OFFICESTATE_TRAINING_ACTING;
						var charConst:int = GlobalData.CHARLIST_ACTING;
					} else {
						trainConst = GlobalData.FRIENDOFFICESTATE_TRAINING_ACTING;
						charConst = GlobalData.FRIENDCHARLIST_ACTING;
					}
					params.expAdded = objectDataArr[trainConst];
					params.trainData =  trainArr[charConst];
					params.textType =  GlobalData.TFTYPE_ACTING;
					break;
				}
				case GlobalData.PLAYER_MOTIONATTRACT:
				{
					if (!_gd.friendView){
						trainConst = GlobalData.OFFICESTATE_TRAINING_ATTRACTION;
						charConst = GlobalData.CHARLIST_ATTRACTION;
					} else {
						trainConst = GlobalData.FRIENDOFFICESTATE_TRAINING_ATTRACTION;
						charConst = GlobalData.FRIENDCHARLIST_ATTRACTION;
					}
					params.expAdded = objectDataArr[trainConst];
					params.trainData =  trainArr[charConst];
					params.textType =  GlobalData.TFTYPE_ATTRACTION;
					break;
				}
				case GlobalData.PLAYER_MOTIONINTEL:
				{
					if (!_gd.friendView){
						trainConst = GlobalData.OFFICESTATE_TRAINING_INT;
						charConst = GlobalData.CHARLIST_INTELLIGENCE;
					} else {
						trainConst = GlobalData.FRIENDOFFICESTATE_TRAINING_INT;
						charConst = GlobalData.FRIENDCHARLIST_INTELLIGENCE;
					}
					params.expAdded = objectDataArr[trainConst];
					params.trainData =  trainArr[charConst];
					params.textType =  GlobalData.TFTYPE_INT;
					break;
				}
				case GlobalData.PLAYER_MOTIONSINGING:
				{
					if (!_gd.friendView){
						trainConst = GlobalData.OFFICESTATE_TRAINING_SING;
						charConst = GlobalData.CHARLIST_SING;
					} else {
						trainConst = GlobalData.FRIENDOFFICESTATE_TRAINING_SING;
						charConst = GlobalData.FRIENDCHARLIST_SING;
					}
					params.expAdded = objectDataArr[trainConst];
					params.trainData =  trainArr[charConst];
					params.textType =  GlobalData.TFTYPE_SING;
					break;
				}
				case GlobalData.PLAYER_MOTIONSTRENGTH:
				{
					if (!_gd.friendView){
						trainConst = GlobalData.OFFICESTATE_TRAINING_HEALTH;
						charConst = GlobalData.CHARLIST_HEALTH;
					} else {
						trainConst = GlobalData.FRIENDOFFICESTATE_TRAINING_HEALTH;
						charConst = GlobalData.FRIENDCHARLIST_HEALTH;
					}
					params.expAdded = objectDataArr[trainConst];
					params.trainData =  trainArr[charConst];
					params.textType =  GlobalData.TFTYPE_HEALTH;
					break;
				}
			}
			//trace data
			trace ("training reduction " + params.expAdded);
			trace ("training data " + params.trainData);
			trace ("training type " + params.textType);
			return params;
		}
		
		/**
		 * Sets the interactions on character click for friend or own character.
		 * @param charNode - the character node.
		 * 
		 */
		
		public function setFriendCharacterInteractionOnClick(charNode:CharacterNode):void{
			trace ("friend Interaction Click");
			if (_gd.friendView && _gd.pHE > 0 && _gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_LEVEL] < 30) {
				trace ("friend Interaction Click 2");
				// todo: server calls for experience add in character stats
				//charNode.showAvatarUI();
				_movement.stopRandomMovementPerCharacter(charNode);
				/*if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY)){
				charNode.action = GlobalData.CHARACTER_ACTION_SOOTHING;
				soothFriendCharacter();
				setCharacterActivityUpdates(charNode);
				} else */if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED)){
					trace ("Stress status detected and relieved");
					charNode.action = GlobalData.CHARACTER_ACTION_STRESSDOWN;
					addStress(charNode, -10);
					charNode.removeStatus(GlobalData.CHARACTER_EXPRESSION_STRESSED);
					setCharacterActivityUpdates(charNode);
				} else {
					/*if (_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_HEALTHTRAINER_NPCFBID] == _gd.myFbId){
					charNode.action = GlobalData.CHARACTER_ACTION_HEALTHBONUS;
					setCharacterActivityUpdates(charNode);
					} else if (_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_ACTINGTEACHER_NPCFBID] == _gd.myFbId){
					charNode.action = GlobalData.CHARACTER_ACTION_ACTIONBONUS;
					setCharacterActivityUpdates(charNode);
					} else if (_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_VOCALTRAINER_NPCFBID] == _gd.myFbId){
					charNode.action = GlobalData.CHARACTER_ACTION_SINGBONUS;
					setCharacterActivityUpdates(charNode);
					} else if (_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_PRIVATETEACHER_NPCFBID] == _gd.myFbId){
					charNode.action = GlobalData.CHARACTER_ACTION_INTBONUS;
					setCharacterActivityUpdates(charNode);
					} else if (_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_STYLIST_NPCFBID] == _gd.myFbId){
					charNode.action = GlobalData.CHARACTER_ACTION_ATTRACTIONBONUS;
					setCharacterActivityUpdates(charNode);
					} */
				}
			}
		}
		
		/**
		 * Sets the character activity updates like adding progress bar and calls to 
		 * server.
		 * @param charNode - the character node.
		 * 
		 */		
		
		private function setCharacterActivityUpdates(charNode:CharacterNode):void{
			_es.dispatchEvent(new CharacterNodeEvent(CharacterNodeEvent.CHARACTER_PROGRESSBAR, {charNode:charNode}));
			charNode.removeBubble();
			if (_gd.friendView){
				_sdc.updatePlayerHelpingEnergy(_gd.selectedFriendFbId, -1 + "");
				//_sdc.clickContestantForAddStats(charNode.charID, getNewCharacterStatus(_selectedCharNode));
			}
		}
		
		/**
		 * Sets the actions and calls when character is clicked.
		 * @param charNode - the character node.
		 * 
		 */		
		
		public function setCharacterInteractionOnClick(charNode:CharacterNode):void{
			// condition ensures that when training no other checks are made when character is clicked
			checkPopup();
			if (charNode.action == GlobalData.CHARACTER_ACTION_IDLE && !charNode.selected && !_gd.friendView){
				/*if (charNode.expression.length == 0 && !charNode.selected){
				charNode.showAvatarUI();
				} else*/ 
				/*if (_selectedCharNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY) && _gd.pAp > 0) {
				charNode.action = GlobalData.CHARACTER_ACTION_SOOTHING;
				soothCharacter(charNode);
				setCharacterActivityUpdates(charNode);
				} else*/ if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED) && _gd.pAp > 0){
					charNode.action = GlobalData.CHARACTER_ACTION_STRESSDOWN;
					addStress(charNode, -10);
					setCharacterActivityUpdates(charNode);
				}
			}
		}
		
		
		/**
		 * Sets the initial character rest condition, including it's position and duration of resting. 
		 * @param charNode - the character node.
		 * @param charData - the cahracter data.
		 * 
		 */		
		
		private function setInitialCharacterRest(charNode:CharacterNode, charData:Array):void{
			if (!_gd.friendView){
				var objectData:Array = _gd.getOfficeStateDataByEntryID(charData[GlobalData.CHARLIST_ITEMENTRYID]);
			} else {
				objectData = _gd.getFriendOfficeStateDataByEntryID(charData[GlobalData.FRIENDCHARLIST_ITEMENTRYID]);		
			}
			_movement.stopRandomMovementPerCharacter(charNode);
			var restPoint:Point = getCharPosByObjectData(objectData, _gd.friendView);
			
			charNode.randomMode = false;
			charNode.characterRestResume = true;
			charNode.moveTo(_gd.CELL_SIZE * restPoint.x, _gd.CELL_SIZE * restPoint.y,  GlobalData.ISO_CONTESTANT_DEPTH);
			//charNode.moveTo(0,0, 3);
			_scene.render();
			charNode.xPos = restPoint.x;
			charNode.yPos = restPoint.y;
			_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable = false;
			
			charNode.action = GlobalData.CHARACTER_ACTION_RESTING;
			charNode.resting = true;
			if (!_gd.friendView){
				charNode.restObject = getIsoObjectByEntryID(charData[GlobalData.CHARLIST_ITEMENTRYID]);
				charNode.startRestTimer(charData[GlobalData.CHARLIST_TIMELEFT]);
				charNode.setCharacterAnimation(GlobalData.PLAYER_MOTIONGAMEPLAY, -1);
			} else {
				charNode.restObject = getIsoObjectByEntryID(charData[GlobalData.FRIENDCHARLIST_ITEMENTRYID]);
				charNode.startRestTimer(charData[GlobalData.FRIENDCHARLIST_TIMELEFT]);
				charNode.setCharacterAnimation(GlobalData.PLAYER_MOTIONGAMEPLAY, -1);
			}
			
			if( charNode != null && charNode.restObject != null){
				charNode.restObject.selectable = false;
				//_selectedCharNode.selectable = false
				charNode.restObject.isUsed = 1;
			}
		}
		
		public function stopRestingCharacter(charNode:CharacterNode):void{
			_sdc.stopMachine(charNode.charID);
			charNode.setCharacterAnimation(GlobalData.PLAYER_STAND, 3);
			charNode.restObject.selectable = true;
			charNode.selectable = true;
			charNode.resting = false;
			charNode.characterRestResume = false;
			charNode.action = GlobalData.CHARACTER_ACTION_IDLE;
			charNode.stopRestTimer();
			charNode.restObject.isUsed = 0;
			_movement.startRandomMovementPerCharacter(charNode);
			
			var arr:Array = [charNode];
			TweenLite.to(charNode, 1, {onComplete:_movement.setRandomPath, onCompleteParams:arr});
			
			charNode.restObject = null;
		}
		
		public function set selectedCharNode(charNode:CharacterNode):void{
			_selectedCharNode  = charNode;
		}
		
		/**
		 * Method for getting the character node based on the characrer Id.
		 * 
		 * @param charID - the character id
		 * @return - the character node to be retrieved
		 * 
		 */		
		
		public function getCharacterNodeOnCharID(charID:String):CharacterNode{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_characterNodesArray[i].charID == charID){
					return _characterNodesArray[i];
					break;
				}
			}
			return null;
		}
		
		/**
		 * Creates an object which contains the added attributes for characters 
		 * abilities. 
		 * @param charNode - the character node.
		 * @return - the object with the new character parameters.
		 * 
		 */		
		
		private function getNewCharacterStatus (charNode:CharacterNode):Object{
			
			var  params:Object = new Object();
			
			// set the current stress level
			params.stress = charNode.stressLevel;
			
			// set the current condition of character
			/*if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_CRY)){
			params.cond = GlobalData.CHARACTER_EXPRESSION_CRY;
			} else */if (charNode.checkIfExpressionExists(GlobalData.CHARACTER_EXPRESSION_STRESSED)){
				params.cond = GlobalData.CHARACTER_EXPRESSION_STRESSED;
			} else {
				params.cond = GlobalData.CHARACTER_EXPRESSION_NORMAL;
			}
			
			// set the bonus ability
			var charData:Array = _gd.getCharDataOnCharID(charNode.charID);
			
			// set default values
			if (!_gd.friendView){
				params.health = charData[GlobalData.CHARLIST_HEALTH];
				params.sing = charData[GlobalData.CHARLIST_SING];
				params.intelligent = charData[GlobalData.CHARLIST_INTELLIGENCE];
				params.acting = charData[GlobalData.CHARLIST_ACTING];;
				params.attraction = charData[GlobalData.CHARLIST_ATTRACTION];
				
				//trace before results
				trace ("training health " + params.health);
				trace ("training sing " + params.sing);
				trace ("training int " + params.intelligent);
				trace ("training attraction " + params.attraction);
				trace ("training acting " + params.acting);
				
				var trainData:Object = getTrainTypes(charNode);
				
				switch(charNode.trainingType)
				{
					case GlobalData.PLAYER_MOTIONACTING:
					{
						params.acting += trainData.expAdded;
						break;
					}
					case GlobalData.PLAYER_MOTIONATTRACT:
					{
						params.attraction += trainData.expAdded;
						break;
					}
					case GlobalData.PLAYER_MOTIONINTEL:
					{
						params.intelligent += trainData.expAdded;					
						break;
					}
					case GlobalData.PLAYER_MOTIONSINGING:
					{
						params.sing += trainData.expAdded;
						break;
					}
					case GlobalData.PLAYER_MOTIONSTRENGTH:
					{
						params.health += trainData.expAdded;
						break;
					}
				}
				
			} else {
				
			}
			
			//trace after results
			trace ("training health " + params.health);
			trace ("training sing " + params.sing);
			trace ("training int " + params.intelligent);
			trace ("training attraction " + params.attraction);
			trace ("training acting " + params.acting);
			
			return params;
		}
		
		/**
		 * Method for gettin the IsoObject by the givent entryId
		 * @param entryId - the unique entry id of the object.
		 * @return - the IsoObject to be retrieved.
		 * 
		 */
		
		public function getIsoObjectByEntryID(entryId:String):IsoObject{
			var len:int = _objectArray.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if (_objectArray[i].entryid == entryId){
					return _objectArray[i];
					break;
				}
			}
			return null;
		}
	}
}