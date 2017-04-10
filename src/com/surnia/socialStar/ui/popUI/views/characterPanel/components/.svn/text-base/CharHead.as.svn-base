package com.surnia.socialStar.ui.popUI.views.characterPanel.components 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class CharHead extends MovieClip
	{		
		private var _charAvatar:MovieClip;	
		private var _charMale:AvatarHeadMale;
		private var _charFemale:AvatarHeadFemale;
		
		private var _definition:String;
		private var _gender:String;
		public function CharHead(definition:String, gender:String) 
		{
			_definition = definition;
			_gender = gender;
			
			remove();
			intialization();
			display();
			
			//this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		public function onRemove(e:Event):void {			
			remove();
		}
		
		private function intialization():void {
			_charAvatar = selectGender(_gender);		
			_charAvatar.setType = String(_definition);
			_charAvatar.scaleX = .5;
			_charAvatar.scaleY = .5;							
		}
		
		private function selectGender(gender:String):MovieClip {
			var _genderHead:MovieClip;
			
			//test
			//gender = "Female";		
			
			if (gender == "Male") {
				_genderHead = new AvatarHeadMale;	
			}
			else {
				_genderHead = new AvatarHeadFemale;
			}
			
			return _genderHead;
		}
		
		public function display():void {
			//remove();		
			_charAvatar.x = 0;
			_charAvatar.y = 0;
			addChild(_charAvatar);			
		}
		
		public function remove():void {
			if (_charAvatar != null) {
				if (this.contains(_charAvatar) ) {
					removeChild(_charAvatar);	
					_charAvatar = null;					
					trace("CLEAN :", this);
				}
			}			
		}
	}

}