package com.surnia.socialStar.minigames.runningMan
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.minigames.EmotionEffect.EmotionEffect;
	import com.surnia.socialStar.minigames.components.avatar.Avatar;
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	import com.surnia.socialStar.minigames.components.player.MiniGame_Player;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Main_Slider;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Slider;
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	import com.surnia.socialStar.minigames.popupUI.test.VersusPopUpController;
	import com.surnia.socialStar.minigames.popupUI.test.VictoryRewardController;
	import com.surnia.socialStar.minigames.runningMan.model.BackgroundItemModel;
	import com.surnia.socialStar.minigames.runningMan.view.BackgroundItemManager;
	import com.surnia.socialStar.test.MiniGameRunningManTest;
	import com.surnia.socialStar.test.MiniGameRunningManTopPanel;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author Drew
	 */
	public class RunningManMain extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		public static const GAME_FINISHED:String = "GameFinished";
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _slider:MiniGame_Main_Slider;
		private var _timer:MiniGame_Timer;
		private var _player:MiniGame_Player;
		
		//->Game logic property
		private var _maxGames:int;
		private var _maxGameTime:int;
		private var _currentRound:int;
		private var _currentWeek:int;
		private var _gamesPlayed:int;
		private var _weeksPassed:int;
		
		private var _playerList:Array;
		private var _numberOfWeeks:int;
		private var _roundsPerWeek:int;
		private var _raceDuration:int;
		private var _obstacleInterval:int;
		private var _startDelay:int;
		
		public var gameEvent:EventDispatcher;
		public var playerRecord:Array; //Array
		public var raceData:Object;
		
		//->Domz
		private var _bg:MiniGameRunningManTest;
		private var _topPanel:MiniGameRunningManTopPanel;
		private var _versus:VersusPopUpController;
		private var _reward:VictoryRewardController;
		private var _emo:EmotionEffect;
		
		//->Interactivity
		private var _jumpSprite:Sprite;
		private var _obstacleState:String;
		private var _obstacleName:String;
		private var _inputList:Array;
		private var _tempHolder:String;
		private var _allowClick:Boolean;
		private var _playerClick:Boolean;
		
		private var _myDrum:MC_Drum;
		//Avatar
		private var _avatarList:Array;
		private var _c:int;
		private var _gameState:Boolean;
		private var _aiState:Boolean
		private var _playerState:Boolean;
		
		private var _tempGame:Boolean;
		
		private var obListInStage:Array;
		private var _pl1:String;
		private var _pl2:String;
		
		public var GAME_WIDTH:Number;
		public var GAME_HEIGHT:Number;
		public var GAME_CENTER_WIDTH:Number;
		public var GAME_CENTER_HEIGHT:Number;
		
		public var masterRecord:Object;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function RunningManMain(playerList:Array, numberOfWeeks:int, roundsPerWeek:int, raceDuration:int, obstacleInterval:int, startDelay:int)
		{
			init(playerList, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init(playerList:Array, numberOfWeeks:int, roundsPerWeek:int, raceDuration:int, obstacleInterval:int, startDelay:int):void
		{
			_tempHolder="none";
			this._currentRound += 1;
			this._gamesPlayed += 1;
			if(this._currentRound > this._roundsPerWeek)
			{
				this._currentWeek += 1;	
				this._currentRound = 1;
				this._weeksPassed += 1;
			}
			else
			{
				this._currentWeek = 1;
			}		
			_c = 0;
			
			this._pl1="blank";
			this._pl2="blank";
			this.obListInStage=new Array();
			this._tempGame=false;
			this.raceData=new Object();
			this._avatarList = new Array();
			this._gameState = false;
			this._allowClick = false;
			this._playerClick = false;
			this._aiState = false;
			this._playerState=false;
			this._inputList = new Array();
			
			//Timer Class
			this._timer = new MiniGame_Timer(90); //add game speed to the parameter
			
			//Slider Class
			//->set ui
			//--declare image types for slider UI
			var sliderBar:Bitmap = new Bitmap(new Slider_Bar());
			
			var collider:Bitmap = new Bitmap(new Slider_Collider());
			collider.name = "collider";
			//--ui coordinates
			collider.x = 60;
			//->set obstacles
			var drum:Ob_Drum = new Ob_Drum();
			var banana:Ob_Banana = new Ob_Banana();
			
			//--create temporary Holder for visual assets
			var uiList:Array = new Array();
			uiList.push(sliderBar);
			uiList.push(collider);
			var obstacleList:Array = new Array();
			//obstacleList.push(null);
			obstacleList.push(drum);
			obstacleList.push(banana);
			
			//Slider Class init
			this._slider = new MiniGame_Main_Slider(raceDuration, obstacleInterval, uiList, obstacleList, startDelay);
			
			//User Input
			var btn_Jump:Bitmap = new Bitmap(new UI_JumpButton());
			this._jumpSprite = new Sprite();
			this._jumpSprite.addChild(btn_Jump);
			
			//Avatar Class
			
			
			//Player Class
			this._playerList = playerList;
			
			//Game Logic
			this._numberOfWeeks = numberOfWeeks;
			this._roundsPerWeek = roundsPerWeek;
			this._raceDuration = raceDuration;
			this._obstacleInterval = obstacleInterval;
			this._startDelay = startDelay;
			
			this._maxGames = numberOfWeeks * roundsPerWeek;
			this._maxGameTime = (startDelay*3) + raceDuration;
			
			this._obstacleState = "false";
			
			this.gameEvent = new EventDispatcher();
			setDisplay();
			setListeners();
			gameLogic();
		}
		private function setListeners():void
		{
			this._timer.addEventListener("TimeUpdated", monitorTime);
			this._timer.addEventListener("GameLoop", gameLoop);
			//this._jumpSprite.addEventListener(MouseEvent.CLICK, jumpClick);
			this.addEventListener(MouseEvent.CLICK, jumpClick);
			this._avatarList[0].avatarEvent.addEventListener("FinishAnimationLoop", avatarHandler1);
			this._avatarList[1].avatarEvent.addEventListener("FinishAnimationLoop", avatarHandler2);
			
			this.addEventListener("POST_VICTORY", removeEvent);
			this.addEventListener("CLOSE", removeEvent);
			this.addEventListener("SHARE_REWARD", removeEvent);
		}
		private function setDisplay():void
		{
			//Screen UI
			//->screen frame
			var screen:Bitmap = new Bitmap(new UI_Screen()); 
			screen.name = "screenUi"
			this.addChild(screen);
			GAME_WIDTH=screen.width;
			GAME_HEIGHT=screen.height;
			GAME_CENTER_WIDTH=screen.width/2;
			GAME_CENTER_HEIGHT=screen.height/2;	
			
			//->parallax backround
			this._bg = new MiniGameRunningManTest(stage, screen.x, screen.y, this);
			_bg.name="paralaxBg"
			//->slider
			this._slider.y = (this.height - ((this._slider.height * 2) - (this._slider.height * .40)));
			this._slider.x = 28;
			this._slider.name="sliderui"
			this.addChild(this._slider);
			//->Jump Button
			this._jumpSprite.y = (this.height - ((this._jumpSprite.height * 2)+5));
			this._jumpSprite.x = 100;
			this._jumpSprite.name="jumpui"
			this.addChild(this._jumpSprite);
			
			//->Text and Effects Display
			this._topPanel = new MiniGameRunningManTopPanel(stage, true,  screen.x, screen.y, this);
			this._topPanel.name="panleu"
			//this._topPanel.setRoundText( this._currentRound );
			//trace(this._currentWeek+":"+this._weeksPassed )
			//this._topPanel.setWeekText( this._currentWeek, this._currentWeek-1 );
			
			//Avatar
			var avatarChar:Avatar;
			var maxLength:int = this._playerList.length;
			for (var num:int = 0; num <maxLength; num++)
			{
				avatarChar = new Avatar(this._playerList[num].charInfo);
				avatarChar.name = "gamePlayer"+this._playerList[num].name;
				//trace(this._playerList[num].isPlayer) //has problem with this
				if(this._playerList[num].isPlayer==true)
				{
					avatarChar.x = 90;
					avatarChar.y = 200;
				}
				else
				{
					avatarChar.x = 120;
					avatarChar.y = 180;
				}
				this.addChild(avatarChar);
				this._avatarList.push(avatarChar);
			}
		}
		private function gameLogic():void
		{
			//Start Game Timer
			this._timer.startClockTimer();
		}
		private function userRecord():void
		{
			var tmp:String;
			if (this._inputList.length > 0)
			{				
				if (_obstacleState!="false" && this._inputList[this._inputList.length-1].name!=_obstacleName)
				{
					if(_obstacleState=="true")
					{
						tmp="Hit";
					}
					else
					{
						tmp="Miss";
					}
					var obj:Object = new Object();
					obj.name = _obstacleName;
					obj.state = tmp;
					
					obj.exp="0";
					obj.ap="0";
					obj.coin="0";
					
					obj.show="false"
					obj.onStage="false";
					obj.jump=this._playerClick;
					this._inputList.push(obj);
				}
			}
			else
			{
				if (_obstacleName != null && _obstacleState!="false")
				{
					if(_obstacleState=="true")
					{
						tmp="Hit";
					}
					else
					{
						tmp="Miss";
					}
					var obj1:Object = new Object();
					obj1.name = _obstacleName;
					obj1.state = tmp;
					
					obj1.exp="0";
					obj1.ap="0";
					obj1.coin="0";
					
					obj1.show = "false";
					obj1.onStage="false";
					obj1.jump=this._playerClick;
					this._inputList.push(obj1);
				}
			}
		}
		private function displayHitCondition():void
		{
			for (var mum:int = 0; mum < this._inputList.length; mum++)
			{
				if (this._inputList[mum].show=="false")
				{
					if (this._inputList[mum].state=="Hit")
					{
						//Perfect Hit
						//this._avatarList[1].playAnimation("racejump", 1);
						
						//call create random award
						
						this._topPanel.getStatus(2, 60, 350 ,150);
					}
					else if (this._inputList[mum].state=="Miss")
					{
						//click but miss
						//this._avatarList[1].playAnimation("racelose", 1);
						this._topPanel.getStatus(1, 60, 350 ,150);
					}
					/*else if (this._inputList[mum].state=="left")
					{
						//click but miss
						this._avatarList[1].playAnimation("racerun", 0);
						this._avatarList[1].playAnimation("racelose", 1);
						this._topPanel.getStatus(1, 60, 350 ,150);
					}
					else if (this._inputList[mum].state=="finish")
					{
						//no click and miss
						this._topPanel.getStatus(1, 60, 350 ,150);
					}
					else
					{
						//obstacle not reach collider
					}*/
					//this._playerState=true;
					this._inputList[mum].show = "true";
					break;
				}
			}
		}
		private function updateColliderAndObstacleState():void
		{
			//Obstacle State
			if(this._slider.obstacleListData.length>0)
			{
				var maxLength:int = this._slider.obstacleListData.length;
				var ctr:int = 0;
				while (ctr<maxLength)
				{
					_obstacleState = this._slider.obstacleListData[ctr].reachCollider;
					_obstacleName = this._slider.obstacleListData[0].obstacleName;
					if (this._slider.obstacleListData[ctr].reachCollider=="false")
					{
						
					}
					if (this._slider.obstacleListData[ctr].reachCollider=="right")
					{
						_obstacleState = this._slider.obstacleListData[ctr].reachCollider;
						_obstacleName = this._slider.obstacleListData[0].obstacleName;
						break;
					}
					if (this._slider.obstacleListData[ctr].reachCollider=="true")
					{
						_obstacleState = this._slider.obstacleListData[ctr].reachCollider;
						_obstacleName = this._slider.obstacleListData[0].obstacleName;
						break;
					}
					if (this._slider.obstacleListData[ctr].reachCollider=="left")
					{
						_obstacleState = this._slider.obstacleListData[ctr].reachCollider;
						_obstacleName = this._slider.obstacleListData[0].obstacleName;
						break;
					}
					if (this._slider.obstacleListData[ctr].reachCollider=="finish")
					{
						_obstacleState = this._slider.obstacleListData[ctr].reachCollider;
						_obstacleName = this._slider.obstacleListData[0].obstacleName;
						break;
					}
					ctr += 1;
				}
				//trace(_obstacleName + "=" + _obstacleState)
			}
		}
		private function jumperButtonAndInputMonitor():void
		{
			//Jumper Button State
			if(_obstacleState!="false")
			{			
				this._jumpSprite.alpha = 1;
			}
			else
			{
				this._jumpSprite.alpha = 0.8;
			}
			//Monitor user input when no click
			if (this._playerClick != true && _obstacleState=="left" && _tempHolder!=_obstacleName)
			{
				_tempHolder=_obstacleName;
				//trace(_obstacleName + "=" + _obstacleState +" Not Clicked")
				//this.userRecord();
				var obj:Object = new Object();
				obj.name = _obstacleName;
				obj.state = "Miss"
				obj.show="false";
				obj.onStage="false";
				obj.jump=false;
				this._inputList.push(obj);
				this.displayHitCondition();
			}
			if(_tempHolder==_obstacleName && _obstacleState!="finish" && this._playerClick == true)
			{
				this._playerClick=false;
			}
		}
		private function updateCharacterAndObstacle():void
		{
			//Obstacle creation
			if(this._slider.obstacleListData.length>0)
			{
				var maxLength:int = this._slider.obstacleListData.length;
				var num:int = 0;
				while (num<maxLength)
				{
					if (_slider.obstacleListData[num].obstacleName != "blank")
					{
						if(this.getChildByName("MC_" + _slider.obstacleListData[num].obstacleName)==null)
						{
							var ob:MiniGame_Obstacle;
							_myDrum = new MC_Drum();
							ob=new MiniGame_Obstacle(_slider.obstacleListData[num].obstacleName, null, "", _myDrum);
							ob.name = "MC_" + _slider.obstacleListData[num].obstacleName;
							ob.y = 260;
							ob.x = 540+60;
							var obj:Object=new Object();
							obj.content=ob;
							obj.aiJump="false";
							obj.plJump="false";
							this.obListInStage.push(obj);
							this.addChild(ob);
						}
					}
					num+=1;
				}
			}
			var iCtr:int=0;
			while(iCtr<this.obListInStage.length)
			{
				if(this.contains(this.getChildByName(this.obListInStage[iCtr].content.name)))
				{
					var obDisp:DisplayObject=this.getChildByName(this.obListInStage[iCtr].content.name);
					obDisp.x -= 2.5;
					//Player
					//if((this._avatarList[1].x + (this._avatarList[1].width/2)) < (obDisp.x+(obDisp.width/2)) && (this._avatarList[1].x + (this._avatarList[1].width/2)) > obDisp.x)
					if(((this._avatarList[1].x + this._avatarList[1].width) < (obDisp.x)) && ((this._avatarList[1].x + this._avatarList[1].width) > (obDisp.x-30)))
					{
						if(this._playerState == false && this.obListInStage[iCtr].plJump=="false")
						{
							trace(this.obListInStage[iCtr].content.obstacleName+"called")
							this.setChildIndex(this._avatarList[1], this.getChildIndex(obDisp));
							this.setChildIndex(this._avatarList[1], this.getChildIndex(this._avatarList[0]));
							this.obListInStage[iCtr].plJump="true";
							userLogic();
							this._playerState = true;						
						}
					}
					//AI
					if(((this._avatarList[0].x + this._avatarList[0].width) < (obDisp.x)) && ((this._avatarList[0].x + this._avatarList[0].width) > (obDisp.x-30)))
					{
						if(this._aiState == false && this.obListInStage[iCtr].aiJump=="false")
						{
							//this.setChildIndex(obDisp, this.getChildIndex(this._avatarList[0]));
							this.setChildIndex(this._avatarList[0], this.getChildIndex(obDisp));
							this.setChildIndex(this._avatarList[1], this.getChildIndex(this._avatarList[0]));
							this.obListInStage[iCtr].aiJump="true";
							runningManAi();
							this._aiState = true;						
						}
					}
					
					//Obstacle on Stage removal
					if (obDisp.x < 25)
					{
						while (obDisp.x != 0)
						{
							obDisp.x-=0.5
						}
						this.obListInStage.splice(iCtr, 1);
						this.removeChild(obDisp);
					}
				}
				iCtr+=1;
			}
		}
		private function userLogic():void
		{
			var normal:Number=0.25;
			var str:int=this._playerList[1].strength;
			var aiSpeed:Number=(str+50)*normal;
			//var u:int=0;
			if(this._inputList.length>0)
			{
				if(this._inputList[this._inputList.length-1].onStage=="false")
				{
					trace(this._inputList[this._inputList.length-1].state)
					if(this._inputList[this._inputList.length-1].state=="Hit")
					{
						this._avatarList[1].playAnimation("racejump", 1);
						if(this._avatarList[1].x <= 320)
						{
							this._avatarList[1].x+=aiSpeed+10;
						}
					}
					else
					{
						this._avatarList[1].playAnimation("racelose", 1);
						if(this._avatarList[1].x >= 90)
						{
							this._avatarList[1].x-=aiSpeed;
						}
					}
					this._inputList[this._inputList.length-1].onStage="true";
				}
			}
			
			/*
			while(u<this._inputList.length)
			{
				if(this._inputList[u].onStage=="false")
				{
					//trace(this._inputList[u].state)
					if(this._inputList[u].state=="Hit")
					{
						this._avatarList[1].playAnimation("racejump", 1);
						if(this._avatarList[1].x <= 320)
						{
							this._avatarList[1].x+=aiSpeed+10;
						}
					}
					else
					{
						this._avatarList[1].playAnimation("racelose", 1);
						if(this._avatarList[1].x >= 90)
						{
							this._avatarList[1].x-=aiSpeed;
						}
					}
					
					this._inputList[u].onStage="true"
					break;	
				}
				u+=1;
			}			*/
		}
		private function winLogic():void
		{
			var winner:String;
			var looser:String;
			
			this._gameState = false;
			if(this._avatarList[0].x > (this._avatarList[1].x + 30))
			{
				//ai winner
				this._avatarList[1].playAnimation("racelosestop", 1);
				this._avatarList[0].playAnimation("racewin", 1);
				//trace("Competitor Wins")
				winner="ai";
				looser="user";
			}
			else if(this._avatarList[0].x < (this._avatarList[1].x + 30))
			{
				//player winner
				this._avatarList[0].playAnimation("racelosestop", 1);
				this._avatarList[1].playAnimation("racewin", 1);
				//trace("Player Wins")
				winner="user";
				looser="ai";
			}
			else if(this._avatarList[0].x == (this._avatarList[1].x + 30))
			{
				//draw
				this._avatarList[0].playAnimation("racelosestop", 1);
				this._avatarList[1].playAnimation("racelosestop", 1);
				//trace("DRAW")
				winner="Draw";
				looser="Draw";
			}
			

			
			/*
			_versus = new VersusPopUpController( stage, 50, 50, this );
			//_reward = new VictoryRewardController( stage, 50, 50, this );
			if(winner=="Player")
			{
				_versus.setWindowValues(_versus.WIN , 1 );
				//_reward.setReward( _reward.WIN, 1, 1);
			}
			else
			{
				_versus.setWindowValues(_versus.LOSE , 1 );
				//_reward.setReward( _reward.LOSE, 1, 1);
			}
			_versus.setPicLeft(this._playerList[0].myPicture);
			_versus.setPicRight(this._playerList[1].myPicture);
			_versus.show();		
			//_reward.show();
			*/	
			this.playerRecord=this._inputList;
			this.raceData.winner=winner;
			this.raceData.looser=looser;
			masterRecord=new Object();
			masterRecord.gameName="runningman";
			masterRecord.xpEarned="0";
			masterRecord.apEarned="0";
			masterRecord.coinEarned="0";
			masterRecord.winner=winner;
			masterRecord.playerRecord=this._inputList;
			//gameEvent.dispatchEvent(new Event(GAME_FINISHED));
		}
		private function runningManAi():void
		{
			var base:int=100;
			var result:int = Math.floor((Math.random() * base) + 1);
			var intel:int = this._playerList[0].inteligence;
			var normal:Number=0.25;
			var str:int=this._playerList[0].strength;
			var aiSpeed:Number=(str+50)*normal;
			
			if (result<=intel)
			{
				_emo=new EmotionEffect();
				this._avatarList[0].playAnimation("racejump", 1);
				_emo.getEmotion(_emo.PERFEC_EMOTE, this._avatarList[0].x-(this._avatarList[0].width/1.8) , (this._avatarList[0].y), 1, this );
				_emo.name="EMOTICONS";

				this.addChild(_emo);
				
				if(this._avatarList[0].x <= 350)
				{
					this._avatarList[0].x+=aiSpeed;
				}
			}
			else
			{
				this._avatarList[0].playAnimation("racelose", 1);
				if(this._avatarList[0].x >= 120)
				{
					this._avatarList[0].x-=aiSpeed;
				}
			}
		}
		private function startGame():void
		{
			this._gameState = true;
			this._allowClick = true;
			this._timer.startGameTimer();
			this._bg.start()
			//this._bg.normalSpeed(); 
			this._bg.slowDown();
			this._avatarList[0].playAnimation("racerun", 1);
			this._avatarList[1].playAnimation("racerun", 1);			
		}
		private function destroyMe():void
		{
			this.gameEvent.dispatchEvent(new Event(GAME_FINISHED));
			this._timer.removeEventListener("TimeUpdated", monitorTime);
			this._timer.removeEventListener("GameLoop", gameLoop);
			//this._jumpSprite.removeEventListener(MouseEvent.CLICK, jumpClick);
			this.removeEventListener(MouseEvent.CLICK, jumpClick);
			this._avatarList[0].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandler1);
			this._avatarList[1].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandler2);
				
			this.removeEventListener("POST_VICTORY", removeEvent);
			this.removeEventListener("CLOSE", removeEvent);
			this.removeEventListener("SHARE_REWARD", removeEvent);

			var maxObjects:int=this.numChildren;
			var obCtr:int=0;
			
			this._topPanel.removeSelf();
			this._bg.removeItem();
			
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
			
			this._timer = null;
			this._slider = null;
			this._topPanel = null;
			this._bg = null;
		}
		private function restartGame():void
		{
			this.init(this._playerList, this._numberOfWeeks, this._roundsPerWeek, this._raceDuration, this._obstacleInterval, this._startDelay);	
	
		}
		public function destroyRunningMan():void
		{
			destroyMe();
		}
		private function tempFunc():void
		{
			trace("its called")
			if(this._pl1=="end" && this._pl2=="end")
			{
				this._timer.stopClockTimer();
				trace("END")
				this._gameState = false;
				//winLogic();

				//_reward = new VictoryRewardController( stage, 50, 50, this );
				//var popUp:UI_EndPopUp=new UI_EndPopUp();
				
				//this.addChild(popUp);
				//popUp.x+=130;
				//popUp.y+=40;
				if(this.raceData.winner=="user")
				{
					_versus = new VersusPopUpController(  140 ,  32 , this );
					//popUp.gotoAndStop(1);
					_versus.setWindowValues(_versus.WIN , 1 );
					//_reward.setReward( _reward.WIN, 1, 1);
					//this.addChild(this._playerList[1].myPicture)
					trace("Winner:"+this.raceData.winner)
					_versus.setPicLeft(this._playerList[1].myPicture);
					trace("Player"+this._playerList[1].name)
					_versus.setPicRight(this._playerList[0].myPicture);
					trace("Competitor"+this._playerList[0].name)
					_versus.show();
				}
				else if( this.raceData.winner != "user")
				{
					_versus = new VersusPopUpController( 140 ,  32 , this );
					//popUp.gotoAndStop(2);
					//this.addChild(this._playerList[0].myPicture)
					_versus.setWindowValues(_versus.LOSE , 1 );
					//_reward.setReward( _reward.LOSE, 1, 1);
					trace("Winner:"+this.raceData.winner)
					_versus.setPicLeft(this._playerList[1].myPicture);
					trace("Player"+this._playerList[1].name)
					_versus.setPicRight(this._playerList[0].myPicture);
					trace("Competitor"+this._playerList[0].name)
					_versus.show();
				}						

				//gameEvent.dispatchEvent(new Event(GAME_FINISHED));
				//_reward.show();
			}
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function avatarHandler1(evt:Event):void
		{
			if (this._aiState == true)
			{
				if(this.getChildByName("EMOTICONS")!=null)
				{
					_emo.removeEmotion();
					this.removeChild(this.getChildByName("EMOTICONS"));
				}
				this._avatarList[0].playAnimation("racerun", 1);
				this._aiState = false;
			}
			else
			{
				if(this._avatarList[0].getLastAnimation()=="racelosestop" || this._avatarList[0].getLastAnimation()=="racewin")
				{
					this._pl1="end";
					tempFunc()
					//trace("pl1")
				}
				else
				{
					this._avatarList[0].playAnimation("racerun", 1);
				}
			}

		}
		private function avatarHandler2(evt:Event):void
		{
			if(this._playerState == true)
			{
				this._playerState=false;
				this._avatarList[1].playAnimation("racerun", 1);
			}
			else
			{
				if(this._avatarList[1].getLastAnimation()=="racelosestop" || this._avatarList[1].getLastAnimation()=="racewin")
				{
					//trace("pl2")
					this._pl2="end";
					tempFunc()
				}
				else
				{
					this._avatarList[1].playAnimation("racerun", 1);
				}
			}
		}
		private function monitorTime(evt:Event):void
		{
			if ((evt.target.timerMinutes*60) + evt.target.timerSeconds <= this._startDelay)
			{
				//count down
				_c += 1;
				//this._topPanel.setRoundText( _c );
			}
			if(((evt.target.timerMinutes*60) + evt.target.timerSeconds) == this._startDelay || this._startDelay==0)
			{
				//Game Start! //trigger once
				startGame();
			}
			else
			{
				if (((evt.target.timerMinutes*60) + evt.target.timerSeconds) > this._startDelay)
				{
					this._slider.monitorTime(evt); //1 second tick					
				}
				if(((evt.target.timerMinutes*60) + evt.target.timerSeconds) == this._maxGameTime)
				{
					this._bg.stop();
					this._timer.stopClockTimer();
					this._timer.stopGameTimer();
					//this._gameState = false;
					winLogic();
				}
			}	
		}
		private function gameLoop(evt:Event):void
		{
			this._bg.onUpdate();
			this._topPanel.statusUpdate();
			this._slider.sliderLoop(); //100 ms tick
			this.updateColliderAndObstacleState();
			this.jumperButtonAndInputMonitor();
			this.updateCharacterAndObstacle();
		}
		private function jumpClick(evt:Event):void
		{
			if (this._allowClick == true)
			{
				this._playerClick = true;
				this._jumpSprite.alpha = 0.3
				_tempHolder=_obstacleName;
				userRecord();
				displayHitCondition();
			}
			else
			{
				//trace("not allowed yet")
			}
		}
		private function removeEvent(evt:Event):void
		{
			trace("click")
			//if(this._tempGame==true)
			//{
				destroyMe();
			//}
		}
	}
}