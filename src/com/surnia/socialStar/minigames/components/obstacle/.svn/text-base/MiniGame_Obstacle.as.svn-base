package com.surnia.socialStar.minigames.components.obstacle 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Drew
	 */
	public class MiniGame_Obstacle extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _obstacleName:String;
		private var _image:BitmapData;
		private var _effectType:String;
		private var _onStage:Boolean;
		private var _mc:MovieClip;
		public var reachCollider:String;
		public var speed:int;
		public var myCollider:MovieClip;
		public var myObCollider:MovieClip;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_Obstacle(obstacleName:String, image:BitmapData, effectType:String, mc:MovieClip) 
		{
			this.obstacleName = obstacleName;
			this.image= image;
			this.effectType = effectType;
			this.movieClip = mc;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			reachCollider = "false";
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function destroyMe():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._obstacleName=null;
			this._image=null;
			this._effectType=null;
			this._onStage=false;
			this._mc=null;
			this.reachCollider=null;
			this.speed=0;
			this.myCollider=null;
			this.myObCollider=null;
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		public function set obstacleName(obstacleName:String):void
		{
			this._obstacleName = obstacleName;
			this.name = obstacleName;
		}
		public function set image(image:BitmapData):void
		{
			if (this._obstacleName != "blank")
			{
				this._image = image;
				var bitmapImage:Bitmap = new Bitmap(image);
				bitmapImage.name = "myImage";	
				if (this.getChildByName("myImage")!= null)
				{
					this.removeChildAt(0);
					this.addChild(bitmapImage);
				}
				else
				{
					this.addChild(bitmapImage);
				}
				this.x = 530;
				this.y = 15;
			}
		}
		public function set movieClip(mc:MovieClip):void
		{
			if(mc!=null)
			{
				this._mc = mc;
				this.addChild(this._mc);
				this.myCollider=this._mc.collider;
				this.myObCollider=this._mc.ob_collider;
			}
		}
		public function set effectType(effectType:String):void
		{
			this._effectType = effectType;
		}
		
		public function set obstacleOnStage(onStage:Boolean):void
		{
			this._onStage = onStage;
		}
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		public function get obstacleName():String
		{
			return this._obstacleName;
		}
		public function get image():BitmapData
		{
			return this._image;
		}
		public function get effectType():String
		{
			return this._effectType;
		}
		
		public function get obstacleOnStage():Boolean
		{
			return this._onStage;
		}
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function removedFromStage(evt:Event):void
		{
			destroyMe();
		}
	}

}