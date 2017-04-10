
package com.surnia.socialStar.minigames.components.parallaxBg
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Droids
	 */
	public class parallaxBgView extends Sprite
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _model:parallaxBg;
		private var _controller:parallaxBgController;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function parallaxBgView(model:parallaxBg, controller:parallaxBgController, objectTypeList:Array)
		{
			this._model=model;
			this._controller=controller;
			this._controller.objectTypes=objectTypeList;
			this.init();
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		private function init():void
		{
			//this._model.addEventListener("UpdateMaxObjects", addObjectsOnStage);
			this._controller.generateLayers();
			setDisplay();
		}
		private function setDisplay():void
		{ //create layers
			var layerOnStageList:Array=new Array();
			var maxLayers:int=this._model.layerList.length;
			for(var num:int=0; num<maxLayers; num++)
			{
				var layerSprite:Sprite=new Sprite();
				layerSprite.name=this._model.layerList[num].name;
				var layerObj:Object=new Object();
				layerObj.layerSprite=layerSprite;
				layerObj.objects=new Array();
				layerObj.order=this._model.layerList[num].layer;
				layerObj.size=this._model.layerList[num].size;
				layerObj.speed=this._model.layerList[num].speed;
				layerObj.amount=this._model.layerList[num].amount;
				layerObj.graphic=this._model.layerList[num].graphic;
				layerOnStageList[layerSprite.name]=layerObj;
				this.addChild(layerOnStageList[layerSprite.name].layerSprite);
			}
			this._model.layersOnStage=layerOnStageList;
			this._controller.generateObject();
			this._controller.gameInit=true;
		}
		public function parallaxBgLoop():void
		{
			//update position
			//remove from stage
			this._controller.generateObject();
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		public function addObjectsOnStage(evt:Event):void
		{
			//this._model.objectsOnStage[this._model.objectsOnStage.length-1].x=this._model.objectsOnStage[this._model.objectsOnStage.length-1].xAxis;
			//this._model.objectsOnStage[this._model.objectsOnStage.length-1].y=this._model.objectsOnStage[this._model.objectsOnStage.length-1].yAxis;
			//this._model.objectsOnStage[this._model.objectsOnStage.length-1].width=this._model.objectsOnStage[this._model.objectsOnStage.length-1].myWidth;
			//this._model.objectsOnStage[this._model.objectsOnStage.length-1].height=this._model.objectsOnStage[this._model.objectsOnStage.length-1].myHeight;
			//var myLayer:Sprite=this._model.layersOnStage["layer_" + this._model.objectsOnStage[this._model.objectsOnStage.length-1].layer];
			//myLayer.addChild(this._model.objectsOnStage[this._model.objectsOnStage.length-1]);
			//trace("layer:"+myLayer.name +" object:"+this._model.objectsOnStage[this._model.objectsOnStage.length-1].objectName);
		}
	}
}