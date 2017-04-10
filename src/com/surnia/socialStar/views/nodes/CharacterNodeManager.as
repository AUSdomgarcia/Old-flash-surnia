package com.surnia.socialStar.views.nodes
{
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import com.surnia.socialStar.data.TrainingData;
	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.avatar.AvatarTooltipUIEvent;
	import com.surnia.socialStar.ui.component.progressBarProxy.ProgressBarManagerProxy;
	import com.surnia.socialStar.ui.component.progressBarProxy.event.ProgressBarEventProxy;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.friendInteraction.event.FriendInteractionEvent;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.utils.stringUtilManager.StringUtilManager;
	import com.surnia.socialStar.views.isoItems.DropItem;
	import com.surnia.socialStar.views.nodes.components.CharacterActionManager;
	import com.surnia.socialStar.views.nodes.components.CharacterMovementManager;
	import com.surnia.socialStar.views.nodes.components.CharacterSelectionManager;
	import com.surnia.socialStar.views.nodes.components.CharacterUpdateManager;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * 
	 * @author Hedrick David
	 * 
	 */	
	
	public class CharacterNodeManager extends Sprite
	{
		private var _characterNodesArray:Array = [];
		private var _selectedCharNode:CharacterNode;
		private var _scene:IsoScene;
		private var _view:IsoView;
		private var _canDetectLoc:Boolean = false;
		
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _pm:PopUpUIManager = PopUpUIManager.getInstance();
		private var _gd:GlobalData = GlobalData.instance;
		private var _pbm:ProgressBarManagerProxy = ProgressBarManagerProxy.instance;
		private var _sdc:ServerDataController = ServerDataController.getInstance();
		private var _friendViewMode:Boolean = false;
		private var _objectArray:Array = [];
		private var _tempCharArray:Array = [];
		private var _charcterRefresh:Boolean = false;
		private var _characterMoved:CharacterNode;
		
		// managers
		public var selection:CharacterSelectionManager;
		public var movement:CharacterMovementManager;
		public var action:CharacterActionManager;
		public var update:CharacterUpdateManager;
		
		public function CharacterNodeManager(scene:IsoScene, view:IsoView,objectArray:Array = null)
		{
			_scene = scene;
			_view = view;
			_objectArray = objectArray;
			_gd.friendView = false;
		}
		
		/**
		 * Initialize character managers
		 */	
		
		private function initManagers():void{
			// class that handles character selection methods
			selection = new CharacterSelectionManager(_characterNodesArray);
			// class that handles character movement methods
			movement = new CharacterMovementManager(_characterNodesArray);
			// class that handles character action methods
			action = new CharacterActionManager(_characterNodesArray, _scene, movement, _objectArray);
			// class that handles character update methods
			//action = new CharacterActionManager(_characterNodesArray);
		}
		
		private function updateCharNodeArrayManagerContents():void{
			selection.updateCharacterNodeContainer(_characterNodesArray);
			movement.updateCharacterNodeContainer(_characterNodesArray);
		}
		
		private function updateObjectArrayManagerContents():void{
			action.updateCharacterNodeContainer(_characterNodesArray);
		}
		

		
		public function updateObjectArray(value:Array):void{
			_objectArray = value;
			updateObjectArrayManagerContents();
		}
		
		/**
		 * Initialize Character Node Manager 
		 * 
		 */		
		
		public function init():void{
			initManagers();
			addListeners();
		}
		
		/**
		 * add event listeners 
		 */	
		
		private function addListeners():void{
			_es.addEventListener(SSEvent.FRIENDCHARLISTXML_LOADED, onFriendCharlistUpdate);
			_es.addEventListener(SSEvent.CHARLISTXML_LOADED, onCharlistUpdate);
			
			_es.addEventListener(ProgressBarEventProxy.PROGRESS_COMPLETE, onProgressBarComplete);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_RESTTIMERDONE, onCharNodeRestTimerIntervalEnded);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_AVATARUI_SHOW, onAvatarUIDisplay);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_AVATARUI_HIDE, onAvatarUIDisplay);
			_es.addEventListener(AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT, onAvatarUIClose);
			
			_es.addEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTCHARACTERROUTEREWARD, onCharacterReward);
			_es.addEventListener(ServerDataControllerEvent.ON_HIRE_CONTESTANT_COMPLETE, onCharacterHiring);
			
			_es.addEventListener(CharacterNodeEvent.CHARACTER_PROGRESSBAR, progressBarHandler);
		}
		
		/**
		 * remove event listeners
		 */
		
		private function removeListeners():void{
			_es.removeEventListener(SSEvent.FRIENDCHARLISTXML_LOADED, onFriendCharlistUpdate);
			_es.removeEventListener(SSEvent.CHARLISTXML_LOADED, onCharlistUpdate);
			_es.removeEventListener(ProgressBarEventProxy.PROGRESS_COMPLETE, onProgressBarComplete);
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_RESTTIMERDONE, onCharNodeRestTimerIntervalEnded);
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_AVATARUI_SHOW, onAvatarUIDisplay);
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_AVATARUI_HIDE, onAvatarUIDisplay);
			_es.removeEventListener(AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT, onAvatarUIClose);
			_es.removeEventListener(FriendInteractionEvent.FRIENDINTERACT_STARTCHARACTERROUTEREWARD, onCharacterReward);
			_es.removeEventListener(ServerDataControllerEvent.ON_HIRE_CONTESTANT_COMPLETE, onCharacterHiring);
			
			_es.removeEventListener(CharacterNodeEvent.CHARACTER_PROGRESSBAR, progressBarHandler);
		}
		
		private function progressBarHandler(ev:CharacterNodeEvent):void{
			if (ev.params != null){
				addProgressBar(ev.params.charNode);
			}
		}
		
		/**
		 * Used for copying current characterNodesArray list for making sure states and positions
		 * are the same when the charlist or friend charlist is invoked.
		 * @param ev - Server data controller event 
		 * 
		 */
		
		private function onCharacterHiring(ev:ServerDataControllerEvent):void{
			_charcterRefresh = true;
		}
		
		/**
		 * Event handler when avatar ui has closed. Starts the random movement of the character
		 * 
		 * @param ev - the event handler. 
		 * 
		 */		
		
		private function onAvatarUIClose (ev:AvatarTooltipUIEvent):void{
			//var charNode:CharacterNode = getCharacterNodeOnCharID(ev.obj.charID);
			//startRandomMovementPerCharacter(charNode);
		}
		
		/**
		 * Starts and stops the specific character movement depending
		 * on the visibility of the avatar ui.
		 * @param ev - the event handler.
		 * 
		 */
		
		private function onAvatarUIDisplay(ev:CharacterNodeEvent):void{
			var charNode:CharacterNode = ev.params.charNode;
			switch(ev.type)
			{
				case CharacterNodeEvent.CHARACTER_AVATARUI_SHOW:
				{
					movement.stopRandomMovementPerCharacter(charNode);
					break;
				}
				case CharacterNodeEvent.CHARACTER_AVATARUI_HIDE:
				{
					movement.startRandomMovementPerCharacter(charNode);
					break;
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Generate characters based on charlist or friend charlist
		
		/**
		 * Removes and adds characters in the list when the friends charlist is updated.
		 * @param ev - event handler for when friend characters are loaded or updated
		 * 
		 */
		
		public function onFriendCharlistUpdate(ev:SSEvent = null):void{
			_gd.charactersLoaded = false;
			_gd.objectsLoaded = false;
			_friendViewMode = true;
			_pbm.forceRemoveProgressBars();
			clearCharactersFromList();
			if (_gd.friendCharListDataArray.length > 0){
				addFriendCharactersFromList();
			}
			// refresh timer array based on the number of updated characters in friend charlist
			/*if (_randomMode){
			stopRandomMovement();
			startRandomMovement();
			}*/
			_pm.removeWindow( WindowPopUpConfig.DIALOGUE_WINDOW);
		}
		
		/**
		 * Removes and adds characters in the list when the charlist is updated.
		 * @param ev - event handler for when office characters are loaded or updated
		 * 
		 */
		
		public function onCharlistUpdate(ev:SSEvent = null):void{
			_friendViewMode = false;
			if (_charcterRefresh){
				//_tempCharArray = [];
				//_tempCharArray = _characterNodesArray;
				addCharactersFromList(true);
			} else {
				_pbm.forceRemoveProgressBars();
				clearCharactersFromList();
				if (_gd.charListDataArray.length > 0){
					addCharactersFromList();
				}
			}
			
			// refresh timer array based on the number of updated characters in charlist
			/*if (_randomMode){
			stopRandomMovement();
			startRandomMovement();
			}*/
			/*if (_charcterRefresh){
				refreshCharacterPosition();
			}*/
			
			_pm.removeWindow( WindowPopUpConfig.DIALOGUE_WINDOW);
		}
		
		/**
		 * Refreshes the character position based from the temporary cached character node data 
		 * 
		 */		
		
		private function refreshCharacterPosition():void{
			var len:int = _tempCharArray.length;
			var len2:int = _characterNodesArray.length;
			if (len > 0){
				for (var x:int = 0; x<len; x++){
					for (var y:int = 0; y<len2; y++){
						/*var tempCharID:String = _tempCharArray[x][0];
						var tempXPos:int = _tempCharArray[x][1];
						var tempYPos:int = _tempCharArray[x][2];*/
						
						var tempCharNode:CharacterNode = _tempCharArray[x];
						var charNode:CharacterNode = _characterNodesArray[y];
						
						if (tempCharNode.charID == charNode.charID){
							charNode.moveTo(_gd.CELL_SIZE * tempCharNode.xPos, _gd.CELL_SIZE * tempCharNode.yPos, 5);
							//_tempCharArray.splice(x, 1);
							continue;
						}
					}
				}
			}			
			_charcterRefresh = false;
		}
		
		/**
		 * Clears the character array and destroys the listeners and elements.
		 * for the character nodes.
		 * 
		 */		
		
		private function clearCharactersFromList():void{
			var len:int =_characterNodesArray.length;
			for (var i:int = 0; i < len; i++)
			{
				if (_characterNodesArray[i] != null){
					var charNode:CharacterNode = _characterNodesArray[i];
					destroyCharacter(charNode);
				}
			}
			_characterNodesArray = [];
		}
		
		/**
		 * Destroys the character and all its elements dependent on it. 
		 * @param charNode - the character node to be destroyed.
		 * 
		 */		
		
		private function destroyCharacter(charNode:CharacterNode):void{
			movement.stopRandomMovementPerCharacter(charNode);
			charNode.removeBubble();
			charNode.hideAvatarUI();
			charNode.stopRestTimer();
			charNode.char.removeEventListener(MouseEvent.CLICK , onCharacter);
			charNode.char.removeEventListener(MouseEvent.ROLL_OVER, onCharacterOver);
			charNode.char.removeEventListener(MouseEvent.ROLL_OUT, onCharacterOut);
			_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable = true;
			charNode.destroy();
			_scene.removeChild(charNode);
			charNode = null;
			
			
		}
		
		/**
		 * Adds the mouse event listeners for the characters. 
		 * 
		 */		
		
		private function addCharacterListeners():void{
			var len:int = _characterNodesArray.length;
			for (var x:int = 0; x<len; x++){
				_characterNodesArray[x].char.addEventListener(MouseEvent.CLICK, onCharacter);
				_characterNodesArray[x].char.addEventListener(MouseEvent.ROLL_OVER , onCharacterOver);
				_characterNodesArray[x].char.addEventListener(MouseEvent.ROLL_OUT , onCharacterOut);
			}
		}
		
		/**
		 * Adds mouse event listeners for specific characters. 
		 * 
		 */		
		
		private function addSpecificCharacterListeners(charNode:CharacterNode):void{
				charNode.char.addEventListener(MouseEvent.CLICK, onCharacter);
				charNode.char.addEventListener(MouseEvent.ROLL_OVER , onCharacterOver);
				charNode.char.addEventListener(MouseEvent.ROLL_OUT , onCharacterOut);
		}
		
		/**
		 * Adds a character in the array and initializes necessary attributes and elements
		 * 
		 */	
		
		private function addCharactersFromList(addLast:Boolean = false):void{
			var len:int = _gd.charListDataArray.length;
			var charListData:Array = _gd.charListDataArray;
			var init:int = 0;
			if (addLast){
				init = len - 1;
			}
			
			for (var i:int = init; i < len; i++)
			{
				var point:Point = movement.getRandomWalkableGridPosition();
				_characterNodesArray[i] = addNewCharacter(i, charListData[i][GlobalData.CHARLIST_GENDER], charListData[i][GlobalData.CHARLIST_ID], point.x, point.y );
				updateCharNodeArrayManagerContents();
				
				if (_characterNodesArray[i].resting == false){
					movement.startRandomMovementPerCharacter(_characterNodesArray[i]);
				} 
				_characterNodesArray[i].removeBubble();
				_characterNodesArray[i].showBubble();
				_gd.pathGrid.getNode(point.x, point.y).walkable = false;
			}
			addCharacterListeners();
			_gd.charactersLoaded = true;
			_es.dispatchEvent(new SSEvent(SSEvent.CHECK_OFFICECHARSTATE));
			_scene.render();
		}
		
		/**
		 * Adds a friend character in the array and initializes necessary attributes and elements.
		 * For friend's charlist update.
		 * 
		 */	
		
		private function addFriendCharactersFromList():void{
			var len:int = _gd.friendCharListDataArray.length;
			var friendCharListData:Array = _gd.friendCharListDataArray;
			
			for (var i:int = 0; i < len; i++)
			{
				var point:Point = movement.getRandomWalkableGridPosition();
				_characterNodesArray[i] = addNewCharacter(i, friendCharListData[i][GlobalData.FRIENDCHARLIST_GENDER], friendCharListData[i][GlobalData.FRIENDCHARLIST_ID], point.x, point.y );
				updateCharNodeArrayManagerContents();
				
				if (_characterNodesArray[i].resting == false){
					movement.startRandomMovementPerCharacter(_characterNodesArray[i]);
				}
				_characterNodesArray[i].removeBubble();
				_characterNodesArray[i].showBubble();
				
				_gd.pathGrid.getNode(point.x, point.y).walkable = false;
			}
			addCharacterListeners();
			_gd.charactersLoaded = true;
			_scene.render();
		}
		
		/**
		 * Adds a new character at the specified position.
		 * 
		 * @param gender - the gender of the character.
		 * @param charId - the character id of the character.
		 * @param xPos - the x position of the character in grid space.
		 * @param yPos - the y position of the character in grid space.
		 * @return - the character node created.
		 * 
		 */		
		
		public function addNewCharacter(index:int, gender:String, charId:String, xPos:int, yPos:int):CharacterNode{
			var charNode:CharacterNode = new CharacterNode(gender);
			_scene.addChild(charNode);
			charNode.charID = charId;
			charNode.index = index;
			charNode.randomMode = false;
			if (!_friendViewMode){
				var charData:Array = _gd.getCharDataOnCharID(charId);
				charNode.charDef = charData[GlobalData.CHARLIST_DEFINITION];
				charNode.name = charData[GlobalData.CHARLIST_NAME];
				charNode.grade = charData[GlobalData.CHARLIST_GRADE];
				charNode.stressLevel = charData[GlobalData.CHARLIST_STRESS];
				if (charData[GlobalData.CHARLIST_ISNEW] == 1){
					charNode.newCharacterAnimation();
					_sdc.setContestantFromNewToOld(charNode.charID);
				}
			} else {
				charData = _gd.getFriendCharDataOnCharID(charId);
				charNode.charDef = charData[GlobalData.FRIENDCHARLIST_DEFINITION];
				charNode.name = charData[GlobalData.FRIENDCHARLIST_NAME];
				charNode.grade = charData[GlobalData.FRIENDCHARLIST_GRADE];
				charNode.stressLevel = charData[GlobalData.FRIENDCHARLIST_STRESS];
			}
			
			charNode.xPos = xPos;
			charNode.yPos = yPos;
			charNode.setSize(_gd.CELL_SIZE, _gd.CELL_SIZE, _gd.CELL_SIZE);
			setStatus(charData, charNode);
			
			if (!_friendViewMode){
				if (charData.length > 0){
					if (charData[GlobalData.CHARLIST_STATUS] == 0){
						charNode.moveTo( _gd.CELL_SIZE * xPos, _gd.CELL_SIZE * yPos, GlobalData.ISO_CONTESTANT_DEPTH);
						charNode.action = GlobalData.CHARACTER_ACTION_IDLE;
						charNode.showBubble();
					} else {
						//setInitialCharacterRest(charNode, charData);
					}
				}
			} else {
				if (charData.length > 0){
					if (charData[GlobalData.FRIENDCHARLIST_STATUS] == 0){
						charNode.moveTo( _gd.CELL_SIZE * xPos, _gd.CELL_SIZE * yPos, GlobalData.ISO_CONTESTANT_DEPTH);
						charNode.action = GlobalData.CHARACTER_ACTION_IDLE;
						charNode.showBubble();
					} else {
						//setInitialCharacterRest(charNode, charData);
					}
				}
			}
			_scene.render();
			return charNode;
		}
		
		/**
		 * Removes a single character from the list 
		 * @param charId - the id of the character
		 * 
		 */	
		
		public function removeSingleCharacterFromList(charId:String):void{
			var len:int = _characterNodesArray.length;
			
			for (var i:int = 0; i < len; i++)
			{
				if (_characterNodesArray[i].charID == charId){
					var charNode:CharacterNode = _characterNodesArray[i];
					destroyCharacter(charNode);
				}
			}
		}
		
		/**
		 * Sets or adds the status depending of the characters condition.
		 * @param charData - the data of the character.
		 * @param charNode - the character node.
		 * 
		 */
		
		private function setStatus(charData:Array, charNode:CharacterNode):void{
			if (charData[GlobalData.CHARLIST_STRESS] >= 100){
				charNode.addStatus(GlobalData.CHARACTER_EXPRESSION_STRESSED);
			}
			
			/*if (charData[GlobalData.CHARLIST_CONDITION] == GlobalData.CHARACTER_EXPRESSION_CRY){
			charNode.addStatus(GlobalData.CHARACTER_EXPRESSION_CRY);
			}*/
		}
		
		/**
		 * Event handler when mouse is hovered on the character
		 * @param ev - mouse event.
		 * 
		 */
		
		private function onCharacterOver(ev:MouseEvent):void{
			if (ev.currentTarget != null){
				var charNode:CharacterNode =  getCharacterNodeOnMC (ev.currentTarget as MovieClip);
				charNode.over = true;
			}
		}
		
		/**
		 * Event handler when mouse is hovered out of the character
		 * @param ev - mouse event.
		 * 
		 */
		
		private function onCharacterOut(ev:MouseEvent):void{
			if (ev.currentTarget != null){
				var charNode:CharacterNode =  getCharacterNodeOnMC (ev.currentTarget as MovieClip);
				charNode.over = false;
			}
		}
		
		/**
		 * Event handler when character is clicked.
		 * @param ev - the mouse event.
		 * 
		 */		
		
		private function onCharacter(ev:MouseEvent):void{
			hideAvatarUI();
			_selectedCharNode = getCharacterNodeOnMC (ev.currentTarget as MovieClip);
			_gd.lastCharacterClicked = _selectedCharNode;
			if( !_gd.friendView ){
				_gd.currentCharId = _selectedCharNode.charID;
			}else {
				_gd.currentFriendCharId = _selectedCharNode.charID;			
				//setFriendCharacterOnClick(selectedCharNode);
			}
			movement.selectedCharNode = _selectedCharNode;
			action.selectedCharNode = _selectedCharNode;
			//selection.selectedCharNode = _selectedCharNode;
			_es.dispatchEvent(new CharacterNodeEvent(CharacterNodeEvent.CHARACTER_CLICK, {charNode:_selectedCharNode}));
		}
		
		/**
		 * Event handler when character finishes resting 
		 * @param ev - the characternode event.
		 * 
		 */		
		
		private function onCharNodeRestTimerIntervalEnded(ev:CharacterNodeEvent = null):void{
			// todo: reduce the process by having a direct link for the rest objects stress down
			var charNode:CharacterNode = ev.params.charNode;
			action.restingDone(charNode);
			trace( "[CharacterNodeManager]: dispatched onCharNodeRestTimerIntervalEnded", charNode );
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Progress bar
		
		/**
		 * Adds the progress bar UI.
		 * @param charNode - the character node.
		 * 
		 */		
		
		public function addProgressBar(charNode:CharacterNode = null):void {
			var objectData:Array;
			if (charNode != null){
				if (charNode.progressBarActive == false){
					charNode.progressBarActive = true;
					if (charNode.action == GlobalData.CHARACTER_ACTION_TRAINING){
						objectData = _gd.getOfficeStateDataByEntryID(charNode.trainingObject.entryid);
						_pbm.addProgressBar(objectData[GlobalData.OFFICESTATE_TRAINING_DURATION], null, charNode);
						Logger.tracer(this, "Training duration: " + objectData[GlobalData.OFFICESTATE_TRAINING_DURATION]);
					} else if (charNode.action == GlobalData.CHARACTER_ACTION_RESTING){
						objectData = _gd.getOfficeStateDataByEntryID(charNode.restObject.entryid);
						_pbm.addProgressBar(objectData[GlobalData.OFFICESTATE_REST_DURATION], null, charNode);
						Logger.tracer(this, "Rest duration: " + objectData[GlobalData.OFFICESTATE_REST_DURATION]);
					} else if (charNode.action == GlobalData.CHARACTER_ACTION_VISITREWARD || charNode.action == GlobalData.CHARACTER_ACTION_CHALENGEREWARD){
						_pbm.addProgressBar(1, null, charNode);
					} else {
						onProgressBarComplete(null, charNode);
					}
				}
			} else {
				if (_selectedCharNode){
					if (_selectedCharNode.progressBarActive == false){
						_selectedCharNode.progressBarActive = true;
						_pbm.addProgressBar(4, null, _selectedCharNode);
					}
				}
			}
		}
		
		/**
		 * Sets the parameters, effects, text hovers etc after the progress bar completes 
		 * for evets such as training, resting and ability up.
		 * @param ev - the progresbareventproxy event
		 * 
		 */
		
		private function onProgressBarComplete(ev:ProgressBarEventProxy = null, characNode:CharacterNode = null):void{
			
			if (ev != null){
				var charNode:CharacterNode = ev.params.charNode;
			} else {
				charNode = characNode;
			}
			
			if (charNode != null){
				if (getCharacterNodeOnMC(charNode.char).char == charNode.char){
					charNode.progressBarActive = false;
					switch(charNode.action)
					{
						case GlobalData.CHARACTER_ACTION_TRAINING:
						{
							// end training (call start train function for _sdc
							// make the pathgrid walkable
							_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable
							Logger.tracer(this, "Training ended: " + charNode.charID);
							action.returnCharacterDirection(charNode);
							_sdc.endTrain(charNode.charID, charNode.trainingObject.gridX, charNode.trainingObject.gridY, 1);
							// display text
							var trainTypeData:Object = action.getTrainTypes(charNode, charNode.charID, charNode.trainingType);
							
							charNode.trainingObject.selectable = true;
							charNode.selectable = true;
							charNode.trainingObject.isUsed = 0;
							var originalTrainData:int = (((trainTypeData.trainData - trainTypeData.expAdded) % 100) + trainTypeData.expAdded);
							
							if (originalTrainData  >= 100){
								charNode.addHoveringTextField(trainTypeData.textType, " +1", 1.5);
								trace (trainTypeData.textType + " Level up");
								charNode.levelUp();
								charNode.addHoveringTextField(trainTypeData.textType + " " + GlobalData.TFTYPE_XP, trainTypeData.expAdded  , .7);
								if (charNode.stressValueBeforeAdd < 100){
									charNode.addStressTextField(action.checkRemainingValue(charNode.stressValueBeforeAdd, trainTypeData.trainStress), 2.3);
								}
							} else {
								charNode.addHoveringTextField(trainTypeData.textType + " " + GlobalData.TFTYPE_XP, trainTypeData.expAdded  , .7);
								if (charNode.stressValueBeforeAdd < 100){
									charNode.addStressTextField(action.checkRemainingValue(charNode.stressValueBeforeAdd, trainTypeData.trainStress), 1.5);
								}
							}
							
							charNode.setCharacterAnimation(GlobalData.PLAYER_STAND, 3);
							charNode.trainingType = "";
							
							movement.startRandomMovementPerCharacter(charNode);
							movement.timerArray[charNode.index].delay = 1000;
							//_sdc.train(charNode, charNode.trainingObjectID);
							charNode.trainingEntryID = "";
							charNode.setCharacterAnimation(GlobalData.PLAYER_STAND, 3);
							selection.deselectAll();
							
							var trimName:String = StringUtilManager.getStringAndNumber( charNode.trainingObject.name ) 
							trace( "[CharacterNodeManager] training object name", charNode.trainingObject.name , "trim", trimName );
							//_sdc.getScene( "training_" + trimName + "_end" );
							
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_SOOTHING:
						{
							charNode.addHoveringTextField(GlobalData.TFTYPE_SOOTHED);
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_STRESSDOWN:
						{
							if (charNode.stressLevel == 90){
								charNode.addHoveringTextField( GlobalData.TFTYPE_STRESSRELIEVED," " ,1.4)
							}
							charNode.addStressTextField(-10);
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_HEALTHBONUS:
						{
							if (int(_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_HEALTH] / 100) != 99){
								charNode.addHoveringTextField(GlobalData.TFTYPE_HEALTH + " " + GlobalData.TFTYPE_XP, " +1", .3);
							} else {
								charNode.addHoveringTextField(GlobalData.TFTYPE_HEALTH, " +1", .3);
							}
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_SINGBONUS:
						{
							if (int(_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_SING] / 100) != 99){
								charNode.addHoveringTextField(GlobalData.TFTYPE_SING + " " + GlobalData.TFTYPE_XP, " +1", .3);
							} else {
								charNode.addHoveringTextField(GlobalData.TFTYPE_SING, " +1", .3);
							}
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_ACTIONBONUS:
						{
							if (int(_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_ACTING] / 100) != 99){
								charNode.addHoveringTextField(GlobalData.TFTYPE_ACTING + " " + GlobalData.TFTYPE_XP, " +1", .3);
							} else {
								charNode.addHoveringTextField(GlobalData.TFTYPE_ACTING, " +1", .3);
							}	
							break;
						}
						case GlobalData.CHARACTER_ACTION_ATTRACTIONBONUS:
						{
							if (int(_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_ATTRACTION] / 100) != 99){
								charNode.addHoveringTextField(GlobalData.TFTYPE_ATTRACTION + " " + GlobalData.TFTYPE_XP, " +1", .3);
							} else {
								charNode.addHoveringTextField(GlobalData.TFTYPE_ATTRACTION, " +1", .3);
							}
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_INTBONUS:
						{
							if (int(_gd.getFriendCharDataOnCharID(charNode.charID)[GlobalData.FRIENDCHARLIST_INTELLIGENCE] / 100) != 99  ){
								charNode.addHoveringTextField(GlobalData.TFTYPE_INT + " " + GlobalData.TFTYPE_XP, " +1", .3);
							} else {
								charNode.addHoveringTextField(GlobalData.TFTYPE_INT, " +1", .3);
							}
							break;
						}
							
						case GlobalData.CHARACTER_ACTION_VISITREWARD:
						{
							setRewardBasedOnView(charNode);
							break
						}	
							
						case GlobalData.CHARACTER_ACTION_RESTING:
						{
							trace( "[CharacterNodeManager]: CHARACTER_ACTION_RESTING!" );
							// make the pathgrid walkable
							action.returnCharacterDirection(charNode);
							_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable
							action.restingDone(charNode);
							
							
							//if ( characNode != null ) {
								//var trainingData:TrainingData = new TrainingData();
								//trainingData.cid = charNode.charID;
								//trainingData.xpos = characNode.x;
								//trainingData.ypos = characNode.y;
								//trainingData.zpos = characNode.z;
								//_gd.restingQeuee.push( trainingData );
							//}							
							
							_es.dispatchESEvent( new CharacterNodeEvent( CharacterNodeEvent.CHARACTER_RESTINGDONE, { charNode:charNode } ) );
							break;
						}	
					}
					
					updateCharNodeArrayManagerContents();
					charNode.showBubble();
					charNode.action = GlobalData.CHARACTER_ACTION_IDLE;
					//setRewardBasedOnView(charNode);
					_es.dispatchEvent(new CharacterNodeEvent ( CharacterNodeEvent.CHARACTER_PROGRESSBAREVENTDONE, { charNode:charNode } ));				
				}
			}
		}
		
		/**
		 * Sets the specific reward based on the view. 
		 * @param charNode - the character node.
		 * 
		 */		
		
		private function setRewardBasedOnView(charNode:CharacterNode):void{
			var xPos:int = charNode.x;
			var yPos:int = charNode.y;
			//var xPos:int = (charNode.x * _gd.CELL_SIZE) * _gd.CELL_SIZE;
			//var yPos:int = (charNode.y * _gd.CELL_SIZE) * _gd.CELL_SIZE;
			
			if (!_friendViewMode){
				addRewardOffice(xPos, yPos, 10);
			} else {
				addRewardFriendOffice(xPos, yPos, 10);
			}	
		}
		
		/**
		 * Hides the avatar UI. 
		 * 
		 */		
		
		public function hideAvatarUI():void{
			/*if (_selectedCharNode){
			_selectedCharNode.onAvatarClose();
			}*/
			_pm.removeWindow(WindowPopUpConfig.AVATAR_TOOL_WINDOW);
		}
		
		/**
		 * Removes any listener created for all characters. 
		 * 
		 */		
		
		public function removeCharacterListeners():void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i<len; i++){
				_characterNodesArray[i].char.removeEventListener(MouseEvent.CLICK, onCharacter);
				_characterNodesArray[i].char.removeEventListener(MouseEvent.MOUSE_OVER, onCharacter);
				_characterNodesArray[i].char.removeEventListener(MouseEvent.MOUSE_OUT, onCharacter);
			}
		}
		
		/**
		 * removes all characters from the list and destroys it. 
		 * 
		 */
		
		public function removeAllCharacters():void{
			var len:int = _gd.charListDataArray.length;
			for (var i:int = 0; i < len; i++)
			{
				if( _characterNodesArray[i] != null ){
					_characterNodesArray[i].destroy();
					_scene.removeChild(_characterNodesArray[i]);
				}
			}	
		}
		
		/**
		 * Event handler for the reward when the friend route  is triggered.
		 * @param ev - the FriendEvent.
		 * 
		 */		
		
		private function onCharacterReward(ev:FriendInteractionEvent):void{
			var charNode:CharacterNode = ev.params.charNode as CharacterNode;
			charNode.action = GlobalData.CHARACTER_ACTION_VISITREWARD;
			addProgressBar(charNode);
		}
		
		/**
		 * Adds the appropriate reward for own office.
		 * @param x - the x grid position.
		 * @param y - the y grid position.
		 * @param z - the z grid position.
		 * 
		 */		
		
		private function addRewardOffice(  x:Number, y:Number, z:Number  ):void 
		{
			trace( "add coin.............................!!!!!!!!" );
			var exp:DropItem = new DropItem( 1, 1, 1, new Object(), x, y, z , _view , stage , _scene , GlobalData.DROP_EXP );			
			
		}
		
		/**
		 * Adds the appropriate reward when on the friends office.
		 * @param x - the x grid position.
		 * @param y - the y grid position.
		 * @param z - the z grid position.
		 * 
		 */		
		
		private function addRewardFriendOffice(  x:Number, y:Number, z:Number  ):void 
		{
			trace( "add coin.............................!!!!!!!!" );
			var coin:DropItem = new DropItem( 1, 1, 1, new Object(), x, y,  z , _view , stage , _scene , GlobalData.DROP_COIN );
			var exp:DropItem = new DropItem( 1, 1, 1, new Object(), x,  y,  z , _view , stage , _scene , GlobalData.DROP_EXP );			
			if (!_gd.isChallenge){
				var redStar:DropItem = new DropItem( 1, 1, 1, new Object(), x,  y, z , _view , stage , _scene , GlobalData.DROP_RED_STAR );
			} else {
				var blackStar:DropItem = new DropItem( 1, 1, 1, new Object(),  x,  y,  z , _view , stage , _scene , GlobalData.DROP_BLACK_STAR );
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Character node search
		
		public function getCharacterNodeOnMC(character:MovieClip):CharacterNode{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_characterNodesArray[i].char == character){
					return _characterNodesArray[i];
					break;
				}
			}
			return null;
		}
		
		/**
		 * Returns all character nodes. 
		 * @return - the array containing all character node.
		 * 
		 */		
		
		public function getAllCharNodes():Array{
			return _characterNodesArray;
		}
		
		/**
		 * Getter and setter for character that last moved.
		 * 
		 */	
		
		public function get characterMoved():CharacterNode
		{
			return _characterMoved;
		}
		
		public function set characterMoved(value:CharacterNode):void
		{
			_characterMoved = value;
		}
		
		/**
		 * Getter and setter for selected character node
		 */	
		
		public function get selectedCharNode():CharacterNode
		{
			return _selectedCharNode;
		}
		
		public function set selectedCharNode(value:CharacterNode):void
		{
			_selectedCharNode = value;
		}

	}
}