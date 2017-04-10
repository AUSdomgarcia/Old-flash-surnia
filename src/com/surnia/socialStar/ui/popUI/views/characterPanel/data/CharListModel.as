package com.surnia.socialStar.ui.popUI.views.characterPanel.data 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.Char;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.event.CharacterPanelEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author DF
	 */
	public class CharListModel extends Sprite
	{		
		
		/*------------------------------------------------------------------------------------------------------------
		*												VARIABLES	
		* ----------------------------------------------------------------------------------------------------------*/
		//character
		public var charName:Array = [];
		public var charGender:Array = [];
		public var charCondition:Array = [];
		public var charDefinition:Array = [];
		public var charActing:Array = [];
		public var charAttraction:Array = [];		
		public var charExp:Array = [];		
		public var charGrade:Array = [];
		public var charHealth:Array = [];
		public var charIntelligence:Array = [];
		public var charLevel:Array = [];		
		public var charPopular:Array = [];
		public var charSing:Array = [];
		public var charStress:Array = [];	
		public var charID:Array = [];
		
		public var charAvatar:Array = [];
		
		public var runingOn:String = "StandAlone";
		private var _gd:GlobalData = GlobalData.instance;
		/*------------------------------------------------------------------------------------------------------------
		*												CONSTRUCTOR	
		* ----------------------------------------------------------------------------------------------------------*/
		public function CharListModel() 
		{			
			runingOn = Capabilities.playerType;	
			
			if (runingOn != 'StandAlone') {
				//ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, _gd.absPath + "characters/charlist");
				//EventSatellite.getInstance().addEventListener(SSEvent.CHARLISTXML_LOADED, onXMLLoadedCharData);	
				updateCharacterData();				
			}
			else {
				//status = "You are OFFLINE VERSION!!!";	
				
				ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA, "charlist.xml");
				EventSatellite.getInstance().addEventListener(SSEvent.CHARLISTXML_LOADED, onXMLLoadedCharData);				
			}
			
		}
		
		/*------------------------------------------------------------------------------------------------------------
		*												METHODS
		* ----------------------------------------------------------------------------------------------------------*/
		public function updateCharacterData():void { 	
			trace ("laoded" );
			trace(this, "GlobalData.instance.charListDataArray.length ", GlobalData.instance.charListDataArray.length, " ", charDefinition.length );
			
			if(GlobalData.instance.charListDataArray.length == 0){
				for (var j:int = 0; j < charDefinition.length; j++ ) {				
					charAvatar.push(new Char(charDefinition[j],charExp[j],charGender[j],charLevel[j],charName[j],charStress[j],charActing[j],charAttraction[j],charCondition[j],charGrade[j],charHealth[j],charIntelligence[j],charPopular[j],charSing[j], charID[i]));
					
				}	
			}
			else {
				for (var i:int = 0; i < GlobalData.instance.charListDataArray.length; i++ ) {
					//charExp[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_EXPERIENCE];
					charGender[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GENDER];
					charLevel[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_LEVEL];					
					charName[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_NAME];
					charDefinition[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_DEFINITION];
					charGrade[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GRADE];
					charCondition[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_CONDITION];
					charID[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_ID];
					
					charStress[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_STRESS];	
					charPopular[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_POPULAR] ;
					
					charActing[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_ACTING] * .01;
					charAttraction[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_ATTRACTION] * .01;					
					charHealth[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_HEALTH] * .01;
					charIntelligence[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_INTELLIGENCE] * .01;						
					charSing[i] = GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_SING] * .01;	
					
					trace(this, "RETURN GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_NAME]:", GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_NAME]);
					trace(this, "RETURN GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GENDER]:", GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GENDER] );
					charAvatar.push(new Char(charDefinition[i],charExp[i],charGender[i],charLevel[i],charName[i],charStress[i],charActing[i],charAttraction[i],charCondition[i],charGrade[i],charHealth[i],charIntelligence[i],charPopular[i],charSing[i], charID[i]));				
				}
			}
			this.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.LOAD_COMPLETE));			
		}
		
		public function dispatchCharLoadComplete():void {
			this.dispatchEvent(new CharacterPanelEvent(CharacterPanelEvent.LOAD_COMPLETE));	
		}
		
		//REMOVE LISTENERS
		public function removeListener():void {
			EventSatellite.getInstance().removeEventListener(SSEvent.CHARLISTXML_LOADED, onXMLLoadedCharData);		
		}
		
		/*------------------------------------------------------------------------------------------------------------
		*												EVENT HANDLER METHODS	
		* ----------------------------------------------------------------------------------------------------------*/
		private function onXMLLoadedCharData(e:SSEvent):void {
			updateCharacterData();			
		}	
		
		
	}
	
}