package com.juliankussman.display{	 	import flash.display.DisplayObject;	import flash.display.Stage;	import flash.display.StageScaleMode;	import flash.display.StageAlign;	import flash.events.Event;	import flash.utils.Dictionary;		/**	 * AS3 liquid layout Static class 	 * 	 * @example	 * StageAlignTool.init(Stage reference[, min width = 1024, min height = 768]); <br />	 * StageAlignTool.init(stage, 1024, 768);<br />	 * StageAlignTool.registerLocation(a DisplayObject, position to lock to[, stay relative to current = false]);<br />	 * possible locations are [StageAlignTool.]TL, TC, TR, ML, MC, MR, BL, BC, BR<br />	 * StageAlignTool.registerLocation(bg, StageAlignTool.MC);<br />	 * <br />	 * Give it a try and tell me what you think.<br />	 * 	 *  @author julian kussman - 2009	 */	public class StageAlignTool{				//nine slices for pinning objects		public static const TL:uint = 1;		public static const TC:uint = 2;		public static const TR:uint = 3;		public static const ML:uint = 4;		public static const MC:uint = 5;		public static const MR:uint = 6;		public static const BL:uint = 7;		public static const BC:uint = 8;		public static const BR:uint = 9;				private static var _stage:Stage		private static var _stageW:uint;		private static var _stageH:uint;		private static var _minW:uint		private static var _minH:uint		private static var _registeredObjects:Dictionary;				/**		 * inital call, sets stage and minimum stage size		 * @param	stage		 * @param	minW		 * @param	minH		 */		public static function init(stage:Stage, minW:uint = 1024, minH:uint = 768):void{			_stage = stage;			_stageW = _stage.stageWidth;			_stageH = _stage.stageHeight;			_minW = minW;			_minH = minH;			_stage.scaleMode = StageScaleMode.NO_SCALE;			_stage.align = StageAlign.TOP_LEFT;						_registeredObjects = new Dictionary();						_stage.addEventListener(Event.RESIZE, onStageResize);		}				/**		 * if you need to stop positioning objects for some reason		 */		public static function kill():void{			_stage.removeEventListener(Event.RESIZE, onStageResize);		}					/**		 * used to add a display object to the list of objects that will be laid out 		 * if stayRelative == true the object will retain it's original offset from the stage (when registered);		 * if stayRelative == false the object will pin to whichever corner is set by loc		 * @param	disp		 * @param	loc		 * @param	stayRelative		 */		public static function registerLocation(disp:DisplayObject, loc:uint, stayRelative:Boolean = false):void{			if (_stage){								_registeredObjects[disp] = {location:loc, stayRelative:stayRelative, ogX:disp.x, ogY:disp.y};				onStageResize(null);							}else{				//trace("stage not set");			}		}				//meat		private static function onStageResize(e:Event = null):void{			//trace(e);			var sw:uint = (_stage.stageWidth >= _minW) ? _stage.stageWidth : _minW;			var sh:uint = (_stage.stageHeight >= _minH) ? _stage.stageHeight : _minH;						//if (sw >= _minW && sh >= _minH){							for (var disp:* in _registeredObjects){										//trace(disp.name, _registeredObjects[disp].location, _registeredObjects[disp].stayRelative);					switch (_registeredObjects[disp].location){												case TL:							if (_registeredObjects[disp].stayRelative){								//x doesn't change								//y doesn't change							}else{								disp.x = disp.y = 0;							}							break;						case TC:							if (_registeredObjects[disp].stayRelative){								disp.x = (sw/2) - (_stageW / 2) + _registeredObjects[disp].ogX;								//y doesn't change							}else{								disp.x = (sw / 2) - (disp.width / 2);								disp.y = 0;							}							break;						case TR:							if (_registeredObjects[disp].stayRelative){								disp.x = sw - _stageW + _registeredObjects[disp].ogX;								//y doesn't change															}else{								disp.x = (sw - disp.width);								disp.y = 0;							}							break;						case ML:							if (_registeredObjects[disp].stayRelative){								//x doesn't change								disp.y = (sh/2) - (_stageH / 2) + _registeredObjects[disp].ogY;							}else{								disp.x = 0;								disp.y = (sh / 2) - (disp.height / 2);							}							break;						case MC:							if (_registeredObjects[disp].stayRelative){								disp.x = (sw/2) - (_stageW / 2) + _registeredObjects[disp].ogX;								disp.y = (sh/2) - (_stageH / 2) + _registeredObjects[disp].ogY;							}else{								disp.x = (sw / 2) - (disp.width / 2);								disp.y = (sh / 2) - (disp.height / 2);							}							break;						case MR:							if (_registeredObjects[disp].stayRelative){								disp.x = sw - _stageW + _registeredObjects[disp].ogX;								disp.y = (sh/2) - (_stageH / 2) + _registeredObjects[disp].ogY;							}else{								disp.x = (sw - disp.width);								disp.y = (sh / 2) - (disp.height / 2);							}							break;						case BL:							if (_registeredObjects[disp].stayRelative){								//x doesn't change								disp.y = sh - _stageH + _registeredObjects[disp].ogY;							}else{								disp.x = 0;								disp.y = (sh - disp.height);							}							break;						case BC:							if (_registeredObjects[disp].stayRelative){								disp.x = (sw/2) - (_stageW / 2) + _registeredObjects[disp].ogX;								disp.y = sh - _stageH + _registeredObjects[disp].ogY;							}else{								disp.x = (sw / 2) - (disp.width / 2);								disp.y = (sh - disp.height);							}							break;						case BR:							if (_registeredObjects[disp].stayRelative){								disp.x = sw - _stageW + _registeredObjects[disp].ogX;								disp.y = sh - _stageH + _registeredObjects[disp].ogY;							}else{								disp.x = (sw - disp.width);								disp.y = (sh - disp.height);							}							break;											}//switch									}//for			//}//if min width					}//onStageResize				public function StageAlignTool() {			throw new Error("Do not create an instance of this class");		}					}//class}//package