package com.surnia.socialStar.views.nodes.event
{
	import flash.events.Event;

	public class CharacterNodeEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const CHARACTER_CLICK:String = "onCharacterClick";
		public static const CHARACTER_TRAININGDONE:String = "onCharacterTrainingDone";
		public static const CHARACTER_STRESSEVENTDONE:String = "onCharacterStressDone";
		public static const CHARACTER_CRYINGEVENTDONE:String = "onCharacterCryingDone";
		public static const CHARACTER_PROGRESSBAREVENTDONE:String = "onProgressBarDone";
		public static const CHARACTER_RESTTIMERDONE:String = "onRestTimerDone";
		public static const CHARACTER_AVATARUI_SHOW:String = "onAvatarUIShow";
		public static const CHARACTER_AVATARUI_HIDE:String = "onAvatarUIHide";
		
		public static const CHARACTER_RESTINGDONE:String = "onRestingDone";
		
		public static const CHARACTER_PROGRESSBAR:String = "onAddProgressBar";
		
		public function CharacterNodeEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}