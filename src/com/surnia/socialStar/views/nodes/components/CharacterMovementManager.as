package com.surnia.socialStar.views.nodes.components
{
	import caurina.transitions.Tweener;
	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.utils.ai.AStar;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class CharacterMovementManager extends EventDispatcher
	{
		private var  _characterNodesArray:Array = []; 
		private var _timerArray:Array = [];
		private var _randomMode:Boolean = false;
		
		private var _gd:GlobalData = GlobalData.instance;
		private var _es:EventSatellite = EventSatellite.getInstance();
		
		private var _randMin:Number;
		private var _randMax:Number;
		
		private var _selectedCharNode:CharacterNode;
		
		public function CharacterMovementManager(characterNodesArray:Array)
		{
			_characterNodesArray = characterNodesArray;
			_randMin = _gd.randMin * 1000;
			_randMax = _gd.randMax * 1000;
		}
		
		public function updateCharacterNodeContainer(characterNodesArray:Array):void{
			_characterNodesArray = characterNodesArray;
		}
		
		/**
		 * Starts character random pathfinding for all.
		 * 
		 */		
		
		public function startRandomMovement():void{
			if (!_randomMode){
				_randomMode = true;
				var len:int = _characterNodesArray.length;
				for (var i:int = 0; i < len; i++)
				{
					var randPos:Point = getLimitedRandomWalkableGridPosition(_gd.characterRandomMovementDegree, _characterNodesArray[i]);
					_characterNodesArray[i].destination = randPos;
					var timer:Timer = new Timer(randomNumbers(_randMax, _randMin, false));
					timer.start();
					_timerArray[i] = timer;
					_timerArray[i].addEventListener(TimerEvent.TIMER, onTimerUpdate);
					//_characterNodesArray[i].randomMode = true;
				}
			}
		}
		
		/**
		 * Stops character random pathfinding for all.
		 * 
		 */		
		
		public function stopRandomMovement():void{
			if (_randomMode){
				//_randomMode = false;
				var len:int = _timerArray.length;
				for (var i:int = 0; i < len; i++)
				{
					//_characterNodesArray[i].randomMode = false;
					if (_characterNodesArray[i].randomMode){
						_timerArray[i].stop();
						_timerArray[i].removeEventListener(TimerEvent.TIMER, onTimerUpdate);
					}
				}
				_timerArray = [];
			}
		}
		
		/**
		 * Starts the random pathfinding for a specific character 
		 * @param charNode - the character node to start pathfinding
		 * 
		 */		
		
		public function startRandomMovementPerCharacter(charNode:CharacterNode):void{
			if (!charNode.randomMode){
				charNode.randomMode = true;
				var len:int = _characterNodesArray.length;
				var randPos:Point =  getLimitedRandomWalkableGridPosition(_gd.characterRandomMovementDegree, charNode);
				charNode.destination = randPos;
				var timer:Timer = new Timer(randomNumbers(_randMax, _randMin, false));
				timer.start();
				_timerArray[charNode.index] = timer;
				_timerArray[charNode.index].addEventListener(TimerEvent.TIMER, onTimerUpdate);
			}
		}
		
		/**
		 * Starts random movement per character
		 * @param charID - the character ID of the character
		 * 
		 */	
		
		public function startRandomMovementPerCharacterByCharID(charID:String):void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++)
			{
				if (_characterNodesArray[i].charID == charID){
					startRandomMovementPerCharacter(_characterNodesArray[i]);
					break;
				}
			}
		}
		
		/**
		 * Stops the random pathfinding for a specific character 
		 * @param charNode - the character node to stop pathfinding
		 * 
		 */	
		
		public function stopRandomMovementPerCharacter(charNode:CharacterNode):void{
			if (charNode.randomMode && _timerArray[charNode.index] != null){
				charNode.randomMode = false;
				_timerArray[charNode.index].stop();
				_timerArray[charNode.index].removeEventListener(TimerEvent.TIMER, onTimerUpdate);
				_timerArray[charNode.index] = null;
			}
		}
		
		/**
		 * Starts random movement per character
		 * @param charID - the character ID of the character
		 * 
		 */	
		
		public function stopRandomMovementPerCharacterByCharID(charID:String):void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (_characterNodesArray[i].charID == charID){
					stopRandomMovementPerCharacter(_characterNodesArray[i]);
					break;
				}
			}
		}
		
		/**
		 * Timer event for character timers for pathfinding 
		 * @param ev - The TimerEvent
		 * 
		 */		
		
		private function onTimerUpdate(ev:TimerEvent):void{
			var targetTimer:Timer = ev.target as Timer;
			var len:int = _timerArray.length;
			var charNode:CharacterNode;
			targetTimer.delay = randomNumbers(_randMax, _randMin, false );
			
			for (var i:int = 0; i < len; i++)
			{
				if (targetTimer == _timerArray[i]){
					charNode = _characterNodesArray[i];
					break;
				}
			}
			
			if (charNode != null){
				setRandomPath(charNode);
			}
		}
		
		/**
		 * Starts the character pathfinding by assigning the destination
		 * and setting the walkable parts of the grid. 
		 * @param charNode - the character Node to start pathfinding
		 * 
		 */
		
		public function setRandomPath(charNode:CharacterNode):void{
			var randPos:Point = getLimitedRandomWalkableGridPosition(_gd.characterRandomMovementDegree, charNode);
			charNode.destinationReached = false;
			_gd.pathGrid.setStartNode(charNode.xPos, charNode.yPos);
			_gd.pathGrid.setEndNode( randPos.x, randPos.y );
			_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable = true;
			findPath(charNode);
			_gd.pathGrid.getNode(randPos.x, randPos.y).walkable = false;
			charNode.xPos = randPos.x;
			charNode.yPos = randPos.y;
		}
		
		/**
		 * For specific x any y grid node position.
		 * Starts the character pathfinding by assigning the destination
		 * and setting the walkable parts of the grid. 
		 * @param charNode - the character Node to start pathfinding
		 * 
		 */
		
		public function setCharacterPath (charNode:CharacterNode, gridX:int, gridY:int):void{
			charNode.destinationReached = false;
			_gd.pathGrid.setStartNode(charNode.xPos, charNode.yPos);
			_gd.pathGrid.setEndNode( gridX, gridY );
			_gd.pathGrid.getNode(charNode.xPos, charNode.yPos).walkable = true;
			findPath(charNode);
			_gd.pathGrid.getNode(gridX, gridY).walkable = false;
			charNode.xPos = gridX;
			charNode.yPos = gridY;
		}
		
		/**
		 * Random function
		 * 
		 * @param max - the max value
		 * @param min - the min value
		 * @param decimals- if with decimals
		 * @return  
		 */
		
		public function randomNumbers( max:int , min:int , decimals:Boolean):Number
		{
			var rnd1:Number;
			var rnd2:int;
			
			if ( decimals ) {
				rnd1 = Math.floor( Math.random() * ( 1 + max - min ) ) + min;
				return rnd1;
			}else{
				rnd2 = Math.floor( Math.random() * ( 1 + max - min ) ) + min;
				return rnd2;
			}			
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Find path
		
		/**
		 * Finds the path based on the given start and end node on the grid path. 
		 * @param characterNode - the character node.
		 * 
		 */
		
		public function findPath(characterNode:CharacterNode = null):void
		{
			if (characterNode){
				var currCharNode:CharacterNode = characterNode;
			} else {
				currCharNode = _selectedCharNode;
			}
			
			currCharNode.moving = true;
			
			//trace('CHARACTER FINDING PATH');
			//addEventListener(Event.ENTER_FRAME, onRender);
			var astar:AStar = new AStar();
			var path:Array = [];
			var speed:Number = .3;
			
			if(astar.findPath(_gd.pathGrid))
			{
				path = astar.path;
			}
			if (path.length >0){
				currCharNode.destination = new Point(path[path.length - 1].x * _gd.CELL_SIZE, path[path.length - 1].y * _gd.CELL_SIZE);
			}
			if( path != null ){
				for (var i:int = 0; i < path.length; i++)
				{
					var targetX:Number = path[i].x * _gd.CELL_SIZE;
					var targetY:Number = path[i].y * _gd.CELL_SIZE;
					var params:Array = [currCharNode];
					Tweener.addTween(currCharNode, { x:targetX, y:targetY, delay:speed * i , time:speed, transition:"linear", onUpdate:onCharacterMove, onUpdateParams:params } );
					//trace('CHARACTER MOVING ALONG PATH');
				}
			}
			/*if (!_randomMode){
			_timerArray[currCharNode.index].delay = randomNumbers(_randMax, _randMin, false);
			}*/
		}
		
		/**
		 * Update function when character is moving based from the tweener. 
		 * @param character - the character node.
		 * 
		 */		
		
		private function onCharacterMove(character:CharacterNode):void{
			if (!character.destinationReached){
				/*if (_canDetectLoc){
				character.xPos = int (character.x / _gd.CELL_SIZE);
				character.yPos = int (character.y / _gd.CELL_SIZE);
				}*/
				if (character.x == character.destination.x && character.y == character.destination.y){
					character.moving = false;
					character.destinationReached = true;
					if (character.action == GlobalData.CHARACTER_ACTION_TRAINING){
						character.setCharacterAnimation(character.trainingType, 4);
						_es.dispatchEvent(new CharacterNodeEvent(CharacterNodeEvent.CHARACTER_PROGRESSBAR, {charNode:character}));
					} else if (character.action == GlobalData.CHARACTER_ACTION_MOVE){
						//startRandomMovementPerCharacter(character);
						character.action = GlobalData.CHARACTER_ACTION_IDLE;
					}
				}
				//_scene.render();
			}
		}
		
		/**
		 * Gets a limited random walkable position based on the contents of
		 * the pathgrid class in relation to the character position.
		 * 
		 * @degree - the radius from the characters postions 
		 * based on the number of grids.
		 * @return - the x and y coordinates in grid space.
		 * 
		 */
		
		public function getLimitedRandomWalkableGridPosition(degree:int, charNode:CharacterNode):Point{
			
			var charXPos:int = charNode.xPos;
			var charYPos:int = charNode.yPos;
			var point:Point = new Point();
			var vectorPoint:Vector.<Point> = new Vector.<Point>();
			var walkable:Boolean = false;
			
			
			var minDegX:int = charXPos - degree;
			var minDegY:int = charYPos - degree;
			var maxDegX:int = charXPos + degree;
			var maxDegY:int = charYPos + degree;
			
			if (minDegX < 0 ){
				minDegX = 0;
			}
			if (minDegY < 0 ){
				minDegY = 0;
			}
			
			if (maxDegX >  _gd.expansion-1){
				maxDegX = _gd.expansion-1;
			}
			if (maxDegY >  _gd.expansion-1 ){
				maxDegY = _gd.expansion-1;
			}
			Logger.tracer(this, "Maximum X " + maxDegX + " | Maximum Y " + maxDegY);
			if (charXPos < (( _gd.expansion -1 )- charXPos)){
				var rand:int = int (Math.random() * 100);
				if (rand > 25){
					minDegX = charXPos;	
				} 
			}
			
			if (charYPos < (( _gd.expansion - 1 ) - charYPos)){
				var rand:int = int (Math.random() * 100);
				if (rand > 25){
					minDegY = charYPos;
				}
			}
			
			for (var i:int = minDegX; i<maxDegX; i++){
				for (var j:int = minDegY; j<maxDegY; j++){
					if (_gd.pathGrid.getWalkable(i,j)){
						//trace ("grid " + i + ":" + j + " is walkable");
						vectorPoint.push(new Point(i,j));
					} else {
						//trace ("grid " + i + ":" + j + "is not walkable");
					}
				}
			}
			
			var randVal:int = Math.random() * vectorPoint.length-1;
			if (randVal < 0){
				randVal = 0;
			}
			if (_gd.pathGrid.getWalkable(vectorPoint[randVal].x,vectorPoint[randVal].y)){
				trace ("grid " + vectorPoint[randVal].x + ":" + vectorPoint[randVal].y + " is walkable");
			} else {
				trace ("grid " + vectorPoint[randVal].x + ":" + vectorPoint[randVal].y + "is not walkable");
			}
			point = vectorPoint[randVal];
			walkable = true;
			return point;
		}
		
		/**
		 * Gets a random walkable position based on the contents of
		 * the pathgrid class.
		 * @return - the x and y coordinates in grid space.
		 * 
		 */
		
		public function getRandomWalkableGridPosition():Point{
			var point:Point = new Point();
			var vectorPoint:Vector.<Point> = new Vector.<Point>();
			var walkable:Boolean = false;
			
			for (var i:int = 0; i<10; i++){
				for (var j:int = 0; j<10; j++){
					try {
						if (_gd.pathGrid.getWalkable(i,j)){
							//trace ("grid " + i + ":" + j + " is walkable");
							vectorPoint.push(new Point(i,j));
						} else {
							//trace ("grid " + i + ":" + j + "is not walkable");
						}
					} catch (e:Error){
						trace ("There is an exeption in grid size: " + i + " : " + j);
					}
				}
			}
			
			var randVal:int = Math.random() * vectorPoint.length-1;
			if (_gd.pathGrid.getWalkable(vectorPoint[randVal].x,vectorPoint[randVal].y)){
				trace ("grid " + vectorPoint[randVal].x + ":" + vectorPoint[randVal].y + " is walkable");
			} else {
				trace ("grid " + vectorPoint[randVal].x + ":" + vectorPoint[randVal].y + "is not walkable");
			}
			point = vectorPoint[randVal];
			walkable = true;
			return point;
		}
		
		public function set selectedCharNode(charNode:CharacterNode):void{
			_selectedCharNode  = charNode;
		}
		
		public function get randomMode():Boolean{
			return _randomMode;
		}
		
		public function get timerArray():Array{
			return _timerArray;
		}
	}
}