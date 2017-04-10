package com.surnia.socialStar.minigames.components.avatar 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.minigames.components.emotion.MiniGame_Emotion;
	import com.surnia.socialStar.minigames.components.portrait.MiniGame_Portrait;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author Droids
	 */
	public class Avatar extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		public static const FINISH_ANIMATION_LOOP:String="FinishAnimationLoop";
		/*-----------------------------------------------Properties--------------------------------------------------*/
		//private var _character:character;
		private var _character:AvatarMale;
		private var _characterDifinition:String;
		public var avatarEvent:EventDispatcher;
		public var ymov:Number;
		public var xmov:Number;
		public var accel:Number;
		public var gravity:Number;
		public var jumpState:Boolean;
		public var accelState:Boolean;
		public var isPlayer:Boolean;
		public var portrait:MiniGame_Portrait;
		public var emotion:MiniGame_Emotion;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function Avatar(characterDefinition:String, gender:int) 
		{
			init(characterDefinition, gender);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init(characterDefinition:String, gender:int):void
		{
			this.avatarEvent = new EventDispatcher();
			this._characterDifinition = characterDefinition;
			//this._character = new character();
			if(gender==0)
			{
				this._character = new AvatarMale();
			}
			else if(gender==1)
			{
				//this._character = new AvatarFemale();
			}
			this.addChild(this._character);
			//this._character.scaleX *= -1;
			this._character.x = 30;
			this._character.y = 110;
			this.ymov=0;
			this.xmov=0;
			this.jumpState=false;
			//this._character.addEventListener("ready2", loaded);
			
			this._character.setType = this._characterDifinition;
			//this._character.addEventListener("loopdone", loopDone);
			this._character.addEventListener("loopend", loopDone);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
		}
		private function destroyMe(evt:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroyMe);
			this._character.removeEventListener("ready2", loaded);
			//this._character.removeEventListener("loopdone", loopDone);
			this._character.removeEventListener("loopend", loopDone);
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._character=null;
			this.avatarEvent=null;
		}
		public function playAnimation(animation:String, loop:Number, orientation:int):void
		{
			if( this._character != null ){
				//this._character.runAnimation(animation, loop, true);
				this._character.runAnimation(animation, loop, orientation);
			}
		}
		public function getLastAnimation():String
		{
			return this._character.getAnimString();
		}
		public function setDefaultStand(type:String):void
		{
			this._character.defaultStand=type;
		}
		public function terminateMe():void
		{
			this._character.terminate();
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		public function set myWidth(width:Number):void
		{
			this._character.width=width;
		}
		public function set myHeight(height:Number):void
		{
			this._character.height=height;
		}
		public function set scaleX1(scaleX:Number):void
		{
			this._character.scaleX *= scaleX;
		}
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function loaded(evt:Event):void
		{
			if (this._characterDifinition!="")
			{
				this._character.setType = this._characterDifinition;
			}

		}
		private function loopDone(evt:Event):void
		{
			this.avatarEvent.dispatchEvent(new Event(FINISH_ANIMATION_LOOP));
		}
	}

}