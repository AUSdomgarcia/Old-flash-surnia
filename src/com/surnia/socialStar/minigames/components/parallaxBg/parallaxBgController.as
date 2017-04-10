package com.surnia.socialStar.minigames.components.parallaxBg
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Droids
	 */
	public class parallaxBgController
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _model:parallaxBg;
		private var _obCtr:int;
		public var gameInit:Boolean;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function parallaxBgController(model:parallaxBg)
		{
			this._model=model;
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		public function generateLayers():void
		{
			var tempHolder:parallaxObject;
			var maxLength:int=this._model.objectTypeList.length;
			for(var num1:int=0; num1<maxLength; num1++)
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
			for(var num:int=0; num<maxLength; num++)
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
					this._model.layerList.push(layerObj);	
				}
			}
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
			/*switch(range)
			{
				case "verysmall":
				{
					size.width=Math.floor((Math.random() * 40)+1);;
					size.height=Math.floor((Math.random() * 10)+1);;
					break;
				}
				case "small":
				{
					size.width=Math.floor((Math.random() * 10)+1);;
					size.height=Math.floor((Math.random() * 25)+1);;
					break;
				}
				case "medium":
				{
					size.width=Math.floor((Math.random() * 20)+1);;
					size.height=Math.floor((Math.random() * 60)+1);;
					break;
				}
				case "large":
				{
					size.width=Math.floor((Math.random() * 120)+80);;
					size.height=Math.floor((Math.random() * 92)+46);;
					break;
				}		
				case "verylarge":
				{
					size.width=Math.floor((Math.random() * 320)+100);;
					size.height=Math.floor((Math.random() * 122)+56);;
					break;
				}	
			}*/
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
					speed.value=0.08;
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
		public function generateObject():void
		{
			var layerList:Array=this._model.layersOnStage;
			for(var layerName:String in layerList)
			{			
				var maxObjects:int;
				var tempList:Array;
				var continuousObj:Object=new Object();
				if(layerList[layerName].amount=="1")
				{
					layerList[layerName].amount="0"
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					continuousObj=singleAmountAdd(continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
				}
				else if(layerList[layerName].amount=="continuous")
				{
					//creation
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					//continuousObj=continuousTypeAdd(layerName, continuousObj);
					continuousObj=continuousPlacement(layerName, continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
					//remove
					/*
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					continuousObj=removeObjects(layerName, continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
					*/
				}
				else
				{
					//creation
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					//continuousObj=addObjects(layerName, continuousObj);
					continuousObj=objectPlacement(layerName, continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
					/*
					//movement
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					continuousObj=moveObjects(layerName, continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
					//remove
					continuousObj.layerSprite=layerList[layerName].layerSprite;
					continuousObj.layerObjects=layerList[layerName].objects;
					continuousObj.prepItem=layerList[layerName].graphic;
					continuousObj=removeObjects(layerName, continuousObj);
					layerList[layerName].layerSprite=continuousObj.layerSprite;
					layerList[layerName].objects=continuousObj.layerObjects;
					*/
				}

			}
			
			this._model.layersOnStage=layerList;
		}
		private function singleAmountAdd(obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite
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
			objDisplay.width=objDisplay.myWidth;
			objDisplay.height=objDisplay.myHeight;
			layerObjects.push(objDisplay);
			spriteLayer.addChild(layerObjects[layerObjects.length-1]);
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function continuousPlacement(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite
			var layerObjects:Array=obj.layerObjects
			var objDisplay:parallaxObject;
			if(layerObjects.length>0)
			{
				var maxObjects:int=layerObjects.length;
				for(var cNum:int=0; cNum<maxObjects; cNum++)
				{
					var disp:DisplayObject=spriteLayer.getChildByName(layerObjects[cNum].name)
					var dispChecker:Number=disp.x + disp.width
					//if(layerObjects[cNum+1]==undefined && disp.x <= 0 && dispChecker <=600)
					if(dispChecker <= 0)
					{
						disp.x=(obj.prepItem.xAxis+(disp.width*2))-30;
						disp.y=obj.prepItem.yAxis;
					}
					//movement
					var speed:Object=getSpeed(layerObjects[cNum].speedRange, 0);
					layerObjects[cNum].x-=speed.value;
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
					spriteLayer.addChild(layerObjects[layerObjects.length-1]);
				}
			}
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function objectPlacement(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite;
			var layerObjects:Array=obj.layerObjects;
			var objDisplay:parallaxObject;
			var yPos:Number;
			var xPos:Number;
			var trans:Number;
			var scalex:int;
			var size:Object;
			if(layerObjects.length>0)
			{
				var maxObjects:int=layerObjects.length;
				for(var cNum:int=0; cNum<maxObjects; cNum++)
				{
					var disp:DisplayObject=spriteLayer.getChildByName(layerObjects[cNum].name)
					var dispChecker:Number=disp.x + disp.width;
					//if(layerObjects[cNum+1]==undefined && disp.x <= 0 && dispChecker <=600)
					if(disp.x<0 && obj.prepItem.xAxisType=="cloud" && obj.prepItem.yAxisType=="cloud")
					{
						xPos=Math.floor((Math.random() * disp.width)+600)
						disp.x=xPos;
						yPos=Math.floor((Math.random() * 285) + 1);
						disp.y=yPos;
						//trans=Math.floor((Math.random() * 5)+5)/10;
						//disp.alpha=trans;
						//disp.rotationX=90;
						//disp.rotationY=180;
					}
					if(dispChecker <= 0 && obj.prepItem.xAxisType!="cloud" && obj.prepItem.yAxisType!="cloud")
					{	
						xPos=Math.floor((Math.random() * disp.width)+590);
						disp.x=xPos;//590+disp.width;
						//Land Objects
						size=getSize(obj.prepItem.sizeRange);
						disp.width=obj.prepItem.myWidth+size.width;
						disp.height=obj.prepItem.myHeight+size.height;
						disp.y=490-obj.prepItem.myHeight;
					}
					//movement
					var speed:Object=getSpeed(layerObjects[cNum].speedRange, 0);
					layerObjects[cNum].x-=speed.value;
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
						yPos=490-objDisplay.height;
						size=getSize(obj.prepItem.sizeRange);
						objDisplay.width=objDisplay.myWidth+size.width;
						objDisplay.height=objDisplay.myHeight+size.height;
					}

					objDisplay.name=layerName+":"+objDisplay.name+num;
					objDisplay.x=xPos;
					objDisplay.y=yPos;
					layerObjects.push(objDisplay);
					spriteLayer.addChild(layerObjects[layerObjects.length-1]);
				}
			}
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function continuousTypeAdd(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite
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
			if(layerObjects.length>0)
			{
				var maxObjects:int=layerObjects.length;
				for(var cNum:int=0; cNum<maxObjects; cNum++)
				{
					var disp:DisplayObject=spriteLayer.getChildByName(layerObjects[cNum].name)
					var dispChecker:Number=disp.x + disp.width
					if(layerObjects[cNum+1]==undefined && disp.x <= 0 && dispChecker <=600)
					{
						objDisplay.name=layerName+":"+objDisplay.name+layerObjects.length;
						objDisplay.x=590;
						objDisplay.y=objDisplay.yAxis;
						//objDisplay.xAxis=0;
						objDisplay.width=objDisplay.myWidth;
						objDisplay.height=objDisplay.myHeight;
						layerObjects.push(objDisplay)
						spriteLayer.addChildAt(layerObjects[layerObjects.length-1], 0);	
					}
					else
					{
						var speed:Object=getSpeed(layerObjects[cNum].speedRange, 0);
						layerObjects[cNum].x-=speed.value;
					}
				}				
			}
			else
			{	//initial object
				objDisplay.name=layerName+":"+objDisplay.name+layerObjects.length;
				objDisplay.x=objDisplay.xAxis;
				objDisplay.y=objDisplay.yAxis;
				//objDisplay.xAxis=0;
				objDisplay.width=objDisplay.myWidth;
				objDisplay.height=objDisplay.myHeight;
				layerObjects.push(objDisplay)
				spriteLayer.addChild(layerObjects[layerObjects.length-1]);
			}
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function moveObjects(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite;
			var layerObjects:Array=obj.layerObjects;
			var maxObjects:int=layerObjects.length;
			for(var cNum:int=0; cNum<maxObjects; cNum++)
			{	
				var speed:Object=getSpeed(obj.prepItem.speedRange, layerObjects[cNum].xAxis);
				layerObjects[cNum].x-= speed.value;
			}
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function addObjects(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite;
			var layerObjects:Array=obj.layerObjects;
			var objDisplay:parallaxObject;
			var stat:Object=getChance(obj.prepItem.amountRange);
			var result:int = Math.floor((Math.random() * stat.base));
			var yPos:Number;
			var xPos:Number;
			var trans:Number;
			var scalex:int;
			var size:Object;
			if (result<=stat.chance && gameInit==true)
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
				objDisplay.name=layerName+":"+objDisplay.name+layerObjects.length;
				
				
				if(obj.prepItem.xAxisType=="cloud")
				{
					objDisplay.x=700;
				}
				else
				{
					//objDisplay.xAxis=0;
					objDisplay.x=590;
				}
				if(obj.prepItem.yAxisType=="cloud")
				{
					yPos=Math.floor((Math.random() * objDisplay.yAxis) + 1);
					objDisplay.y=yPos;
					//trans=Math.floor((Math.random() * 5)+5)/10;
					//objDisplay.alpha=trans;
					scalex=Math.floor((Math.random() * 2)+1);
					if(scalex==1)
					{
						objDisplay.rotation=180;
					}
					//objDisplay.rotationX=90;
					//objDisplay.rotationY=180;
				}
				else
				{ //Land Objects
					//objDisplay.y=obj.prepItem.yAxis;
					size=getSize(obj.prepItem.sizeRange);
					objDisplay.width=objDisplay.myWidth+size.width;
					objDisplay.height=objDisplay.myHeight+size.height;
					objDisplay.y=490-objDisplay.height;
				}


				layerObjects.push(objDisplay);
				spriteLayer.addChild(layerObjects[layerObjects.length-1]);
			}		
			
			if(gameInit==false)
			{
				for(var num:int=0; num<2; num++)
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
						xPos=Math.floor((Math.random() * 584)+1);
					}
					else
					{
						xPos=Math.floor((Math.random() * 225)+1);					}
					
					if(obj.prepItem.yAxisType=="cloud")
					{
						yPos=Math.floor((Math.random() * objDisplay.yAxis)+1);
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
						yPos=490-objDisplay.height;
						size=getSize(obj.prepItem.sizeRange);
						objDisplay.width=objDisplay.myWidth+size.width;
						objDisplay.height=objDisplay.myHeight+size.height;
					}
					objDisplay.name=layerName+":"+objDisplay.name+layerObjects.length;
					
					objDisplay.xAxis=0;

					
					objDisplay.x=xPos;
					objDisplay.y=yPos;
					
					layerObjects.push(objDisplay);
					spriteLayer.addChild(layerObjects[layerObjects.length-1]);
				}
			}
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		private function removeObjects(layerName:String, obj:Object):Object
		{
			var spriteLayer:Sprite=obj.layerSprite;
			var layerObjects:Array=obj.layerObjects;
			var maxObjects:int=layerObjects.length;
			/*
			for(var cNum:int=0; cNum<maxObjects; cNum++)
			{
				var disp:DisplayObject=spriteLayer.getChildByName(layerObjects[cNum].name);
				var checkPos:Number=disp.x + disp.width;
				if(checkPos < 0)
				{
					trace(disp.name + "="+maxObjects)
					spriteLayer.removeChild(disp);
					layerObjects.splice(cNum, 1);
					break;
				}
			}*/
			var ctr:int=0;
			while(ctr<maxObjects)
			{
				var disp:DisplayObject=spriteLayer.getChildByName(layerObjects[ctr].name);
				var checkPos:Number=disp.x + disp.width;
				if(checkPos < 0)
				{
					spriteLayer.removeChild(disp);
					layerObjects.splice(ctr, 1);
					break;
				}
				ctr++;
			}
			
			obj.layerSprite=spriteLayer;
			obj.layerObjects=layerObjects;
			return obj;
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		public function set objectTypes(list:Array):void
		{
			this._model.objectTypeList=list;
		}
		public function set updateObjectListData(list:Array):void
		{
			this._model.objectsOnStage=list;
		}
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
	}
}