package com.surnia.socialStar.ui.popUI.views.characterPanel.components.BossAvatar
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author Droids
	 */	
	public class Droids_Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		public var name:String;
		public var bitmapData:BitmapData;
		public var col_indx:int;
		public var row_indx:int;
		public var maxColumns:int;
		public var maxRows:int;
		public var iterator:int;
		public var maxItems:int;
		public var x:Number;
		public var y:Number;
		public var xmov:Number;
		public var ymov:Number;
		public var width:Number;
		public var height:Number;
		public var loop:Boolean;
		public var itemList:Array;
		public var points:int;
		public var move:Boolean;
		public var holder:Object;
		public var xGap:Number;
		public var yGap:Number;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function Droids_Sprite(bitmap:BitmapData, maxColumns:int, maxRows:int, maxItems:int, x:Number, y:Number, width:Number, height:Number, loop:Boolean)
		{
			this.bitmapData=bitmap;
			this.col_indx=0;
			this.row_indx=0;
			this.maxColumns=maxColumns;
			this.maxRows=maxRows;
			this.iterator=0;
			this.maxItems=maxItems;
			this.x=x;
			this.y=y;
			this.xGap=x;
			this.yGap=y;
			this.ymov=-10;
			this.xmov=-5;
			this.width=width;
			this.height=height;
			this.loop=loop;
			
			init();
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init():void
		{
			this.itemList=new Array();
			var displayBD:BitmapData;
			for(var row:int=0; row < this.maxRows; row++)
			{
				for(var col:int=0; col < this.maxColumns; col++)
				{
					displayBD=new BitmapData(this.width, this.height, true, 0xffffffff);
					displayBD.copyPixels(this.bitmapData, new Rectangle(col*this.width, row*this.height, this.width, this.height), new Point(0, 0));
					this.itemList.push(displayBD);
					if(this.itemList.length-1 == this.maxItems)
					{
						break;
					}
				}
			}
		}
		public function flip():void
		{
			var displayBD:BitmapData;
			var max:int=this.itemList.length
			for(var num:int=0; num < max; num++)
			{
				displayBD=new BitmapData(this.width, this.height, true, 0x000000);
				displayBD.draw(this.itemList[num], new Matrix(-1, 0, 0, 1, this.width, 0), null, null,null,true);
				this.itemList[num]=displayBD;
			}
		}
		public function recolor(redM:Number, greenM:Number, blueM:Number, alphaM:Number, redOff:Number, greenOff:Number, blueOff:Number, alphaOff:Number):void
		{
			var displayBD:BitmapData;
			
			var max:int=this.itemList.length
			for(var num:int=0; num < max; num++)
			{
				this.itemList[num].colorTransform(new Rectangle(0,0,this.width,this.height), new ColorTransform(redM,greenM,blueM,alphaM,redOff,greenOff,blueOff,alphaOff));
			}
		}
		public function resize(scaleX:Number, scaleY:Number):void
		{
			var displayBD:BitmapData;
			var max:int=this.itemList.length
			var matrix:Matrix;
			for(var num:int=0; num < max; num++)
			{
				displayBD=new BitmapData(this.width, this.height, true, 0x000000);
				matrix=new Matrix();
				matrix.translate((this.width/2)*-1, (this.height/2)*-1);
				matrix.scale(scaleX, scaleY);
				matrix.translate((this.width/2), (this.height/2));

				displayBD.draw(this.itemList[num], matrix, null, null,null,true);
				this.itemList[num]=displayBD;
			}
		}
		public function rotate(rotation:Number):void
		{
			var displayBD:BitmapData;
			var max:int=this.itemList.length
			var matrix:Matrix;
			var angle_in_radians:Number= Math.PI * 2 * (rotation/360);
			for(var num:int=0; num < max; num++)
			{
				displayBD=new BitmapData(this.width, this.height, true, 0x000000);
				matrix=new Matrix();
				matrix.translate((this.width/2)*-1, (this.height/2)*-1);
				matrix.rotate(angle_in_radians)
				matrix.translate((this.width/2), (this.height/2));
				displayBD.draw(this.itemList[num], matrix, null, null,null,true);
				this.itemList[num]=displayBD;
			}
		}
		public function destroyMe():void
		{
			var max:int=this.itemList.length
			for(var num:int=0; num < max; num++)
			{
				this.itemList[num].dispose();
				this.itemList[num]=null;
			}
			this.itemList=null;
			this.bitmapData=null;
		}

		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/

	}
}