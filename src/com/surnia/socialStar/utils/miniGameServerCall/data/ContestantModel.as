package com.surnia.socialStar.utils.miniGameServerCall.data 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ContestantModel 
	{
		
		/*
		  myPlayer.name ="Drew" //CharacterName
			myPlayer.gender =0; //0-male 1-female
			myPlayer.characterId = "PlayerCharID";
			myPlayer.myFacebookID="";
			myPlayer.isPlayer = true; //is Current Player
			myPlayer.popularity=10;
			myPlayer.stress=10;
			myPlayer.health=10;
			myPlayer.singing=10;
			myPlayer.inteligence=10;
			myPlayer.acting=10;
			myPlayer.attraction=10;
			myPlayer.strength=10;

		  
		  
		 */ 
		
		public var name:String;
		public var gender:String;
		public var characterId:String;
		public var myFacebookID:String;
		public var isPlayer:String;
		public var popularity:String = 10;
		public var stress:String;
		public var health:String;
		public var singing:String;
		public var inteligence:String;
		public var acting:String;
		public var attraction:String;
		public var strength:String = 10;		 
		public var dna:String;
		
		
		public function ContestantModel() 
		{
			
		}
		
	}

}