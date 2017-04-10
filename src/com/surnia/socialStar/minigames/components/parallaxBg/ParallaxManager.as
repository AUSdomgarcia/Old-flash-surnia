package com.surnia.socialStar.minigames.components.parallaxBg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author Droids
	 */
	public class ParallaxManager extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _model:parallaxBg;
		private var _screenBD:BitmapData;
		private var _backgroundBD:BitmapData;
		private var _screenB:Bitmap;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function ParallaxManager(model:parallaxBg, objectTypeList:Array)
		{
			this._model=model;
			this._model.objectTypeList=objectTypeList;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function setDisplay():void
		{ //create layers
			var layerOnStageList:Array=new Array();
			var maxLayers:int=this._model.layerList.length;
			for(var num:int=0; num<maxLayers; num++)
			{
				var layerObj:Object=new Object();
				layerObj.name=this._model.layerList[num].name;
				layerObj.objects=new Array();
				layerObj.order=this._model.layerList[num].layer;
				layerObj.size=this._model.layerList[num].size;
				layerObj.speed=this._model.layerList[num].speed;
				layerObj.amount=this._model.layerList[num].amount;
				layerObj.graphic=this._model.layerList[num].graphic;
				//layerOnStageList[layerObj.name]=layerObj;
				layerOnStageList[num]=layerObj;
			}
			this._model.layersOnStage=layerOnStageList;
			renderObject();
			//renderBackground();
		}
		private function createScreen():void
		{
			this._backgroundBD=new BitmapData(this._model.stageWidth, this._model.stageHeight, false, 0x000000);
			var scaleMatrix:Matrix=new Matrix();
			scaleMatrix.scale(1, 2.065);
			this._backgroundBD.draw(new Scene_Sky(), scaleMatrix);
			this._screenBD=new BitmapData(this._model.stageWidth, this._model.stageHeight, false, 0x000000);
			
			this._screenBD.copyPixels(this._backgroundBD, new Rectangle(0,0,this._model.stageWidth, this._model.stageHeight),new Point(0,0));

			this._screenB=new Bitmap(this._screenBD);
			this.addChild(this._screenB);
		}
		private function renderBackground():void
		{
			this._screenBD.copyPixels(this._backgroundBD, new Rectangle(0,0,this._model.stageWidth, this._model.stageHeight),new Point(0,0));
		}
		private function generateLayers():void
		{
			var tempHolder:parallaxObject;
			var maxLength:int=this._model.objectTypeList.length;
			for(var num1:int=0; num1<maxLength; num1++)//sorting of object type layer
			{
				for(var num2:int=0; num2<maxLength; num2++)
				{
					if(this._model.objectTypeList[num1].layer < this._model.objectTypeList[num2].layer)
					{
						tempHolder=this._model.objectTypeList[num1];
						this._model.objectTypeList[num1]=this._model.objectTypeList[num2];
						this._model.objectTypeList[num2]=tempHolder;
					}
				}
			}	
			var layerList:Array=new Array();
			for(var num:int=0; num<maxLength; num++)//used for layer creation
			{
				var layerObj:Object=new Object();
				layerObj.name="layer_"+this._model.objectTypeList[num].layer;
				layerObj.order=this._model.objectTypeList[num].layer;
				layerObj.size=this._model.objectTypeList[num].sizeRange;
				layerObj.speed=this._model.objectTypeList[num].speedRange;
				layerObj.amount=this._model.objectTypeList[num].amountRange;
				layerObj.graphic=this._model.objectTypeList[num];
				if(checkLayers(layerObj.name)==false)
				{	
					//trace("layer_"+this._model.objectTypeList[num].name+":"+this._model.objectTypeList[num].layer)
					layerList.push(layerObj);	
				}
			}
			this._model.layerList=layerList;
		}
		private function checkLayers(layerName:String):Boolean
		{
			var result:Boolean=false;
			var maxLayers:int=this._model.layerList.length;
			for(var num:int=0; num<maxLayers;  num++)
			{
				if(layerName==this._model.layerList[num].name)
				{
					result=true;
					break;
				}
			}
			return result;
		}
		private function getSize(range:String):Object
		{
			var size:Object=new Object();
			size.width=0;
			size.height=0;
			size.scale="none";
			switch(range)
			{
				case "verysmall":
				{
					//size.width=Math.floor((Math.random() * 40)+1);;
					//size.height=Math.floor((Math.random() * 10)+1);;
					break;
				}
				case "small":
				{
					//size.width=Math.floor((Math.random() * 10)+1);;
					//size.height=Math.floor((Math.random() * 25)+1);;
					break;
				}
				case "medium":
				{
					//size.width=Math.floor((Math.random() * 20)+1);;
					//size.height=Math.floor((Math.random() * 60)+1);;
					break;
				}
				case "large":
				{
					//size.width=Math.floor((Math.random() * 120)+80);;
					//size.height=Math.floor((Math.random() * 92)+46);;
					break;
				}		
				case "verylarge":
				{
					//size.width=Math.floor((Math.random() * 320)+100);;
					//size.height=Math.floor((Math.random() * 122)+56);;
					break;
				}
				case "scaleY":
				{
					size.scale="y";
					break;
				}
				case "scaleX":
				{
					size.scale="x";
					break;
				}
			}
			return size;
		}
		private function getChance(range:String):Object
		{
			var stat:Object=new Object();
			stat.chance=0;
			stat.base=10;
			stat.amount=0;
			switch(range)
			{
				case "continuous":
				{
					stat.chance=100;
					stat.base=1000;
					stat.amount=3;
					break;
				}
				case "verysmall":
				{
					stat.chance=1;
					stat.base=1000;
					stat.amount=1;
					break;
				}
				case "small":
				{
					stat.chance=2;
					stat.base=1000;
					stat.amount=2;					
					break;
				}
				case "medium":
				{
					stat.chance=50;
					stat.base=1000;
					stat.amount=5;					
					break;
				}
				case "large":
				{
					stat.chance=80;
					stat.base=1000;
					stat.amount=7;					
					break;
				}
				case "verylarge":
				{
					stat.chance=100;
					stat.base=1000;
					stat.amount=10;					
					break;
				}
			}
			return stat;
		}
		private function getSpeed(range:String, xPos:Number):Object
		{
			var speed:Object=new Object();
			speed.value=0;
			speed.xPos=xPos;
			switch(range)
			{
				case "veryslow":
				{
					speed.xPos+=0.01;
					speed.value=0.04;
					break;
				}
				case "slow":
				{
					speed.xPos+=0.08;
					speed.value=0.05;
					break;
				}
				case "medium":
				{
					speed.xPos+=0.01;
					speed.value=2;
					break;
				}
				case "fast":
				{
					speed.xPos+=0.01;
					speed.value=3;
					break;
				}
				case "veryfast":
				{
					speed.xPos+=0.01;
					speed.value=10;
					break;
				}
			}
			return speed;
		}
		private function renderObject():void
		{
			var layerList:Array=this._model.layersOnStage;
			//for(var layerName:String in layerList)
			var maxLayers:int=layerList.length;
			for(var num:int=0; num<maxLayers; num++)
			{			
				//trace("layer:"+layerList[num].name)
				var maxObjects:int;
				var tempList:Array;
				var obj:Object=new Object();
				if(layerList[num].amount=="1")
				{/*
					//layerList[num].amount="0"
					obj.layerSprite=layerList[num].layerSprite;
					obj.layerObjects=layerList[num].objects;
					obj.prepItem=layerList[num].graphic;
					obj=singleAmountAdd(obj);
					layerList[num].layerSprite=obj.layerSprite;
					layerList[num].objects=obj.layerObjects;*/
				}
				else if(layerList[num].amount=="continuous")
				{
					obj.layerSprite=layerList[num].layerSprite;
					obj.layerObjects=layerList[num].objects;
					obj.prepItem=layerList[num].graphic;
					obj=continuousPlacement(layerList[num].name, obj);
					layerList[num].layerSprite=obj.layerSprite;
					layerList[num].objects=obj.layerObjects;
				}
				else
				{
					obj.layerSprite=layerList[num].layerSprite;
					obj.layerObjects=layerList[num].objects;
					obj.prepItem=layerList[num].graphic;
					obj=objectPlacement(layerList[num].name, obj);
					layerList[num].layerSprite=obj.layerSprite;
					layerList[num].objects=obj.layerObjects;
				}
			}
			this._model.layersOnStage=layerList;
		}
		private function singleAmountAdd(obj:Object):Object
		{
			var layerObjects:Array=obj.layerObjects
			var objDisplay:parallaxObject=new parallaxObject(
				obj.prepItem.objectName, 
				obj.prepItem.graphic, 
				obj.prepItem.type, 
				"display", 
				obj.prepItem.layer, 
				obj.prepItem.sizeRange, 
				obj.prepItem.speedRange, 
				obj.prepItem.amountRange, 
				obj.prepItem.xAxis, 
				obj.prepItem.yAxis, 
				obj.prepItem.myWidth, 
				obj.prepItem.myHeight,
				obj.prepItem.xAxisType,
				obj.prepItem.yAxisType
			) 
			
			objDisplay.x=objDisplay.xAxis;
			objDisplay.y=objDisplay.yAxis;
			
			var size:Object=getSize(obj.prepItem.sizeRange);
			if(obj.prepItem.sizeRange=="y")
			{
				objDisplay.width=1;
				objDisplay.height=2.065;
			}
			else if(obj.prepItem.sizeRange=="x")
			{
				objDisplay.width=1.03;
				objDisplay.height=1;
			}
			else
			{
				objDisplay.width=objDisplay.myWidth;
				objDisplay.height=objDisplay.myHeight;
			}
			layerObjects.push(objDisplay);
			obj.layerObjects=layerObjects;
			

			var scaleMatrix:Matrix=new Matrix();
			scaleMatrix.scale(1, 2.065);
			this._backgroundBD.draw(obj.prepItem.graphic, scaleMatrix);
			this._screenBD.copyPixels(this._backgroundBD, new Rectangle(0,0,this._model.stageWidth, this._model.stageHeight),new Point(0,0));
			
			return obj;
		}
		private function continuousPlacement(layerName:String, obj:Object):Object
		{
			var layerObjects:Array=obj.layerObjects
			var objDisplay:parallaxObject;
			var displayBD:BitmapData;
			if(layerObjects.length>0)
			{
				var maxObjects:int=layerObjects.length;
				for(var cNum:int=0; cNum<maxObjects; cNum++)
				{
					var dispChecker:Number=layerObjects[cNum].x + layerObjects[cNum].width;
					if(dispChecker <= 0)
					{
						layerObjects[cNum].x = layerObjects[cNum].x + (layerObjects[cNum].width *3);
						layerObjects[cNum].y = obj.prepItem.yAxis;
					}
					var speed:Object=getSpeed(layerObjects[cNum].speedRange, 0);
					layerObjects[cNum].x-=speed.value;
					
					displayBD=new BitmapData(layerObjects[cNum].width,layerObjects[cNum].height, true, 0xffffffff);					
					displayBD.copyPixels(obj.prepItem.graphic, new Rectangle(0,0,layerObjects[cNum].width,layerObjects[cNum].height), new Point(0, 0));
					this._screenBD.copyPixels(displayBD, new Rectangle(0,0,layerObjects[cNum].width,layerObjects[cNum].height), new Point(layerObjects[cNum].x, layerObjects[cNum].y));					
				}	
			}
			else
			{	//initial object
				var stat:Object=getChance(obj.prepItem.amountRange);
				for(var num:int=0; num<stat.amount; num++)
				{
					objDisplay=new parallaxObject(
						obj.prepItem.objectName, 
						obj.prepItem.graphic, 
						obj.prepItem.type, 
						"display", 
						obj.prepItem.layer, 
						obj.prepItem.sizeRange, 
						obj.prepItem.speedRange, 
						obj.prepItem.amountRange, 
						obj.prepItem.xAxis, 
						obj.prepItem.yAxis, 
						obj.prepItem.myWidth, 
						obj.prepItem.myHeight,
						obj.prepItem.xAxisType,
						obj.prepItem.yAxisType
					);
					objDisplay.name=layerName+":"+objDisplay.name+num;
					switch(num)
					{
						case 0:
						{
							objDisplay.x=objDisplay.xAxis;
							break;
						}
						case 1:
						{
							objDisplay.x=objDisplay.xAxis+objDisplay.width;
							break;
						}	
						case 2:
						{
							objDisplay.x=objDisplay.xAxis+(objDisplay.width*2);
							break;
						}
					}					
					objDisplay.y=objDisplay.yAxis;
					objDisplay.width=objDisplay.myWidth;
					objDisplay.height=objDisplay.myHeight;
					layerObjects.push(objDisplay);
					
					displayBD=new BitmapData(objDisplay.width,objDisplay.height, true, 0xffffffff);					
					displayBD.copyPixels(obj.prepItem.graphic, new Rectangle(0,0,objDisplay.width,objDisplay.height), new Point(0, 0));
					this._screenBD.copyPixels(displayBD, new Rectangle(0,0,objDisplay.width,objDisplay.height), new Point(objDisplay.x, objDisplay.y));	
				}
			}
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function objectPlacement(layerName:String, obj:Object):Object
		{
			var layerObjects:Array=obj.layerObjects;
			var objDisplay:parallaxObject;
			var yPos:Number;
			var xPos:Number;
			var trans:Number;
			var scalex:int;
			var size:Object;
			var displayBD:BitmapData;
			if(layerObjects.length>0)
			{
				var maxObjects:int=layerObjects.length;
				for(var cNum:int=0; cNum<maxObjects; cNum++)
				{					
					var dispChecker:Number=layerObjects[cNum].x + layerObjects[cNum].width
					if(dispChecker <= 0 && obj.prepItem.xAxisType=="cloud" && obj.prepItem.yAxisType=="cloud")
					{					
						xPos=Math.floor((Math.random() * layerObjects[cNum].myWidth)+600)
						layerObjects[cNum].x=xPos;
						yPos=Math.floor((Math.random() * 285) + 1);
						layerObjects[cNum].y=yPos;
					}
					if(dispChecker <= 0 && obj.prepItem.xAxisType!="cloud" && obj.prepItem.yAxisType!="cloud")
					{
						xPos=Math.floor((Math.random() * layerObjects[cNum].myWidth)+590);
						layerObjects[cNum].x=xPos;//590+disp.width;
						//Land Objects
						size=getSize(obj.prepItem.sizeRange);
						layerObjects[cNum].myWidth=obj.prepItem.myWidth+size.width;
						layerObjects[cNum].myHeight=obj.prepItem.myHeight+size.height;
						//layerObjects[cNum].y=490-obj.prepItem.myHeight;
						layerObjects[cNum].y=obj.prepItem.yAxis-obj.prepItem.myHeight;
					}
					var speed:Object=getSpeed(layerObjects[cNum].speedRange, 0);
					layerObjects[cNum].x-=speed.value;
					
					displayBD=new BitmapData(layerObjects[cNum].width,layerObjects[cNum].height, true, 0xffffffff);					
					displayBD.copyPixels(obj.prepItem.graphic, new Rectangle(0,0,layerObjects[cNum].width,layerObjects[cNum].height), new Point(0, 0));
					this._screenBD.copyPixels(displayBD, new Rectangle(0,0,layerObjects[cNum].width,layerObjects[cNum].height), new Point(layerObjects[cNum].x, layerObjects[cNum].y));					
				}		
			}
			else
			{
				//initial object
				var stat:Object=getChance(obj.prepItem.amountRange);
				//trace(obj.prepItem.objectName+":"+stat.amount+":"+obj.prepItem.amountRange)
				for(var num:int=0; num<stat.amount; num++)
				{
					objDisplay=new parallaxObject(
						obj.prepItem.objectName, 
						obj.prepItem.graphic, 
						obj.prepItem.type, 
						"display", 
						obj.prepItem.layer, 
						obj.prepItem.sizeRange, 
						obj.prepItem.speedRange, 
						obj.prepItem.amountRange, 
						obj.prepItem.xAxis, 
						obj.prepItem.yAxis, 
						obj.prepItem.myWidth, 
						obj.prepItem.myHeight,
						obj.prepItem.xAxisType,
						obj.prepItem.yAxisType
					);	
					if(obj.prepItem.xAxisType=="cloud")
					{
						xPos=Math.floor((Math.random() * 584)+obj.prepItem.width);
					}
					else
					{
						xPos=Math.floor((Math.random() * 584)+obj.prepItem.width);					
					}
					if(obj.prepItem.yAxisType=="cloud")
					{
						yPos=Math.floor((Math.random() * objDisplay.yAxis)+obj.prepItem.height);
						//objDisplay.rotationX=90;
						//objDisplay.rotationY=180;
						//trans=Math.floor((Math.random() * 5)+5)/10;
						//objDisplay.alpha=trans;
						scalex=Math.floor((Math.random() * 2)+1);
						if(scalex==1)
						{
							objDisplay.rotation=180;
						}
					}
					else
					{
						//yPos=490-objDisplay.height;
						yPos=obj.prepItem.yAxis-objDisplay.height;
						
						size=getSize(obj.prepItem.sizeRange);
						objDisplay.width=objDisplay.myWidth+size.width;
						objDisplay.height=objDisplay.myHeight+size.height;
					}
					
					objDisplay.name=layerName+":"+objDisplay.name+num;
					objDisplay.x=xPos;
					objDisplay.y=yPos;
					layerObjects.push(objDisplay);
					
					displayBD=new BitmapData(objDisplay.width,objDisplay.height, true, 0xffffffff);					
					displayBD.copyPixels(obj.prepItem.graphic, new Rectangle(0,0,objDisplay.width,objDisplay.height), new Point(0, 0));
					this._screenBD.copyPixels(displayBD, new Rectangle(0,0,objDisplay.width,objDisplay.height), new Point(objDisplay.x, objDisplay.y));	

				}
			}
			obj.layerObjects=layerObjects;
			return obj;
		}
		public function parallaxBgLoop():void
		{
			renderBackground();
			renderObject();

		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			createScreen();
			generateLayers();
			setDisplay();
		}
	}
}