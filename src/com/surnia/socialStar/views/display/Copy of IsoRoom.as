package com.surnia.socialStar.views.display
{
	/* ------------------------
	* Default Flash Libraries 
	-------------------------*/	
	
	import as3isolib.core.ClassFactory;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.SolidColorFill;
	import caurina.transitions.Tweener;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.component.progressBar.event.ProgressBarEvent;
	import com.surnia.socialStar.ui.component.progressBar.ProgressBarManager;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.InventoryEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.staff.event.StaffEvent;
	import com.surnia.socialStar.utils.ai.AStar;
	import com.surnia.socialStar.utils.ai.Grid;
	import com.surnia.socialStar.utils.rewardComponents.RewardPopup;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.isoItems.DropItem;
	import com.surnia.socialStar.views.isoItems.DropItems;
	import com.surnia.socialStar.views.isoItems.events.DropItemEvent;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import eDpLib.events.ProxyEvent;
	import flash.display.FrameLabel;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	
/******************************************************************************************************************************************************
	VARIABLE DECLARATIONS
*******************************************************************************************************************************************************/	
	public class IsoRoom extends MovieClip
	{
		/* ----------
		* CONSTANTS 
		------------ */
		private var STAGE_WIDTH:int = 760;
		private var STAGE_HEIGHT:int = 630;
		
		private var CELL_SIZE:int = 34;
		private var GRID_WIDTH:int = 10;
		private var GRID_LENGTH:int = 10;
		private var GRID_HEIGHT:int = 0;
		
		private var MAX_ZOOM_OUT:Number = 1;
		private var MAX_ZOOM_IN:Number = 1.3;
		private var _panPt:Point;
		private var _zoom:Number = 1;
		
		/* ---------------
		* ISO PROPERTIES 
		------------------ */ 
		private var _view:IsoView;
		private var _gridScene:IsoScene;
		private var _scene:IsoScene;
		private var _box:IsoBox;
		private var _grid:IsoGrid;
		private var _glow:GlowFilter;
		private var _dragPt:Pt;
		private var _floors:IsoSprite;
		
		/*-------------------------
		* OBJECTS
		-------------------------*/
		private var leftWallsAry:Array = new Array();
		private var rightWallsAry:Array = new Array();
		private var floorsAry:Array = new Array();
		private var floorType:String = "";
		private var allFloorsAry:Array = new Array();
		private var wallsAry:Array = new Array();
		private var wallType:String = "";
		private var allWallsAry:Array = new Array();
		public var OBJECT_BUYING:Boolean = false;
		private var OBJECT_MOVING:Boolean = false;
		private var OBJECT_COLLISSION:Boolean = false;
		private var SPACE_COLLISSION:Boolean = false;
		private var OBJECT_ROTATABLE:Boolean = false;
		private var WITHIN_BOUNDS:Boolean = false;
		private var CURRENT_FLOOR:String = new String();
		public var OBJECT_INTERACTION:String = new String();
		private var _objLoader:Loader;
		private var _objClass:Class;
		private var ENTRY_ID:String = "";
		private var CHARACTER_MOVING:Boolean = false;
		private var CHARACTER_ACTION:String = "";
		private var ALL_INTERACTIONS_ON:Boolean = true;
		private var _popUIManager:PopUpUIManager = PopUpUIManager.getInstance();
		
		/*-----------------------------------
		* Iso Room Objects temporary chunks
		------------------------------------*/
		public var objectCategory:String = "";
		private var objectType:String = "";		
		private var objectsAry:Array = new Array();
		private var _currentObject:Object = new Object();
		public var _dragObject:IsoSprite;
		private var _dragObjectProp:*;
		public var _charObject:IsoSprite;
		private var _currentCharacterMoving:IsoSprite;
		private var endPosX:int = 0;
		private var endPosY:int = 0;
		private var _activeObject:IsoSprite;
		
		//new
		private var _currentIsoObject:IsoObject;
		
		/*-------------------
		* Iso Room Renderer
		---------------------*/
		private var _factory:ClassFactory;
		
		/* --------------------
		* FOR EVENT SATELLITE
		--------------------- */
		private var _es:EventSatellite;
		private var _isoRoomEvent:IsoRoomEvent;
		private var _sdc:ServerDataController;
		
		/*-------------------
		* CHARACTERS
		---------------------*/
		private var charAry:Array = new Array();
		protected var pathGrid:Grid;
		protected var playerHelper:IsoPrimitive;
		protected var path:Array;
		protected var isoSprite:IsoSprite;
		protected var isoView:IsoView;
		protected var isoScene:IsoScene;
		public var tmpdef:String;
		
		/*-------------------
		* OTHERS
		---------------------*/
		private var ptrAry:Array;
		private var _rewardPopup:RewardPopup;
		private var tempIsoHolder:IsoSprite;
		private var _popupObject:IsoSprite;
		public var character_gender:int = 0;
		
		private var _progressBarManager:ProgressBarManager;
		private var dropItems:DropItems;
		
		/*********************************************************************************************************************************************
		|	CONSTRUCTOR
		*********************************************************************************************************************************************/
		public function IsoRoom():void
		{			
			initialize();
		}
		
		/*********************************************************************************************************************************************
		|	INITIALIZATIONS
		*********************************************************************************************************************************************/
		/*-------------------------------
		|	initialize data
		-------------------------------*/
		private function initialize():void
		{
			initEventSatellite();
			initVars();
			initIsoView();
			initGridIsoScene();
			initIsoScene();
			initIsoGrids();
			initOfficeObjects();
			addStageListeners();						
		}
		
		/*-------------------------------
		| Initialize event satellite
		-------------------------------*/
		private function initVars():void 
		{		
			_dragObject = new IsoSprite();
			_popupObject = new IsoSprite();
			_progressBarManager = new ProgressBarManager(this);
		}				
		
		private function initIsoView():void {
			_view = new IsoView();			
			_view.setSize( 760, 630);			
			_view.clipContent = true;			
			_view.centerOnPt(new Pt(200,200,0));
			addChild( _view );		
			
			var _bgImg:BackgroundImage = new BackgroundImage();
			_view.backgroundContainer.addChild(_bgImg);
			_view.rangeOfMotionTarget = _bgImg;
		}
		
		private function initGridIsoScene():void {
			_gridScene = new IsoScene();
			_gridScene.hostContainer = this;
			_view.addScene( _gridScene );
		}
		
		private function initIsoScene():void {
			_scene = new IsoScene();
			_scene.hostContainer = this;			
			_view.addScene( _scene );
		}
		
		private function initIsoGrids():void {
			_grid = new IsoGrid();
			_grid.showOrigin = false;
			_grid.setGridSize(GRID_WIDTH, GRID_LENGTH, 0);
			_grid.cellSize = CELL_SIZE;			
			_gridScene.addChild( _grid );
		}	
		
		/*---------------------------------------------------
		| Initialize Office Items like floor tiles and walls
		---------------------------------------------------*/
		private function initOfficeObjects():void 
		{
			addFlooring('D5GMAiDOWZnB7bbSHIjR');
			addWalling('NUADZJKjVpEDWUxuTG6X');
		}
		
		/*---------------------------------------------
		| Add Stage Listeners
		---------------------------------------------*/
		private function addStageListeners():void 
		{
			addEventListener( MouseEvent.MOUSE_DOWN, onStartPan );
			addEventListener( MouseEvent.MOUSE_UP, onStopPan );			
		}
		
		private function initEventSatellite():void
		{
			_sdc = ServerDataController.getInstance();
			
			_es = EventSatellite.getInstance();			
			_es.addEventListener( ServerDataControllerEvent.HIRE_STAFF_COMPLETE, onHireStaffComplete );
			_es.addEventListener( InventoryEvent.SET_OFFICE_INVENTORY_ITEM, onSetOfficeInventoryItem );			
			_es.addEventListener( DropItemEvent.ON_CLICK_DROP_ITEM, onClickMouse );
			_es.addEventListener( ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE, _onOfcItemBuyComplete );
			_es.addEventListener( ServerDataControllerEvent.REGISTER_OFFICE_ITEM_POS_COMPLETE, _onOfcItemRegistrationComplete );
			_es.addEventListener( ServerDataControllerEvent.SELL_OFFICE_ITEM_COMPLETE, _onObjectSold );
			_es.addEventListener( MiniGameEvent.START_MINI_GAME, _onStopInteraction );
			_es.addEventListener( MiniGameEvent.END_MINI_GAME, _onStartInteraction );
			_es.addEventListener( StaffEvent.HIRED_FRIEND, onHiredStaff );
			_es.addEventListener( StaffEvent.HIRED_NPC, onHiredStaff);
			_es.addEventListener( ProgressBarEvent.PROGRESS_COMPLETE, onProgressBarComplete);
		}
		
		public function onHiredStaff(ev:StaffEvent):void {
			clearDragObject();			
			switch(ev.type)
			{
				case  StaffEvent.HIRED_FRIEND:
				{
				
					break;
				}
				case  StaffEvent.HIRED_NPC:
				{
					var len:int = objectsAry.length;
					for (var x:int = 0; x<len; x++){
						if (objectsAry[x].entryid == ev.params.entryID)
						{
							objectsAry[x].npc = true;
							objectsAry[x].empty = false;
							break;
						}
					}
				}	
			}			
		}		
		
		public function updateGrid():void
		{
			GRID_WIDTH++;
			GRID_LENGTH++;		
		}
		
		private function addFlooring(_id:String):void 
		{
			pathGrid = new Grid(GRID_WIDTH, GRID_LENGTH);
			floorType = _id;		
			for (var i:int = 0; i < GRID_WIDTH; i++)
			{
				for (var j:int = 0; j < GRID_LENGTH; j++)
				{
					_floors = new IsoSprite();
					_floors.setSize(0, 0, 0);
					var _floor:MovieClip = new Objects();
					
					_floor.name = "floor" + String(i) + String(j);					
					_floor.gotoAndStop(_id);
					_floors.sprites = [_floor];
					_scene.addChild(_floors);
					_floors.moveBy(i * CELL_SIZE, j * CELL_SIZE, 0);					
					allFloorsAry.push(_floors);					
					_scene.render();
					
					var floorObj:Object = new Object();
					floorObj.instance = _floor;
					floorObj.name = _floor.name;
					floorObj.occupied = 0;
					floorObj.x = _floors.x;
					floorObj.y = _floors.y;
					floorObj.walldirection = "";
					floorObj.xpos = i;
					floorObj.ypos = j;
					//trace('floor xpos : ' + floorObj.xpos + 'floor ypos : ' + floorObj.ypos);
					floorsAry.push(floorObj);					
					_floor.addEventListener(MouseEvent.MOUSE_DOWN, onFloorClick);
					_floor.addEventListener(MouseEvent.MOUSE_OVER, onFloorOver);
					_floor.addEventListener(MouseEvent.MOUSE_OVER, onFloorOut);
				}
			}
		}
		
		public function expandFlooring():void 
		{
			deleteFlooring();
			updateFlooring();
		}
		
		private function deleteFlooring():void
		{
			trace(' all floors ary length : ' + allFloorsAry.length);		
			for (var i:int = 0; i < allFloorsAry.length; i++)
			{
				_scene.removeChild(allFloorsAry[i]);
			}			
			allFloorsAry = new Array();
			floorsAry = new Array();
		}
		
		private function updateFlooring():void
		{
			pathGrid = new Grid(GRID_WIDTH, GRID_LENGTH);
			for (var i:int = 0; i < GRID_WIDTH; i++)
			{
				for (var j:int = 0; j < GRID_LENGTH; j++)
				{
					_floors = new IsoSprite();
					_floors.setSize(0, 0, 0);
					var _floor:MovieClip = new Objects();
					
					_floor.name = "floor" + String(i) + String(j);
					
					_floor.addEventListener(MouseEvent.MOUSE_DOWN, onFloorClick);
					
					_floor.gotoAndStop(floorType);
					_floors.sprites = [_floor];
					_scene.addChild(_floors);
					_floors.moveBy(i * CELL_SIZE, j * CELL_SIZE, 0);
					
					_scene.render();
					
					allFloorsAry.push(_floors);
					
					var floorObj:Object = new Object();
					floorObj.instance = _floor;
					floorObj.name = _floor.name;
					floorObj.occupied = 0;
					floorObj.x = _floors.x;
					floorObj.y = _floors.y;
					floorObj.gridX = _floors.x / CELL_SIZE;
					floorObj.gridY = _floors.y / CELL_SIZE;
					floorsAry.push(floorObj);
				}
			}		
		}
		
		//private function updateObjects():void
		//{
			//for (var i:int = 0; objectsAry.length; i++) {
				//_dragObject = objectsAry[i].instance as IsoSprite;
				//_dragObject.moveTo(objectsAry[i].gridX, objectsAry[i].gridY, objectsAry[i].z);
				//setWalkables(objectsAry[i].gridX, objectsAry[i].gridY);
			//}
		//}
		
		//private function updateCharacters():void
		//{
			//for (var i:int = 0; charAry.length; i++) {
				//charAry[i].instance.moveTo(charAry[i].gridX, charAry[i].gridY, charAry[i].z);
			//}
		//}
		
		//private function setWalkables(_X:int, _Y:int):void {
			//for (var i:int = 0; i < floorsAry.length; i++) {
				//if (floorsAry[i].x == _X && floorsAry[i].y == _Y) 
				//{
					//floorsAry[i].occupied = 1;
					//pathGrid.setWalkable(_X, _Y, false);
				//}
			//}
		//}
		
		public function editFlooring(_id:String):void {
			floorType = _id;			
			if (_dragObject != null ) 
			{
				_scene.removeChild(_dragObject);
			}
			
			for (var a:int = 0; a < floorsAry.length; a++) 
			{				
				floorsAry[a].instance.gotoAndStop(_id);
			}			
			_scene.render();
		}
		
		protected function onGridItemClick(e:ProxyEvent):void 
		{
			if ( _charObject != null )
			{				
				var box:IsoBox = e.target as IsoBox;
				
				//Get and set End Nodes (where are we going)
				var xpos:int = (box.x) / CELL_SIZE;
				var ypos:int = Math.floor(box.y / CELL_SIZE);
				pathGrid.setEndNode(xpos,ypos );
				
				//Get and set Start Node (where are we now)
				xpos = Math.floor(_charObject.x / CELL_SIZE);
				ypos = Math.floor(_charObject.y / CELL_SIZE);
				pathGrid.setStartNode(xpos, ypos);
				
				//Find our path
				findPath();
			}
		}
		
		private function addWalling(_id:String):void 
		{
			wallType = _id;
			for (var i:int = 0; i < 1; i++)
			{
				for (var j:int = 0; j < GRID_LENGTH; j++)
				{
					var _leftWalls:IsoSprite = new IsoSprite();
					var _leftWall:MovieClip = new Objects();
					
					_leftWall.gotoAndStop(_id);
					_leftWall.name = "wall_" + "_i" + i + "_j" + j;
					
					wallsAry.push(_leftWall);
					//trace('wall name : ' + wallsAry[j].name);
					_leftWalls.sprites = [_leftWall];
					
					var leftWallObj:Object = new Object();
					leftWallObj.instance = _leftWalls;
					leftWallObj.movieclip = _leftWall.name;					
					leftWallsAry.push(_leftWalls);					
					_scene.addChild(_leftWalls);					
					allWallsAry.push(_leftWalls);					
					_leftWalls.moveBy(i * CELL_SIZE, j * CELL_SIZE, 0);					
					_scene.render();
				}				
			}
			
			for (var a:int = 0; a < GRID_WIDTH; a++)
			{
				for (var b:int = 0; b < 1; b++)
				{
					var _rightWalls:IsoSprite = new IsoSprite();
					var _rightWall:MovieClip = new Objects();					
					_rightWall.gotoAndStop(_id);
					_rightWall.name = "wall_" + "_a" + a + "_b" + b;
					wallsAry.push(_rightWall);					
					rightWallsAry.push(_rightWalls);					
					//trace('wall name : ' + wallsAry[b].name);
					_rightWalls.sprites = [_rightWall];
					_rightWalls.container.scaleX = -(_rightWalls.container.scaleX);
					_scene.addChild(_rightWalls);
					allWallsAry.push(_rightWalls);
					_rightWalls.moveBy(a * CELL_SIZE, b * CELL_SIZE, 0);					
					_scene.render();
				}
			}
		}
		
		public function editWalling(_id:String):void 
		{
			wallType = _id;
			for (var i:int = 0; i < wallsAry.length; i++) {
				
				var labels:Array = wallsAry[i].currentLabels;
				var found:Boolean = false;
				
				for (var j:uint = 0; j < labels.length; j++) 
				{
					var label:FrameLabel = labels[j];
					if ( label.name == _id ) 
					{
						found = true;
						break;
					}
				}
				
				if (found) {
					wallsAry[i].gotoAndStop(_id);
				} else {
					wallsAry[i].gotoAndStop( 69 );
				}			
			}
		}
		
		public function expandWalling():void
		{
			deleteWalling();
			updateWalling();
		}
		
		private function deleteWalling():void
		{
			for (var i:int = 0; i < allWallsAry.length; i++) {
				_scene.removeChild(allWallsAry[i]);
			}
			
			wallsAry = new Array();
			allWallsAry = new Array();
		}
		
		private function updateWalling():void
		{
			for (var i:int = 0; i < 1; i++)
			{
				for (var j:int = 0; j < GRID_LENGTH; j++)
				{
					var _leftWalls:IsoSprite = new IsoSprite();
					var _leftWall:MovieClip = new Objects();
					
					_leftWall.gotoAndStop(wallType);
					_leftWall.name = "wall_" + "_i" + i + "_j" + j;
					wallsAry.push(_leftWall);					
					_leftWalls.sprites = [_leftWall];					
					_scene.addChild(_leftWalls);
					allWallsAry.push(_leftWalls);
					_leftWalls.moveBy(i * CELL_SIZE, j * CELL_SIZE, 0);					
					_scene.render();
				}				
			}
			
			for (var a:int = 0; a < GRID_WIDTH; a++)
			{
				for (var b:int = 0; b < 1; b++)
				{
					var _rightWalls:IsoSprite = new IsoSprite();
					var _rightWall:MovieClip = new Objects();
					
					_rightWall.gotoAndStop(wallType);
					_rightWall.name = "wall_" + "_a" + a + "_b" + b;
					wallsAry.push(_rightWall);
					//trace('wall name : ' + wallsAry[b].name);
					_rightWalls.sprites = [_rightWall];
					_rightWalls.container.scaleX = -(_rightWalls.container.scaleX);
					_scene.addChild(_rightWalls);
					allWallsAry.push(_rightWalls);
					_rightWalls.moveBy(a * CELL_SIZE, b * CELL_SIZE, 0);					
					_scene.render();
				}				
			}
		}
		
		/*----------------------------------------------------
		|	set office item when loaded the game
		----------------------------------------------------*/
		//public function addObject(obj:IsoObjectData):void
		//{		
			//if (_dragObject != null )
			//{
				//_scene.removeChild(_dragObject);
			//}
			//
			//var _objects:IsoSprite = new IsoSprite;
			//var _obj:MovieClip = new Objects();			
			//
			//if ( obj != null && _objects != null )
			//{
				//trace('\nADD NEW OFFICE OBJECT');
				//trace('OBJECT WIDTH : ' + Math.floor(obj.dimension.y / CELL_SIZE));
				//trace('OBJECT LENGTH : ' + Math.floor(obj.dimension.x / (CELL_SIZE + CELL_SIZE)));
				//trace('OBJECT HEIGHT : ' + Math.floor(obj.dimension.z / CELL_SIZE));
				//trace('OBJECT TYPE : ' + obj.type);
				//trace('OBJECT SUB TYPE : ' + obj.subType);
				//
				//_objects.setSize(obj.dimension.y * CELL_SIZE, obj.dimension.x * CELL_SIZE, obj.dimension.z);
				//
				//if (obj.id != null) 
				//{
					//_obj.gotoAndStop(obj.id);
				//}else {
					//_obj.gotoAndStop(obj.fn);
				//}
				//
				//_objects.sprites = [_obj];
				//_objects.moveTo(obj.position.x * CELL_SIZE, obj.position.y * CELL_SIZE, obj.position.z);				
				//
				//_scene.addChild(_objects);
				//
				//if (obj.rotation == 1) {
					//_objects.container.scaleX = -(_objects.container.scaleX);
				//}				
			//
				//var itemObj:Object = new Object();
				//itemObj.instance = _objects;
				//itemObj.movieclip = _obj;
				//itemObj.name = "object_" + String(objectsAry.length + 1);
				//itemObj.id = obj.id;
				//itemObj.entryid = obj.entryid;
				//itemObj.rotation = obj.rotation;
				//itemObj.l = obj.position.y;
				//itemObj.w = obj.position.x;
				//itemObj.h = obj.position.z;
				//itemObj.x = obj.position.x * CELL_SIZE;
				//itemObj.y = obj.position.y * CELL_SIZE;
				//itemObj.z = obj.position.z;
				//itemObj.extraSpace = null;
				//itemObj.gridX = obj.position.x;
				//itemObj.gridY = obj.position.y;
				//itemObj.type = obj.type;
				//itemObj.subType = obj.subType;
				//itemObj.npc = obj.npc;
				//itemObj.empty = obj.empty;
				//itemObj.level = obj.level;
				//itemObj.fbid = obj.fbid;
				//itemObj.npcid = obj.npcid;
				//itemObj.gender = obj.gender;
				//itemObj.staff = obj.staff;
				//itemObj.state = obj.state;
				//itemObj.fn = obj.fn;
//
				//if (obj.type == "training") // width 
				//{
					//var _box:IsoBox = new IsoBox();
					//_box.setSize(CELL_SIZE, CELL_SIZE, 0);
					//_box.fills = [
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5)
					//];
					//_scene.addChild(_box);
					//itemObj.extraSpace = _box;
					//switch (itemObj.subType)
					//{
						//case "sing" : 
							//trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							//itemObj.extraSpacePosition = "back"; 
							//_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
						//break;
						//
						//case "acting" :
							//trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							//itemObj.extraSpacePosition = "back"; 
							//_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
						//break;
						//
						//case "attraction" :
							//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							//itemObj.extraSpacePosition = "front";
							//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						//break;
						//
						//case "health" :
							//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							//itemObj.extraSpacePosition = "front";
							//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						//break;
						//
						//case "intelligent" :
							//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							//itemObj.extraSpacePosition = "front";
							//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						//break;
						//
						//default : break;
					//}
				//}else if (obj.type != "training") {
					//if (obj.dimension.x > 1 ) { // length
						//
						//_box = new IsoBox();
						//_box.setSize(CELL_SIZE, CELL_SIZE, 0);
						//_box.fills = [
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5)
						//];
						//_scene.addChild(_box);
						//itemObj.extraSpace = _box;
						//_box.moveTo(_objects.x, _objects.y + CELL_SIZE, 3);
						//
					//} else if ( obj.dimension.y > 1 ) { // width
						//
						//_box = new IsoBox();
						//_box.setSize(CELL_SIZE, CELL_SIZE, 0);
						//_box.fills = [
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5),
							//new SolidColorFill(0x00ff00, .5)
						//];
						//_scene.addChild(_box);
						//itemObj.extraSpace = _box;
						//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						//
					//}
				//}
				//
				//objectsAry.push(itemObj);				
				//pathGrid.setWalkable(obj.position.x, obj.position.y, false);
				//putToTile(_objects);				
				//_objects.addEventListener( MouseEvent.MOUSE_OVER, onObjectMouseOver );
				//_objects.addEventListener( MouseEvent.MOUSE_OUT, onObjectMouseOut );
				//_objects.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect );
				//
				//if ( obj.type == "staff"  && obj.subType == "hire" && itemObj.state != "" ) {
					//var str:String = itemObj.state;
					//"npc_Ki1U8I3IOTjQN54SlRSV_male_1";
					//if( str != null ){
						//var arr:Array = str.split("_");
						//trace( arr[ 2 ] ) ;
						//if ( arr[ 2 ] == "male" ) {
							//trace( "show  male ..............." );
							//if( itemObj.movieclip.mc != null ){
								//itemObj.movieclip.mc.gotoAndStop( 2 );	
							//}
						//}else {
							//trace( "show  female ..............." );
							//if( itemObj.movieclip.mc != null ){
								//itemObj.movieclip.mc.gotoAndStop( 3 );	
							//}
						//}
					//}
				//}
			//}			
			//_scene.render();			
		//}
		
		
		public function addObject(obj:IsoObjectData):void
		{		
			if (_dragObject != null )
			{
				_scene.removeChild(_dragObject);
			}
			
			var isoObject:IsoObject = new IsoObject( obj as IsoObjectData );			
			isoObject.instance.moveTo( isoObject.position.x * CELL_SIZE, isoObject.position.y * CELL_SIZE, isoObject.position.z );		
			_scene.addChild( isoObject.instance );
			
			if ( isoObject.rotation == 1){				
				isoObject.instance.container.scaleX = -( isoObject.instance.container.scaleX ); 
			}	
			
			isoObject.showBubble();			
				
				/*
				if (obj.type == "training") // width 
				{
					var _box:IsoBox = new IsoBox();
					_box.setSize(CELL_SIZE, CELL_SIZE, 0);
					_box.fills = [
						new SolidColorFill(0x00ff00, .5),
						new SolidColorFill(0x00ff00, .5),
						new SolidColorFill(0x00ff00, .5),
						new SolidColorFill(0x00ff00, .5),
						new SolidColorFill(0x00ff00, .5),
						new SolidColorFill(0x00ff00, .5)
					];
					_scene.addChild(_box);
					itemObj.extraSpace = _box;
					switch (itemObj.subType)
					{
						case "sing" : 
							trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							itemObj.extraSpacePosition = "back"; 
							_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
						break;
						
						case "acting" :
							trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							itemObj.extraSpacePosition = "back"; 
							_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
						break;
						
						case "attraction" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							itemObj.extraSpacePosition = "front";
							_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						break;
						
						case "health" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							itemObj.extraSpacePosition = "front";
							_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						break;
						
						case "intelligent" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							itemObj.extraSpacePosition = "front";
							_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						break;
						
						default : break;
					}
				}else if (obj.type != "training") {
					if (obj.dimension.x > 1 ) { // length
						
						_box = new IsoBox();
						_box.setSize(CELL_SIZE, CELL_SIZE, 0);
						_box.fills = [
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5)
						];
						_scene.addChild(_box);
						itemObj.extraSpace = _box;
						_box.moveTo(_objects.x, _objects.y + CELL_SIZE, 3);
						
					} else if ( obj.dimension.y > 1 ) { // width
						
						_box = new IsoBox();
						_box.setSize(CELL_SIZE, CELL_SIZE, 0);
						_box.fills = [
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5),
							new SolidColorFill(0x00ff00, .5)
						];
						_scene.addChild(_box);
						itemObj.extraSpace = _box;
						_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
						
					}
				}
				*/				
				
			objectsAry.push(isoObject);				
			pathGrid.setWalkable( isoObject.position.x , isoObject.position.y , false);
			putToTile( isoObject.instance );
			isoObject.instance.addEventListener( MouseEvent.MOUSE_OUT, onObjectMouseOut );
			isoObject.instance.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect );		
			_scene.render();			
		}
		
		//public function buyNewObject(obj:Object):void 
		//{			
			//trace( "[ IsoRoom ]: check id:..............................................................," + obj.id );
			//trace( "[ IsoRoom ]: check type:..............................................................," + obj.type );
			//trace( "[ IsoRoom ]: check sub type:..............................................................," + obj.type );
			//trace( "[ IsoRoom ]: check x:..............................................................," + obj.x );
			//trace( "[ IsoRoom ]: check y:..............................................................," + obj.y );
			//
			//if (_dragObject != null ) 
			//{
				//_scene.removeChild(_dragObject);
			//}
			//
			//var _objects:IsoSprite = new IsoSprite;
			//
			//actual mc
			//var _obj:MovieClip = new Objects();
			//
			//var labels:Array = _obj.currentLabels;
			//var found:Boolean = false;
			//
			//for (var i:uint = 0; i < labels.length; i++) {
				//var label:FrameLabel = labels[i];	
				//for checking obj.id
				//if ( label.name == obj.id ) {
					//found = true;
					//break;
				//}
			//}
			//
			//if (found)
			//{
				//_objects.setSize(obj.w * CELL_SIZE, obj.l * CELL_SIZE, obj.z);
				//see here checking objid
				//_obj.gotoAndStop(obj.id);
				//_objects.sprites = [_obj];
				//_objects.moveTo(CELL_SIZE + 1, CELL_SIZE + 1, 3);
				//_scene.addChild(_objects);
				//_dragObject = _objects as IsoSprite;
				//
				//var itemObj:Object = new Object();
				//itemObj.instance = _objects;
				//itemObj.movieclip = _obj;
				//itemObj.name = "object_" + String(objectsAry.length + 1);
				//itemObj.id = obj.id;
				//itemObj.entryid = "";
				//itemObj.w = obj.w;
				//itemObj.l = obj.l;
				//itemObj.h = obj.h;
				//itemObj.rotation = obj.rotation;
				//itemObj.gridX = obj.x;
				//itemObj.gridY = obj.y;
				//itemObj.type = obj.type;
				//itemObj.subType = obj.subType;
				//itemObj.npc = obj.npc;
				//itemObj.empty = obj.empty;
				//itemObj.level = obj.level;
				//itemObj.fbid = obj.fbid;
				//itemObj.npcid = obj.npcid;
				//itemObj.gender = obj.gender;
				//itemObj.staff = obj.staff;
				//itemObj.state = obj.state;
				//itemObj.fn = obj.fn;
				//
				//if (obj.type == "training") // width 
				//{
					//var _box:IsoBox = new IsoBox();
					//_box.setSize(CELL_SIZE, CELL_SIZE, 0);
					//_box.fills = [
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5),
						//new SolidColorFill(0x00ff00, .5)
					//];
					//_scene.addChild(_box);
					//itemObj.extraSpace = _box;
					//
					//switch (itemObj.subType)
					//{
						//case "sing" : 
								//trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
								//itemObj.extraSpacePosition = "back"; 
								//_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
							//break;
							//
							//case "acting" :
								//trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
								//itemObj.extraSpacePosition = "back"; 
								//_box.moveTo(_objects.x, _objects.y - CELL_SIZE, 3);
							//break;
							//
							//case "attraction" :
								//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
								//itemObj.extraSpacePosition = "front";
								//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
							//break;
							//
							//case "health" :
								//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
								//itemObj.extraSpacePosition = "front";
								//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
							//break;
							//
							//case "intelligent" :
								//trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
								//itemObj.extraSpacePosition = "front";
								//_box.moveTo(_objects.x + CELL_SIZE, _objects.y, 3);
							//break;
							//
							//default : break;
					//}
				//}
				//
				//_dragObjectProp = itemObj;
				//objectsAry.push(itemObj);				
				//OBJECT_INTERACTION = "BUY";
				//OBJECT_MOVING = true;				
				//_dragObject.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect );
				//addEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );				
				//_scene.render();
			//}
		//}
		
		public function buyNewObject(obj:*):void 
		{			
			if (_dragObject != null ) 
			{
				_scene.removeChild(_dragObject);
			}
			
			var isoObject:IsoObject = new IsoObject( obj as IsoObjectData );
			_scene.addChild( isoObject.instance );
			addChild( isoObject );			
			isoObject.showBubble( );
			
			_dragObject = isoObject.instance;
			trace( "check data isoObject eid", isoObject.entryid, "id", isoObject.id  );			
			_currentIsoObject = isoObject;				
			trace( "check data _currentIsoObject eid", _currentIsoObject.entryid, "id",_currentIsoObject.id  );
			objectsAry.push(isoObject);
			
			if (obj.type == "training") // width 
			{
				var _box:IsoBox = new IsoBox();
				_box.setSize(CELL_SIZE, CELL_SIZE, 0);
				_box.fills = [
					new SolidColorFill(0x00ff00, .5),
					new SolidColorFill(0x00ff00, .5),
					new SolidColorFill(0x00ff00, .5),
					new SolidColorFill(0x00ff00, .5),
					new SolidColorFill(0x00ff00, .5),
					new SolidColorFill(0x00ff00, .5)
				];
				_scene.addChild(_box);
				isoObject.extraSpace = _box;
				
				switch (isoObject.subType)
				{
					case "sing" : 
							trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							isoObject.extraSpacePosition = "back"; 
							_box.moveTo(isoObject.x, isoObject.y - CELL_SIZE, 3);
						break;
						
						case "acting" :
							trace('FREE SPACE SHOULD BE AT THE BACK OF OBJECT');
							isoObject.extraSpacePosition = "back"; 
							_box.moveTo(isoObject.x, isoObject.y - CELL_SIZE, 3);
						break;
						
						case "attraction" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							isoObject.extraSpacePosition = "front";
							_box.moveTo(isoObject.x + CELL_SIZE, isoObject.y, 3);
						break;
						
						case "health" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							isoObject.extraSpacePosition = "front";
							_box.moveTo(isoObject.x + CELL_SIZE, isoObject.y, 3);
						break;
						
						case "intelligent" :
							trace('FREE SPACE SHOULD BE AT THE FRONT OF OBJECT');
							isoObject.extraSpacePosition = "front";
							_box.moveTo(isoObject.x + CELL_SIZE, isoObject.y, 3);
						break;
						
						default : break;
				}
			}				
				
				
			OBJECT_INTERACTION = "BUY";
			OBJECT_MOVING = true;
			
			_dragObject.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect );
			addEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );			
			_scene.render();		
		}
		
		/*
		public function onObjectMouseUp(ev:ProxyEvent):void{
			ev.target.removeEventListener( MouseEvent.MOUSE_UP, onObjectMouseUp );
			if ( _dragObjectProp.type == "staff"  && _dragObjectProp.subType == "hire" ){
				trace( "[iso room ] staff table detected........................................................." );
				ev.target.addEventListener( MouseEvent.MOUSE_DOWN, onClickTableStaff );
			}
		}*/
		
		public function addNewFemaleCharacter( _def:String, X:int, Y:int , charid:String ):void 
		{
			/*
			var _characters:IsoSprite = new IsoSprite();
			_characters.setSize(1 * CELL_SIZE, 1 * CELL_SIZE, 3);
			
			var _char:AvatarFemale = new AvatarFemale;
			_char.y += 20;
			
			tmpdef = _def;
			//_char.addEventListener("ready2", onCharacterLoaderComplete);
			
			_characters.sprites = [_char];
			_characters.setSize(1*CELL_SIZE, 1*CELL_SIZE, 3);
			_characters.moveTo(X*CELL_SIZE, Y*CELL_SIZE, 3);
			_scene.addChild(_characters);
			
			_scene.render();
			
			_characters.addEventListener( MouseEvent.MOUSE_DOWN, _onCharSelect);
			//_characters.addEventListener( MouseEvent.ROLL_OVER, onObjectMouseOver, false, 0, true );
			//_characters.addEventListener( MouseEvent.ROLL_OUT, onObjectMouseOut, false, 0, true );
			
			_charObject = _characters as IsoSprite;
			_dragPt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );
			
			pathGrid.setWalkable(_charObject.x/CELL_SIZE, _charObject.y/CELL_SIZE, false);
			
			var charObj:Object = new Object();
			charObj.instance = _characters;
			charObj.movieclip = _char;
			charObj.name = "character_" + String(charAry.length + 1);
			charObj.gender = 1;
			charObj.definition = tmpdef;
			charObj.occupied = 0;
			charObj.x = _characters.x;
			charObj.y = _characters.y;
			
			charAry.push(charObj);
			
			for (var i:int = 0; i < floorsAry.length; i++) {
				if (_characters.x == floorsAry[i].x && _characters.y == floorsAry[i].y) {
					if (floorsAry[i].occupied == 0) {
						floorsAry[i].occupied = 1;
						//trace('floor xpos : ' + floorsAry[i].xpos + '& floor ypos : ' + floorsAry[i].ypos);
						//pathGrid.setWalkable(floorsAry[i].xpos, floorsAry[i].ypos, false);
					}
				}
			}
			*/
		}
		
		public function addNewMaleCharacter(_def:String, X:int, Y:int, charid:String ):void 
		{
			if( _def != null   )			
			{				
				if ( _def.length > 10 ) {
					trace( "def leng.=======================>",_def.length );
					var _characters:IsoSprite = new IsoSprite();
					_characters.setSize(1 * CELL_SIZE, 1 * CELL_SIZE, 3);
					
					var _char:AvatarMale = new AvatarMale();				
					if ( _char != null ) {					
						trace( "def========================>>>", _def );
						tmpdef = _def;
						_char.y += 20;
						_char.setType = _def;
						
						_characters.sprites = [_char];
						_characters.setSize(CELL_SIZE, CELL_SIZE, 3);
						_characters.moveTo(X*CELL_SIZE, Y*CELL_SIZE, 3);
						_scene.addChild(_characters);				
						_characters.addEventListener( MouseEvent.MOUSE_DOWN, _onCharSelect);
						_charObject = _characters as IsoSprite;
						_dragPt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );				
						pathGrid.setWalkable(_charObject.x/CELL_SIZE, _charObject.y/CELL_SIZE, false);
						
						var charObj:Object = new Object();
						charObj.instance = _characters;
						charObj.movieclip = _char;
						charObj.name = "character_" + String(charAry.length + 1);
						charObj.moveStartX = 0;
						charObj.moveStartY = 0;
						charObj.moveEndX = 0;
						charObj.moveEndY = 0;
						charObj.occupied = 0;
						charObj.definition = _def;
						charObj.gender = 0;
						charObj.x = _characters.x;
						charObj.y = _characters.y;
						charObj.z = 3;
						trace( "[ iso Room ].........................", charid );
						charObj.cid = charid;
						charAry.push(charObj);
						
						for (var i:int = 0; i < floorsAry.length; i++) {
							if (_characters.x == floorsAry[i].x && _characters.y == floorsAry[i].y) 
							{
								if (floorsAry[i].occupied == 0) 
								{
									floorsAry[i].occupied = 1;							
								}
							}
						}
						_scene.render();
					}
				}
			}	
		}
		
		/*--------------------------------------------------------------------
		|	PUBLIC METHOD FOR UPDATING CHARACTER SPRITE DEFINITIONS
		--------------------------------------------------------------------*/
		public function updateCharacter(definition:String):void
		{
			for (var i:int = 0; i < charAry.length; i++) {
				if (_charObject == charAry[i].instance) {
					trace('update character : ' + definition);
					tmpdef = definition;
					charAry[i].movieclip.setType = definition;
					tmpdef = charAry[i].movieclip.getType;					
					_scene.render();	
					break;
				}
			}
		}
		
		public function removeChar(char:IsoSprite):void
		{
			for (var i:int = 0; i < charAry.length; i++) {
				if (char == charAry[i].instance) {
					removeIsoSprite( char );
					charAry.splice( i, 1 );
					trace( "[IsoRoom]: Character remove from isoRoom" );
					break;
				}
			}
		}
		
		
		private function selectAllCharacters():void
		{
			for (var i:int = 0; i < charAry.length; i++) 
			{
				charAry[i].instance.container.filters = [new GlowFilter( 0xFF0000, 1, 6, 6, 64 )];				
			}
		}
		
		private function deselectAllCharacters():void
		{
			for (var i:int = 0; i < charAry.length; i++) 
			{
				charAry[i].instance.container.filters = [];
			}
		}
		
		private function deselectAllObjects():void
		{
			for (var i:int = 0; i < objectsAry.length; i++) 
			{
				objectsAry[i].instance.container.filters = [];
			}
		}
		
		public function get getCharData():Array
		{
			return charAry;
		}
		
		private function moveCharToObj(_charInstance:IsoSprite, _objInstance:IsoSprite):void 
		{
			deselectAllCharacters();
			deselectAllObjects();
			
			trace('char x : ' + _charInstance.x/CELL_SIZE + '&char y : ' + _charInstance.y/CELL_SIZE);
			trace('obj x : ' + _objInstance.x / CELL_SIZE + '&obj y : ' + _objInstance.y / CELL_SIZE);
			
			pathGrid.setStartNode(_charInstance.x / CELL_SIZE, _charInstance.y / CELL_SIZE);
			removeToTile(_charInstance);
			
			switch(getObjectSubType(_objInstance)) {
				case "sing" : 
					if (getObjectRotation(_objInstance) == 0) {
						endPosX = (_objInstance.x / CELL_SIZE);
						endPosY = (_objInstance.y / CELL_SIZE)-1;
					}else {
						endPosX = (_objInstance.x / CELL_SIZE)-1;
						endPosY = (_objInstance.y / CELL_SIZE);
					}
				break;
				
				case "acting" : 
					if (getObjectRotation(_objInstance) == 0) {
						endPosX = (_objInstance.x / CELL_SIZE);
						endPosY = (_objInstance.y / CELL_SIZE)-1;
					}else {
						endPosX = (_objInstance.x / CELL_SIZE)-1;
						endPosY = (_objInstance.y / CELL_SIZE);
					}
				break;
				
				default :
					if (getObjectRotation(_objInstance) == 0) {
						trace("OBJECT ROTATION IS 0");
						endPosX = (_objInstance.x / CELL_SIZE) + 1;
						endPosY = _objInstance.y / CELL_SIZE;
					}else if (getObjectRotation(_objInstance) == 1) {
						trace("OBJECT ROTATION IS 1");
						endPosX = _objInstance.x / CELL_SIZE;
						endPosY = (_objInstance.y / CELL_SIZE) + 1;
					}
				break;
			}
			
			trace("CHARACTER TARGET COORDINATES X : " + endPosX + " Y : " + endPosY);
			pathGrid.setEndNode(endPosX, endPosY);
			putToTile(_charInstance);
			
			/*if (_charInstance.x / CELL_SIZE == endPosX && _charInstance.y / CELL_SIZE == endPosY) {
				
				for (var i:int = 0; i < charAry.length; i++) 
				{
					if (_charInstance == charAry[i].instance) {
						_progressBarManager.addProgressBar(5, getObjectData(_dragObject), charAry[i]);
						
						charAry[i].movieclip.runAnimation(CHARACTER_ACTION, 5, 0);
						_dragObject.container.filters = [];
						deselectAllCharacters();
						deselectAllObjects();
						_dragObject = null;
						_charObject = null;
						endPosX = 0;
						endPosY = 0;
						break;
					}
				}
			}else{
				findPath();
			}*/
			
			findPath();
		}
		
		public function moveCharacterTo(_sprite:IsoSprite, X:int, Y:int):void
		{
			/*
			_charObject = _sprite as IsoSprite;				
			pathGrid.setStartNode(Math.floor(_sprite.x / CELL_SIZE), Math.floor(_sprite.y / CELL_SIZE));
			endPosX = X;
			endPosY = Y;
			pathGrid.setEndNode( X, Y );
			removeToTile(_charObject);			
			CHARACTER_MOVING = true;
			findPath();
			*/
		}
		
		public function addNewDoor(_type:int, X:int, Y:int, rot:int):void
		{
			var _objects:IsoSprite = new IsoSprite;			
			var _obj:MovieClip = new _objClass();
			
			_obj.gotoAndStop(_type);
			_objects.sprites = [_obj];
			_objects.moveTo(X, Y, 0);
			_scene.addChild(_objects);
			_dragObject = _objects as IsoSprite;
			_dragPt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );
			_objects.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect, false, 0, true );
			//_objects.addEventListener( MouseEvent.ROLL_OVER, onObjectMouseOver, false, 0, true );
			_objects.addEventListener( MouseEvent.ROLL_OUT, onObjectMouseOut, false, 0, true );			
			objectCategory = "doors";			
			_scene.render();
			
			if (rot == 1) {
				_objects.container.scaleX = -(_objects.container.scaleX);
			}
		}
		
		public function addNewWindow(_type:int, X:int, Y:int, rot:int):void
		{
			var _objects:IsoSprite = new IsoSprite;			
			var _obj:MovieClip = new _objClass();			
			_obj.gotoAndStop(_type);
			_objects.sprites = [_obj];
			_objects.moveTo(X, Y, 4);
			_scene.addChild(_objects);
			_dragObject = _objects as IsoSprite;
			_dragPt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );
			_objects.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect, false, 0, true );			
			_objects.addEventListener( MouseEvent.ROLL_OUT, onObjectMouseOut, false, 0, true );
			objectCategory = "windows";			
			_scene.render();
			
			if (rot == 1) {
				_objects.container.scaleX = -(_objects.container.scaleX);
			}
		}
		
		private function objready(e:Event):void {
			e.target.setType = e.target.tempDef;
		}
		
		
		private function addCoin(  x:Number, y:Number, z:Number  ):void 
		{
			trace( "add coin.............................!!!!!!!!" );
			var coin:DropItem = new DropItem( 1, 1, 1, new Coin(), new Object(), x, y, z , _view , stage , _scene ,0 );
			var ap:DropItem = new DropItem( 1, 1, 1, new Coin(), new Object(), x, y, z , _view , stage , _scene ,1 );			
		}
		/******************************************************************************************************************************************
		|	EVENT HANDLERS
		*******************************************************************************************************************************************/
		/*---------------------------
		|	loader event handlers
		-----------------------------*/
		private function _onObjectLoaderComplete(e:Event):void {
			_objClass = _objLoader.contentLoaderInfo.applicationDomain.getDefinition('Objects') as Class;
		}
		
		private function _onObjectLoaderProgress(e:ProgressEvent):void {
			var percent:Number = e.bytesLoaded/e.bytesTotal;
			trace(percent);
		}		
		
		/*---------------------------
		|	object event handlers
		---------------------------*/
		
		/*---------------------------
		* floor event handler
		-----------------------------*/
		private function onFloorClick(e:MouseEvent):void {
			if (ALL_INTERACTIONS_ON) {
				if (OBJECT_INTERACTION == "") {
					if ( _charObject != null ) 
					{				
						for (var c:int = 0; c < floorsAry.length; c++) {
							if (e.target.name == floorsAry[c].name) {						
								pathGrid.setEndNode( floorsAry[c].xpos, floorsAry[c].ypos );
								endPosX = floorsAry[c].xpos * CELL_SIZE;
								endPosY = floorsAry[c].ypos * CELL_SIZE;
							}				
						}
						
						var xpos:int = Math.floor(_charObject.x / CELL_SIZE);
						var ypos:int = Math.floor(_charObject.y / CELL_SIZE);
						trace('\n_charObject x : ' + _charObject.x + '& _charObject y : ' + _charObject.y);
						trace('xpos : '  + xpos + '& ypos : '  + ypos);
						
						for (var i:int = 0; i < floorsAry.length; i++) 
						{
							if (_charObject.x == floorsAry[i].x && _charObject.y == floorsAry[i].y) 
							{
								if (floorsAry[i].occupied == 1)
								{
									floorsAry[i].occupied = 0;									
								}
							}
						}
						
						pathGrid.setWalkable(xpos, ypos, true);
						pathGrid.setStartNode(xpos, ypos);						
						CURRENT_FLOOR = e.target.name;						
						findPath();
					}				
				}
			}
		}
		
		private function onFloorOver(e:MouseEvent):void
		{
			CURRENT_FLOOR = e.target.name;			
			/*
			if (_dragObject != null) {
				
					trace('dragObject orientation : ' + _dragObject.container.scaleX);
					
					for (var i:int = 0; i < floorsAry.length; i++) 
					{
						if (floorsAry[i].x == e.target.x && floorsAry[i].y == e.target.y) 
						{
							var direction:String = floorsAry[i].walldirection;
							trace('wall direction : ' + floorsAry[i].walldirection);
							
							if (direction == "left") {
								if (_dragObject.container.scaleX != -1) 
								{
									_dragObject.container.scaleX = 1;
									_scene.render();
								}
							}else if (direction == "right") {
								if (_dragObject.container.scaleX != 1) 
								{
									_dragObject.container.scaleX = -(_dragObject.container.scaleX);
									_scene.render();
								}
							}
						}
					}

			}
			*/
		}
		
		private function onFloorOut(e:MouseEvent):void
		{
			var flrObj:IsoSprite = e.target as IsoSprite;			
		}
		
		private function onObjectSelect( e:ProxyEvent ):void
		{
			_dragObject = null;
			_charObject = null;
			
			if (ALL_INTERACTIONS_ON) 
			{
				_dragObject = e.target as IsoSprite;
				
				trace('OBJECT COLLISSION : ' + OBJECT_COLLISSION);
				switch (OBJECT_INTERACTION) 
				{
				/*-----------------------------
				|	CASE 'MOVE'
				-----------------------------*/
				case "MOVE" :
					var officeItemObject:Object = getObjectData( _dragObject );	
					_sdc.placeToInvetory( officeItemObject.entryid  );
				
					if (OBJECT_COLLISSION == false && SPACE_COLLISSION == false) {
						if (OBJECT_MOVING) 
						{
							if (_activeObject == _dragObject) {
								trace('place object');
								OBJECT_MOVING = false;
								putToTile(e.target as IsoSprite);
								
								removeEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );								
								_dragObject = null;
								
								removePointer();
								updateObjectAttributes(e.target as IsoSprite);
								registerObject(e.target as IsoSprite);
								_activeObject = null;
							}
						}else {
							trace('object dragged sub type : ' + getObjectSubType(e.target as IsoSprite));
							_activeObject = _dragObject;
							OBJECT_MOVING = true;
							removeToTile(e.target as IsoSprite);
							
							addEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );
						}
					}else {
						trace('COLLISSIONS DETECTED');
					}
				break;
				
				/*-----------------------------
				|	CASE 'BUY'
				-----------------------------*/
				case "BUY" :
					trace('buying');
					if (OBJECT_COLLISSION == false && SPACE_COLLISSION == false) {
						if (OBJECT_MOVING){
							OBJECT_MOVING = false;							
							updateObjectAttributes(e.target as IsoSprite);
							_currentObject = new Object();
							
							for (var b:int = 0; b < objectsAry.length; b++)
							{
								if (objectsAry[b].instance == e.target)
								{
									_currentObject.instance = objectsAry[b].instance;
									_currentObject.gridX = objectsAry[b].gridX;
									_currentObject.gridY = objectsAry[b].gridY;
									_currentObject.z = objectsAry[b].z;
									_currentObject.rotation = objectsAry[b].rotation;
								}
							}
							
							putToTile(e.target as IsoSprite);
							removeEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );						
							
							if ( !GlobalData.instance.tutorialparts[ GlobalData.instance.tutTracker ] && !GlobalData.instance.isTutorialDone ) {
								_popUIManager.removeCurrentSubWindow( );
								_popUIManager.loadSubWindow( WindowPopUpConfig.TUTORIAL_WINDOW );
							}else {
								addCoin( _dragObject.x, _dragObject.y , _dragObject.z  );
							}									
							_dragObject = null;
							_charObject = null;
							OBJECT_INTERACTION = "";							
							ServerDataController.getInstance().buyItem(getObjectID(e.target as IsoSprite));							
						}else {
							OBJECT_MOVING = true;
							removeToTile(e.target as IsoSprite);
						}
					}else {
						trace('OBJECT COLLISSIONS DETECTED');
					}
				break;				
				
				case "SET" :
					trace('seting item');
					if (OBJECT_COLLISSION == false && SPACE_COLLISSION == false) {
						if (OBJECT_MOVING){
							OBJECT_MOVING = false;
							
							updateObjectAttributes(e.target as IsoSprite);						
							_currentObject = new Object();
							
							for ( b = 0; b < objectsAry.length; b++)
							{
								if (objectsAry[b].instance == e.target)
								{
									_currentObject.instance = objectsAry[b].instance;
									_currentObject.gridX = objectsAry[b].gridX;
									_currentObject.gridY = objectsAry[b].gridY;
									_currentObject.z = objectsAry[b].z;
									_currentObject.rotation = objectsAry[b].rotation;
									break;
								}
							}
							
							GlobalData.instance.currentEntryId = _currentIsoObject.entryid;
							putToTile(e.target as IsoSprite);
							removeEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );
							registerOfficeItemPos(  _currentIsoObject.entryid, _currentObject.gridX
													,_currentObject.gridY, _currentObject.z,
													_currentObject.rotation );							
							_dragObject = null;
							_charObject = null;
							OBJECT_INTERACTION = "";
						}else {
							OBJECT_MOVING = true;
							removeToTile(e.target as IsoSprite);
						}
					}else {
						trace('OBJECT COLLISSIONS DETECTED');
					}
				break;
				
				/*-----------------------------
				|	CASE 'ROTATE'
				-----------------------------*/
				case "ROTATE" :
					removeToTile(_dragObject);
					
					if (getObjectType(_dragObject) == "training")
					{
						checkFreeSpaceRotation(_dragObject);
					} else {
						if (getObjectSubType(_dragObject) == "window" || getObjectSubType(_dragObject) == "door") {
							OBJECT_ROTATABLE = false;
						}else {
							OBJECT_ROTATABLE = true;
						}
					}
					
					if (OBJECT_ROTATABLE)
					{
						_dragObject.container.scaleX = -(_dragObject.container.scaleX);
						updateObjectAttributes(e.target as IsoSprite);
						registerObject(e.target as IsoSprite);
					}
					
					OBJECT_ROTATABLE = false;
					SPACE_COLLISSION = false;
					putToTile(_dragObject);
					removePointer();
					OBJECT_INTERACTION = "";
					_dragObject = null;
				break;
				
				/*-----------------------------
				|	CASE 'SELL'
				-----------------------------*/
				case "SELL" :
					_dragObject = e.target as IsoSprite;
					_scene.removeChild(_dragObject);
					
					for (var _fs:int = 0; _fs < objectsAry.length; _fs++ )
					{
						if (_dragObject == objectsAry[_fs].instance)
						{
							if (objectsAry[_fs].extraSpace != null)
							{
								_scene.removeChild(objectsAry[_fs].extraSpace);
							}
						}
					}
					
					ServerDataController.getInstance().sellItem(getObjectEntryID(e.target as IsoSprite));
					//to do set walkable to true when sell
					OBJECT_INTERACTION = "";
				break;
				
				/*-----------------------------
				|	CASE 'STORE'
				-----------------------------*/
				case "STORE" :
					
				break;
				
				/*-----------------------------
				|	CASE 'DEFAULT'
				-----------------------------*/
				default :					
					if (getObjectType(_dragObject) == "training" ) // OBJECT TYPE : TRAINING
					{ 							
						if (OBJECT_INTERACTION == "CHARACTER_ACTION") 
						{
							//test
							//trace( "train me started............");
							//_sdc.startTrain( GlobalData.instance.currentCharId, GlobalData.instance.currentEntryId );							
							_dragObject.container.filters = [];
							OBJECT_INTERACTION = "";
							CHARACTER_ACTION = "";
							_dragObject = e.target as IsoSprite;
							_dragObject.container.filters = [];
							deselectAllCharacters();
						} else { 
							var ifObjectHasTrainingInteraction:Boolean = false;
							switch (getObjectSubType(_dragObject))
							{
								case "health" : ifObjectHasTrainingInteraction = true; break;
								case "intelligent" : ifObjectHasTrainingInteraction = true; break;
								case "acting" :  ifObjectHasTrainingInteraction = true; break;
								case "sing" : ifObjectHasTrainingInteraction = true; break;
								case "attraction" : ifObjectHasTrainingInteraction = true; break;
								default :  ifObjectHasTrainingInteraction = false; break;
							}
							
							if (ifObjectHasTrainingInteraction) 
							{
								OBJECT_INTERACTION = "CHARACTER_ACTION";
								
								var _action:String = getObjectSubType(e.target as IsoSprite);
								
								switch (_action)
								{
									case "health" : _action = GlobalData.PLAYER_MOTIONSTRENGTH; 
									break;
									
									case "intelligent" : 	_action = GlobalData.PLAYER_MOTIONINTEL ; 
									break;
									
									case "acting" :  _action = GlobalData.PLAYER_MOTIONACTING; 
									break;
									
									case "sing" : _action = GlobalData.PLAYER_MOTIONSINGING; 
									break;
									
									case "attraction" : _action = GlobalData.PLAYER_MOTIONATTRACT; 
									break;
									
									default : _action = ""; 
									break;
								}
								
								trace('\nCHARACTER ACTION : ' + CHARACTER_ACTION);
								
								CHARACTER_ACTION = _action;
								
								_dragObject.container.filters = [new GlowFilter( 0xFF0000, 1, 6, 6, 64 )];
								selectAllCharacters();
							}else {
								_dragObject = null;
							}
						}
					}
				break;
				}
				_scene.render();
			}
		}
		
		/*----------------------------
		| UPDATE OBJECT ATTRIBUTES
		----------------------------*/
		private function updateObjectAttributes(_target:IsoSprite):void 
		{
			for (var i:int = 0; i <  objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					objectsAry[i].x = _target.x;
					objectsAry[i].y = _target.y;
					objectsAry[i].gridX = _target.x / CELL_SIZE;
					objectsAry[i].gridY = _target.y / CELL_SIZE;
					if (_target.container.scaleX == -1)
					{
						objectsAry[i].rotation = 1;
					}else {
						objectsAry[i].rotation = 0;
					}
				}
			}
		}
		
		// GET OBJECT ID
		private function getObjectID(_target:IsoSprite):String
		{
			var _objectID:String = "";
			
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					_objectID = objectsAry[i].id;
				}
			}
			
			return _objectID;
		}
		
		// GET OBJECT ENTRY ID
		private function getObjectEntryID(_target:IsoSprite):String
		{
			var _entryID:String = "";
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					_entryID = objectsAry[i].entryid;
				}
			}
			return _entryID;
		}
		
		// GET OBJECT TYPE
		private function getObjectType( _target:IsoSprite ):String
		{
			var _type:String = "";
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance)
				{
					_type = objectsAry[i].type;
					break;
				}
			}
			return _type;
		}
		
		// GET OBJECT SUB TYPE
		private function getObjectSubType( _target:IsoSprite ):String
		{
			var _subType:String = "";
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					_subType = objectsAry[i].subType;
					break;
				}
			}
			return _subType;
		}
		
		// GET OBJECT ROTATION
		private function getObjectRotation( _target:IsoSprite ):int
		{
			var _rotation:int = 0;
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					_rotation = objectsAry[i].rotation;
					break;
				}
			}
			return _rotation;
		}
		
		// GET OBJECT ROTATION
		private function getObjectExtraSpace(_target:IsoSprite):IsoBox
		{
			var _extraSpace:IsoBox = new IsoBox();
			for (var i:int = 0; i < objectsAry.length; i++ ) {
				if (_target == objectsAry[i].instance)
				{
					_extraSpace = objectsAry[i].extraSpace.instance as IsoBox;
				}
			}
			return _extraSpace;
		}
		
		private function getObjectData( _target:IsoSprite ):Object 
		{
			var isoSpriteObj:Object;
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if ( _target == objectsAry[i].instance ){
					isoSpriteObj = objectsAry[i];
					break;
				}
			}
			return isoSpriteObj;
		}
		
		
		//new
		private function setObjectView( entryid:String ):void 
		{			
			trace( "see===== entryid================>>>",entryid );
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				trace( "entr id search",entryid );
				if ( entryid == objectsAry[i].entryid ) {					
					//objectsAry[i].movieclip.mc.gotoAndStop( 2 );					
					objectsAry[i].showDeskStaff();
					objectsAry[i].addObjectInteraction();
					trace( "[ isoRoom  ] setView hire staff.................................." );
					break;
				}
			}			
			trace( "see end ===== entryid================>>>",entryid );
		}
		
		
		
		// REGISTER OBJECT TO DATABASE
		private function registerObject( _target:IsoSprite):void 
		{			
			//swifer
			var officeItemObject:Object = getObjectData( _target as IsoSprite );			
			trace( "[iso room register officeItem ] .................................");
			//swifer			
			for (var i:int = 0; i < objectsAry.length; i++ ) 
			{
				if (_target == objectsAry[i].instance) 
				{
					trace('\nREGISTERING OBJECT');
					trace('\nregistering object instance : ' + objectsAry[i].instance);
					trace('registering object ID : ' + objectsAry[i].id);
					trace('registering object entry ID : ' + objectsAry[i].entryid);
					trace('registering object gridX : ' + objectsAry[i].gridX);
					trace('registering object gridY : ' + objectsAry[i].gridY);
					trace('registering object z : ' + objectsAry[i].z);
					trace('registering object rotation : ' + objectsAry[i].rotation);
					//addCoin( objectsAry[i].gridX, objectsAry[i].gridY , objectsAry[i].z  );
					ServerDataController.getInstance().registerOfficeItemPosition
																		  (
																			  objectsAry[i].entryid,
																			  objectsAry[i].gridX,
																			  objectsAry[i].gridY,
																			  objectsAry[i].z,
																			  objectsAry[i].rotation
																		  );
					trace( "[iso room register officeItem ] entryid>>>>.................................", objectsAry[i].entryid );
					break;
				}				
			}
		}
		
		// EVENT HANDLER IF OBJECT ITEM IS BOUGHT
		private function _onOfcItemBuyComplete(e:ServerDataControllerEvent):void
		{
			clearDragObject();
			trace('*******************************BUYING ITEM ' + e.obj.entryid) + ' SUCCESSFUL*******************************';			
			for (var i:int = 0; i < objectsAry.length; i++ )
			{
				if (_currentObject.instance == objectsAry[i].instance) 
				{
					objectsAry[i].entryid = e.obj.entryid;
				}
			}
			
			ServerDataController.getInstance().registerOfficeItemPosition(
																			  e.obj.entryid,
																			  _currentObject.gridX,
																			  _currentObject.gridY,
																			  _currentObject.z,
																			  _currentObject.rotation
																		  );
		}
		
		public function registerOfficeItemPos( entryid:String, x:uint, y:uint, z:uint, rot:uint  ):void 
		{
			_sdc.registerOfficeItemPosition( entryid, x,y,z,rot );
		}
		
		// EVENT HANDLER IF OBJECT ITEM IS REGISTERED ON THE DATABASE
		private function _onOfcItemRegistrationComplete(e:ServerDataControllerEvent):void
		{
			clearDragObject();			
			var globalData:GlobalData = GlobalData.instance;
			var len:int = globalData.officeStateDataArray.length;
			for(var i:int = 0; i < objectsAry.length; i++)
			{
				if(_dragObject == objectsAry[i].instance)
				{
					objectsAry[i].entryid = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_ENTRY];
					objectsAry[i].w = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_DIMENSION].x;
					objectsAry[i].l = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_DIMENSION].y;
					objectsAry[i].h = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_DIMENSION].z;
					objectsAry[i].rotation = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_ROTATION];
					objectsAry[i].rotation = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_ROTATION];
					objectsAry[i].gridX = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_POSITION].x;
					objectsAry[i].gridY = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_POSITION].y;
					objectsAry[i].type = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_TYPE];
					objectsAry[i].subType = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_SUBTYPE];
					objectsAry[i].npc = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_NPC];
					objectsAry[i].empty = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_EMPTY];
					objectsAry[i].level = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_LEVEL];
					objectsAry[i].fbid = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_FBID];
					objectsAry[i].npcid = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_NPCID];
					objectsAry[i].gender = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_GENDER];
					objectsAry[i].staff = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_STAFF_POS];
					objectsAry[i].state = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_POS_STATE];
					objectsAry[i].fn = globalData.officeStateDataArray[len -1][GlobalData.OFFICESTATE_ITEMFRAMENUMBER];
					pathGrid.setWalkable( objectsAry[i].gridX , objectsAry[i].gridY , false);
					break;
				}
			}			
			
			
			//if (getObjectType(_dragObject) == "staff" ) // OBJECT TYPE : STAFF
			//{ 
				//processStaffTable(_dragObject);
			//}
			
			//if( _currentIsoObject != null ){
				//_currentIsoObject.addObjectInterAction();
			//}
			trace('*******************************REGISTRATION SUCCESSFUL*******************************');			
		}
		
		// REMOVE OBJECT FROM TILE'S COORDINATE
		private function removeToTile(_target:IsoSprite):void {
			for (var i:int = 0; i < floorsAry.length; i++ ) 
			{
				if (_target.x == floorsAry[i].x && _target.y == floorsAry[i].y) 
				{
					floorsAry[i].occupied = 0;
					addEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );
					pathGrid.setWalkable(Math.floor(_target.x / CELL_SIZE), Math.floor(_target.y / CELL_SIZE), true);
				}
			}
			
			for (var j:int = 0; j < objectsAry.length; j++ )
			{
				if (objectsAry[j].extraSpace != null && objectsAry[j].instance == _target)
				{
					var _box:IsoBox = objectsAry[j].extraSpace as IsoBox;
					for (var a:int = 0; a < floorsAry.length; a++ ) 
					{
						if (_box.x == floorsAry[a].x && _box.y == floorsAry[a].y) 
						{
							if (floorsAry[a].occupied == 1)
							{		
								floorsAry[a].occupied = 0;
							}
						}
					}
				}
			}
			
			_scene.render();
		}
		
		// PUT OBJECT TO TILE'S COORDINATE
		private function putToTile(_target:IsoSprite):void 
		{
			for (var i:int = 0; i < floorsAry.length; i++ ) 
			{
				if (_target.x == floorsAry[i].x && _target.y == floorsAry[i].y) 
				{
					if (floorsAry[i].occupied == 0)
					{		
						_target.container.alpha = 1;
						floorsAry[i].occupied = 1;
						pathGrid.setWalkable(Math.floor(_target.x / CELL_SIZE), Math.floor(_target.y / CELL_SIZE), false);
					}
				}
			}
			
			for (var j:int = 0; j < objectsAry.length; j++ )
			{
				//check here
				if (objectsAry[j].extraSpace != null && objectsAry[j].instance == _target)
				{
					var _box:IsoBox = objectsAry[j].extraSpace as IsoBox;
					for (var a:int = 0; a < floorsAry.length; a++ ) 
					{
						if (_box.x == floorsAry[a].x && _box.y == floorsAry[a].y) 
						{
							if (floorsAry[a].occupied == 0)
							{		
								floorsAry[a].occupied = 1;
							}
						}
					}
				}
			}
			
			_scene.render();
		}
		
		private function onObjectMove( e:MouseEvent ):void
		{
			//trace('\nON OBJECT MOVE RUNNING');
			//trace('OBJECT COLLISSIONS = ' + OBJECT_COLLISSION + ' && SPACE COLLISSIONS = ' + SPACE_COLLISSION);
			if (_dragObject != null && OBJECT_MOVING == true) {
				var pt:Pt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );				
				_dragObject.moveTo(Math.floor(pt.x / CELL_SIZE) * CELL_SIZE, Math.floor(pt.y / CELL_SIZE) * CELL_SIZE, 3);			
				var _subType:String = getObjectSubType(_dragObject);
				
				for (var a:int = 0; a < floorsAry.length; a++) 
				{
					if (_dragObject.x == floorsAry[a].x && _dragObject.y == floorsAry[a].y) 
					{
						if (_subType == 'window' || _subType == 'door') {
							trace('OBJECT SUBTYPE : ' + _subType);
							checkRotation();
							
							/*
							for (var dw:int = 0; dw < wallsAry.length; dw++ )
							{
								if (_dragObject.x == wallsAry[dw].x && _dragObject.y == wallsAry[dw].y) {
									
									for (var eo:int = 0; eo < floorsAry.length; eo++ ) 
									{
										if (floorsAry[eo].occupied == 0) 
										{
											OBJECT_COLLISSION = false;
										}else {
											OBJECT_COLLISSION = true;
										}
									}
									
								}else {
									OBJECT_COLLISSION = true;
								}
							}
							*/
							
						}else {
							//trace('OBJECT SUBTYPE IS NOT DOOR OR WINDOW');
							if (floorsAry[a].occupied == 1) {
								_dragObject.container.filters = [ new GlowFilter( 0xFF0000, 1, 6, 6, 64 ) ];
								_dragObject.z = 10;
								OBJECT_COLLISSION = true;
							} else {
								_dragObject.container.filters = [];
								_dragObject.z = 3;
								OBJECT_COLLISSION = false;
							}
						}
					}
				}				
				adjustObjectExtraSpace(_dragObject);
				_scene.render();
			}
		}
		
		private function checkFreeSpaceRotation(_target:IsoSprite):void
		{
			for (var i:int = 0; i < objectsAry.length; i++ )
			{
				if (_target == objectsAry[i].instance)
				{
					if (objectsAry[i].extraSpace != null)
					{
						var _box:IsoBox = objectsAry[i].extraSpace as IsoBox;
						
						if (objectsAry[i].extraSpacePosition == "front")
						{							
							if (objectsAry[i].rotation == 0) {
								_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y + CELL_SIZE, 3);
								checkSpaceCollission(_box);
								if (SPACE_COLLISSION) {
									_box.moveTo(objectsAry[i].instance.x + CELL_SIZE, objectsAry[i].instance.y, 3);
									OBJECT_ROTATABLE = false;
								}else {
									OBJECT_ROTATABLE = true;
								}
							}else if (objectsAry[i].rotation == 1) {
								_box.moveTo(objectsAry[i].instance.x + CELL_SIZE, objectsAry[i].instance.y, 3);
								checkSpaceCollission(_box);
								if (SPACE_COLLISSION) {
									_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y + CELL_SIZE, 3);
									OBJECT_ROTATABLE = false;
								}else {
									OBJECT_ROTATABLE = true;
								}
							}	
						}else if (objectsAry[i].extraSpacePosition == "back") {
							if (objectsAry[i].rotation == 0) {
								_box.moveTo(objectsAry[i].instance.x - CELL_SIZE, objectsAry[i].instance.y, 3);
								checkSpaceCollission(_box);
								if (SPACE_COLLISSION) {
									_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y - CELL_SIZE, 3);
									OBJECT_ROTATABLE = false;
								}else {
									OBJECT_ROTATABLE = true;
								}
							}else if (objectsAry[i].rotation == 1) {
								_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y - CELL_SIZE, 3);
								checkSpaceCollission(_box);
								if (SPACE_COLLISSION) {
									_box.moveTo(objectsAry[i].instance.x - CELL_SIZE, objectsAry[i].instance.y, 3);
									OBJECT_ROTATABLE = false;
								}else {
									OBJECT_ROTATABLE = true;
								}
							}
						}						
					}
				}
			}
		}
		
		private function adjustObjectExtraSpace(_target:IsoSprite):void
		{
			for (var i:int = 0; i < objectsAry.length; i++ )
			{
				if (_target == objectsAry[i].instance)
				{
					if (objectsAry[i].extraSpace != null)
					{
						var _box:IsoBox = objectsAry[i].extraSpace as IsoBox;
						
						if (objectsAry[i].extraSpacePosition == "back") {
							//_box.moveTo(objectsAry[i].x + CELL_SIZE, objectsAry[i].y, 3);
							if (objectsAry[i].rotation == 0) {
								_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y - CELL_SIZE, 3);
								checkSpaceCollission(_box);
							}else if (objectsAry[i].rotation == 1) {
								_box.moveTo(objectsAry[i].instance.x - CELL_SIZE, objectsAry[i].instance.y, 3);
								checkSpaceCollission(_box);
							}
						}else if (objectsAry[i].extraSpacePosition == "front") {
							//_box.moveTo(objectsAry[i].x + CELL_SIZE, objectsAry[i].y, 3);
							if (objectsAry[i].rotation == 0) {
								_box.moveTo(objectsAry[i].instance.x + CELL_SIZE, objectsAry[i].instance.y, 3);
								checkSpaceCollission(_box);
							}else if (objectsAry[i].rotation == 1) {
								_box.moveTo(objectsAry[i].instance.x, objectsAry[i].instance.y + CELL_SIZE, 3);
								checkSpaceCollission(_box);
							}
						}
						
					}else {
						SPACE_COLLISSION = false;
					}
				}
			}
		}
		
		private function checkSpaceCollission(_box:IsoBox):Boolean
		{
			for (var i:int = 0; i < floorsAry.length; i++ )
			{
				var _val:Boolean = false;
				if (floorsAry[i].x == _box.x && floorsAry[i].y == _box.y) {
					if (floorsAry[i].occupied == 1) {
						SPACE_COLLISSION = true;
						_val = true;
					}else {
						SPACE_COLLISSION = false;
						_val = false;
					}
				}
			}
			return _val;
		}
		
		private function checkRotation():void 
		{
			for (var l:int = 0; l < leftWallsAry.length; l++ ) {
				if (leftWallsAry[l].x == _dragObject.x && leftWallsAry[l].y == _dragObject.y) 
				{
					trace('OBJECT ON LEFT WALLS');
					if (_dragObject.container.scaleX != 1) 
					{
						_dragObject.container.scaleX = 1;
					}
				}
			}
			
			for (var r:int = 0; r < rightWallsAry.length; r++ ) {
				if (rightWallsAry[r].x == _dragObject.x && rightWallsAry[r].y == _dragObject.y) 
				{
					trace('OBJECT ON RIGHT WALLS');
					if (_dragObject.container.scaleX != -1) 
					{
						_dragObject.container.scaleX = -(_dragObject.container.scaleX);
					}
				}
			}
		}	
		
		public function clearDragObject():void 
		{
			if( _dragObject != null ){
				_dragObject = null;				
			}
			
			if ( _charObject != null ) {
				_charObject = null;
			}
		}
		
		
		public function removeDragObject():void 
		{
			if( _dragObject != null ){				
				removeIsoSprite( _dragObject );
			}
			
			if ( _charObject != null ) {
				_sdc.placeCharToInventory( GlobalData.instance.currentCharId );
				removeChar( _charObject );
			}
		}
		
		private function removeIsoSprite( isoSprite:IsoSprite ):void 
		{
			if( isoSprite != null ){
				if ( _scene.contains( isoSprite ) ) {
					_scene.removeChild( isoSprite );
					isoSprite = null;
					trace( "[IsoRoom]: IsoSprite remove..............................." );
				}		
			}
		}		
		
		private function onObjectMouseOut(e:ProxyEvent):void 
		{
			/*
			_scene.removeChild(_popupObject);
			removeEventListener(Event.ENTER_FRAME, onRun);
			*/
		}
		
		private function onPick( e:ProxyEvent ):void
		{
			_dragObject = e.target as IsoSprite;
			_dragPt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );
			_dragPt.x -= _dragObject.x;
			_dragPt.y -= _dragObject.y;
			
			_dragObject.removeEventListener( MouseEvent.MOUSE_DOWN, onPick );			
			_dragObject.addEventListener( MouseEvent.MOUSE_UP, onDrop, false, 0, true );
			addEventListener( MouseEvent.MOUSE_UP, onDrop, false, 0, true );			
			Tweener.addTween( _dragObject, { z:10, time:0.5 } );
		}
		
		private function onDrop( e:Event ):void
		{
			_dragObject.removeEventListener( MouseEvent.MOUSE_UP, onDrop );
			removeEventListener( MouseEvent.MOUSE_UP, onDrop );			
			_dragObject.addEventListener( MouseEvent.MOUSE_DOWN, onPick, false, 0, true );
			Tweener.addTween( _dragObject, { z:3, time:0.5 } );
		}
		
		/*---------------------------
		* mouse pointer functions
		-----------------------------*/	
		public function createMovePointer():void
		{
			trace('CREATE MOVE POINTER');
			
			if (ptrAry != null) 
			{
				removePointer();
			}
			
			ptrAry = new Array();
			OBJECT_INTERACTION = "MOVE";
			var _pointer:MovePointer = new MovePointer();
			addChild(_pointer);
			ptrAry.push(_pointer);
			ptrAry[0].addEventListener(Event.ENTER_FRAME, onMousePointerMove);
		}
		
		public function createRotatePointer():void
		{
			trace('CREATE ROTATE POINTER');
			if (ptrAry != null) 
			{
				removePointer();
			}
			
			ptrAry = new Array();
			OBJECT_INTERACTION = "ROTATE";
			var _pointer:RotatePointer = new RotatePointer();
			addChild(_pointer);
			ptrAry.push(_pointer);
			ptrAry[0].addEventListener(Event.ENTER_FRAME, onMousePointerMove);
		}
		
		public function removePointer():void {
			if( ptrAry != null ){
				trace(ptrAry);
				if (ptrAry.length > 0) 
				{
					if( this.contains( ptrAry[0] ) ){
						ptrAry[0].removeEventListener(Event.ENTER_FRAME, onMousePointerMove);
						removeChild(ptrAry[0]);
						OBJECT_INTERACTION = "";
						ptrAry[0] = null;
						ptrAry = new Array();
					}
				}
			}
		}
		
		/*---------------------------
		* object interaction functions
		-----------------------------*/	
		public function moveObject():void
		{
			//var pt:Pt = _view.localToIso( new Point( stage.mouseX, stage.mouseY ) );
			//_dragObject.moveTo( Math.floor(pt.x / CELL_SIZE) * CELL_SIZE, Math.floor(pt.y / CELL_SIZE) * CELL_SIZE, pt.z = 3);
		}
		
		public function rotateObject():void
		{
			//_dragObject.container.scaleX = -(_dragObject.container.scaleX);
		}
		
		public function sellObject():void
		{
			OBJECT_INTERACTION = "SELL";
		}
		
		public function storeObject():void
		{
			OBJECT_INTERACTION = "STORE";
		}		
		
		/*---------------------------
		* object mouse over
		* and mouse out
		* event handlers
		-----------------------------*/		
		
		private function onCharacterMouseOver(e:ProxyEvent):void
		{
			_glow = new GlowFilter( 0x00FF00, 1, 6, 6, 64 );
			( e.target as IsoSprite ).container.filters = [ _glow ];
		}
		
		private function onCharacterMouseOut(e:ProxyEvent):void
		{
			( e.target as IsoSprite ).container.filters = [ ];
		}
		
		/*----------------------
		* avatar event handlers
		--------------------- */
		private function _onCharSelect(e:ProxyEvent):void
		{	
			_charObject = null;
			//_dragObject = null;
			
			var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_CONTESTANT_TO_HIRE_CREW );
			_es.dispatchESEvent( tutEvent );			
			
			//swifer
			//charAry
			if (ALL_INTERACTIONS_ON) {
				
				for (var i:int = 0; i < charAry.length; i++) {
					if (e.target == charAry[i].instance) {
						trace('char gender : ' + charAry[i].gender);
						character_gender = charAry[i].gender;
						tmpdef = charAry[i].definition;
						GlobalData.instance.currentCharId = charAry[i].cid;
						break;
					}
				}
				
				//TEST
				//_sdc.stressDownChar( GlobalData.instance.currentCharId );
				//_sdc.stressDownNeighborChar( GlobalData.instance.currentCharId,GlobalData.instance.myFbId );
				//_sdc.soothNeighborChar( GlobalData.instance.currentCharId,GlobalData.instance.selectedFriendFbId );
				//_sdc.cryChar( GlobalData.instance.currentCharId );
				
				if( GlobalData.instance.currentCharId != null ){
					_sdc.endTrain( GlobalData.instance.currentCharId );
					trace( "current charid", GlobalData.instance.currentCharId );
				}
				_charObject = e.target as IsoSprite;				
				
				
				if (OBJECT_INTERACTION == "CHARACTER_ACTION") 
				{
					trace('MOVE CHARACTER TO OBJECT');
					_dragObject.container.filters = [];
					moveCharToObj(_charObject, _dragObject);
					//moveCharacterTo(_charObject, _dragObject.x / CELL_SIZE, _dragObject.y / CELL_SIZE);
				}else {
					_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_CHARACTER_SELECT );										
					//swifer
					//GlobalData.instance.currentCharId = _charObject.cid;
					_es.dispatchESEvent( _isoRoomEvent  );
				}			
			}
		}
		
		private function moveCharacter():void
		{
			if (_charObject != null)
			{
				Tweener.addTween( _charObject, { x:stage.mouseX, y:stage.mouseY ,time:0.5 } );				
			}
		}
		
		///////////////////////////////////////
		// stage event handlers
		///////////////////////////////////////
		
		private function onStartPan( e:MouseEvent ):void
		{			
			_panPt = new Point( stage.mouseX, stage.mouseY );			
			addEventListener( MouseEvent.MOUSE_MOVE, onPan, false, 0, true );
			addEventListener( MouseEvent.MOUSE_UP, onStopPan, false, 0, true );
		}
		
		private function onPan( e:MouseEvent ):void
		{
			/*--------------------------------------
			* SECOND OPTION
			* -----------------------------------*/
			/*if (_view.currentX > STAGE_WIDTH/2) {
				//trace("\n\nlimit\n\n");
				_view.pan( -1, _panPt.y - stage.mouseY);
				_panPt.x = stage.mouseX;
			}else if (_view.currentX < STAGE_WIDTH / -2) {
				_view.pan(1, _panPt.y - stage.mouseY);
				_panPt.x = stage.mouseX;
			}else {
				_view.pan( _panPt.x - stage.mouseX, _panPt.y - stage.mouseY );
				_panPt.x = stage.mouseX;
			}
			
			if (_view.currentY > STAGE_HEIGHT / 2) {
				trace('_view.currentY > STAGE_HEIGHT / 2');
				_view.pan(_panPt.x - stage.mouseX, -5);
				_panPt.y = stage.mouseY;
			}else if (_view.currentY < STAGE_HEIGHT / -4) {
				trace('_view.currentY < STAGE_HEIGHT / -4');
				_view.pan(_panPt.x - stage.mouseX, 5);
				_panPt.y = stage.mouseY;
			}else {
				_view.pan( _panPt.x - stage.mouseX, _panPt.y - stage.mouseY );
				_panPt.y = stage.mouseY;
			}*/
			
			/*--------------------------------------
			* FIRST OPTION
			* -----------------------------------*/
			_view.pan( _panPt.x - stage.mouseX, _panPt.y - stage.mouseY );
			_panPt.x = stage.mouseX;
			_panPt.y = stage.mouseY;			
		}
		
		private function onStopPan( e:MouseEvent ):void
		{			
			removeEventListener( MouseEvent.MOUSE_MOVE, onPan );
			removeEventListener( MouseEvent.MOUSE_UP, onStopPan );			
		}
		
		public function zoomIn():void 
		{			
			if (_view.currentZoom >= MAX_ZOOM_IN) {
				
			}
			else
			{
				_zoom += 0.1;
			}
			Tweener.addTween( _view, { currentZoom:_zoom, time:0.5 } );
		}
		
		public function zoomOut():void 
		{
			if (_view.currentZoom <= MAX_ZOOM_OUT) {
				
			}else{
				_zoom -= 0.1;
			}
			Tweener.addTween( _view, { currentZoom:_zoom, time:0.5 } );
		}
		
		/*----------------------
		* AI handlers
		--------------------- */		
		private function findPath():void
		{
			trace('CHARACTER FINDING PATH');			
			var astar:AStar = new AStar();
			var speed:Number = .3;
			
			if(astar.findPath(pathGrid))
			{
				path = astar.path;
			}
			
			if( path != null ){
				for (var i:int = 0; i < path.length; i++)
				{
					var targetX:Number = path[i].x * CELL_SIZE;
					var targetY:Number = path[i].y * CELL_SIZE;
					Tweener.addTween(_charObject, { x:targetX, y:targetY, delay:speed * i , time:speed, transition:"linear", onUpdate:onCharacterMove } );					
					trace('CHARACTER MOVING ALONG PATH');					
					/*
					if (_charObject.x == endPosX && _charObject.y == endPosY) 
					{
						trace('CHARACTER MOVING REACHED END POSITION');
					}
					*/					
				}
			}
		}
		
		/* ------------------------------
		 * mouse pointer event handlers
		-------------------------------- */
		private function onMousePointerMove(e:Event):void
		{
			e.target.x = stage.mouseX + 25;
			e.target.y = stage.mouseY + 25;			
		}
		
		/* ----------- 
		* main loop
		-------------- */
		private function onRender( e:Event ):void
		{
			_scene.render();
		}
		
		private function onCharacterMove():void
		{			
			for (var c:int = 0; c < charAry.length; c++ ) 
			{
				if (_charObject == charAry[c].instace) 
				{
					charAry[c].movieclip.runAnimation("walk", 3, 0);
					break;
				}
			}			
			
			if (OBJECT_INTERACTION == "CHARACTER_ACTION") 
			{
				if (_charObject.x == (endPosX*CELL_SIZE) && _charObject.y == (endPosY*CELL_SIZE))
				{
					trace('\nCHARACTER MOVING REACHED END POSITION');
					for (var i:int = 0; i < charAry.length; i++)
					{
						if (_charObject == charAry[i].instance) 
						{	
							trace('\nCHARACTER ACTION : ' + CHARACTER_ACTION);
							_progressBarManager.addProgressBar(5, getObjectData(_dragObject), charAry[i]);
							charAry[i].movieclip.runAnimation(CHARACTER_ACTION, 5, 0);
							_dragObject.container.filters = [];
							deselectAllCharacters();
							deselectAllObjects();
							_dragObject = null;
							_charObject = null;
							endPosX = 0;
							endPosY = 0;
							break;
						}
					}
				}
			}
			
			_scene.render();
		}
		
		private function onProgressBarComplete(ev:ProgressBarEvent):void {			
			var params:Object = new Object();
			params = ev.params;
			addCoin( params.itemObject.x, params.itemObject.y , params.itemObject.z  );
			if (params.itemObject.type == "training"){
				params.charObject.movieclip.runAnimation(GlobalData.PLAYER_STAND, 1, 0);
				OBJECT_INTERACTION = "";
				CHARACTER_ACTION = "";
			}
		}	
		
		private function onRun(e:Event):void
		{
			_scene.render();
		}
		
		public function clearObjectData():void
		{
			if (objectsAry.length > 0) {
				for (var i:int = 0; i < objectsAry.length; i++) 
				{
					_scene.removeChild(objectsAry[i].instance);
					if (objectsAry[i].extraSpace != null)
					{
						_scene.removeChild(objectsAry[i].extraSpace);
					}
				}
				objectsAry = new Array();
			}
		}
		
		public function clearCharacterData():void
		{
			if( charAry != null ){
				if ( charAry.length >= 0) {
					for ( var i:int = 0; i <= charAry.length ; i++){
						if( charAry[i] != null ){
							if( charAry[i].instance != null ){
								if( _scene.contains( charAry[i].instance  ) ){
									_scene.removeChild(charAry[i].instance);
									charAry[i].instance = null;
								}
							}
						}
					}								
				}			
			}
			
			charAry = new Array();			
			trace( "[ IsoRoom ]clear Character Data...................." );
		}
		
		private function _onObjectSold(e:ServerDataControllerEvent):void
		{
			trace('OBJECT SOLD');
			_dragObject = null;			
		}		
		
		private function _onStartInteraction(e:MiniGameEvent):void
		{
			ALL_INTERACTIONS_ON = true;
		}
		
		private function _onStopInteraction(e:MiniGameEvent):void
		{
			ALL_INTERACTIONS_ON = false;
		}
		
		/*
		private function onClickTableStaff(e:ProxyEvent):void 
		{
			var officeItemObject:Object = getObjectData( e.target as IsoSprite );
			var popUpUIManager:PopUpUIManager = PopUpUIManager.getInstance();
			trace( "[iso room hire staff ] check hired.....officestaff and state", officeItemObject.staff, officeItemObject.state );
			
			if( officeItemObject.state == "" && officeItemObject.npc == "false" && officeItemObject.empty == "true"){
				trace( "[ isoRoom ] hire staff........................................................................" );				
				//officeItemObject.state = "hr";
				popUpUIManager.loadWindow( WindowPopUpConfig.STAFF_WINDOW );
				EventSatellite.getInstance().dispatchEvent(new StaffEvent (StaffEvent.UPDATE_STAFFITEMDATA, {itemEntryID:officeItemObject.entryid}));
				trace( "[iso room hire staff ] entry id", officeItemObject.entryid );
				GlobalData.instance.currentEntryId = officeItemObject.entryid;
			}else{		
				popUpUIManager.loadWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW, 0, 0, false, 12 , 83 );
				trace( "[iso room hire staff ] can't hire already hired.....2", officeItemObject.staff, officeItemObject.state );
			}
		}*/
		
		private function processStaffTable(_target:IsoSprite):void
		{
			var officeItemObject:Object = getObjectData( _target as IsoSprite );
			var popUpUIManager:PopUpUIManager = PopUpUIManager.getInstance();
			trace( "[iso room hire staff ] check hired.....officestaff and state", officeItemObject.staff, officeItemObject.state );
			
			if( officeItemObject.state == "" && officeItemObject.npc == "false" && officeItemObject.empty == "true" && officeItemObject.subType == "hire"){
				trace( "[ isoRoom ] hire staff........................................................................" );				
				//officeItemObject.state = "hr";
				popUpUIManager.loadWindow( WindowPopUpConfig.STAFF_WINDOW );
				EventSatellite.getInstance().dispatchEvent(new StaffEvent (StaffEvent.UPDATE_STAFFITEMDATA, {itemEntryID:String (officeItemObject.entryid), fn:officeItemObject.fn}));
				trace( "[iso room hire staff ] entry id", officeItemObject.entryid );
				GlobalData.instance.currentEntryId = officeItemObject.entryid;
			}else {
				if (officeItemObject.subType == "hire") {					
					var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_SCOUTER_TABLE_TO_HIRE_CONTESTANT  );
					_es.dispatchESEvent( tutEvent );					
					popUpUIManager.loadWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW, 0, 0, false, 12 , 83 );
					trace( "[iso room hire staff ] can't hire already hired.....2", officeItemObject.staff, officeItemObject.state );
				}
			}
		}
		
		private function onAddHirestaffEvent(e:ProxyEvent):void 
		{
			trace( "staffbuy up....................." );
		}
		
		private function onHireStaffComplete(e:ServerDataControllerEvent):void 
		{
			//e.obj.entryid
			trace(  " [ isoRoom ] set view entry id", e.obj.entryid );
			EventSatellite.getInstance().dispatchEvent(new StaffEvent (StaffEvent.HIRED_NPC, {entryID:String (e.obj.entryid)}));
			setObjectView( e.obj.entryid );			
		}
		
		private function onClickMouse(e:DropItemEvent):void 
		{
			trace( "clicker!!!!!!!!!!!!!!!!!!!!!!" );
			dropItems = new DropItems( e.obj.drop );
			addChild( dropItems );			
			//dropItems.x = stage.mouseX + 40;
			//dropItems.y = stage.mouseY - 25;
			dropItems.x = e.obj.x;
			dropItems.y = e.obj.y;
		}
		
		private function onSetOfficeInventoryItem(e:InventoryEvent):void 
		{			
			trace( "[IsoRoom]on SetOfficeInventoryItem........................................................." );
			if (_dragObject != null )
			{
				_scene.removeChild(_dragObject);
			}
			
			var isoObject:IsoObject = new IsoObject( e.obj as IsoObjectData );
			_scene.addChild( isoObject.instance );
			//addChild( isoObject );			
			isoObject.showBubble();
			
			_dragObject = isoObject.instance;
			trace( "check data isoObject eid", isoObject.entryid, "id", isoObject.id  );			
			_currentIsoObject = isoObject;
			trace( "check data _currentIsoObject eid", _currentIsoObject.entryid, "id",_currentIsoObject.id  );
			objectsAry.push(isoObject);
			
			OBJECT_INTERACTION = "SET";
			OBJECT_MOVING = true;
			
			_dragObject.addEventListener( MouseEvent.MOUSE_DOWN, onObjectSelect );
			addEventListener( MouseEvent.MOUSE_MOVE, onObjectMove );			
			_scene.render();			
		}
	}
}