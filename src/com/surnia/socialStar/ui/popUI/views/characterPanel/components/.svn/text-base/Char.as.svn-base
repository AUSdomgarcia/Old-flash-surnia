package com.surnia.socialStar.ui.popUI.views.characterPanel.components 
{
	
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.BossAvatar.BossAvatarMain;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author DF
	 */
	public class Char extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES
		 * ----------------------------------------------------------------------------------------------------------*/
		
		//public var avatar:AvatarMale;
		public var avatar:MovieClip;
		public var hitBox:MovieClip;
		
		//character
		public var definition:String;
		public var index:int;
		public var charExp:int;	
		public var charGender:String;
		public var charLevel:int;
		public var charName:String;
		public var charCondition:int;
		
		public var charActing:int;
		public var charAttraction:int;	
				
		public var charGrade:int;
		public var charHealth:int;
		public var charIntelligence:int;
				
		public var charPopular:int;
		public var charSing:int;
		public var charStress:int;	
		
		public var charID:String;
		
		public var isNPC:Boolean = false;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR
		 * ----------------------------------------------------------------------------------------------------------*/
		public function Char(_definition:String = "01",_charExp:int = 1,_charGender:String = "Male",_charLevel:int = 1,_charName:String = "NoName",_charStress:int = 1,_charActing:int = 1,_charAttraction:int = 1,_charCondition:int = 1,_charGrade:int = 1,_charHealth:int = 1,_charIntelligence:int = 1,_charPopular:int = 1,_charSing:int = 1,id:String = "1")
		{			
			definition = _definition;		
			charID = id;
			charExp 	= _charExp;	
		    charGender  = _charGender;
			charLevel	= _charLevel;
			charName 	= _charName;
			charCondition = _charCondition;
			
			charGrade 		 = _charGrade;
			
			charPopular		 = _charPopular;
			charStress		 = _charStress;
			charHealth		 = _charHealth;
			charSing 		 = _charSing;
			charIntelligence = _charIntelligence;
			charActing 		= _charActing;
			charAttraction  = _charAttraction;
			
			avatar = selectGender(charGender);			
			
			avatar.indexnum = index;	
			avatar.setType = String(definition);		
			display();	
			
			//this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS
		 * ----------------------------------------------------------------------------------------------------------*/
		private function display():void {
			if(avatar != null){
				addChild(avatar);
			}
		}
		
		public function remove():void {
			if (avatar != null) {
				if (this.contains(avatar)) {
					removeChild(avatar);
					avatar = null;
					trace("CLEAN :", this);
				}
			}
		}
		
		private function selectGender(gender:String):MovieClip {
			var _genderChar:MovieClip;
			
			//test
			//gender = "Female";
			
			if (isNPC == false) {		
				if (gender == "Male") {
					_genderChar = new MiniGameMale;
				}
				else {
					_genderChar = new MiniGameFemale;
				}
			}
			else {
				//PREPARE SWITCH FOR RIVAL
				/*
				switch(gender) {
					case "Male":
						_genderChar = new RIVALMALE;
					break;
					case "Female":
						_genderChar = new RIVALFEMALE;
					break;				
				}
				*/
			}
			return _genderChar;
		}
		
		public function updateAvatar():void {		
			avatar.gotoAndStop(1);
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER AND GETTER
		 * ----------------------------------------------------------------------------------------------------------*/
		public function setRivalAvatar(val:Boolean = true):void {
			isNPC = val;
			remove();
			
			avatar = selectGender(charGender);
			avatar.setType = String(definition);
			display();
		}
		
		public function setBossNPC(type:int = 0, scalex:Number = 1, scaley:Number = 1):void {
			remove();			
			if (type > 2) {
				type = 2;
			}
			var _boss:BossAvatarMain = new BossAvatarMain(type, scalex, scaley);
			avatar = _boss;		
			
			//temporary positioning
			setBossPosition(type);			
			display();
		}
		
		//temporary positioning
		private function setBossPosition(bossID:int = 0):void {
			
			switch(bossID) {
				case 0:
					avatar.x = -80;
					avatar.y = -150;
				break;
				case 1:
					avatar.x = -80;
					avatar.y = -170;
				break;
				case 2:
					avatar.x = -90;
					avatar.y = -170;
				break;
			}		
		}
		
		public function get indexChar():int {
			return index;
		}
		
		public function get charDefinition():String {		
			return  definition;
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLERS
		 * ----------------------------------------------------------------------------------------------------------*/
		public function onRemove(e:Event):void {			
			remove();
		}		
	}

}