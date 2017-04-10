package com.surnia.socialStar.views.display 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.IsoScene;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.SWFLoader;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.views.display.IsoWallObject.IsoWallObject;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import eDpLib.events.ProxyEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Windz
	 */
	public class IsoWallsManager extends IsoSprite
	{
		//---------------------------------
		// PROPERTIES
		//---------------------------------
		private var _scene:IsoScene;
		private var _gd:GlobalData;
		private var wallObj:Object;
		//private var wallObj:IsoObject;
		
		public var _id:String;
		public var _instance:MovieClip;
		public var _name:String;
		public var _x:int;
		public var _y:int;
		public var _xpos:int;
		public var _ypos:int;
		public var _occupied:int;
		public var _rotation:String;
		public var walls_array:Array;
		
		//new
		private var _es:EventSatellite;
		private var _isoRoomEvent:IsoRoomEvent;
		private var _sdc:ServerDataController;
		private var _stage:Stage;
		
		
		//new 12/12/2011
		//private var _imageHolder:Sprite;
		//private var _loadingMC:LoadingMC; 
		//private var _imageStorage:ImageStorage;
		//private var imageLoader:ImageLoader;
		//private var _swfLoader:SWFLoader;
		//private var _imageName:String;
		//private var _isSwf:Boolean;
		
		
		//---------------------------------
		// CONSTRUCTOR
		//---------------------------------
		public function IsoWallsManager(iScene:IsoScene , stage:Stage ) 
		{				
			_stage = stage;
			_id = 'NUADZJKjVpEDWUxuTG6X';						
			//_id = "Tt"; 
			_es = EventSatellite.getInstance();
			_es.addEventListener(OfficeShopUIEvent.ON_EXPANSION_BUY, onExpandFloor );
			//_es.addEventListener(OfficeShopUIEvent.ON_WALL_BUY, onUpdateWallSkin );
			_es.addEventListener( ServerDataControllerEvent.ON_BUY_WALL_COMPLETE, onBuywallComplete );
			_es.addEventListener( IsoRoomEvent.ON_SET_OFFICE_ROOM_OBJECT_COMPLETE, onUpdateInitialSkin );
			_es.addEventListener( IsoRoomEvent.ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE, onUpdateFriendInitialTileSkin );
			
			_sdc = ServerDataController.getInstance();			
			initVars(iScene);
			initWalls( _id );
		}									
		
		//---------------------------------
		// METHODS
		//---------------------------------
		private function initVars(iScene:IsoScene):void
		{			
			_es = EventSatellite.getInstance();
			_gd = GlobalData.instance;
			_scene = iScene;									
			_occupied = 0;
			_rotation = '';
		}
		
		
		private function initWalls( id:String = null ):void
		{			
			_id = id;			
			walls_array = new Array();
			var isoWallObject:IsoWallObject;
			// switched to expansion
			for (var i:int = 0; i < 1; i++)
			{
				for (var j:int = 0; j < _gd.expansion; j++)
				{
					isoWallObject = new IsoWallObject( _scene, _id, i, j , "left" );
					walls_array.push(isoWallObject);
					
					//var _leftWalls:IsoSprite = new IsoSprite();
					//var _leftWall:MovieClip = new Objects();
					//
					//_leftWall.gotoAndStop(_id);
					//_leftWall.name = "left_wall_" + "_i" + i + "_j" + j;
					//_leftWalls.sprites = [_leftWall];
					//_leftWalls.moveBy(i * _gd.CELL_SIZE, j * _gd.CELL_SIZE, GlobalData.ISO_WALL_OBJECT_DEPTH );
					//_scene.addChild(_leftWalls);
					//
					//wallObj = new Object();
					//wallObj.instance = _leftWalls;
					//wallObj.name = "left_wall_" + "_i" + i + "_j" + j;
					//wallObj.movieclip = _leftWall;
					//
					//walls_array.push(wallObj);
				}				
			}
			// switched to expansion
			for (var a:int = 0; a < _gd.expansion; a++)
			{
				for (var b:int = 0; b < 1; b++)
				{
					isoWallObject = new IsoWallObject( _scene, _id, a, b , "right" );
					walls_array.push(isoWallObject);
					
					//var _rightWalls:IsoSprite = new IsoSprite();
					//var _rightWall:MovieClip = new Objects();
					//_rightWall.gotoAndStop(_id);
					//_rightWall.name = "right_wall_" + "_a" + a + "_b" + b;
					//_rightWalls.sprites = [_rightWall];
					//_rightWalls.container.scaleX = -(_rightWalls.container.scaleX);
					//_rightWalls.moveBy(a * _gd.CELL_SIZE, b * _gd.CELL_SIZE, GlobalData.ISO_WALL_OBJECT_DEPTH );
					//_scene.addChild(_rightWalls);
					//
					//wallObj = new Object();
					//wallObj.instance = _rightWalls;
					//wallObj.name = "right_wall_" + "_i" + a + "_j" + b;
					//wallObj.movieclip = _rightWall;
					//
					//walls_array.push(wallObj);
				}
			}
			
			_scene.render();			
		}				
		
		public function expand():void
		{
			deleteWalls();
			initWalls( _id );
		}
		
		public function deleteWalls():void
		{			
			var len:uint = walls_array.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( walls_array[ i ]!= null && walls_array[ i ].instance != null ) {
					if ( _scene.contains( walls_array[ i ].instance ) ) {
						//_scene.removeChild( walls_array[ i ].instance );						
						//walls_array[ i ].instance = null;
						//walls_array.splice( i, 1 );
						walls_array[ i ].destroy();						
					}
				}
			}
			
			walls_array = new Array();
			_scene.render();
		}
		
		private function change(newId:String):void 
		{
			for (var a:int = 0; a < walls_array.length; a++)
			{				
				walls_array[a].movieclip.gotoAndStop(newId);
				_scene.render();
			}
		}
		
		public function rotation():String
		{
			return _rotation;
		}		
		
		public function updateWallSkin( ):void 
		{	
			if ( id != null && id != "" ) {
				for (var a:int = 0; a < walls_array.length; a++)
				{		
					//replace wall by current walls
					//to do calls update for wall here
					
					//walls_array[a].movieclip.gotoAndStop(id);
					//walls_array[a].updateSkin( "wall_Wood02_L", "Wall_Wood02_R", "public/data/imgs/images/Tile/Wall/wall_Wood02_L.png", "public/data/imgs/images/Tile/Wall/Wall_Wood02_R.png"  );
					walls_array[a].updateSkin( _gd.wallImageLeftName, _gd.wallImageRightName, _gd.wallImageLeft, _gd.wallImageRight  );
					_scene.render();
				}
			}
		}
		
		/*--------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		
		private function _onLeftWallMouseOver(e:ProxyEvent):void
		{
			trace('on left wall mouse over');
			_rotation = 'left';
		}
		
		private function _onRightWallMouseOver(e:ProxyEvent):void
		{
			trace('on right wall mouse over');
			_rotation = 'right';
		}
		
		private function onLeftWallClick(e:ProxyEvent):void 
		{
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_CLICK_WALL );
			_es.dispatchESEvent( _isoRoomEvent );
		}
		
		private function onRightWallClick(e:ProxyEvent):void 
		{
			_isoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_CLICK_WALL );
			_es.dispatchESEvent( _isoRoomEvent );
		}		
		
		private function onExpandFloor(e:OfficeShopUIEvent):void 
		{
			expand(  );
		}
		
		private function onUpdateWallSkin(e:OfficeShopUIEvent):void 
		{
			_sdc.buyUpdateWallTile( e.obj.id );
			//updateWallSkin( e.obj.id );
		}
		
		private function onUpdateInitialSkin(e:IsoRoomEvent):void 
		{
			_id = _gd.officeStateWallID;
			//updateWallSkin( _id );
		}
		
		private function onUpdateFriendInitialTileSkin(e:IsoRoomEvent):void 
		{			
			_id = _gd.friendOfficeStateWallID;
			//updateWallSkin( _id );
		}
		
		private function onBuywallComplete(e:ServerDataControllerEvent):void 
		{
			updateWallSkin();
		}
	}

}