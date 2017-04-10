package com.surnia.socialStar.ui.popUI.views.dialogue.event
{
	import flash.events.Event;

	public class DialogueEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const HOME_DIALOGUE:String = "onHomeDialogue";
		public static const FRIEND_VISIT_DIALOGUE:String = "onFriendVisitDialogue";
		public static const FRIEND_CHALLENGE_DIALOGUE:String = "onFriendChallengeDialogue";
		public static const NPC_VISIT_DIALOGUE:String = "onNpcVisitDialogue";
		public static const NPC_CHALLENGE_DIALOGUE:String = "onNpcChallengeDialogue";
		public static const SERVER_CALL_DIALOGUE:String = "onServerCallDialogue";
		public static const CHARACTER_TRAINING_DIALOGUE:String = "onCharacterTrainingDialogue";
		public static const CHARACTER_RESTING_DIALOGUE:String = "onCharacterRestingDialogue";
		public static const CUSTOM_DIALOGUE:String = "onCustomDialogue";
		
		public function DialogueEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}