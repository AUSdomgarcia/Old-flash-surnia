package com.surnia.socialStar.minigames.components.parallaxBg
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Droids
	 */
	public class parallaxBg extends EventDispatcher
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		public static const UPDATE_OBJECTS_DATA:String="UpdateObjectsData";
		public static const UPDATE_MAX_OBJECTS:String="UpdateMaxObjects";
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		public var objectTypeList:Array;
		public var layerList:Array;
		private var _layersOnStage:Array;
		private var _objectsOnStage:Array;
		private var _maxObjects:int;
		public var stageWidth:Number;
		public var stageHeight:Number;
		public var screen:*;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function parallaxBg()
		{
			//objectTypeList=new Array();
			layerList=new Array();
			_objectsOnStage=new Array();
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		public function set layersOnStage(layers:Array):void
		{
			this._layersOnStage=layers;
			dispatchEvent(new Event(UPDATE_OBJECTS_DATA));
		}
		public function set objectsOnStage(objects:Array):void
		{
			this._objectsOnStage=objects;
			dispatchEvent(new Event(UPDATE_OBJECTS_DATA));
		}
		public function set maxObjects(maxObjects:int):void
		{
			this._maxObjects=maxObjects;
			dispatchEvent(new Event(UPDATE_MAX_OBJECTS));
		}
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		public function get layersOnStage():Array
		{
			return this._layersOnStage;
		}
		public function get objectsOnStage():Array
		{
			return this._objectsOnStage;
		}
		public function get maxObjects():int
		{
			return this._maxObjects;
		}
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
	}
}