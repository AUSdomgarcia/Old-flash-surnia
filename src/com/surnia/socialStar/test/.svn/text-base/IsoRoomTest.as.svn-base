package com.surnia.socialStar.test 
{
	import Math;
	import Function;
	
	import com.surnia.socialStar.data.GlobalData;
	
	import flash.display.MovieClip;	
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	
	import com.surnia.socialStar.views.display.IsoRoom;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.nodes.CharacterNodeManager;
	
	/**
	 * ...
	 * @author Windz
	 * ...
	 */
	
	public class IsoRoomTest extends MovieClip
	{
		private var _gd:GlobalData = GlobalData.instance;
		private var _isoRoom:IsoRoom;
		private var _charObj:Object;
		private var _charAry:Array;
		private var DEFAULT_CHARACTER_ID:String;
		private var DEFAULT_OBJECT_ID:String;
		
		public function IsoRoomTest() 
		{
			initVars();
			initButtons();
			initIsoRoom();
			initObjects();
		}
		
		//------------------------------------
		// initialize variables
		private function initVars():void
		{			
			_charAry = new Array();
			_charObj = new Object();
			_isoRoom = new IsoRoom();
			
			DEFAULT_OBJECT_ID = 'TRNktbxKHHEUTTmwncju';
			DEFAULT_CHARACTER_ID = '030a02010404000004000000000000000000000001000a0403030a0a0a0a0a0a04000000000000000a0a0a0a0a0a020300000000000000000000000002040000000000000000000000000000000000002B2C2C61708663AEDC63AEDCFADCCCC57963D1DF52999E456DC49F529C7AC67A64C67A64F19D88F19D8836528133486Dc5045bc5045b0dddfb0dddfb12899a12899aE5F5F960B0B8';
		}
		
		//------------------------------------
		// initialize buttons
		private function initButtons():void
		{
			
		}
		
		//------------------------------------
		// initialize isometric room
		private function initIsoRoom():void
		{
			addChild(_isoRoom);
		}
		
		//------------------------------------
		// initialize objects
		private function initObjects():void
		{
			var _objData:IsoObjectData = new IsoObjectData();
			
			_objData.w = 1;
			_objData.l = 1;
			_objData.h = 3;
			
			_objData.x = 5;
			_objData.y = 5;
			_objData.z = 5;
			
			_objData.position = new Vector3D(5, 5, 5);
			
			_objData.id = DEFAULT_OBJECT_ID;
			_isoRoom.addObject(_objData);
		}
		
		
	}

}