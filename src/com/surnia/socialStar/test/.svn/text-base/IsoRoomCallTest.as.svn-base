package com.surnia.socialStar.test 
{
	import flash.display.MovieClip;	
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import Math;
	
	import Function;
	
	import com.surnia.socialStar.views.display.IsoRoom;
	
	/**
	 * ...
	 * @author Windz
	 * ...
	 */
	
	public class IsoRoomCallTest extends MovieClip
	{
		private var _isoRoom:IsoRoom;
		private var _charObj:Object;
		private var _charAry:Array;
		
		public function IsoRoomCallTest() 
		{
			initVars();
			initIsoRoom();
			addButtons();
		}
		
		private function initVars():void
		{
			_charAry = new Array();
			_charObj = new Object();
			_isoRoom = new IsoRoom();
		}
		
		private function initIsoRoom():void
		{
			addChild(_isoRoom);
		}
		
		private function addButtons():void
		{
			var _charBtn:TextField = new TextField();
			_charBtn.width = 100;
			_charBtn.height = 100;
			_charBtn.x = 20;
			_charBtn.y = 20;
			_charBtn.text = "Add New Character";
			_charBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewCharBtnPress);
			addChild(_charBtn);
			
			var _moveCharBtn:TextField = new TextField();
			_moveCharBtn.width = 100;
			_moveCharBtn.height = 100;
			_moveCharBtn.x = 20;
			_moveCharBtn.y = 60;
			_moveCharBtn.text = "Move Character";
			_moveCharBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onMoveCharBtnPress);
			addChild(_moveCharBtn);
			
			var _objBtn:TextField = new TextField();
			_objBtn.width = 100;
			_objBtn.height = 100;
			_objBtn.x = 600;
			_objBtn.y = 20;
			_objBtn.text = "Add New Object";
			_objBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewObjBtnPress);
			addChild(_objBtn);
			
			var _wideObjBtn:TextField = new TextField();
			_wideObjBtn.width = 100;
			_wideObjBtn.height = 100;
			_wideObjBtn.x = 600;
			_wideObjBtn.y = 40;
			_wideObjBtn.text = "Add Wide Object";
			_wideObjBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewWideObjBtnPress);
			addChild(_wideObjBtn);
			
			
			
			// STRENGTH TRAINING OBJECT
			var _addStrTrainObj:TextField = new TextField();
			_addStrTrainObj.width = 100;
			_addStrTrainObj.height = 100;
			_addStrTrainObj.x = 120;
			_addStrTrainObj.y = 20;
			_addStrTrainObj.text = "Add New Strength Training Object";
			_addStrTrainObj.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewStrTrainObj);
			addChild(_addStrTrainObj);
			
			// INTELLIGENCE TRAINING OBJECT
			var _addIntTrainObj:TextField = new TextField();
			_addIntTrainObj.width = 100;
			_addIntTrainObj.height = 100;
			_addIntTrainObj.x = 120;
			_addIntTrainObj.y = 40;
			_addIntTrainObj.text = "Add New Intelligence Training Object";
			_addIntTrainObj.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewIntTrainObj);
			addChild(_addIntTrainObj);
			
			// ACTING TRAINING OBJECT
			var _addActTrainObj:TextField = new TextField();
			_addActTrainObj.width = 100;
			_addActTrainObj.height = 100;
			_addActTrainObj.x = 120;
			_addActTrainObj.y = 60;
			_addActTrainObj.text = "Add New Acting Training Object";
			_addActTrainObj.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewActTrainObj);
			addChild(_addActTrainObj);
			
			// SINGING TRAINING OBJECT
			var _addSingTrainObj:TextField = new TextField();
			_addSingTrainObj.width = 100;
			_addSingTrainObj.height = 100;
			_addSingTrainObj.x = 120;
			_addSingTrainObj.y = 80;
			_addSingTrainObj.text = "Add New Singing Training Object";
			_addSingTrainObj.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewSingTrainObj);
			addChild(_addSingTrainObj);
			
			// ATTRACTION TRAINING OBJECT
			var _addAttractTrainObj:TextField = new TextField();
			_addAttractTrainObj.width = 100;
			_addAttractTrainObj.height = 100;
			_addAttractTrainObj.x = 120;
			_addAttractTrainObj.y = 100;
			_addAttractTrainObj.text = "Add New Attraction Training Object";
			_addAttractTrainObj.addEventListener(MouseEvent.MOUSE_DOWN, _onAddNewAttractTrainObj);
			addChild(_addAttractTrainObj);
			
			// OBJECT TOOLS
			var _moveToolBtn:TextField = new TextField();
			_moveToolBtn.width = 100;
			_moveToolBtn.height = 100;
			_moveToolBtn.x = 600;
			_moveToolBtn.y = 500;
			_moveToolBtn.text = "MOVE OBJECT";
			_moveToolBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onMoveToolBtnPress);
			addChild(_moveToolBtn);
			
			var _rotateToolBtn:TextField = new TextField();
			_rotateToolBtn.width = 100;
			_rotateToolBtn.height = 100;
			_rotateToolBtn.x = 600;
			_rotateToolBtn.y = 520;
			_rotateToolBtn.text = "ROTATE OBJECT";
			_rotateToolBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onRotateToolBtnPress);
			addChild(_rotateToolBtn);
		}
		
		private function _onAddNewCharBtnPress(e:MouseEvent):void
		{
			var def:String = "0104040301030002030000000000000000000000010203010302010301040303020000000000000001020101040402030000000000000000000000000301000000000000000000000000000000000000F390BBF0A8CD392F2F392F2FF9C5AFC67A64EED7E03F36565E313E51323BC67A64C67A64EA7D99CF55767EB6654D63414e82ed4e82ed7efbef7efbef434408434408D44A6090313D";
			_isoRoom.addNewMaleCharacter(def, Math.random()*10, Math.random()*10, "");
			//_isoRoom.addNewFemaleCharacter("", Math.random()*10, Math.random()*10, "");
			_charAry = _isoRoom.getCharData;
		}
		
		private function _onMoveCharBtnPress(e:MouseEvent):void
		{
			for (var i:int = 0; i < _charAry.length; i++)
			{
				_charObj = _charAry[i];
				_isoRoom.moveCharacterTo(_charObj.instance, Math.random() * 10, Math.random() * 10)
			}
		}
		
		private function _onAddNewObjBtnPress(e:MouseEvent):void
		{
			
		}
		
		private function _onAddNewWideObjBtnPress(e:MouseEvent):void
		{
			var Obj:Object = new Object();
			var dimension:Object = new Object();
			dimension.x = 2; // length
			dimension.y = 1; // width
			dimension.z = 1; // height
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.rotation = 0;
			
			Obj.type = "deco";
			Obj.subType = "cabinet";
			
			Obj.fn = 38;
			_isoRoom.addObject(Obj);
		}
		
		private function _onMoveToolBtnPress(e:MouseEvent):void
		{
			_isoRoom.createMovePointer();
		}
		
		private function _onRotateToolBtnPress(e:MouseEvent):void
		{
			_isoRoom.createRotatePointer();
		}
		
		//--------------------------------------------------------
		// add strength training object
		private function _onAddNewStrTrainObj(e:MouseEvent):void 
		{
			var Obj:Object = new Object();
			
			//var dimension:Vector3D = new Vector3D(1, 1, 3);
			var dimension:Object = new Object();
			dimension.x = 1;
			dimension.y = 1;
			dimension.z = 1;
			
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			//var position:Vector3D = new Vector3D(1, 1, 3);
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.rotation = 0;
			
			Obj.type = "training";
			Obj.subType = "health";
			
			Obj.fn = 88;
			_isoRoom.addObject(Obj);
		}
		
		//--------------------------------------------------------
		// add intelligence training object
		private function _onAddNewIntTrainObj(e:MouseEvent):void 
		{
			var Obj:Object = new Object();
			
			//var dimension:Vector3D = new Vector3D(1, 1, 3);
			var dimension:Object = new Object();
			dimension.x = 1;
			dimension.y = 1;
			dimension.z = 1;
			
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			//var position:Vector3D = new Vector3D(1, 1, 3);
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.type = "training";
			Obj.subType = "intelligent";
			
			Obj.fn = 83;
			_isoRoom.addObject(Obj);
		}
		
		//--------------------------------------------------------
		// add acting training object
		private function _onAddNewActTrainObj(e:MouseEvent):void 
		{
			var Obj:Object = new Object();
			
			//var dimension:Vector3D = new Vector3D(1, 1, 3);
			var dimension:Object = new Object();
			dimension.x = 1;
			dimension.y = 1;
			dimension.z = 1;
			
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			//var position:Vector3D = new Vector3D(1, 1, 3);
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.type = "training";
			Obj.subType = "acting";
			
			Obj.fn = 92;
			_isoRoom.addObject(Obj);
		}
		
		private function _onAddNewSingTrainObj(e:MouseEvent):void
		{
			var Obj:Object = new Object();
			
			//var dimension:Vector3D = new Vector3D(1, 1, 3);
			var dimension:Object = new Object();
			dimension.x = 1;
			dimension.y = 1;
			dimension.z = 1;
			
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			//var position:Vector3D = new Vector3D(1, 1, 3);
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.rotation = 0;
			
			Obj.type = "training";
			Obj.subType = "sing";
			
			Obj.fn = 91;
			_isoRoom.addObject(Obj);
		}
		
		private function _onAddNewAttractTrainObj(e:MouseEvent):void
		{
			var Obj:Object = new Object();
			
			//var dimension:Vector3D = new Vector3D(1, 1, 3);
			var dimension:Object = new Object();
			dimension.x = 1;
			dimension.y = 1;
			dimension.z = 1;
			
			var position:Object = new Object();
			position.x = Math.floor(Math.random()*10);
			position.y = Math.floor(Math.random()*10);
			position.z = 3;
			
			//var position:Vector3D = new Vector3D(1, 1, 3);
			Obj.dimension = dimension;
			Obj.position = position;
			
			Obj.rotation = 0;
			
			Obj.type = "training";
			Obj.subType = "attraction";
			
			Obj.fn = 86;
			_isoRoom.addObject(Obj);
		}
		
	}

}