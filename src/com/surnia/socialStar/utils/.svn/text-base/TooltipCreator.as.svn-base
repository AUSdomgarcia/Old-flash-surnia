package com.surnia.socialStar.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * 
	 * Tooltip class for creating tooltips.
	 * 
	 * @author hedrick david
	 * 
	 */	
	
	public class TooltipCreator
	{
		
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String = "horizontal";
		
		/**
		 * 
		 * @param midPartAmount - the amount of midpart to be placed to increase height as needed
		 * @param topPart - the class of the top part asset, usally needed for non squared designs.
		 * @param midPart - the class of the mid part asset of the tooltip, where the content will be placed and multiplied.
		 * @param bottomPart - the class of the bottom part asset usally needed for non squared designs.
		 * @return Sprite - the combined asset
		 * 
		 */		
		
		public static function createTooltip (midPartAmount:int, AlphaPart:Class, MidPart:Class, OmegaPart:Class, direction:String = "vertical"):Sprite{
			var yPos:int = 0;
			var xPos:int = 0;
			var topPart:* = new AlphaPart();
			var midPart:Array = [];
			var bottomPart:* = new OmegaPart();
			var tooltip:Sprite = new Sprite();
			
			tooltip.addChild(topPart);
			if (direction == HORIZONTAL){
				topPart.y = yPos;
				yPos += topPart.height;
				for (var x:int = 0; x<midPartAmount; x++){
					midPart[x] = new MidPart();
					tooltip.addChild(midPart[x]);
					//midPart[x].y = yPos;
					yPos += midPart[x].height;
				}
				tooltip.addChild(bottomPart);
				bottomPart.y = yPos;
			} else {
				topPart.x = xPos;
				xPos += topPart.width;
				for (var y:int = 0; y<midPartAmount; y++){
					midPart[x] = new MidPart();
					tooltip.addChild(midPart[x]);
					midPart[x].x = xPos;
					xPos += midPart[x].width;
				}
				tooltip.addChild(bottomPart);
				bottomPart.x = xPos;
			}
			return tooltip;
		}
		
		public static function addTextField(toolTip:Sprite ,  initialValue:String = "", name:String = "", xPos:Number = 0, yPos:Number = 0):TextField{
			var textField:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat();
			
			toolTip.addChild(textField);
			textField.name = "textField";
			textField.x = xPos;
			textField.y = yPos;
			textField.text = initialValue;
			textField.width = 150;
			textField.mouseEnabled = false;
			textField.setTextFormat(textFormat);
			textFormat.align = TextFormatAlign.JUSTIFY;
			textFormat.font = "arial";
			textFormat.size = 10;
			return textField;
		}
	}
}