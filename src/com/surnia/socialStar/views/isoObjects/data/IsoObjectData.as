package com.surnia.socialStar.views.isoObjects.data 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoBox;
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author JC
	 */
	public class IsoObjectData 
	{
		public var isoSprite:IsoSprite;
		public var mc:MovieClip;
		public var name:String;
		public var id:String;
		public var entryid:String;
		public var w:int;
		public var l:int;
		public var h:int;
		public var rotation:int;
		public var gridX:int;
		public var gridY:int;
		public var type:String;
		public var subType:String;
		public var npc:String;
		public var npcid:String;
		public var empty:String;
		public var level:int;
		public var fbid:String;
		public var gender:String;
		public var staff:String;
		public var state:String;
		public var fn:String;
		public var x:int;
		public var y:int;
		public var z:int;		
		
		//add ons because of inventory process,shop and initial state
		public var from:String;
		public var stafflist:String;
		public var assignednpc:String;		
		
		//extra things
		public var extraSpacePosition:String;
		public var extraSpace:IsoBox;
		
		
		//offfice state data
		public var rotatable:Boolean;
		public var dimension:Vector3D;
		public var position:Vector3D;
		
		//new		
		public var stress:int;
		public var duration:int;		
		public var health:int;
		public var acting:int;
		public var attraction:int;
		public var intelligence:int;
		public var sing:int;		
		public var machineDuration:int;
		public var machineStress:int;
		
		//officeStore
		public var coin:int;
		public var star:int;		
		
		//inventory things
		public var sellPrice:int;
		public var isUsed:int;
		
		//special attributes
		public var eff:String;
		public var machineRewardCoin:int;
		public var machinerewardcooldown:int;
		public var desc:String;
		public var unlocklevel:int;		
		
		//new 01112012
		public var exp:int;
		public var apcost:int;
		
		public function IsoObjectData() 
		{
			
		}
		
	}

}