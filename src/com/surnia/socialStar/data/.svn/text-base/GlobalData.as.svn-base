package com.surnia.socialStar.data
{
	import com.surnia.socialStar.quest.Model.QuestData;
	import com.surnia.socialStar.ui.popUI.itemShopUI.data.ItemStructureData;
	import com.surnia.socialStar.utils.ai.Grid;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * 
	 * This the main data repository for the 
	 * application 
	 * 
	 * @author hedrick david
	 * 
	 */
	
	public class GlobalData
	{	
		// universal iso room pathgrid
		public var pathGrid:Grid;
	
		public var absPath:String;
		public var domain:String;
		public var screenWidth:int;
		public var screenHeight:int;
		public var offsetWidth:int;
		public var offsetHeight:int;
		public var screenMode:String;
		
		public var isDebug:Boolean = false;
		public var islocal:Boolean = false;
		
		public var shopBtnXyPos:Point;
		
		public var CELL_SIZE:int = 36;
		
		/*rows*/
		//public var GRID_WIDTH:int = 10;
		//cols
		//public var GRID_LENGTH:int= 10;
		
		public var GRID_HEIGHT:int = 0;
		
		public var MAX_ZOOM_OUT:Number = 1;
		public var MAX_ZOOM_IN:Number = 1.3;
		
		//GAME OFFICIAL SCREEN SIZE
		public static const GAME_WIDTH:Number = 760;
		public static const GAME_HEIGHT:Number = 630;
		public static const WINDOW_DELAY_TIME:Number = 2;
		
		public var showVisitingReward:Boolean = false;
		
		//GUI positions
		public var levelMCPos:Point = new Point( 0,0 );
		
		
		//MINI GAME OFFICIAL SCREEN SIZE
		public static const MINI_GAME_WIDTH:Number = 646;
		public static const MINI_GAME_HEIGHT:Number = 460;
		
		// set office view constants
		public static const VIEW_FRIEND:String = "friendView";
		public static const VIEW_HOME:String = "homeView";
		
		public static const ITEMCATEGORY_STAFF:String = "staff";
		public static const ITEMCATEGORY_TRAINING:String = "training";
		public static const ITEMCATEGORY_MACHINE:String = "machine";
		public static const ITEMCATEGORY_DECO:String = "deco";
		public static const ITEMCATEGORY_TILE:String = "tile";
		public static const ITEMCATEGORY_EXPANSION:String = "expansion";
		public static const ITEMCATEGORY_POWER:String = "power";
		
		public static const ITEMTYPE_STAFF_INCOME:String = "income";
		public static const ITEMTYPE_STAFF_FIRE:String = "fire";
		public static const ITEMTYPE_STAFF_HIRE:String = "hire";
		
		public static const ITEMCATEGORY_TRAINING_HEALTH:String = "health";
		public static const ITEMCATEGORY_TRAINING_SING:String = "sing";
		public static const ITEMCATEGORY_TRAINING_INT:String = "intelligent";
		public static const ITEMCATEGORY_TRAINING_ACTING:String = "acting";
		public static const ITEMCATEGORY_TRAINING_ATTRACTION:String = "attraction";
		
		public static const ITEMTYPE_MACHINE_REST:String = "rest";
		public static const ITEMTYPE_MACHINE_INCOME:String = "income";
		
		public static const ITEMTYPE_DECO_WATER:String = "water";
		public static const ITEMTYPE_DECO_DOOR:String = "door";
		public static const ITEMTYPE_DECO_TABLE:String = "table";
		public static const ITEMTYPE_DECO_WINDOW:String = "window";
		
		public static const ITEMTYPE_TILE_TILE:String = "tile";
		public static const ITEMTYPE_TILE_WALL:String = "wall";
		
		public static const ITEMTYPE_EXPANSION_EXPANSION:String = "expansion";
		
		public static const ITEMTYPE_POWER_AP:String = "ap";
		public static const ITEMTYPE_POWER_COIN:String = "coin";
		
		// Gender
		
		public static const GENDER_MALE:int = 1;
		public static const GENDER_FEMALE:int = 0;
		
		/**
		 * Visibility Constants
		 */
		
		public static const VISIBLE_ON:Boolean = true;
		public static const VISIBLE_OFF:Boolean = false;
		public static const TWEEN_ON:Boolean = true;
		public static const TWEEN_OFF:Boolean = false;
		
		/**
		 * Constants Used for the character animation
		 */	
		
		// for office
		public static const PLAYER_STAND:String = "stand";
		public static const PLAYER_WALK:String = "walk";
		
		public static const CASHITEM_COWBOYREADY:String = "cowboyready";
		public static const CASHITEM_KAREADY:String = "karateready";
		public static const CASHITEM_CHEERER:String = "cheerer";
		
		public static const CASHITEM_MJ1:String = "mj1";
		public static const CASHITEM_MJ2:String = "mj2";
		public static const CASHITEM_MJ3:String = "mj3";
		
		public static const PLAYER_MOTIONSTRENGTH:String = "motionstrength";
		public static const PLAYER_MOTIONACTING:String = "motionacting";
		public static const PLAYER_MOTIONINTEL:String = "motionintel";
		public static const PLAYER_MOTIONATTRACT:String = "motionattract";
		public static const PLAYER_MOTIONSINGING:String = "motionsinging";
		public static const PLAYER_MOTIONGAMEPLAY:String = "motionplay";
		
		// for minigames
		public static const PLAYER_READY:String = "racereadyplayer";
		public static const PLAYER_RUN:String = "racerunplayer";
		public static const PLAYER_JUMP:String = "racejumpplayer";
		public static const PLAYER_CRY:String = "racejumpcry";
		public static const PLAYER_FALL:String = "racefall";
		public static const PLAYER_LOSE:String = "raceloseplayer";
		public static const PLAYER_WIN:String = "racewinplayer";
		
		public static const RIVAL_READY:String = "racereadyrival";
		public static const RIVAL_RUN:String = "racerunrival";
		public static const RIVAL_JUMP:String = "racejumprival";
		public static const RIVAL_CRY:String = "racejumprivalcry";
		public static const RIVAL_FALL:String = "racerivalfall";
		public static const RIVAL_LOSE:String = "raceloserival";
		public static const RIVAL_WIN:String = "racewinrival";
		
		// for new miniGame
		public static const PLAYER_SING_ROCK:String = "motionsingrockplayer";
		public static const PLAYER_SING_NORMAL:String = "motionsingnormalplayer";
		public static const PLAYER_SING_EXTREME:String = "motionsingextremeplayer";
		public static const PLAYER_SING_AUDIENCE:String = "motionsingaudienceplayer";
		public static const PLAYER_SING_INSTRUMENT:String = "motionsinginstrumentplayer";
		public static const PLAYER_SING_EMPATHY:String = "motionsingempathyplayer";
		
		public static const RIVAL_SING_ROCK:String = "motionsingrockrival";
		public static const RIVAL_SING_NORMAL:String = "motionsingnormalrival";
		public static const RIVAL_SING_EXTREME:String = "motionsingextremerival";
		public static const RIVAL_SING_AUDIENCE:String = "motionsingaudiencerival";
		public static const RIVAL_SING_INSTRUMENT:String = "motionsinginstrumentrival";
		public static const RIVAL_SING_EMPATHY:String = "motionsingempathyrival";
		
		
		// Character expression states
		
		public static const CHARACTER_EXPRESSION_CRY:String = "cry";
		public static const CHARACTER_EXPRESSION_NORMAL:String = "normal";
		public static const CHARACTER_EXPRESSION_STRESSED:String = "stressed";
		
		
		
		// Character action states. Used for when the progress bar is loaded
		
		public static const CHARACTER_ACTION_WALKING:String = "characterWalking";
		public static const CHARACTER_ACTION_IDLE:String = "characterIdle";
		public static const CHARACTER_ACTION_TRAINING:String = "characterTraining";
		public static const CHARACTER_ACTION_SOOTHING:String = "characterSoothing";
		public static const CHARACTER_ACTION_RESTING:String = "characterRest";
		public static const CHARACTER_ACTION_STRESSDOWN:String = "characterStressDown";
		public static const CHARACTER_ACTION_VISITREWARD:String = "characterVisitReward";
		public static const CHARACTER_ACTION_CHALENGEREWARD:String = "characterChallengeReward";
		public static const CHARACTER_ACTION_REVENGEREWARD:String = "characterRevengeReward";
		public static const CHARACTER_ACTION_MOVE:String = "characterMove";
		
		public static const CHARACTER_ACTION_HEALTHBONUS:String = "characterHealthUp";
		public static const CHARACTER_ACTION_SINGBONUS:String = "characterSingUp";
		public static const CHARACTER_ACTION_ATTRACTIONBONUS:String = "characterAttractionUp";
		public static const CHARACTER_ACTION_ACTIONBONUS:String = "characterActionUp";
		public static const CHARACTER_ACTION_INTBONUS:String = "characterIntUp";
		
		public static const CHARACTER_ACTION_HEALTHLEVELUP:String = "characterHealthLevelUp";
		public static const CHARACTER_ACTION_SINGLEVELUP:String = "characterSingLevelUp";
		public static const CHARACTER_ACTION_ATTRACTIONLEVELUP:String = "characterAttractionLevelUp";
		public static const CHARACTER_ACTION_ACTIONLEVELUP:String = "characterActionLevelUp";
		public static const CHARACTER_ACTION_INTLEVELUP:String = "characterIntLevelUp";
		
		public static const CONTESTANT_MALE:String = "Male";
		public static const CONTESTANT_FEMALE:String = "Female";
		
		/**
		 * Constants Used for the player status 
		 */		
		
		public static const VERTICAL:int = 0;
		public static const HORIZONTAL:int = 1;
		
		public static const COIN:int = 0;
		public static const STARPOINT:int = 1;
		public static const AP:int = 2;
		public static const LEVEL:int = 3;
		public static const TICKET:int = 4;
		public static const HOTPOINT:int = 5;
		public static const EXPERIENCE:int = 6;
		public static const REDSTARLVL:int = 7;
		public static const BLACKSTARLVL:int = 8;
		public static const REDSTAREXP:int = 9;
		public static const BLACKSTAREXP:int = 10;
		public static const REDSTAR:int = 11;
		public static const BLACKSTAR:int = 12;
		public static const HELPINGENERGY:int = 13;
		public static const CHARACTERHIRED:int = 14;
		public static const CHARACTERLIMIT:int = 15;
		public static const TIMER:int = -1;
		
		public static const COIN_LIMIT:int = 0;
		public static const AP_LIMIT:int = 1;
		public static const LEVEL_LIMIT:int = 2;
		public static const TICKET_LIMIT:int = 3;
		public static const HOTPOINT_LIMIT:int = 4;
		public static const EXPERIENCE_LIMIT:int = 5;	
		public static const REDSTAR_LEVELLIMIT:int = 6;
		public static const BLACKSTAR_LEVELLIMIT:int = 7;
		public static const REDSTAR_EXPLIMIT:int = 8;
		public static const BLACKSTAR_EXPLIMIT:int = 9;
		
		/**
		 * Constants used for types of data. 
		 */
		
		public static const FRIENDS_DATA:String = "friendsData";
		public static const OFFICESTORE_DATA:String = "officeStoreData";
		public static const CLOTHESSTORE_DATA:String = "clothesStoreData";
		public static const OFFICEINVENTORY_DATA:String = "officeInventoryData";
		public static const CLOTHESINVENTORY_DATA:String = "clothesInventoryData";
		public static const OFFICE_DATA:String = "officeData";
		public static const PLAYER_DATA:String = "playerData";
		public static const CREATECHAR_DATA:String = "characterData";
		public static const CLASSPRICE_DATA:String = "classPriceData";
		public static const CHARSHOP_DATA:String = "characterShopData";
		public static const CHARLIST_DATA:String = "characterListData";
		public static const MAPBUILDING_DATA:String = "mapBuildingData";
		public static const APPSETTINGS_DATA:String = "applicationSettings";
		public static const MAPCHARLIST_DATA:String = "mapCharListData";
		public static const OFFICESTATE_DATA:String = "officeStateData";
		public static const FRIENDOFFICESTATE_DATA:String = "friendOfficeStateData";
		public static const FRIENDCHARLIST_DATA:String = "friendCharacterListData";
		public static const QUESTLIST_DATA:String = "questListData";
		public static const LEVELAPTABLE_DATA:String = "levelAPTableData";
		public static const FRIENDROUTES_DATA:String = "friendRoutesData";
		public static const COLLECTIONLIST_DATA:String = "collectionListData";
		public static const MATERIALLIST_DATA:String = "materialListData";
		public static const CHALLENGEVALUES_DATA:String = "challengeValuesData";
		
		public static const FRIENDS:int = 0;
		public static const OFFICESTORE:int = 1;
		public static const CLOTHESSTORE:int = 2;
		public static const OFFICEINVENTORY:int = 3;
		public static const CLOTHESINVENTORY:int = 4;
		public static const OFFICE:int = 5;
		public static const PLAYER:int = 6;
		public static const CREATECHAR:int = 7;
		public static const CLASSPRICE:int = 8;
		public static const CHARSHOP:int = 9;
		public static const CHARLIST:int = 10;
		public static const MAPBUILDING:int = 11;
		public static const APPSETTINGS:int = 12;
		public static const MAPCHARLIST:int = 13;
		public static const OFFICESTATE:int = 14;
		public static const FRIENDOFFICESTATE:int = 15;
		public static const QUESTLIST:int = 16;
		public static const LEVELAPTABLE:int = 17;
		public static const FRIENDROUTES:int = 18;
		public static const COLLECTIONLIST:int = 19;
		public static const MATERIALLIST:int = 20;
		public static const CHALLENGEVALUES:int = 21;
		
		/**
		 * Constants for accessing data in array. 
		 */
		
		public static const CHALLENGEVALUES_TYPE:int = 0;
		public static const CHALLENGEVALUES_DURA:int = 1;
		public static const CHALLENGEVALUES_COINCOST:int = 2;
		public static const CHALLENGEVALUES_APCOST:int = 3;
		public static const CHALLENGEVALUES_SCRIPT:int = 4;
		
		public static const MATERIALLIST_ID:int = 0;
		public static const MATERIALLIST_NAME:int = 1;
		public static const MATERIALLIST_PIC:int = 2;
		public static const MATERIALLIST_QTY:int = 3;
		
		public static const COLLECTIONLIST_ID:int = 0;
		public static const COLLECTIONLIST_CATEGORY:int = 1;
		public static const COLLECTIONLIST_ICON:int = 2;
		public static const COLLECTIONLIST_DESCRIPTION:int = 3;
		public static const COLLECTIONLIST_LVLREQ:int = 4;
		public static const COLLECTIONLIST_STACK:int = 5;
		public static const COLLECTIONLIST_FORCECRAFT:int = 6;
		public static const COLLECTIONLIST_REWARDCATEGORY:int = 7;
		public static const COLLECTIONLIST_REWARDID:int = 8;
		public static const COLLECTIONLIST_ITEM:int = 9;
		
		public static const COLLECTIONLIST_ITEMID:int = 0;
		public static const COLLECTIONLIST_ITEMICON:int = 1;
		public static const COLLECTIONLIST_ITEMCURRQUANTITY:int = 2;
		public static const COLLECTIONLIST_ITEMMAXQUANTITY:int = 3;
		public static const COLLECTIONLIST_ITEMFORCECRAFT:int = 4;
		
		public static const LEVELAPTABLE_LVL:int = 0;
		public static const LEVELAPTABLE_EXP:int = 1;
		public static const LEVELAPTABLE_AP:int = 2;
		public static const LEVELAPTABLE_STATMAXEXP:int = 3;
		
		public static const QUESTLIST_ID:int = 0;
		public static const QUESTLIST_NPCTYPE:int = 1;
		public static const QUESTLIST_COMMAND:int = 2;
		public static const QUESTLIST_CATEGORY:int = 3;
		public static const QUESTLIST_TITLE:int = 4;
		public static const QUESTLIST_NPCIMAGE:int = 5;
		public static const QUESTLIST_NPCSCRIPT:int = 6;
		public static const QUESTLIST_HINTSCRIPT:int = 7;
		public static const QUESTLIST_STARPOINTREQ:int = 8;
		public static const QUESTLIST_REWARDNPCIMAGE:int = 9;
		public static const QUESTLIST_QUESTICON:int = 10;
		public static const QUESTLIST_TYPE:int = 11;
		public static const QUESTLIST_TIMELIMIT:int = 12;
		public static const QUESTLIST_DAILYQUEST:int = 13;
		public static const QUESTLIST_REWARD:int = 14;
		public static const QUESTLIST_TERM:int = 15;
		public static const QUESTLIST_ISNEW:int = 16;
		public static const QUESTLIST_ISACCEPTED:int = 17;
		
		public static const QUESTLIST_REWARD_QID:int = 0;
		public static const QUESTLIST_REWARD_TYPE:int = 1;
		public static const QUESTLIST_REWARD_QUESTREWARD:int = 2;
		public static const QUESTLIST_REWARD_AMOUNT:int = 3;
		
		public static const QUESTLIST_TERM_ID:int = 0;
		public static const QUESTLIST_TERM_COMMAND:int = 1;
		public static const QUESTLIST_TERM_STATUS:int = 2;
		public static const QUESTLIST_TERM_AMOUNTREQUIRED:int = 3;
		public static const QUESTLIST_TERM_AMOUNTHAVE:int = 4;
		public static const QUESTLIST_TERM_OBJECTIMAGE:int = 5;
		public static const QUESTLIST_TERM_CONDITIONTEXT:int = 6;
		public static const QUESTLIST_TERM_STARPOINTREQ:int = 7;
		public static const QUESTLIST_TERM_FUNCTION:int = 8;
		
		public static const OFFICESTATE_ENTRY:int = 0;
		public static const OFFICESTATE_ITEMUSED:int = 1;
		public static const OFFICESTATE_ITEMNAME:int = 2;
		public static const OFFICESTATE_ITEMID:int = 3;
		public static const OFFICESTATE_POSITION:int = 4;
		public static const OFFICESTATE_ROTATION:int = 5;
		public static const OFFICESTATE_TYPE:int = 6;
		public static const OFFICESTATE_SUBTYPE:int = 7;
		public static const OFFICESTATE_ITEMFRAMENUMBER:int = 8;
		public static const OFFICESTATE_DIMENSION:int = 9;
		public static const OFFICESTATE_EMPTY:int = 10;
		public static const OFFICESTATE_GENDER:int = 11;
		public static const OFFICESTATE_STAFF_POS:int = 12;
		public static const OFFICESTATE_POS_STATE:int = 13;
		public static const OFFICESTATE_TRAINING_STRESS:int = 14;
		public static const OFFICESTATE_TRAINING_DURATION:int = 15;
		public static const OFFICESTATE_TRAINING_HEALTH:int = 16;
		public static const OFFICESTATE_TRAINING_SING:int = 17;
		public static const OFFICESTATE_TRAINING_INT:int = 18;
		public static const OFFICESTATE_TRAINING_ACTING:int = 19;
		public static const OFFICESTATE_TRAINING_ATTRACTION:int = 20;
		public static const OFFICESTATE_REST_STRESS:int = 21;
		public static const OFFICESTATE_REST_DURATION:int = 22;
		public static const OFFICESTATE_ITEM_COOLDOWN:int = 23;
		public static const OFFICESTATE_SELLPRICE:int = 24;
		public static const OFFICESTATE_APCOST:int = 25;
		//public static const OFFICESTATE_NPC:int = 10;
		//public static const OFFICESTATE_LEVEL:int = 12;
		//public static const OFFICESTATE_FBID:int = 13;
		//public static const OFFICESTATE_NPCID:int = 14;
		
		public static const FRIENDOFFICESTATE_ENTRY:int = 0;
		public static const FRIENDOFFICESTATE_ITEMUSED:int = 1;
		public static const FRIENDOFFICESTATE_ITEMNAME:int = 2;
		public static const FRIENDOFFICESTATE_ITEMID:int = 3;
		public static const FRIENDOFFICESTATE_POSITION:int = 4;
		public static const FRIENDOFFICESTATE_ROTATION:int = 5;
		public static const FRIENDOFFICESTATE_TYPE:int = 6;
		public static const FRIENDOFFICESTATE_SUBTYPE:int = 7;
		public static const FRIENDOFFICESTATE_ITEMFRAMENUMBER:int = 8;
		public static const FRIENDOFFICESTATE_DIMENSION:int = 9;
		public static const FRIENDOFFICESTATE_EMPTY:int = 10;
		public static const FRIENDOFFICESTATE_GENDER:int = 11;
		public static const FRIENDOFFICESTATE_STAFF_POS:int = 12;
		public static const FRIENDOFFICESTATE_POS_STATE:int = 13;
		public static const FRIENDOFFICESTATE_TRAINING_STRESS:int = 14;
		public static const FRIENDOFFICESTATE_TRAINING_DURATION:int = 15;
		public static const FRIENDOFFICESTATE_TRAINING_HEALTH:int = 16;
		public static const FRIENDOFFICESTATE_TRAINING_SING:int = 17;
		public static const FRIENDOFFICESTATE_TRAINING_INT:int = 18;
		public static const FRIENDOFFICESTATE_TRAINING_ACTING:int = 19;
		public static const FRIENDOFFICESTATE_TRAINING_ATTRACTION:int = 20;
		public static const FRIENDOFFICESTATE_REST_STRESS:int = 21;
		public static const FRIENDOFFICESTATE_REST_DURATION:int = 22;
		public static const FRIENDOFFICESTATE_ITEM_COOLDOWN:int = 23;
		public static const FRIENDOFFICESTATE_SELLPRICE:int = 24;
		public static const FRIENDOFFICESTATE_APCOST:int = 25;
		//public static const FRIENDOFFICESTATE_NPC:int = 10;
		//public static const FRIENDOFFICESTATE_LEVEL:int = 12;
		//public static const FRIENDOFFICESTATE_FBID:int = 13;
		//public static const FRIENDOFFICESTATE_NPCID:int = 14;
		
		// category constants for office store and inventory
		public static const OFFICESTORE_CATEGORY_STAFF:int = 0;
		public static const OFFICESTORE_CATEGORY_TRAINING:int = 1;
		public static const OFFICESTORE_CATEGORY_MACHINE:int = 2;
		public static const OFFICESTORE_CATEGORY_DECO:int = 3;
		public static const OFFICESTORE_CATEGORY_TILE:int = 4;
		public static const OFFICESTORE_CATEGORY_EXPANSION:int = 5;
		public static const OFFICESTORE_CATEGORY_POWER:int = 6;
		
		public static const OFFICESTORE_CATEGORY:int = 0;
		public static const OFFICESTORE_TYPE:int = 1;
		public static const OFFICESTORE_ID:int = 2;
		public static const OFFICESTORE_NAME:int = 3;
		public static const OFFICESTORE_COIN:int = 4;
		public static const OFFICESTORE_STAR:int = 5;
		public static const OFFICESTORE_SELLPRICE:int = 6;
		public static const OFFICESTORE_PNGOBJECTLINK:int = 7;
		public static const OFFICESTORE_PNGICONLINK:int = 8;
		public static const OFFICESTORE_SWFOBJECTLINK:int = 9;
		public static const OFFICESTORE_EXPIRATION:int = 10;
		public static const OFFICESTORE_FRAMENUMBER:int = 11;
		public static const OFFICESTORE_DESCRIPTION:int = 12;
		public static const OFFICESTORE_UNLOCKLEVEL:int = 13;
		public static const OFFICESTORE_ASSIGNEDNPC:int = 14;
		public static const OFFICESTORE_DIMENSION:int = 15;
		public static const OFFICESTORE_MACHINEREWARDCOIN:int = 16;
		public static const OFFICESTORE_TRAINING_STRESS:int = 17;
		public static const OFFICESTORE_TRAINING_DURATION:int = 18;
		public static const OFFICESTORE_TRAINING_HEALTH:int = 19;
		public static const OFFICESTORE_TRAINING_SING:int = 20;
		public static const OFFICESTORE_TRAINING_INT:int = 21;
		public static const OFFICESTORE_TRAINING_ACTING:int = 22;
		public static const OFFICESTORE_TRAINING_ATTRACTION:int = 23;
		public static const OFFICESTORE_REST_STRESS:int = 24;
		public static const OFFICESTORE_REST_DURATION:int = 25;
		public static const OFFICESTORE_STAFF_POSITIONS:int = 26;
		public static const OFFICESTORE_APCOST:int = 27;
		public static const OFFICESTORE_EXP:int = 28;
		//public static const OFFICESTORE_AP:int = 6;
		//public static const OFFICESTORE_ISHOT:int = 11;
		//public static const OFFICESTORE_ISNEW:int = 12;
		//public static const OFFICESTORE_COLLISION:int = 13;
		public static const OFFICESTORE_EFFECT:int = 14;
		//public static const OFFICESTORE_STACKABLE:int = 15;
		//public static const OFFICESTORE_STACKMAX:int = 16;
		//public static const OFFICESTORE_CONSUMABLE:int = 17;
		//public static const OFFICESTORE_BUILDTIME:int = 21;
		//public static const OFFICESTORE_REWARDTYPE:int = 22;
		//public static const OFFICESTORE_REWARDVALUE:int = 23;
		//public static const OFFICESTORE_TRAINING:int = 24;
		//public static const OFFICESTORE_MACHINEREWARDCOOLDOWN:int = 26;
		//public static const OFFICESTORE_ROTATABLE:int = 27;
		
		public static const OFFICEINVENTORY_CATEGORY_STAFF:int = 0;
		public static const OFFICEINVENTORY_CATEGORY_TRAINING:int = 1;
		public static const OFFICEINVENTORY_CATEGORY_MACHINE:int = 2;
		public static const OFFICEINVENTORY_CATEGORY_DECO:int = 3;
		public static const OFFICEINVENTORY_CATEGORY_TILE:int = 4;
		public static const OFFICEINVENTORY_CATEGORY_EXPANSION:int = 5;
		public static const OFFICEINVENTORY_CATEGORY_POWER:int = 6;
		
		public static const OFFICEINVENTORY_CATEGORY:int = 0;
		public static const OFFICEINVENTORY_TYPE:int = 1;
		public static const OFFICEINVENTORY_ID:int = 2;
		public static const OFFICEINVENTORY_NAME:int = 3;
		public static const OFFICEINVENTORY_COIN:int = 4;
		public static const OFFICEINVENTORY_STAR:int = 5;
		public static const OFFICEINVENTORY_AP:int = 6;
		public static const OFFICEINVENTORY_SELLPRICE:int = 7;
		public static const OFFICEINVENTORY_EXPIRATION:int = 8;
		public static const OFFICEINVENTORY_FRAMENUMBER:int = 9;
		public static const OFFICEINVENTORY_DESCRIPTION:int = 10;
		public static const OFFICEINVENTORY_ISHOT:int = 11;
		public static const OFFICEINVENTORY_ISNEW:int = 12;
		public static const OFFICEINVENTORY_COLLISION:int = 13;
		public static const OFFICEINVENTORY_EFFECT:int = 14;
		public static const OFFICEINVENTORY_STACKABLE:int = 15;
		public static const OFFICEINVENTORY_STACKMAX:int = 16;
		public static const OFFICEINVENTORY_CONSUMABLE:int = 17;
		public static const OFFICEINVENTORY_UNLOCKLEVEL:int = 18;
		public static const OFFICEINVENTORY_ASSIGNEDNPC:int = 19;
		public static const OFFICEINVENTORY_DIMENSION:int = 20;
		public static const OFFICEINVENTORY_BUILDTIME:int = 21;
		public static const OFFICEINVENTORY_REWARDTYPE:int = 22;
		public static const OFFICEINVENTORY_REWARDVALUE:int = 23;
		public static const OFFICEINVENTORY_TRAINING:int = 24;
		public static const OFFICEINVENTORY_MACHINEREWARDCOIN:int = 25;
		public static const OFFICEINVENTORY_MACHINEREWARDCOOLDOWN:int = 26;
		public static const OFFICEINVENTORY_ROTATABLE:int = 27;		
		
		// category constants for clothes store and inventory
		public static const CLOTHESSTORE_CATEGORY_NORMAL:int = 0;
		public static const CLOTHESSTORE_CATEGORY_SET:int = 1;
		public static const CLOTHESSTORE_CATEGORY_HAIRAVATAR:int = 2;
		
		public static const CLOTHESSTORE_CATEGORY:int = 0;
		public static const CLOTHESSTORE_TYPE:int = 1;
		public static const CLOTHESSTORE_GENDER:int = 2;
		public static const CLOTHESSTORE_ID:int = 3;
		public static const CLOTHESSTORE_NAME:int = 4;
		public static const CLOTHESSTORE_COINCOST:int = 5;
		public static const CLOTHESSTORE_FRAMENUMBER:int = 6;
		public static const CLOTHESSTORE_SELLPRICE:int = 7;
		public static const CLOTHESSTORE_EXPIRE:int = 8;
		public static const CLOTHESSTORE_ISHOT:int = 9;
		public static const CLOTHESSTORE_ISNEW:int = 10;
		public static const CLOTHESSTORE_EFFECT:int = 11;
		
		public static const CLOTHESINVENTORY_CATEGORY_NORMAL:int = 0;
		public static const CLOTHESINVENTORY_CATEGORY_SET:int = 1;
		public static const CLOTHESINVENTORY_CATEGORY_HAIRAVATAR:int = 2;
		
		public static const CLOTHESINVENTORY_CATEGORY:int = 0;
		public static const CLOTHESINVENTORY_TYPE:int = 1;
		public static const CLOTHESINVENTORY_GENDER:int = 2;
		public static const CLOTHESINVENTORY_ID:int = 3;
		public static const CLOTHESINVENTORY_NAME:int = 4;
		public static const CLOTHESINVENTORY_COINCOST:int = 5;
		public static const CLOTHESINVENTORY_FRAMENUMBER:int = 6;
		public static const CLOTHESINVENTORY_SELLPRICE:int = 7;
		public static const CLOTHESINVENTORY_EXPIRE:int = 8;
		public static const CLOTHESINVENTORY_ISHOT:int = 9;
		public static const CLOTHESINVENTORY_ISNEW:int = 10;
		public static const CLOTHESINVENTORY_EFFECT:int = 11;
		
		public static const FRIEND_OWN:int = 1;
		public static const FRIEND_HELPINGENERGY:int = 2;
		public static const FRIEND_FBID:int = 3;
		public static const FRIEND_LEVEL:int = 4;
		public static const FRIEND_NAME:int = 5;
		public static const FRIEND_PICLINK:int = 6;
		
		public static const STORE_CATEGORYNAME:int = 0;
		public static const STORE_CATEGORYSOURCE:int = 1;
		public static const STORE_PRODUCTNAME:int = 2;
		public static const STORE_PRODUCTPRICECOIN:int = 3;
		public static const STORE_PRODUCTPRICECREDIT:int = 4;
		public static const STORE_PRODUCTTYPE:int = 5;
		public static const STORE_PRODUCTDESCRIPTION:int = 6;
		
		public static const OFFICE_POSITION:int = 0;
		public static const OFFICE_FRAMENUMBER:int = 1;
		public static const OFFICE_CATEGORY:int = 2;
		public static const OFFICE_COLLISION:int = 3;
		public static const OFFICE_ROTATION:int = 4;
		public static const OFFICE_DIMENSION:int = 5;
		
		public static const CREATECHARACTER_PREMIUM:int = 0;
		public static const CREATECHARACTER_GENDER:int = 1;
		public static const CREATECHARACTER_NAME:int = 2;
		public static const CREATECHARACTER_DEFINITION:int = 3;
		public static const CREATECHARACTER_HEALTH:int = 4;
		public static const CREATECHARACTER_SING:int = 5;
		public static const CREATECHARACTER_ACTING:int = 6;
		public static const CREATECHARACTER_ATTRACTION:int = 7;
		public static const CREATECHARACTER_INTELLIGENCE:int = 8;
		public static const CREATECHARACTER_GRADE:int = 9;
		public static const CREATECHARACTER_SIGNATURE:int = 10;
		
		public static const CLASSPRICE_TYPE:int = 0;
		public static const CLASSPRICE_COINREQ:int = 1;
		public static const CLASSPRICE_TICKETREQ:int = 2;
		public static const CLASSPRICE_RANK:int = 3;
		
		public static const CHARSHOP_TYPE:int = 0;
		public static const CHARSHOP_ID:int = 1;
		public static const CHARSHOP_NAME:int = 2;
		public static const CHARSHOP_COIN:int = 3;
		public static const CHARSHOP_CASH:int = 4;
		public static const CHARSHOP_FRAMENUM:int = 5;
		public static const CHARSHOP_DESCRIPTION:int = 6;
		public static const CHARSHOP_HOT:int = 7;
		public static const CHARSHOP_NEW:int = 8;
		public static const CHARSHOP_EFFECT:int = 9;
		public static const CHARSHOP_GENDER:int = 10;
		
		public static const CHARLIST_MANAGER:int = 0;
		public static const CHARLIST_HEALTHTRAINER:int = 1;
		public static const CHARLIST_VOCALTRAINER:int = 2;
		public static const CHARLIST_PRIVATETEACHER:int = 3;
		public static const CHARLIST_ACTINGTEACHER:int = 4;
		public static const CHARLIST_STYLIST:int = 5;
		
		public static const BUY:int = 0;
		public static const NOTIFY:int = 1;
		public static const NEITHER:int = 2;
		
		public static const FRIENDROUTES_HELP_ENTRY:int = 0;
		public static const FRIENDROUTES_HELP_FBID:int = 1;
		public static const FRIENDROUTES_HELP_PICLINK:int = 2;
		public static const FRIENDROUTES_HELP_COUNT:int = 3;	
		public static const FRIENDROUTES_HELP_ROUTE:int = 4;
		
		public static const FRIENDROUTES_HELP_ROUTE_ISITEM:int = 0;
		public static const FRIENDROUTES_HELP_ROUTE_ID:int = 1;
		public static const FRIENDROUTES_HELP_ROUTE_POSITION:int = 2;
		public static const FRIENDROUTES_HELP_ROUTE_ACTION:int = 3;
		public static const FRIENDROUTES_HELP_ROUTE_ROUTEID:int = 4;
		
		public static const FRIENDROUTES_CHALLENGE_ENTRY:int = 0;
		public static const FRIENDROUTES_CHALLENGE_FBID:int = 1;
		public static const FRIENDROUTES_CHALLENGE_PICLINK:int = 2;
		public static const FRIENDROUTES_CHALLENGE_COUNT:int = 3;	
		public static const FRIENDROUTES_CHALLENGE_ROUTE:int = 4;
		
		public static const FRIENDROUTES_CHALLENGE_ROUTE_CHARID:int = 0;
		public static const FRIENDROUTES_CHALLENGE_ROUTE_CHALLENGERCHARID:int = 1;
		
		public static const CHARLIST_ID:int = 0;
		public static const CHARLIST_GENDER:int = 1;
		public static const CHARLIST_NAME:int = 2;
		public static const CHARLIST_DEFINITION:int = 3;
		public static const CHARLIST_HEALTH:int = 4;
		public static const CHARLIST_SING:int = 5;
		public static const CHARLIST_ACTING:int = 6;
		public static const CHARLIST_ATTRACTION:int = 7;
		public static const CHARLIST_INTELLIGENCE:int = 8;
		public static const CHARLIST_LEVEL:int = 9;
		public static const CHARLIST_GRADE:int = 10;
		public static const CHARLIST_POPULAR:int = 11;
		public static const CHARLIST_STRESS:int = 12;
		public static const CHARLIST_CONDITION:int = 13;
		public static const CHARLIST_STATUS:int = 14;
		public static const CHARLIST_TIMELEFT:int = 15;
		public static const CHARLIST_ITEMENTRYID:int = 16;
		public static const CHARLIST_POSITION:int = 17;
		public static const CHARLIST_WEARINGSPECIAL:int = 18;
		public static const CHARLIST_ACTION1:int = 19;
		public static const CHARLIST_ACTION2:int = 20;
		public static const CHARLIST_ACTION3:int = 21;
		public static const CHARLIST_STATMAXEXP:int = 22;
		public static const CHARLIST_ISNEW:int = 23;
		public static const CHARLIST_SINGING_SHOUT:int = 24;
		public static const CHARLIST_SINGING_EMPATHY:int = 25;
		public static const CHARLIST_SINGING_AUDIENCE:int = 26;
		public static const CHARLIST_SINGING_INSTRUMENT:int = 27;
		public static const CHARLIST_SINGING_EXPERFORMANCE:int = 28;
		public static const CHARLIST_ACTING_MUSICAL:int = 29;
		public static const CHARLIST_ACTING_EMOTION:int = 30;
		public static const CHARLIST_ACTING_MIME:int = 31;
		public static const CHARLIST_ACTING_COMEDY:int = 32;
		public static const CHARLIST_ACTING_ACTION:int = 33;
		public static const CHARLIST_MODELING_GROTESQUE:int = 34;
		public static const CHARLIST_MODELING_HOTPOSE:int = 35;
		public static const CHARLIST_MODELING_STICKACTION:int = 36;
		public static const CHARLIST_MODELING_BALANCE:int = 37;
		public static const CHARLIST_MODELING_POWERWALKING:int = 38;
		/*public static const CHARLIST_EXPERIENCE:int = 10;
		public static const CHARLIST_MANAGER_NPC:int = 18;
		public static const CHARLIST_MANAGER_STATE:int = 19;
		public static const CHARLIST_MANAGER_NAME:int = 20;
		public static const CHARLIST_MANAGER_LEVEL:int = 21;
		public static const CHARLIST_MANAGER_NPCFBID:int = 22;
		public static const CHARLIST_HEALTHTRAINER_NPC:int = 23;
		public static const CHARLIST_HEALTHTRAINER_STATE:int = 24;
		public static const CHARLIST_HEALTHTRAINER_NAME:int = 25;
		public static const CHARLIST_HEALTHTRAINER_LEVEL:int = 26;
		public static const CHARLIST_HEALTHTRAINER_NPCFBID:int = 27;
		public static const CHARLIST_VOCALTRAINER_NPC:int = 28;
		public static const CHARLIST_VOCALTRAINER_STATE:int = 29;
		public static const CHARLIST_VOCALTRAINER_NAME:int = 30;
		public static const CHARLIST_VOCALTRAINER_LEVEL:int = 31;
		public static const CHARLIST_VOCALTRAINER_NPCFBID:int = 32;
		public static const CHARLIST_PRIVATETEACHER_NPC:int = 33;
		public static const CHARLIST_PRIVATETEACHER_STATE:int = 34;
		public static const CHARLIST_PRIVATETEACHER_NAME:int = 35;
		public static const CHARLIST_PRIVATETEACHER_LEVEL:int = 36;
		public static const CHARLIST_PRIVATETEACHER_NPCFBID:int = 37;	
		public static const CHARLIST_ACTINGTEACHER_NPC:int = 38;
		public static const CHARLIST_ACTINGTEACHER_STATE:int = 39;
		public static const CHARLIST_ACTINGTEACHER_NAME:int = 40;
		public static const CHARLIST_ACTINGTEACHER_LEVEL:int = 41;
		public static const CHARLIST_ACTINGTEACHER_NPCFBID:int = 42;
		public static const CHARLIST_STYLIST_NPC:int = 43;
		public static const CHARLIST_STYLIST_STATE:int = 44;
		public static const CHARLIST_STYLIST_NAME:int = 45;
		public static const CHARLIST_STYLIST_LEVEL:int = 46;
		public static const CHARLIST_STYLIST_NPCFBID:int = 47;*/
		
		public static const FRIENDCHARLIST_ID:int = 0;
		public static const FRIENDCHARLIST_GENDER:int = 1;
		public static const FRIENDCHARLIST_NAME:int = 2;
		public static const FRIENDCHARLIST_DEFINITION:int = 3;
		public static const FRIENDCHARLIST_HEALTH:int = 4;
		public static const FRIENDCHARLIST_SING:int = 5;
		public static const FRIENDCHARLIST_ACTING:int = 6;
		public static const FRIENDCHARLIST_ATTRACTION:int = 7;
		public static const FRIENDCHARLIST_INTELLIGENCE:int = 8;
		public static const FRIENDCHARLIST_LEVEL:int = 9;
		public static const FRIENDCHARLIST_GRADE:int = 10;
		public static const FRIENDCHARLIST_POPULAR:int = 11;
		public static const FRIENDCHARLIST_STRESS:int = 12;
		public static const FRIENDCHARLIST_CONDITION:int = 13;
		public static const FRIENDCHARLIST_STATUS:int = 14;
		public static const FRIENDCHARLIST_TIMELEFT:int = 15;
		public static const FRIENDCHARLIST_ITEMENTRYID:int = 16;
		public static const FRIENDCHARLIST_POSITION:int = 17;
		public static const FRIENDCHARLIST_WEARINGSPECIAL:int = 18;
		public static const FRIENDCHARLIST_ACTION1:int = 19;
		public static const FRIENDCHARLIST_ACTION2:int = 20;
		public static const FRIENDCHARLIST_ACTION3:int = 21;
		public static const FRIENDCHARLIST_STATMAXEXP:int = 22;
		public static const FRIENDCHARLIST_ISNEW:int = 23;
		public static const FRIENDCHARLIST_SINGING_SHOUT:int = 24;
		public static const FRIENDCHARLIST_SINGING_EMPATHY:int = 25;
		public static const FRIENDCHARLIST_SINGING_AUDIENCE:int = 26;
		public static const FRIENDCHARLIST_SINGING_INSTRUMENT:int = 27;
		public static const FRIENDCHARLIST_SINGING_EXPERFORMANCE:int = 28;
		public static const FRIENDCHARLIST_ACTING_MUSICAL:int = 29;
		public static const FRIENDCHARLIST_ACTING_EMOTION:int = 30;
		public static const FRIENDCHARLIST_ACTING_MIME:int = 31;
		public static const FRIENDCHARLIST_ACTING_COMEDY:int = 32;
		public static const FRIENDCHARLIST_ACTING_ACTION:int = 33;
		public static const FRIENDCHARLIST_MODELING_GROTESQUE:int = 34;
		public static const FRIENDCHARLIST_MODELING_HOTPOSE:int = 35;
		public static const FRIENDCHARLIST_MODELING_STICKACTION:int = 36;
		public static const FRIENDCHARLIST_MODELING_BALANCE:int = 37;
		public static const FRIENDCHARLIST_MODELING_POWERWALKING:int = 38;
		/*public static const FRIENDCHARLIST_EXPERIENCE:int = 10;
		public static const FRIENDCHARLIST_MANAGER_NPC:int = 18;
		public static const FRIENDCHARLIST_MANAGER_STATE:int = 19;
		public static const FRIENDCHARLIST_MANAGER_NAME:int = 20;
		public static const FRIENDCHARLIST_MANAGER_LEVEL:int = 21;
		public static const FRIENDCHARLIST_MANAGER_NPCFBID:int = 22;
		public static const FRIENDCHARLIST_HEALTHTRAINER_NPC:int = 23;
		public static const FRIENDCHARLIST_HEALTHTRAINER_STATE:int = 24;
		public static const FRIENDCHARLIST_HEALTHTRAINER_NAME:int = 25;
		public static const FRIENDCHARLIST_HEALTHTRAINER_LEVEL:int = 26;
		public static const FRIENDCHARLIST_HEALTHTRAINER_NPCFBID:int = 27;
		public static const FRIENDCHARLIST_VOCALTRAINER_NPC:int = 28;
		public static const FRIENDCHARLIST_VOCALTRAINER_STATE:int = 29;
		public static const FRIENDCHARLIST_VOCALTRAINER_NAME:int = 30;
		public static const FRIENDCHARLIST_VOCALTRAINER_LEVEL:int = 31;
		public static const FRIENDCHARLIST_VOCALTRAINER_NPCFBID:int = 32;
		public static const FRIENDCHARLIST_PRIVATETEACHER_NPC:int = 33;
		public static const FRIENDCHARLIST_PRIVATETEACHER_STATE:int = 34;
		public static const FRIENDCHARLIST_PRIVATETEACHER_NAME:int = 35;
		public static const FRIENDCHARLIST_PRIVATETEACHER_LEVEL:int = 36;
		public static const FRIENDCHARLIST_PRIVATETEACHER_NPCFBID:int = 37;	
		public static const FRIENDCHARLIST_ACTINGTEACHER_NPC:int = 38;
		public static const FRIENDCHARLIST_ACTINGTEACHER_STATE:int = 39;
		public static const FRIENDCHARLIST_ACTINGTEACHER_NAME:int = 40;
		public static const FRIENDCHARLIST_ACTINGTEACHER_LEVEL:int = 41;
		public static const FRIENDCHARLIST_ACTINGTEACHER_NPCFBID:int = 42;
		public static const FRIENDCHARLIST_STYLIST_NPC:int = 43;
		public static const FRIENDCHARLIST_STYLIST_STATE:int = 44;
		public static const FRIENDCHARLIST_STYLIST_NAME:int = 45;
		public static const FRIENDCHARLIST_STYLIST_LEVEL:int = 46;
		public static const FRIENDCHARLIST_STYLIST_NPCFBID:int = 47;*/
		
		
		public static const FRIENDCHARLIST_MANAGER:int = 0;
		public static const FRIENDCHARLIST_HEALTHTRAINER:int = 1;
		public static const FRIENDCHARLIST_VOCALTRAINER:int = 2;
		public static const FRIENDCHARLIST_PRIVATETEACHER:int = 3;
		public static const FRIENDCHARLIST_ACTINGTEACHER:int = 4;
		public static const FRIENDCHARLIST_STYLIST:int = 5;
		
		public static const MAPCHARLIST_CID:int = 0;
		public static const MAPCHARLIST_HEADDEFINITION:int = 1;
		public static const MAPCHARLIST_GENDER:int = 2;
		public static const MAPCHARLIST_LEVEL:int = 3;
		public static const MAPCHARLIST_EXPERIENCE:int = 4;
		
		/**
		 * Call this constants for specific text type
		 */	
		
		public static const TFTYPE_STRESS:String = "Stress";
		public static const TFTYPE_XP:String = "XP";
		
		//public static const TEXTFIELDTYPE_EXPERIENCE:String = "XP";
		public static const TFTYPE_SING:String = "Sing";
		public static const TFTYPE_INT:String = "Intelligence";
		public static const TFTYPE_HEALTH:String = "Health";
		public static const TFTYPE_ACTING:String = "Acting";
		public static const TFTYPE_ATTRACTION:String = "Attraction";
		
		// expression textfield
		public static const TFTYPE_CRY:String = "Crying...";
		public static const TFTYPE_SOOTHED:String = "Soothed...";
		public static const TFTYPE_STREDDED:String = "Stressed...";
		public static const TFTYPE_STRESSRELIEVED:String = "Stress Relieved...";
		
		/**
		 * Call this constants to access the types of character grade
		 */		
		
		public static const CHARACTER_GRADE_POORTYPE:String = "Poor";
		public static const CHARACTER_GRADE_NORMALTYPE:String = "Normal";
		public static const CHARACTER_GRADE_GOODTYPE:String = "Good";
		public static const CHARACTER_GRADE_TALENTEDTYPE:String = "Talented";
		public static const CHARACTER_GRADE_EXCELLENTTYPE:String = "Excellent";
		
		/**
		 * Call this constants to access the types of map data in the
		 * minimap array. 
		 */		
		
		public static const MAPBUILDING_MAP_ID:int = 0;
		public static const MAPBUILDING_MAP_NAME:int = 1;
		public static const MAPBUILDING_MAP_LVREQ:int = 2;
		public static const MAPBUILDING_MAP_REQ:int = 3;
		public static const MAPBUILDING_MAP_STATUS:int = 4;
		public static const MAPBUILDING_MAP_BACKGROUND:int = 5;
		public static const MAPBUILDING_MAP_CLOUD:int = 6;
		public static const MAPBUILDING_MAP_ZONES:int = 7;
		
		/**
		 * Call this constants to access the types of zone data in the
		 * minimap array. 
		 */		
		
		public static const MAPBUILDING_ZONE_ID:int = 0;
		public static const MAPBUILDING_ZONE_NAME:int = 1;
		public static const MAPBUILDING_ZONE_LVLREQ:int = 2;
		public static const MAPBUILDING_ZONE_REQ:int = 3;
		public static const MAPBUILDING_ZONE_STATUS:int = 4;
		public static const MAPBUILDING_ZONE_NPCNAME:int = 5;
		public static const MAPBUILDING_ZONE_NPCPNG:int = 6;
		public static const MAPBUILDING_ZONE_NPCOFFSET:int = 7;
		public static const MAPBUILDING_ZONE_ZONEOFFSET:int = 8;
		public static const MAPBUILDING_ZONE_IMG0:int = 9;
		public static const MAPBUILDING_ZONE_IMG1:int = 10;
		public static const MAPBUILDING_ZONE_IMG2:int = 11;
		public static const MAPBUILDING_ZONE_BUILDINGS:int = 12;
		
		/**
		 * Call this constants to access the types of building data in the
		 * minimap array. 
		 */		
		
		public static const MAPBUILDING_BUILDING_ID:int = 0;
		public static const MAPBUILDING_BUILDING_NAME:int = 1;
		public static const MAPBUILDING_BUILDING_LVLREQ:int = 2;
		public static const MAPBUILDING_BUILDING_REQ:int = 3;
		public static const MAPBUILDING_BUILDING_STATUS:int = 4;
		public static const MAPBUILDING_BUILDING_BLDGPNG:int = 5;
		public static const MAPBUILDING_BUILDING_BLDGPNGBRIGHT:int = 6;
		public static const MAPBUILDING_BUILDING_BLDGPNGDIM:int = 7;
		public static const MAPBUILDING_BUILDING_POSITION:int = 8;
		public static const MAPBUILDING_BUILDING_TYPE:int = 9;
		public static const MAPBUILDING_BUILDING_DIFFICULTY:int = 10;
		public static const MAPBUILDING_BUILDING_DURATION:int = 11;
		public static const MAPBUILDING_BUILDING_COIN:int = 12;
		public static const MAPBUILDING_BUILDING_AP:int = 13;
		public static const MAPBUILDING_BUILDING_BOSSSCRIPT:int = 14;
		public static const MAPBUILDING_BUILDING_NPCNAME:int = 15;
		public static const MAPBUILDING_BUILDING_NPCID:int = 16;
		public static const MAPBUILDING_BUILDING_NPCLVL:int = 17;
		public static const MAPBUILDING_BUILDING_NPCGENDER:int = 18;
		public static const MAPBUILDING_BUILDING_NPCHEALTH:int = 19;
		public static const MAPBUILDING_BUILDING_NPCSING:int = 20;
		public static const MAPBUILDING_BUILDING_NPCINTELLIGENT:int = 21;
		public static const MAPBUILDING_BUILDING_NPCACTING:int = 22;
		public static const MAPBUILDING_BUILDING_NPCATTRACTION:int = 23;
		public static const MAPBUILDING_BUILDING_NPCBODYDEFINITION:int = 24;
		public static const MAPBUILDING_BUILDING_REWARDCOIN:int = 25;
		public static const MAPBUILDING_BUILDING_REWARDEXP:int = 26;
		public static const MAPBUILDING_BUILDING_ISBOSS:int = 27;
		public static const MAPBUILDING_BUILDING_CONTEST:int = 28;
		
		
		/**
		 * Call this constants to access the types of character shop data types in the
		 * array. 
		 */	
		
		public static const CHARSHOP_BODY:int = 0;
		public static const CHARSHOP_CLOTH:int = 1;
		
		//command static values
		public static const COMMAND_MOVE:String = "move";
		public static const COMMAND_ROTATE:String = "rotate";
		public static const COMMAND_SELL:String = "sell";
		public static const COMMAND_INFO:String = "info";
		public static const COMMAND_COLLECT:String = "collect";
		public static const COMMAND_REST:String = "rest";
		public static const COMMAND_CHEER:String = "cheer";
		public static const COMMAND_SOOTHE:String = "soothe";
		public static const COMMAND_SHOP:String = "shop";
		public static const COMMAND_INVENTORY:String = "inventory";
		public static const COMMAND_INVENTORY_CONTESTANT:String = "charInventory";		
		public static const COMMAND_STAFF:String = "staff";
		public static const COMMAND_TRAINING:String = "training";
		public static const COMMAND_STOP:String = "stop";
		public static const COMMAND_PLAY:String = "play";
		public static const COMMAND_FAST:String = "fast";
		public static const COMMAND_RECRUIT:String = "recruit";
		public static const COMMAND_FIRE:String = "fire";
		public static const COMMAND_ACTION1:String = "action1";
		public static const COMMAND_ACTION1_LOCK:String = "action1lock";
		public static const COMMAND_ACTION2:String = "action2";
		public static const COMMAND_ACTION2_LOCK:String = "action2lock";
		
		public static const COMMAND_STOP_RESTING:String = "stopResting";
		public static const COMMAND_MOVE_CONTESTANT:String = "moveContestant";
		
		
		// info if data are loaded
		public var playerDataLoaded:Boolean = false;
		public var friendDataLoaded:Boolean = false;
		public var storeDataLoaded:Boolean = false;
		public var officeDataLoaded:Boolean = false;
		public var characterDataLoaded:Boolean = false;
		public var classPriceDataLoaded:Boolean = false;
		public var characterShopDataLoaded:Boolean = false;
		public var characterListDataLoaded:Boolean = false;
		public var mapBuildingDataLoaded:Boolean = false;
		public var appSettingsDataLoaded:Boolean = false;
		public var mapCharListDataLoaded:Boolean = false;
		public var officeStoreDataLoaded:Boolean = false;
		public var officeInventoryDataLoaded:Boolean = false;
		public var clothesStoreDataLoaded:Boolean = false;
		public var clothesInventoryDataLoaded:Boolean = false;
		public var officeStateDataLoaded:Boolean = false;
		public var friendOfficeStateDataLoaded:Boolean = false;
		public var friendCharacterListDataLoaded:Boolean = false;
		public var questlistDataLoaded:Boolean = false;
		public var levelAPTableDataLoaded:Boolean = false;
		public var friendRoutesDataLoaded:Boolean = false;
		public var collectionListDataLoaded:Boolean = false;
		public var materialListDataLoaded:Boolean = false;
		public var challengeValuesDataLoaded:Boolean = false;
		
		public var tutorialMode:int = 0;
		
		// character random attr;
		public var randMin:Number;
		public var randMax:Number;		
		
		// Iso room grid parameters
		//public var gridSize:int = 36;
		//public var gridWidth:int = 10;
		//public var gridLength:int = 10;
		//public var gridHeight:int = 0;
		
		// staff view variables
		///public var staffDataLoaded:Boolean = false;
		
		
		// dialogue texts
		public var returnHomeDialogue:String = "Loading... Returning Home";		
		public var friendVisitDialogue:String = "Loading... Visiting Friend";
		public var friendChallengeDialogue:String = "Loading... Challenging Friend";
		public var serverCallDialogue:String = "Loading... Please wait";
		public var npcVisitDialogue:String = "Loading... Visiting Npc";
		public var npcChallengeDialogue:String = "Loading... Challenging Npc";
		public var characterTrainingDialogue:String = "Training area obstructed, pls. move the training object";
		public var characterRestingDialogue:String = "Resting area obstructed, pls. move the resting object";
		
		public var stage:Stage;
		public var GameStage:Stage;		
		
		// player information
		public var pFbid:String; // player facebookID
		public var pFname:String; // player facebook name
		public var pId:String; // player ID
		public var pCoin:int; // player coin amount
		public var pSp:int; // player starpoint
		public var pNAp:int; // player timer initial value
		public var pExp:int; // player current total experience
		public var pLvl:int; // player level
		public var pAp:int; // player action points
		public var pRSExp:int; // player red star points
		public var pBSExp:int; // player black star points
		public var pRSLvl:int; // player red star level
		public var pBSLvl:int; // player black star level
		public var pHE:int; // player helping energy
		public var pSDP:int = 5; // player friend stress down point
		public var pChAmt:int = 0; // player character hired
		
		// Office state row, column, wall and tile frame numbers		
		public var officeStateWallID:String;
		public var wallImageRight:String= "";
		public var wallImageRightName:String = "";
		public var wallImageLeft:String = "";
		public var wallImageLeftName:String = "";
		public var expansion:int = 10;
		
		public var tileImage:String = "w";
		public var tileImageName:String = "w";
		
		public var officeStateTileID:String;
		public var officeStateWallFN:int;
		public var officeStateTileFN:int;
		
		// Friend office state row, column, wall and tile frame numbers
		public var friendOfficeStateWallID:String;
		public var friendOfficeStateTileID:String;
		//public var friendOfficeRow:int = 10;
		//public var friendOfficeColumn:int = 10;
		public var friendOfficeStateWallFN:int;
		public var friendOfficeStateTileFN:int;
		public var friendExpansion:int;
		
		// player settings pertaining to background music, sound effects and graphics quality
		public var appBGM:int;
		public var appSFX:int;
		public var appGFX:int;
		
		// status array limits
		public var experienceTable:Array = [];
		public var apTable:Array = [];
		
		// status limits
		public var coinLimit:int = 99999999;
		public var starPointLimit:int = 99999999;
		public var actionPointLimit:int = 20;
		public var levelLimit:int = 30;
		public var ticketLimit:int = 2000;
		public var hotPointLimit:int = 100;
		public var experienceLimit:int = 1000;
		public var redStarLvlLim:int = 100;
		public var blackStarLvlLim:int = 100;
		public var redStarExpLimit:int = 100;
		public var blackStarExpLimit:int = 100;
		public var characterLimit:int = 3;
		
		public var friendView:Boolean = false;
		public var npcView:Boolean;
		public var isNpcTabSelected:Boolean;
		
		public var lastCharacterClicked:CharacterNode;
		public var characterRandomMovementDegree:int = 4;
		
		/*--------------------------edited by jc-------------------------------------------*/
		//use for storing opponent fbid when challenging friend		
		
		public var isRevenge:Boolean;
		public var isRevengeFbid:String;
		public var isRevengeCharID:String;
		
		public var selectedFriendFbId:String;
		public var selectedFriendCid:String;
		public var myFbId:String;
		public var isChallenge:Boolean = false;
		public var currentEntryId:String;
		public var currentCharId:String;
		public var currentCharNode:CharacterNode;
		public var currentIsoObjectCharId:String;
		public var currentFriendCharId:String;
		public var currentIsoObject:IsoObject;
		public var currentFriendIsoObject:IsoObject;
		public var currentOfficeSelected:*;
		public var isCharacterForcedUpdated:Boolean;
		
		//officeId for checking if you are in your own office or not. 
		//if officeId equal your fbid  = true else your in your friend
		public var officeId:String;
		public var miniGameData:Object = new Object();
		
		
		// loading checks
		public var objectsLoaded:Boolean = false;
		public var charactersLoaded:Boolean = false;
		/*--------------------------edited by jc-------------------------------------------*/
		
		/**
		 * Contains all the players friend information.
		 * Use the friends constants to access specific information
		 * in the array.
		 */		
		
		public var friendsDataArray:Array = [new Array()];
		
		/**
		 * Contains all the player's office information.
		 * Use specic store constants to access specific information
		 * in the array.
		 */	
		public var officeName:String;
		public var officeTileDataArray:Array = [new Array()];
		
		/**
		 * Contains all the store data information.
		 * Use the store constants to access specific information
		 * in the arrays.
		 */	
		
		public var storeDataArray:Array = [new Array()];
		
		/**
		 * Contains all the character data information.
		 * Use the character constants to access specific info in the array
		 */		
		
		public var characterDataArray:Array = [new Array()];
		
		/**
		 * Contains all the price data information.
		 * Use the price data constants to access specific info in the array
		 */		
		
		public var classPriceDataArray:Array = [new Array()];
		
		/**
		 * Contains all the character shop data information.
		 * Use the character shop constants to access specific info in the array
		 */	
		
		public var charShopBodyDataArray:Array = [new Array()];
		public var charShopClothDataArray:Array = [new Array()];
		
		/**
		 * Contains all the character list data information.
		 * Use the char list constants to access specific info in the array
		 */
		
		public var charListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the map building data information.
		 * Use the map building constants to access specific info in the array
		 */
		
		public var mapBlueBoxPath:String;
		public var mapRedFlag:String;
		public var mapLocking:String;
		public var mapBackNorm:String;
		public var mapBackOver:String;
		public var mapBuildingDataArray:Array = [new Array()];
		
		/**
		 * Contains all the map character list data information.
		 * Use the class price constants to access specific info in the array
		 */
		
		public var mapCharListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the office store data information.
		 * Use the office store constants to access specific info in the array
		 */
		
		public var officeStoreDataArray:Array = [new Array()];
		
		/**
		 * Contains all the office inventory data information.
		 * Use the office inventory constants to access specific info in the array
		 */
		
		public var officeInventoryDataArray:Array = [new Array()];
		
		/**
		 * Contains all the clothes store data information.
		 * Use the clothes store constants to access specific info in the array
		 */
		
		public var clothesStoreDataArray:Array = [new Array()];
		
		/**
		 * Contains all the clothes inventory data information.
		 * Use the clothes store constants to access specific info in the array
		 */
		
		public var clothesInventoryDataArray:Array = [new Array()];
		
		/**
		 * Contains all the office state data information.
		 * Use the office state to access specific info in the array
		 */
		
		public var officeStateDataArray:Array = [new Array()];
		
		/**
		 * Contains all the friend office state data information.
		 * Use the friend office state to access specific info in the array
		 */
		public var friendOfficeName:String;
		public var friendOfficeStateDataArray:Array = [new Array()];
		
		/**
		 * Contains all the friend character list data information.
		 * Use the friend character list constants to access specific info in the array
		 */
		
		public var friendCharListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the quest list data information.
		 * Use the quest list constants to access specific info in the array
		 */
		
		public var questListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the table data for the ap and level.
		 * Use the table data constants to access specific info in the array
		 */
		
		public var levelAPTableDataArray:Array = [new Array()];
		
		/**
		 * Contains all the data for the friend routes.
		 * Use the friend route constants to access specific info in the array
		 */
		
		public var friendRoutesHelpArray:Array = [];
		public var friendRoutesChallengeArray:Array = [];
		
		/**
		 * Contains all the collection list data.
		 * Use the collection list constants to access specific info in the array
		 */
		
		public var collectionListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the material list data.
		 * Use the material list constants to access specific info in the array
		 */
		
		public var materialListDataArray:Array = [new Array()];
		
		/**
		 * Contains all the challenge values data.
		 * Use the challenge values constants to access specific info in the array
		 */
		
		public var challengeValuesDataArray:Array = [new Array()];
		
		/**
		 * XML raw data from server / database. 
		 */
		
		public var friendsDataXML:XML;
		public var officeStoreDataXML:XML;
		public var clothesStoreDataXML:XML;
		public var officeInventoryDataXML:XML;
		public var clothesInventoryDataXML:XML;
		public var officeDataXML:XML;
		public var playerDataXML:XML;
		public var characterDataXML:XML;
		public var classPriceDataXML:XML; 
		public var characterShopDataXML:XML;
		public var characterListDataXML:XML;
		public var mapBuildingDataXML:XML;
		public var appSettingDataXML:XML;
		public var mapCharListDataXML:XML;
		public var officeShopDataXML:XML;
		public var officeStateDataXML:XML;
		public var friendOfficeStateDataXML:XML;
		public var friendCharacterListDataXML:XML;
		public var questListDataXML:XML;
		public var levelAPTableListDataXML:XML;
		public var friendRoutesDataXML:XML;
		public var collectionListDataXML:XML;
		public var materialListDataXML:XML;
		
		
		// friend routes
		public var totalRoute:int;
		
		public var inventoryStructure:Array;
		public var inventoryContestant:Array;
		public var inventoryDress:Array;
		public var inventoryPower:Array;
		
		//tutorial tracker		
		public var tutLabel:String;
		public var isTutorialDone:Boolean;		
		public var tutTracker:Array = new Array();
		//tutorial tracker
		
		// instance var
		private static var _instance:GlobalData;
		
		//scene data
		public var sceneData:Array = [];		
		
		//training qeuee
		public var trainingQeuee:Array = new Array();
		public var restingQeuee:Array = new Array();
		
		//miniGame 
		public var selectionProgram:String;
		
		//office object interaction mode
		public var currentInterAction:String = "";
		public var isDragging:Boolean;
		public var isValidSpace:Boolean;
		public var refreshRate:int = 10;	
		
		//for ending Quest
		public var currentCompleteQuestID:String;
		public var currentCompletedQuestData:Array = new Array();
		public var currentSelectedQuestData:QuestData;
		public var currentRewardData:RewardData;
		
		//default true
		public var onAnimateQuest:Boolean = true;
		
		//contestant price
		public var CONTESTANT_NORMAL_COIN_PRICE:int = 1000;;
		public var CONTESTANT_PREMIUM_STAR_PRICE:int = 10;
		
		
		//reward drop constants
		public static const DROP_COIN:int = 0;
		public static const DROP_AP:int = 1;
		public static const DROP_EXP:int = 2;
		public static const DROP_RED_STAR:int = 3;
		public static const DROP_BLACK_STAR:int = 4;
		
		public static var EXP_ADD_VALUE:int = 1;		
		public static var AP_MINUS_VALUE:int = 1;
		public static var AP_ADD_VALUE:int = 1;
		//public static const COIN_ADD_VALUE:int = 100;
		public static var RED_STAR_ADD_VALUE:int = 1;
		public static var BLACK_STAR_ADD_VALUE:int = 1;
		
		public var coinReward:int;
		
		//z depth values
		public static const ISO_FLOOR_DEPTH:int = 1;	
		public static const ISO_WALL_DOOR_DEPTH:int = 2;
		public static const ISO_WALL_OBJECT_DEPTH:int = 3;	
		public static const ISO_CONTESTANT_DEPTH:int = 4;
		public static const ISO_CONTESTANT_EFFECTS:int = 5;
		public static const ISO_OBJECT_DEPTH:int = 6;
		public static const ISO_ROUTE_DEPTH:int = 7;
		public static const ISO_SPECIAL_OBJECT_DEPTH:int = 8;
		public static const ISO_DRAG_OBJECT_DEPTH:int = 9;
		
		//loading external assets		
		//checks thumb images for inventory
		public var inventoryThumbImagesLoaded:Boolean;
		public var inventoryItemDataLoaded:Boolean;
		
		/**
		 *
		 * Singleton class. Access through .instance
		 *  
		 * @return GlobalData - this class as Singleton 
		 * 
		 */		
		
		public static function get instance():GlobalData{
			if(_instance == null){
				_instance = new GlobalData();
				instance.computeExperience();
				instance.computeAP();
				instance.updateStarLevelExp();
			}
			return _instance;
		}
		
		/**
		 * 
		 * Initializes the black and red star values;
		 * 
		 */		
		
		public function updateStarLevelExp():void{
			pRSLvl = Math.floor(pRSExp/ 100);
			pBSLvl = Math.floor(pBSExp/ 100);
		}
		
		
		/**
		 *	
		 * Updates the display limit.
		 * 
		 */
		
		public function updateLimit(limitType:int, value:int):void{
			switch(limitType)
			{
				case REDSTAR_LEVELLIMIT:
				{
					redStarLvlLim = value;
					break;
				}
				case BLACKSTAR_LEVELLIMIT:
				{
					blackStarLvlLim = value;
					break;
				}
				case REDSTAR_EXPLIMIT:
				{
					blackStarExpLimit = value;
					break;
				}
				case BLACKSTAR_EXPLIMIT:
				{
					blackStarExpLimit = value;
					break;
				}
			}
		}
		
		/**
		 *
		 * Computes the total experience table. 
		 * 
		 */		
		
		public function computeExperience():void{
			var a:int = 0;
			for(var x:int = 0; x<levelLimit; x++) {
				a += Math.floor(x+300*Math.pow(2, (x/7)));
				experienceTable[x] = a;
			}
		}
		
		/**
		 *
		 * Computes the total action point table. 
		 * 
		 */	
		
		public function computeAP():void{
			var a:int = 0;
			for(var x:int = 0; x<levelLimit; x++) {
				apTable[x] = 20+(int((x+1)/5)*2)
			}
		}
		
		/**
		 * @return Object - get packaged data from facebook friends 
		 * based on the facebook friend ID entered. Access the data by:
		 * .fbid - friend facebook ID.
		 * .name - friend name.
		 * .piclink - friend picture link. 
		 */		
		
		public function getFriendDataByID(fbid:String):Object{
			var data:Object = new Object();
			for (var x:int = 0; x<friendsDataArray.length; x++){
				if (friendsDataArray[x][FRIEND_FBID] == fbid){
					data.fbid = friendsDataArray[x][FRIEND_FBID];
					data.name = friendsDataArray[x][FRIEND_NAME];
					data.piclink = friendsDataArray[x][FRIEND_PICLINK];
					return data;
					break;
				}
			}
			return data;
		}
		
		/**
		 * @return Object - get packaged data from facebook friends 
		 * based on the index entered. Use the friend constant. Access the data by:
		 * .fbid - friend facebook ID.
		 * .name - friend name.
		 * .piclink - friend picture link. 
		 */	
		
		public function getFriendDataByIndex(index:int):Object{
			var data:Object = new Object();
			data.own = friendsDataArray[index][FRIEND_OWN];
			data.he = friendsDataArray[index][FRIEND_HELPINGENERGY];
			data.fbid = friendsDataArray[index][FRIEND_FBID];
			data.lvl = friendsDataArray[index][FRIEND_LEVEL];
			data.name = friendsDataArray[index][FRIEND_NAME];
			data.piclink = friendsDataArray[index][FRIEND_PICLINK];
			return data;
		}
		
		/**
		 * @return String - returns the piclink of the given fbid.
		 */	
		
		public function getPicLinkByFID(fbid:String):String{
			var picLink:String = "";
			for (var x:int = 0; x<friendsDataArray.length; x++){
				if (friendsDataArray[x][FRIEND_FBID] == fbid){
					picLink = friendsDataArray[x][FRIEND_PICLINK];
					return picLink;
					break;
				}
			}
			return picLink;
		}
		
		public function getCharDataOnCharID(charID:String):Array{
			var charDataArray:Array = [];
			var charlistArray:Array = GlobalData.instance.charListDataArray;
			var len:int = charlistArray.length;
			for (var x:int = 0; x<len; x++){
				var characterID:String = charlistArray[x][GlobalData.CHARLIST_ID];
				if (characterID == charID){
					charDataArray = charlistArray[x];
					return charDataArray;
				}
			}
			return null;
		}
		
		public function getFriendCharDataOnCharID(charID:String):Array{
			var friendCharDataArray:Array = [];
			var friendCharlistArray:Array = GlobalData.instance.friendCharListDataArray;
			var len:int = friendCharlistArray.length;
			for (var x:int = 0; x<len; x++){
				var characterID:String = friendCharlistArray[x][GlobalData.FRIENDCHARLIST_ID];
				if (characterID == charID){
					friendCharlistArray = friendCharlistArray[x];
					return friendCharlistArray;
				}
			}
			return null;
		}
		
		
		/**
		 * @return Object - get packaged data for player data. Access data by:
		 * .fbid = pFbid;
		 * .pid = player ID;
		 * .coin = player Coin;
		 * .ticket = player Ticket;
		 * .starpoint = player starpoint;
		 * .exp = player Exp;
		 * .lvl = player Lvl;
		 * .hp = player Hotpoints;
		 * .ap = player Action Points;
		 */	
		
		public function getPlayerAssetData():Object{
			var data:Object = new Object();
			data.fbid = pFbid;
			data.pid = pId;
			data.coin = pCoin;
			data.sp = pSp;
			data.currentExp = pExp;
			data.lvl = pLvl;
			data.ap = pAp;
			data.phe = pHE;
			return data;
		}
		
		/**
		 * @return Object - get packaged data for class price data. Use the type
		 * constants here. Access data by:
		 * .type - the type of class;
		 * .coin - the coin required for the type of class;
		 * .ticket - the ticket required for the type of clas;
		 */	
		
		public function getClassPriceDataByType(index:int):Object{
			var data:Object = new Object();
			data.type = classPriceDataArray[index][CLASSPRICE_TYPE];
			data.coin = classPriceDataArray[index][CLASSPRICE_COINREQ];
			data.ticket = classPriceDataArray[index][CLASSPRICE_TICKETREQ];
			return data;
		}
		
		/**
		 * For Character Shop Body Data
		 * Gets a specific type of data based on the type of character shop data part.
		 * 
		 * @param partType - the type to be retrieved from the data pool. Ex. "hair" or "jawline"
		 * @return @return Array - return an array of character shop data based on the 
		 * type of data given.
		 */	
		
		public function getCharShopBodyDataByType (partType:String):Array{
			var charLen:int = charShopBodyDataArray.length;
			var charShopDataArray:Array = [];
			for (var x:int = 0; x<charLen; x++){
				if (charShopBodyDataArray[x][CHARSHOP_TYPE] == partType){
					charShopDataArray.push(charShopBodyDataArray[x]);
				}
			}
			return charShopDataArray;
		}
		
		/**
		 * For Character Shop Cloth Data
		 * Gets a specific type of data based on the type of character shop data part.
		 * 
		 * @param partType - the type to be retrieved from the data pool. Ex. "pants" 
		 * @return @return Array - return an array of character shop data based on the 
		 * type of data given
		 */		
		
		public function getCharShopDataByType (partType:String):Array{
			var charLen:int = charShopBodyDataArray.length;
			var charShopDataArray:Array = [];
			for (var x:int = 0; x<charLen; x++){
				if (charShopClothDataArray[x][CHARSHOP_TYPE] == partType){
					charShopDataArray.push(charShopClothDataArray[x]);
				}
			}
			return charShopDataArray;
		}	
		
		
		
		/**
		 * Returns the object of the attributes of an office object.
		 * 
		 * @param entryId - the entry id of the item wherein the attribute will be returned.
		 * @return - the object consisting the round frame numbers for the specific building
		 * 
		 */	
		
		public function getInitialOfficeStateData(entryId:String):IsoObjectData{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			var isoObjectData:IsoObjectData = null;
			for (var x:int = 0; x<len; x++){
				if (globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ENTRY] == entryId) {
					isoObjectData = new IsoObjectData();
					isoObjectData.entryid = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ENTRY];
					isoObjectData.id = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ITEMID];
					isoObjectData.dimension = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_DIMENSION];
					isoObjectData.fn = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ITEMFRAMENUMBER];
					isoObjectData.position = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_POSITION];
					isoObjectData.rotation = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ROTATION];
					isoObjectData.subType = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_SUBTYPE];
					isoObjectData.type = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_TYPE];
					//isoObjectData.npc = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_NPC];
					isoObjectData.empty = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_EMPTY];
					//isoObjectData.level = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_LEVEL];
					//isoObjectData.fbid = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_FBID];
					//isoObjectData.npcid = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_NPCID];
					isoObjectData.gender = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_GENDER];
					isoObjectData.staff = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_STAFF_POS];
					isoObjectData.state = globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_POS_STATE ];
					isoObjectData.l = isoObjectData.dimension.x;
					isoObjectData.w = isoObjectData.dimension.y;
					isoObjectData.h = isoObjectData.dimension.z;
					isoObjectData.x = isoObjectData.position.x * CELL_SIZE;
					isoObjectData.y = isoObjectData.position.y * CELL_SIZE;
					isoObjectData.z = isoObjectData.position.z;
					isoObjectData.gridX = isoObjectData.position.x;
					isoObjectData.gridY = isoObjectData.position.y;
					isoObjectData.stress = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_STRESS ];
					isoObjectData.duration = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_DURATION ];
					isoObjectData.health = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_HEALTH ];
					isoObjectData.acting = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_ACTING ];
					isoObjectData.sing = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_SING ];
					isoObjectData.attraction = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_ATTRACTION ];
					isoObjectData.intelligence = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_INT ];
					isoObjectData.machineStress = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_REST_STRESS ];
					isoObjectData.machineDuration = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_REST_DURATION ];
					isoObjectData.name = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_ITEMNAME ];
					isoObjectData.isUsed = int( globalData.officeStateDataArray[x][ GlobalData.FRIENDOFFICESTATE_ITEMUSED ]); 
					isoObjectData.sellPrice = int( globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_SELLPRICE ]);
					isoObjectData.from = "initial";
					break;
				}
			}			
			return isoObjectData;
		}
		
		/**
		 * Returns the object of the attributes of an office object.
		 * 
		 * @param entryId - the entry id of the item wherein the attribute will be returned.
		 * @return - the object consisting the round frame numbers for the specific building
		 * 
		 */	
		
		public function getInitialFriendOfficeStateData(entryId:String):IsoObjectData{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			var isoObjectData:IsoObjectData = null;
			for (var x:int = 0; x<len; x++){
				if (globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY] == entryId) {
					isoObjectData = new IsoObjectData();
					isoObjectData.entryid = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_ENTRY];
					isoObjectData.id = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_ITEMID];
					isoObjectData.dimension = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_DIMENSION];
					isoObjectData.fn = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_ITEMFRAMENUMBER];
					isoObjectData.position = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_POSITION];
					isoObjectData.rotation = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_ROTATION];
					isoObjectData.subType = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_SUBTYPE];
					isoObjectData.type = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_TYPE];
					//isoObjectData.npc = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_NPC];
					isoObjectData.empty = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_EMPTY];
					//isoObjectData.level = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_LEVEL];
					//isoObjectData.fbid = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_FBID];
					//isoObjectData.npcid = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_NPCID];
					isoObjectData.gender = globalData.friendOfficeStateDataArray[x][GlobalData.OFFICESTATE_GENDER];
					isoObjectData.staff = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_STAFF_POS ];
					isoObjectData.state = globalData.friendOfficeStateDataArray[x][GlobalData.FRIENDOFFICESTATE_POS_STATE ];
					isoObjectData.l = isoObjectData.dimension.x;
					isoObjectData.w = isoObjectData.dimension.y;
					isoObjectData.h = isoObjectData.dimension.z;
					isoObjectData.x = isoObjectData.position.x * CELL_SIZE;
					isoObjectData.y = isoObjectData.position.y * CELL_SIZE;
					isoObjectData.z = isoObjectData.position.z;
					isoObjectData.gridX = isoObjectData.position.x;
					isoObjectData.gridY = isoObjectData.position.y;					
					isoObjectData.stress = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_STRESS ];
					isoObjectData.duration = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_DURATION ];
					isoObjectData.health = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_HEALTH ];
					isoObjectData.acting = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_ACTING ];
					isoObjectData.sing = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_SING ];
					isoObjectData.attraction = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_ATTRACTION ];
					isoObjectData.intelligence = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_TRAINING_INT ];
					isoObjectData.machineStress = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_REST_STRESS ];
					isoObjectData.machineDuration = globalData.friendOfficeStateDataArray[x][ GlobalData.OFFICESTATE_REST_DURATION ];
					isoObjectData.name = globalData.officeStateDataArray[x][ GlobalData.OFFICESTATE_ITEMNAME ];
					isoObjectData.sellPrice = int( globalData.friendOfficeStateDataArray[x][ GlobalData.FRIENDOFFICESTATE_SELLPRICE ]);					
					isoObjectData.from = "initial";
					break;
				}
			}			
			return isoObjectData;
		}
		
		
		/**
		 * Returns the specific staff item by the entryID given.
		 * 
		 * @param entryID - the items unique entry id.
		 * @return - the array containing the items data. 
		 * 
		 */		
		
		public function getStaffItemDataByEntryID(entryID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			for (var x:int = 0; x<len; x++){
				if (globalData.officeStateDataArray[x][GlobalData.OFFICESTATE_ENTRY] == entryID){
					return globalData.officeStateDataArray[x];
				}
			}
			return null;
		}
		
		
		/**
		 * Returns the 2 dimentional array containing the rewards data of the specified quest.
		 * 
		 * @param questID - the questID where the rewards data will be retrieved.
		 * @return - the 2 dimentional array containing the data for the quest rewards. 
		 * 
		 */	
		
		public function getQuestRewardDataByQuestID(questID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.questListDataArray.length;
			var questRewardArray:Array = [];
			for (var i:int = 0; i < len; i++)
			{
				if (globalData.questListDataArray[i][GlobalData.QUESTLIST_ID] == questID){
					questRewardArray = globalData.questListDataArray[i][GlobalData.QUESTLIST_REWARD];
					return questRewardArray;
				}
			}
			return questRewardArray;
		}
		
		/**
		 * Returns the 2 dimentional array containing the requirements of the specified quest.
		 * 
		 * @param questID - the questID where the termlist will be retrieved.
		 * @return - the 2 dimentional array containing the data for the quest termlist. 
		 * 
		 */	
		
		public function getQuestTermsDataByQuestID(questID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.questListDataArray.length;
			var questTermsArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.questListDataArray[i][GlobalData.QUESTLIST_ID] == questID){
					questTermsArray = globalData.questListDataArray[i][GlobalData.QUESTLIST_TERM];
					return questTermsArray;
					break;
				}
			}
			return questTermsArray;
		}
		
		public function getQuestIfAcceptedByQuestID(questID:String):Boolean{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.questListDataArray.length;	
			
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.questListDataArray[i][GlobalData.QUESTLIST_ID] == questID) {
					if ( globalData.questListDataArray[i][GlobalData.QUESTLIST_ISACCEPTED] == "1" ) {
						trace( "[GlobalData]: Found accepted quest qid", questID  );
						return true;
						break;
					}				
				}
			}
			return false;
		}
		
		/**
		 * Returns the array containing the data for the office state.
		 * 
		 * @param entryID - the entryID where the item will be retrieved.
		 * @return - the array containing the data for the office state. 
		 * 
		 */	
		
		public function getOfficeStateDataByEntryID(entryID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.officeStateDataArray.length;
			var officeStateArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.officeStateDataArray[i][GlobalData.OFFICESTATE_ENTRY] == entryID){
					officeStateArray = globalData.officeStateDataArray[i];
					return officeStateArray;
					break;
				}
			}
			return officeStateArray;
		}
		
		/**
		 * Returns the array containing the data for the friend office state.
		 * 
		 * @param entryID - the entryID where the item will be retrieved.
		 * @return - the array containing the data for the friend office state. 
		 * 
		 */	
		
		public function getFriendOfficeStateDataByEntryID(entryID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.friendOfficeStateDataArray.length;
			var friendOfficeStateArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.friendOfficeStateDataArray[i][GlobalData.FRIENDOFFICESTATE_ENTRY] == entryID){
					friendOfficeStateArray = globalData.friendOfficeStateDataArray[i];
					return friendOfficeStateArray;
					break;
				}
			}
			return friendOfficeStateArray;
		}
		
		/**
		 * Returns the array containing the data for the collection list.
		 * 
		 * @param collectionID - the collectionID where the item will be retrieved.
		 * @return - the array containing the data for the collection list. 
		 * 
		 */	
		
		public function getCollectionItemsByCollID(collectionID:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.collectionListDataArray.length;
			var collectionListDataArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ID] == collectionID){
					collectionListDataArray = globalData.collectionListDataArray[i][GlobalData.COLLECTIONLIST_ITEM];
					return collectionListDataArray;
					break;
				}
			}
			return collectionListDataArray;
		}
		
		/**
		 * Returns the array containing the data for the level ap table.
		 * 
		 * @param level - the level where the exp and ap will be retrieved.
		 * @return - the array containing the data for the level ap table. 
		 * 
		 */	
		
		public function getLevelAPTableByLevel(level:int):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.levelAPTableDataArray.length;
			var levelAPTableDataArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.levelAPTableDataArray[i][GlobalData.LEVELAPTABLE_LVL] == level){
					levelAPTableDataArray = globalData.levelAPTableDataArray[i];
					return levelAPTableDataArray;
					break;
				}
			}
			return levelAPTableDataArray;
		}
		
		/**
		 * Returns the array containing the help route data for the specified friendId.
		 * 
		 * @param fbid - the facebook id where the help route data will be retrieved.
		 * @return - the array containing the data for help route data. 
		 * 
		 */	
		
		public function getFriendHelpRouteData(fbid:String):Array{
			var gd:GlobalData = GlobalData.instance;
			var len:int = gd.friendRoutesHelpArray.length;
			var friendRoutesHelpArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (gd.friendRoutesHelpArray[i][GlobalData.FRIENDROUTES_HELP_FBID] == fbid){
					friendRoutesHelpArray = gd.friendRoutesHelpArray[i][GlobalData.FRIENDROUTES_HELP_ROUTE];
					return friendRoutesHelpArray;
					break;
				}
			}
			return friendRoutesHelpArray;
		}
		
		/**
		 * Retrieves the zone instances of the minimap data.
		 *  
		 * @mapId - the id of the map data.
		 * @return - the array containing the zones.
		 * 
		 */		
		
		public function getMinimapZoneData(mapId:String):Array{
			var gd:GlobalData = GlobalData.instance;
			var len:int = gd.mapBuildingDataArray.length;
			var mapBuildingDataArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ID] == mapId){
					mapBuildingDataArray = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES];
					return mapBuildingDataArray;
					break;
				}
			}
			return mapBuildingDataArray;
		}
		
		/**
		 * Retrieves the building instances of a particular zone the minimap data.
		 *  
		 * @zoneId - the id of the zone data.
		 * @return - the array containing the building data of the particular zone.
		 * 
		 */		
		
		public function getMinimapBuildingData(zoneId:String):Array{
			var gd:GlobalData = GlobalData.instance;
			var len:int = gd.mapBuildingDataArray.length;
			var mapBuildingDataArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				var len2:int = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES].length;
				for (var j:int = 0; j < len2; j++) 
				{
					var zoneData:Array = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES][j];
					if (zoneData[GlobalData.MAPBUILDING_ZONE_ID] == zoneId){
						mapBuildingDataArray = zoneData[GlobalData.MAPBUILDING_ZONE_BUILDINGS];
						return mapBuildingDataArray;
						break;
					}
				}
			}
			return mapBuildingDataArray;
		}
		
		/**
		 * Retrieves the specific building instance of a particular zone the minimap data.
		 *  
		 * @buildingId - the id of the building data.
		 * @return - the array containing the building data of the particular zone.
		 * 
		 */		
		
		public function getSpecificMinimapBuildingData(buildingId:String):Array{
			var gd:GlobalData = GlobalData.instance;
			var len:int = gd.mapBuildingDataArray.length;
			var mapBuildingDataArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				var len2:int = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES].length;
				for (var j:int = 0; j < len2; j++) 
				{
					var len3:int = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES][j][GlobalData.MAPBUILDING_ZONE_BUILDINGS].length;
					for (var k:int = 0; k < len3; k++)
					{
						var buildingData:Array = gd.mapBuildingDataArray[i][GlobalData.MAPBUILDING_MAP_ZONES][j][GlobalData.MAPBUILDING_ZONE_BUILDINGS][k];
						if (buildingData[GlobalData.MAPBUILDING_BUILDING_ID] == buildingData){
							mapBuildingDataArray = buildingData;
							return mapBuildingDataArray;
							break;
						}
					}
				}
			}
			return mapBuildingDataArray;
		}
		
		/**
		 * Returns the array containing the challenge route data for the specified friendId.
		 * 
		 * @param fbid - the facebook id where the challenge route data will be retrieved.
		 * @return - the array containing the data for challenge route data. 
		 * 
		 */	
		
		public function getFriendChallengeRouteData(fbid:String):Array{
			var globalData:GlobalData = GlobalData.instance;
			var len:int = GlobalData.instance.friendRoutesChallengeArray.length;
			var friendRoutesChallengeArray:Array = [];
			for (var i:int = 0; i < len; i++) 
			{
				if (globalData.friendRoutesChallengeArray[i][GlobalData.FRIENDROUTES_CHALLENGE_FBID] == fbid){
					friendRoutesChallengeArray = globalData.friendRoutesChallengeArray[i][GlobalData.FRIENDROUTES_CHALLENGE_ROUTE];
					return friendRoutesChallengeArray;
					break;
				}
			}
			return friendRoutesChallengeArray;
		}
		
		/**
		 * 
		 * @param	itemStructureData - used for inventory
		 * @param	itemid - used for shop
		 * @return - isoobject data used in the isoroom also called isoobjects
		 */
		public function extactData( itemStructureData:ItemStructureData = null , itemid:String = null  ):IsoObjectData 
		{
			var isoObectData:IsoObjectData = null;
			var gd:GlobalData = GlobalData.instance;
			for (var i:int = 0; i < GlobalData.instance.officeStoreDataArray.length; i++)
			{
				for (var j:int = 0; j < GlobalData.instance.officeStoreDataArray[i].length; j++) 
				{			
					//check for id
					if ( itemStructureData != null  ) {
						//owned
						trace( "[GlobalData search check===>]: ", itemStructureData.itemid, "officeStoreID: ", GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ID] );
						if ( itemStructureData.itemid == GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ID])
						{								
							trace( "[GlobalData search check===> found items ...]: ", itemStructureData.itemid, "officeStoreID: ", GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ID] );
							isoObectData = new IsoObjectData();
							isoObectData.id = itemStructureData.itemid;
							isoObectData.entryid = itemStructureData.entry;
							isoObectData.name = itemStructureData.itemname;
							isoObectData.sellPrice = itemStructureData.sellprice;
							isoObectData.coin = 0;
							isoObectData.star = 0;
							isoObectData.type = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_CATEGORY];
							isoObectData.subType = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TYPE];
							isoObectData.w = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].y;
							isoObectData.l = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].x;
							isoObectData.h = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].z;
							isoObectData.rotation = 0;
							isoObectData.fn = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_FRAMENUMBER];														
							isoObectData.state = itemStructureData.state;							
							isoObectData.stafflist = itemStructureData.stafflist;
							isoObectData.assignednpc = itemStructureData.assignednpc;
							isoObectData.from = "inventory";
							isoObectData.staff = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_STAFF_POSITIONS];
							isoObectData.duration = itemStructureData.duration;
							isoObectData.stress = itemStructureData.stress;							
							isoObectData.intelligence = itemStructureData.intelligence;
							isoObectData.acting = itemStructureData.acting;
							isoObectData.attraction = itemStructureData.attraction;
							isoObectData.health = itemStructureData.health;
							isoObectData.sing = itemStructureData.sing;
							
							isoObectData.eff = itemStructureData.eff;
							isoObectData.machineRewardCoin = itemStructureData.machinerewardcoin;
							isoObectData.machinerewardcooldown = itemStructureData.machinerewardcooldown;
							isoObectData.desc = itemStructureData.descrip;
							isoObectData.unlocklevel = itemStructureData.unlocklevel;
							
							//new
							isoObectData.apcost = itemStructureData.apcost;
							isoObectData.exp = itemStructureData.exp;
							
							var str:String = isoObectData.state;
							//"npc_Ki1U8I3IOTjQN54SlRSV_male_1";
							if ( str != null ) {
								
								var arr:Array = str.split("_");
								
								if( arr[ 0 ] == "npc" ){
									isoObectData.npc = arr[ 0 ];
									isoObectData.npcid = arr[ 1 ];
									isoObectData.fbid = "";									
									//isoObectData.staff = "";
								}
								
								if ( arr[ 0 ] == "friend" ){
									isoObectData.fbid = arr[ 1 ];
									//reason unknown
									//isoObectData.staff = "";
									isoObectData.npcid = "";
									isoObectData.npc = "";
								}								
								
								isoObectData.gender = arr[ 2 ];
								isoObectData.level = int ( arr[ 3 ] );
								isoObectData.empty = "false";	
							}else {							
								isoObectData.gender = "";
								isoObectData.level = 0;
								isoObectData.empty = "true";							
							}
							break;
						}
					}else if ( itemid != null ) {
						//when buying
						if ( itemid == GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_ID])
						{						
							isoObectData = new IsoObjectData();
							isoObectData.id = itemid;
							isoObectData.entryid = "";
							isoObectData.name = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_NAME];
							isoObectData.sellPrice = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_SELLPRICE];
							isoObectData.coin = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_COIN];
							isoObectData.star = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_STAR];
							isoObectData.type = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_CATEGORY];
							isoObectData.subType = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TYPE];
							isoObectData.w = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].y;
							isoObectData.l = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].x;
							isoObectData.h = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION].z;
							isoObectData.position = new Vector3D( 0, 0, 0 );
							isoObectData.dimension = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DIMENSION];
							isoObectData.staff = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_STAFF_POSITIONS];
							isoObectData.x = 0;
							isoObectData.y = 0;
							isoObectData.z = 0;
							isoObectData.rotation = 0;
							isoObectData.fn = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_FRAMENUMBER];
							isoObectData.npc = "";
							isoObectData.empty = "true";
							isoObectData.level = 0;
							isoObectData.fbid = myFbId;
							isoObectData.npcid = "";
							isoObectData.gender = "";							
							isoObectData.state = "null";
							isoObectData.from = "shop";
							isoObectData.duration = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_DURATION];
							isoObectData.stress = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_STRESS];
							isoObectData.machineDuration = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_REST_DURATION];
							isoObectData.machineStress = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_REST_STRESS];							
							isoObectData.intelligence = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_INT];
							isoObectData.acting = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_ACTING];
							isoObectData.attraction = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_ATTRACTION];
							isoObectData.health = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_HEALTH];
							isoObectData.sing = GlobalData.instance.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_TRAINING_SING];							
							
							//new oct 17
							isoObectData.eff = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_EFFECT];
							isoObectData.machineRewardCoin = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_MACHINEREWARDCOIN];
							//isoObectData.machinerewardcooldown = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_MACHINEREWARDCOOLDOWN];							
							isoObectData.desc = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_DESCRIPTION];
							isoObectData.unlocklevel = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_UNLOCKLEVEL]
							
							//new
							isoObectData.apcost = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_APCOST];
							isoObectData.exp = gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_EXP];
							trace( "[Global Data ]: check exp ", gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_EXP], "apcost", gd.officeStoreDataArray[i][j][GlobalData.OFFICESTORE_APCOST] );
							break;
						}
					}
				}
			}			
			return isoObectData;
		}
	}
}