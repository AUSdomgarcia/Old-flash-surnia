package com.surnia.socialStar.ui.popUI.tooltip
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.utils.TooltipCreator;
	import com.surnia.socialStar.utils.points.Points;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.events.ModelChange;

	public class MiniTooltipManager extends Sprite
	{
		private static var _instance:MiniTooltipManager;
		
		private var _toolTip:Sprite;
		private var _textFormat:TextFormat;
		private var _statusText:MiniToolTipText;
		private var _descText:ToolTipText;
		private var _itemsArray:Array = [];
		private var _descArray:Array = [];
		private var _statusArray:Array = [];
		private var _offsetArray:Array = [];
		
		public static function get instance():MiniTooltipManager{
			if (_instance == null){
				_instance = new MiniTooltipManager();
				return _instance;
			} else {
				return _instance;
			}
		}
		
		private function initAsset(index:int):void{
				// set tooltip
				_toolTip = TooltipCreator.createTooltip(_statusArray[index].length/2 + 1, MiniToolTipAlpha, MiniToolTipMid, MiniToolTipOmega, TooltipCreator.VERTICAL);
				addChild(_toolTip);
				_toolTip.alpha = 0;
				var arr:Array = [index];
				TweenLite.to(_toolTip, 0, {alpha:1, onComplete:showData, onCompleteParams:arr})
				/*_toolTip.x = _itemsArray[index].x;
				_toolTip.y = _itemsArray[index].y - 50;*/
		}
		
		private function showData(index:int):void {
			
			var point:Point = Points.getGlobalPoints( _itemsArray[index] );
			//trace( "[MiniToolTipManager]: point xy", point.x, point.y );
			
			/*if ( _statusArray[index] == "Collection" ) {
				_toolTip.x =   point.x;
				_toolTip.y =  point.y - 60;
			}else {
				_toolTip.x =   point.x;
				_toolTip.y =  point.y ;
			}	*/	
			
			_toolTip.x =  ((point.x + (_itemsArray[index].width - _toolTip.width)/2) + _offsetArray[index][0]) ; //(_coinMC.x + _coinMC.width) + _toolTip.width;
			_toolTip.y = ((point.y + (_itemsArray[index].height - _toolTip.height)/2) + _offsetArray[index][1]);
			
			_statusText = new MiniToolTipText();
			_toolTip.addChild(_statusText);
			_statusText.textField.text = _statusArray[index];
			
			var textWidth:Number = _statusText.textField.textWidth;
			_statusText.x = ((_toolTip.width - textWidth )/2) * .90;
			_statusText.y = 3;
			_statusText.textField.width = textWidth + (textWidth * .6);
			//_statusText.textField.width = 300;
			//_statusText.textField.width = ((_toolTip.width - _statusText.textField.textWidth)/2) * .90;
			//_statusTextField.textField.width = 300;
			_statusText.mouseEnabled = false;
			//_statusText.textField.multiline = true;
			//_statusText.textField.height = 66;
			
			//_toolTip.alpha = 1;
			_toolTip.mouseChildren = false;
			_toolTip.mouseEnabled = false;
			
			
			// set text format
			var textFormat:TextFormat = new TextFormat();
			textFormat.align = TextFormatAlign.LEFT;
			_statusText.textField.setTextFormat(textFormat);
			//_textFormat = new TextFormat();
			//_textFormat.color = 0xFFFFFF;
			//_textFormat.align = TextFormatAlign.JUSTIFY;
			
			//_statusText.textField.setTextFormat(_textFormat);
		}
		
		public function disable():void{
			_toolTip.alpha = 0;
			_toolTip.mouseChildren = false;
			_toolTip.mouseEnabled = false;
		}
		
		public function enable():void{
			_toolTip.alpha = 1;
			_toolTip.mouseChildren = true;
			_toolTip.mouseEnabled = true;
		}
		
		public function registerItem(item:DisplayObject, statusText:String, offsetX:Number = 0, offsetY:Number = 0):void{
			var arr:Array = [offsetX, offsetY];
			_offsetArray.push(arr);
			
			_itemsArray.push(item);
			item.addEventListener(MouseEvent.ROLL_OUT,onOutTooltipHandle);
			item.addEventListener(MouseEvent.ROLL_OVER,onOverTooltipHandle);
			item.addEventListener(MouseEvent.MOUSE_UP, onUpTooltipHandle);
			_statusArray.push(statusText);
		}
		
		public function unregisterItem(item:DisplayObject):void{
			var len:int = _itemsArray.length;
			for (var x:int = 0; x<len; x++){
				if (_itemsArray[x] == item){
					_itemsArray[x].removeEventListener(MouseEvent.ROLL_OUT, onOutTooltipHandle);
					_itemsArray[x].removeEventListener(MouseEvent.ROLL_OVER, onOverTooltipHandle);
					_itemsArray[x].removeEventListener(MouseEvent.MOUSE_UP, onUpTooltipHandle);
					_itemsArray.splice(x, 1);
					_statusArray.splice(x,1);
					_offsetArray.splice(x,1);
					break;
				}
			}
		}
		
		public function setStatusText(item:DisplayObject, statusText:String):void{

			var len:int = _itemsArray.length;
			for (var x:int = 0; x<len; x++){
				if (_itemsArray[x] == item){
					_statusArray[x] = statusText;
					break;
				}
			}
		}
		
		private function setDescriptionText(item:DisplayObject, descText:String):void{
			var len:int = _itemsArray.length;
			for (var x:int = 0; x<len; x++){
				if (_itemsArray[x] == item){
					_descArray[x] = descText;
					break;
				}
			}
		}
			
		private function onOutTooltipHandle(ev:MouseEvent):void{
			if (_toolTip != null){
				TweenLite.to(_toolTip, 0, {alpha:0, onComplete:onRemoveAsset})
			}
		}
		
		private function onUpTooltipHandle(ev:MouseEvent):void{
			if (_toolTip != null){
				TweenLite.to(_toolTip, 0, {alpha:0, onComplete:onRemoveAsset})	
			}
		}
		
		private function onOverTooltipHandle(ev:MouseEvent):void{
			var target:DisplayObject = ev.target as DisplayObject;

			var len:int = _itemsArray.length;
			for (var x:int = 0; x<len; x++){
				if (_itemsArray[x] == target){
					initAsset(x);
					break;
				}
			}
		}
		
		private function onRemoveAsset():void{
			removeChild(_toolTip);
			_toolTip = null;
		}
	}
}