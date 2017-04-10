package com.surnia.socialStar.minigames.components.parallaxBg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Droids
	 */
	public class parallaxObject extends Sprite
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _objectName:String;
		private var _graphic:*;
		private var _type:String;
		private var _mode:String;
		private var _layer:int;
		private var _sizeRange:String; //width, height
		private var _speedRange:String; //movement
		private var _amountRange:String; //min max number of this object
		public var xAxis:Number;
		public var yAxis:Number;
		private var _width:Number;
		private var _height:Number;
		public var xAxisType:String;
		public var yAxisType:String;
		public var myMatrix:Matrix;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function parallaxObject(name:String, graphic:*, type:String, mode:String, layer:int, sizeRange:String, speedRange:String, amountRange:String, xAxis:Number, yAxis:Number, width:Number, height:Number, xAxisType:String, yAxisType:String)
		{
			myMatrix=new Matrix();
			this.objectName=name;
			this.type=type;
			this.mode=mode;
			this.myWidth=width;
			this.myHeight=height;
			this.graphic=graphic;
			this.layer=layer;
			this.sizeRange=sizeRange;
			this.speedRange=speedRange;
			this.amountRange=amountRange;
			this.xAxis=xAxis;
			this.yAxis=yAxis;
			this.xAxisType=xAxisType;
			this.yAxisType=yAxisType;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage)
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		private function destroyMe():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage)
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._objectName=null;
			this._graphic=null;
			this._type=null;
			this._mode=null;
			this._layer=0;
			this._sizeRange=null;
			this._speedRange=null;
			this._amountRange=null;
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		public function set objectName(name:String):void
		{
			this._objectName=name;
			this.name=name;
		}
		public function set graphic(graphic:*):void
		{
			if(this.name!="blank")
			{
				this._graphic=graphic;
				if(this._mode=="display")
				{
					switch(this._type)
					{
						case "image":
						{
							
							var bitmapImage:Bitmap =new Bitmap(graphic);
							bitmapImage.name="myGraphic";
							//bitmapImage.width=this._width;
							//bitmapImage.height=this._height;
							if (this.getChildByName("myGraphic")!= null)
							{
								this.removeChildAt(0);
								this.addChild(bitmapImage);
								
							}
							else
							{
								this.addChild(bitmapImage);
							}
							
							//var bitmapImage:BitmapData=new BitmapData();
							//bitmapImage.copyPixels(graphic);
							break;
						}
						case "sprite":
						{
							this._graphic.name="myGraphic";
							if (this.getChildByName("myGraphic")!= null)
							{
								this.removeChildAt(0);
								this.addChild(this._graphic);
								
							}
							else
							{
								this.addChild(this._graphic);
							}
							break;
						}
						case "movie":
						{
							var mc:MovieClip=this._graphic;
							mc.name="myGraphic";
							if (this.getChildByName("myGraphic")!= null)
							{
								this.removeChildAt(0);
								this.addChild(mc);
								
							}
							else
							{
								this.addChild(mc);
							}
							break;
						}
					}
				}
			}
		}
		public function set type(type:String):void
		{
			this._type=type;
		}
		public function set mode(mode:String):void
		{
			this._mode=mode;
		}
		public function set layer(layer:int):void
		{
			this._layer=layer;
		}
		public function set sizeRange(range:String):void
		{
			this._sizeRange=range;
		}
		public function set speedRange(range:String):void
		{
			this._speedRange=range;
		}
		public function set amountRange(range:String):void
		{
			this._amountRange=range;
		}
		public function set myWidth(width:Number):void
		{
			this._width=width;
		}
		public function set myHeight(height:Number):void
		{
			this._height=height;
		}
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		public function get objectName():String
		{
			return this._objectName;
		}
		public function get graphic():*
		{
			return this._graphic;
		}
		public function get type():String
		{
			return this._type;
		}
		public function get mode():String
		{
			return this._mode;
		}
		public function get layer():int
		{
			return this._layer;
		}
		public function get sizeRange():String
		{
			return this._sizeRange;
		}
		public function get speedRange():String
		{
			return this._speedRange;
		}
		public function get amountRange():String
		{
			return this._amountRange;
		}
		public function get myWidth():Number
		{
			return this._width;
		}
		public function get myHeight():Number
		{
			return this._height;
		}
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		private function removedFromStage(evt:Event):void
		{
			destroyMe();
		}
	}
}