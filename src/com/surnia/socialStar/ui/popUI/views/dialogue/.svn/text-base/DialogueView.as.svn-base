package com.surnia.socialStar.ui.popUI.views.dialogue
{
	//import com.adobe.air.filesystem.VolumeMonitor;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class DialogueView extends Sprite
	{
		private var _pm:PopUpUIManager = PopUpUIManager.getInstance();
		
		private var _dialogueMC:DialogueMC;
		private var _canClick:Boolean = false;
		
		public function DialogueView()
		{
			
		}
		
		public function init():void{
			initAsset();
			addListeners();
		}
		
		public function initAsset():void{
			_dialogueMC = new DialogueMC();
			addChild(_dialogueMC);
			_dialogueMC.textField.text = "Must dispatch a dialogue event";
		}
		
		private function addListeners():void{
			EventSatellite.getInstance().addEventListener(DialogueEvent.HOME_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.FRIEND_CHALLENGE_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.FRIEND_VISIT_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.SERVER_CALL_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.NPC_VISIT_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.NPC_CHALLENGE_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().addEventListener(DialogueEvent.CHARACTER_TRAINING_DIALOGUE, onChangeDialogue);	
			EventSatellite.getInstance().addEventListener(DialogueEvent.CHARACTER_RESTING_DIALOGUE, onChangeDialogue);	
			
			_dialogueMC.addEventListener(MouseEvent.CLICK, onDialogueClick);
		}
		
		public function removeListeners():void{
			EventSatellite.getInstance().removeEventListener(DialogueEvent.HOME_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.FRIEND_CHALLENGE_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.FRIEND_VISIT_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.SERVER_CALL_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.NPC_VISIT_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.NPC_CHALLENGE_DIALOGUE, onChangeDialogue );
			EventSatellite.getInstance().removeEventListener(DialogueEvent.CHARACTER_TRAINING_DIALOGUE, onChangeDialogue);
			EventSatellite.getInstance().removeEventListener(DialogueEvent.CHARACTER_RESTING_DIALOGUE, onChangeDialogue);
			
			_dialogueMC.removeEventListener(MouseEvent.CLICK, onDialogueClick);
		}
		
		private function onDialogueClick(ev:MouseEvent):void{
			if (_canClick == true){
				_pm.removeWindow(WindowPopUpConfig.DIALOGUE_WINDOW);
			}
		}
		
		private function onChangeDialogue(ev:DialogueEvent):void{
			switch(ev.type)
			{
				case DialogueEvent.FRIEND_CHALLENGE_DIALOGUE:
				{
					trace( "challenge!!!!!!!!!!!!!!" );
					_dialogueMC.textField.text = GlobalData.instance.friendChallengeDialogue;										
					break;
				}
					
				case DialogueEvent.FRIEND_VISIT_DIALOGUE:
				{
					trace( "visit!!!!!!!!!!!!!!!!!!!!!!!" );
					_dialogueMC.textField.text = GlobalData.instance.friendVisitDialogue;
					break;
				}
				
				case DialogueEvent.HOME_DIALOGUE:
				{
					trace( "bo back home!!!!!!!!!!!!!!!!!!!!" );
					_dialogueMC.textField.text = GlobalData.instance.returnHomeDialogue;
					break;
				}
				
				case DialogueEvent.SERVER_CALL_DIALOGUE:
				{
					trace( "call server dialogue!!!!!!!!!!!!!!!!!!!!" );
					_dialogueMC.textField.text = GlobalData.instance.serverCallDialogue;
					break;
				}
				
				case DialogueEvent.NPC_VISIT_DIALOGUE:
				{					
					_dialogueMC.textField.text = GlobalData.instance.npcVisitDialogue;
					break;
				}
				
				case DialogueEvent.CHARACTER_TRAINING_DIALOGUE:
				{					
					_dialogueMC.textField.text = GlobalData.instance.characterTrainingDialogue;
					_canClick = true;
					break;
				}
					
				case DialogueEvent.CHARACTER_RESTING_DIALOGUE:
				{					
					_dialogueMC.textField.text = GlobalData.instance.characterRestingDialogue;
					_canClick = true;
					break;
				}	
					
				case DialogueEvent.CUSTOM_DIALOGUE:
				{	
					_dialogueMC.textField.text = ev.params.text;
					break;
				}	
					
			}
		}
	}
}