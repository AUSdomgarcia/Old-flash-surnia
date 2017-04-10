package com.surnia.socialStar.minigames.runningMan
{
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Droids
	 */
	public class RunningManController
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _model:RunningMan;
		private var _obCtr:int;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function RunningManController(model:RunningMan)
		{
			this._model=model;
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		public function computeRaceDuration():void
		{
			this._model.maxGames=this.numberOfWeeks + this.roundsPerWeek;
			this._model.maxGameTime=(this.startDelay*2) + this.raceDuration;
		}
		public function obstaclePlacement():void //new method for adding 1 obstacle
		{
			if(this._model.obstacleList.length==0)
			{
				var ob:MiniGame_Obstacle;
				var result:int = createObstacle();
				if (this._model.obstacleTypes[result]==null)
				{
					ob = new MiniGame_Obstacle("blank", null, "", null);
				}
				else
				{  
					if(this._model.obstacleTypes[result].name=="drum")
					{
						ob = new MiniGame_Obstacle("obstacle" + _obCtr, null, "", new MC_Drum());
					}
					else
					{
						ob = new MiniGame_Obstacle("obstacle" + _obCtr, null, "", this._model.obstacleTypes[result]);
					}
				}
				ob.x=900;
				ob.y=328.15;
				var num:int=Math.floor((Math.random()*5)+5);
				ob.speed=num;
				ob.obstacleOnStage= true;
				this._model.obstacleList.push(ob);
				this._model.maxObstacles = this._model.obstacleList.length;
			}
		}
		public function moveObstacleOnStage():void //new method for moving the obstacle and its placement
		{
			var obstacleList:Array = this._model.obstacleList;
			var ctr:int = 0;
			if (obstacleList[ctr].obstacleOnStage == false)
			{
				_obCtr += 1
				obstacleList[ctr].obstacleName="obstacle" + _obCtr;
				obstacleList[ctr].obstacleOnStage=true;
				obstacleList[ctr].x=900;
				var num:int=Math.floor((Math.random()*5)+5);
				obstacleList[ctr].speed=num;
			}
			this._model.obstacleList = obstacleList;
		}
		//update obstacle position
		public function updateObstaclePosition():void
		{
			var avatars:Array=this._model.avatarList;
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			
			var maxLength:int = this._model.obstacleList.length;
			for (var num:int = 0; num < maxLength; num++)
			{
				var dispOb:DisplayObject=spLayer.getChildByName("aiSprite");
				if (this._model.obstacleList[num].obstacleOnStage==true)
				{
					this._model.obstacleList[num].x -= this._model.obstacleList[num].speed;
				}
				if(this._model.obstacleList[num].x < -310 )
				{
					this._model.obstacleList[num].obstacleOnStage=false;
				}
			}
			
		}
		//random award items
		public function generateAwardItems():Object
		{
			var ob:Object=new Object();
			var result:int = createAwardItem();
			ob.id=result;
			ob.bitmap=new Bitmap(this._model.awardTypes[result]);
			ob.bitmap.x=90;
			ob.bitmap.y=300;
			ob.ymov=-20;
			ob.xmov=0;
			ob.onGround=false;
			return ob
		}
		public function createAwardItem():int
		{
			var awardTypes:Array = this._model.awardTypes;
			var maxTypes:int = awardTypes.length;
			var result:int = Math.floor(Math.random() * maxTypes);
			if (this._model.awardTypes[result] == null)
			{
				var tmp:int = Math.floor(Math.random() * 1);
				if (tmp==1)
				{
					result=Math.floor(Math.random() * maxTypes);
				}
			}
			return result;
		}	
		//randomization of obstacle types
		public function generateObstacles():void
		{
			_obCtr += 1
			var ob:MiniGame_Obstacle;
			var result:int = createObstacle();
			if (this._model.obstacleTypes[result]==null)
			{
				ob = new MiniGame_Obstacle("blank", null, "", null);
			}
			else
			{  
				if(this._model.obstacleTypes[result].name=="drum")
				{
					ob = new MiniGame_Obstacle("obstacle" + _obCtr, null, "", new MC_Drum());
				}
				else
				{
					ob = new MiniGame_Obstacle("obstacle" + _obCtr, null, "", this._model.obstacleTypes[result]);
				}
			}
			ob.x=900;
			ob.y=328.15;
			var num:int=Math.floor((Math.random()*5)+5);
			ob.speed=num;
			ob.obstacleOnStage= true;
			this._model.obstacleList.push(ob);
			this._model.maxObstacles = this._model.obstacleList.length;
		}
		public function createObstacle():int
		{
			var obstacleTypes:Array = this._model.obstacleTypes;
			var maxTypes:int = obstacleTypes.length;
			var result:int = Math.floor(Math.random() * maxTypes);
			if (this._model.obstacleTypes[result] == null)
			{
				var tmp:int = Math.floor(Math.random() * 1);
				if (tmp==1)
				{
					result=Math.floor(Math.random() * maxTypes);
				}
			}
			return result;
		}	
		public function checkObstacleOnStage():String
		{
			var obstacleList:Array = this._model.obstacleList;
			var maxLength:int = obstacleList.length;
			var ctr:int = 0;
			var obstacleName:String="blank";
			while(ctr<maxLength)
			{			
				if (obstacleList[ctr].obstacleOnStage == false)
				{
					obstacleName = obstacleList[ctr].obstacleName;
					obstacleList.splice(ctr, 1);
					break;
				}
				ctr += 1;
			}
			this._model.obstacleList = obstacleList;
			return obstacleName;
		}
		public function userRecord(result:Object):void
		{
			var obj:Object=new Object();
			var tempList:Array;
			var maxLength:int;
			var holder:String="blank";
			if(this._model.inputList.length>0)
			{
				maxLength=this._model.inputList.length;
				tempList=this._model.inputList;
				for(var num:int=0; num<maxLength; num++)
				{
					if(tempList[num].name==result.obstacle)
					{
						holder="modify";
					}
				}
				if(holder=="blank")
				{
					obj.user = result.user;
					obj.name = result.obstacle;
					obj.state = result.state;
					obj.jump=result.jump;
					obj.xp=result.xp;
					obj.ap=result.ap;
					obj.coin=result.coin;
					obj.raceleader=result.raceleader;
					this._model.inputList.push(obj);
				}
			}
			else
			{
				obj.user = result.user;
				obj.name = result.obstacle;
				obj.state = result.state;
				obj.jump=result.jump;
				obj.xp=result.xp;
				obj.ap=result.ap;
				obj.coin=result.coin;
				obj.raceleader=result.raceleader;
				this._model.inputList.push(obj);
			}
			//trace("userName:" + obj.user + " obsName:" + obj.name + " state:" + obj.state + " jump?:" + obj.jump + " xp:" + obj.xp + " ap:" + obj.ap + " coin:" + obj.coin + " leader:" + obj.raceleader)
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		public function set numberOfWeeks(numberOfWeeks:int):void
		{
			this._model.numberOfWeeks=numberOfWeeks;
		}
		public function set roundsPerWeek(roundsPerWeek:int):void
		{
			this._model.roundsPerWeek=roundsPerWeek;
		}		
		public function set raceDuration(raceDuration:int):void
		{
			this._model.raceDuration=raceDuration;
		}
		public function set obstacleInterval(obstacleInterval:int):void
		{
			this._model.obstacleInterval=obstacleInterval;
		}
		public function set startDelay(startDelay:int):void
		{
			this._model.startDelay=startDelay;
		}
		public function set playerList(playerList:Array):void
		{
			this._model.playerList=playerList;
		}
		public function set inputList(inputList:Array):void
		{
			this._model.inputList=inputList;
		}
		public function set avatarList(avatarList:Array):void
		{
			this._model.avatarList=avatarList;
		}
		public function set obstacleList(obstacleList:Array):void
		{
			this._model.obstacleList=obstacleList;
		}
		public function set layersList(layers:Array):void
		{
			this._model.layersList=layers;
		}
		public function set gameState(gameState:String):void
		{
			this._model.gameState=gameState;
		}
		public function set maxGameTime(maxGameTime:int):void
		{
			this._model.maxGameTime=maxGameTime;
		}
		public function set raceData(raceData:Object):void
		{
			this._model.raceData=raceData;
		}
		public function set masterRecord(masterRecord:Object):void
		{
			this._model.masterRecord=masterRecord;
		}
		public function set obstacleTypes(obstacleList:Array):void
		{
			this._model.obstacleTypes = obstacleList;
		}
		public function set awardTypes(awardTypes:Array):void
		{
			this._model.awardTypes=awardTypes;
		}
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		public function get numberOfWeeks():int
		{
			return this._model.numberOfWeeks;
		}
		public function get roundsPerWeek():int
		{
			return this._model.roundsPerWeek;
		}
		public function get raceDuration():int
		{
			return this._model.raceDuration;
		}
		public function get obstacleInterval():int
		{
			return this._model.obstacleInterval;
		}
		public function get startDelay():int
		{
			return this._model.startDelay;
		}
		public function get playerList():Array
		{
			return this._model.playerList;
		}
		public function get inputList():Array
		{
			return this._model.inputList;
		}
		public function get avatarList():Array
		{
			return this._model.avatarList;
		}
		public function get obstacleList():Array
		{
			return this._model.obstacleList;
		}
		public function get layersList():Array
		{
			return this._model.layersList;
		}
		public function get gameState():String
		{
			return this._model.gameState;
		}
		public function get maxGameTime():int
		{
			return this._model.maxGameTime;
		}
		public function get raceData():Object
		{
			return this._model.raceData;
		}
		public function get masterRecord():Object
		{
			return this._model.masterRecord;
		}
		public function get awardTypes():Array
		{
			return this._model.awardTypes;
		}
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
	}
}