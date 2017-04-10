package com.surnia.socialStar.views.display 
{
	import as3isolib.display.scene.IsoScene;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.utils.ai.Grid;
	import com.surnia.socialStar.utils.Logger;
	import com.surnia.socialStar.views.display.IsoFloorObject.IsoFloorObject;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	
	
	/**
	 * ...
	 * @author Windz
	 */
	public class IsoFloorsManager extends Sprite
	{
		/*--------------------------------------------------------------------------Constant-------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		private var _scene:IsoScene;		
		private var _gd:GlobalData;
		
		public var floors_array:Array;
		public var floor:IsoFloorObject;		
		public var _instance:MovieClip;
		public var _name:String;
		public var _x:int;
		public var _y:int;
		public var _xpos:int;
		public var _ypos:int;
		public var _occupied:int;
		
		
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		private var _stage:Stage;
		private var _isoRoomEvent:IsoRoomEvent;
		private var _gridPath:Grid;
		private var _floorsSelectable:Boolean = false;
		
		/*--------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		public function IsoFloorsManager(iScene:IsoScene , stage:Stage, grid:Grid ):void
		{
			_stage = stage;
			_gridPath = grid;
			_es = EventSatellite.getInstance();
			_es.addEventListener(OfficeShopUIEvent.ON_EXPANSION_BUY, onExpandFloor );			
			_es.addEventListener(ServerDataControllerEvent.ON_BUY_TILE_COMPLETE, onUpdateTile );			
			_es.addEventListener( IsoRoomEvent.ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE, onUpdateFriendTile );
			_es.addEventListener( IsoRoomEvent.ON_SET_OFFICE_ROOM_OBJECT_COMPLETE, onUpdateMyTile );
			addEventListener(MouseEvent.CLICK, onClickFloor );
			addEventListener(MouseEvent.MOUSE_DOWN, onStartPanFloor );
			addEventListener(MouseEvent.MOUSE_UP, onStopPanFloor);			
			initVars(iScene);
			initFloors();
		}								
		/*--------------------------------------------------------------------------Methods-------------------------------------------------------------*/

		private function initVars(iScene:IsoScene):void
		{		
			_sdc = ServerDataController.getInstance();
			_gd = GlobalData.instance;			
			_scene = iScene;			
			floors_array = new Array();			
			_occupied = 0;
		}
		
		private function initFloors():void
		{
			// swithed to expansion
			for (var i:int = 0; i < _gd.expansion; i++)
			{
				for (var j:int = 0; j < _gd.expansion; j++)
				{
					floor = new IsoFloorObject(_scene,i,j );					
					floors_array.push(floor);
					floor.instance.container.addEventListener(MouseEvent.ROLL_OUT, onFloorOut);
					floor.instance.container.addEventListener(MouseEvent.ROLL_OVER, onFloorOver);					
				}
			}
			
			_scene.render();
		}		
		
		public function expand( val:int ):void
		{
			trace( "expand val", val );
			
			/*_gd.GRID_WIDTH = val;
			_gd.GRID_LENGTH = val;*/			
			// switched to expansion
			_gd.expansion = val;
			_gd.expansion = val;	
			deleteFloors();
			initFloors();
			
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_ROOM_TILE_EXPANDED );
			_es.dispatchESEvent( isoRoomEvent );
		}	
		
		public function updateFloorTile(  ):void
		{	
			trace( "[IsoFloorManager]: ", "tilename", _gd.tileImageName, "tileImage", _gd.tileImage  );
			for (var i:int = 0; i < floors_array.length; i++)
			{
				floors_array[i].updateTileSkin( _gd.tileImageName, _gd.tileImage );
			}
		}
		
		private function onFloorOut(ev:Event):void{			
			var target:MovieClip = ev.target as MovieClip;
			var floor:IsoFloorObject = getIsoFloorObject(target);
			if (floor != null){
				floor.instance.container.filters = [];
				floor.selected = false;
				//Logger.tracer(this, "Floor out: " + floor);
			}
		}
		
		private function onFloorOver(ev:Event):void{
			var target:MovieClip = ev.target as MovieClip;
			var floor:IsoFloorObject = getIsoFloorObject(target);
			if (floor != null){
				if (_floorsSelectable){
					if (_gridPath.getNode(floor.xPos / _gd.CELL_SIZE, floor.yPos / _gd.CELL_SIZE).walkable){
						floor.instance.container.filters = [new GlowFilter( 0x00CC00, 1, 4, 4, 48 )];
					} else {
						floor.instance.container.filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 48 )];
					}
					floor.selected = true;
				}
				//Logger.tracer(this, "Floor over: " + floor);
				//selectAllNonWalkable();
			}
			
			
		}
		
		public function selectAllFloors():void{
		
			for (var i:int = 0; i < floors_array.length; i++)
			{
				if (_gridPath.getWalkable(floors_array[i].xPos / _gd.CELL_SIZE, floors_array[i].yPos / _gd.CELL_SIZE)){
					floors_array[i].instance.container.filters = [new GlowFilter( 0x00CC00, 1, 4, 4, 48 )];
				} else {
					floors_array[i].instance.container.filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 48 )];
				}
			}
		}
		
		public function selectAllWalkable():void{
			
			for (var i:int = 0; i < floors_array.length; i++)
			{
				if (_gridPath.getWalkable(floors_array[i].xPos / _gd.CELL_SIZE, floors_array[i].yPos / _gd.CELL_SIZE)){
					floors_array[i].instance.container.filters = [new GlowFilter( 0x00CC00, 1, 4, 4, 48 )];
				} 
			}
		}
		
		public function selectAllNonWalkable():void{
			
			for (var i:int = 0; i < floors_array.length; i++)
			{
				if (!_gridPath.getWalkable(floors_array[i].xPos / _gd.CELL_SIZE, floors_array[i].yPos / _gd.CELL_SIZE)){
					floors_array[i].instance.container.filters = [new GlowFilter( 0xFF0000, 1, 4, 4, 48 )];
				} 
			}
		}
		
		public function updatePathGrid(pathGrid:Grid):void{
			_gridPath = pathGrid;
		}
		
		public function get length():int
		{
			return floors_array.length;
		}		
		
		public function deleteFloors():void 
		{			
			var len:uint = floors_array.length;
			
			for (var i:int = 0; i < len; i++) 
			{			
				floors_array[ i ].destroy();						
			}			
			
			floors_array = new Array();
			_scene.render();
		}
		
		/*--------------------------------------------------------------------------Setters-------------------------------------------------------------*/
		/*--------------------------------------------------------------------------Getters-------------------------------------------------------------*/
		/*--------------------------------------------------------------------------EventHandler--------------------------------------------------------*/
		private function onExpandFloor(e:OfficeShopUIEvent):void 
		{
			if ( e.obj != null ) {
				var isoObjectData:IsoObjectData = ( e.obj as IsoObjectData);
				_sdc.expandOffice( isoObjectData.id );
				trace( "expand now ======================> eff" , e.obj.eff );
				var eff:String = isoObjectData.eff;
				var effect:Array = eff.split( "_" );
				trace( "tile effect", effect[ 0 ] );			
				expand( int( effect[ 0 ] ) );
			}else {
				trace( "[ IsoFloormanager ]: no data for expansion.........." );
			}
		}		
		
		private function onStartPanFloor(e:MouseEvent):void 
		{
			//trace('floor name : ' + name , "isDraging", _gd.isDragging , "isWindowActive" , _popUpUIManager.isWindowActive , "isSubWindowActive", _popUpUIManager.isSubWindowActive, "currentWindow", _popUpUIManager.currentWindow );
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_START_PAN );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function onStopPanFloor(e:MouseEvent):void 
		{
			//trace('floor name : ' + name);
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_PAN );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function onClickFloor(e:MouseEvent):void
		{
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_CLICK_FLOOR );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function getIsoFloorObject(floor:MovieClip):IsoFloorObject{
			var  len:int = floors_array.length;
			for (var x:int = 0; x<len; x++){
				if (floors_array[x].instance.container == floor){
					return floors_array[x];
				}
			}
			return null;
		}
		
		
		public function get floorsSelectable():Boolean
		{
			return _floorsSelectable;
		}
		
		public function set floorsSelectable(value:Boolean):void
		{
			_floorsSelectable = value;
		}
		
		private function onUpdateTile(e:ServerDataControllerEvent):void 
		{
			updateFloorTile();
		}
		
		private function onUpdateMyTile(e:IsoRoomEvent):void 
		{
			//updateFloorTile();
		}
		
		private function onUpdateFriendTile(e:IsoRoomEvent):void 
		{
			//updateFloorTile();
		}

	}

}