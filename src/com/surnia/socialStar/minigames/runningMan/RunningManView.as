package com.surnia.socialStar.minigames.runningMan
{
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.minigames.components.avatar.Avatar;
	import com.surnia.socialStar.minigames.components.emotion.MiniGame_Emotion;
	import com.surnia.socialStar.minigames.components.parallaxBg.ParallaxManager;
	import com.surnia.socialStar.minigames.components.parallaxBg.parallaxBg;
//	import com.surnia.socialStar.minigames.components.parallaxBg.parallaxBgController;
//	import com.surnia.socialStar.minigames.components.parallaxBg.parallaxBgView;
	import com.surnia.socialStar.minigames.components.parallaxBg.parallaxObject;
	import com.surnia.socialStar.minigames.components.portrait.MiniGame_Portrait;
	import com.surnia.socialStar.minigames.components.raceProgressBar.MiniGame_RaceProgressBar;
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	import com.surnia.socialStar.minigames.popupUI.test.VersusPopUpController;
	import com.surnia.socialStar.test.MiniGameRunningManTopPanel;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	/**
	 * ...
	 * @author Droids
	 */
	public class RunningManView extends MovieClip
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _model:RunningMan;
		private var _controller:RunningManController;
		private var _timer:MiniGame_Timer;
		private var _parallaxBg:parallaxBg;
		//private var _parallaxBgController:parallaxBgController;
		//private var _parallaxBgView:parallaxBgView;
		private var _cameraPan:Object;
		private var _camfocusY:Number;
		private var _allowClick:Boolean;
		private var _pl1:String;
		private var _pl2:String;
		private var _inputList:Array;
		private var _obstacleOnStage:Array;
		private var _obstacleList:Array;
		private var _aiState:Boolean;
		private var _plState:Boolean;
		private var _obsHolderAi:String;
		private var _obsHolderPl:String;
		private var _aiCollide:int;
		private var _plCollide:int;
		private var _aiJump:Boolean;
		private var _aiOnStage:Boolean;
		private var _dropHolder:Object;
		private var _countDown:int;
		private var _progressBar:MiniGame_RaceProgressBar;	
		private var _minutes:int;
		private var _seconds:int;
		private var _playerLeadCtr:int;
		private var _awardPlacement:Number;
		private var _pbRun:Boolean;
		
		private var _parallaxBgView:ParallaxManager;
		//Domz
		private var _topPanel:MiniGameRunningManTopPanel;
		//sir JC
		private var _popUpUIManager:PopUpUIManager;		
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function RunningManView(model:RunningMan, controller:RunningManController)
		{
			//_popUpUiManager = PopUpUIManager.getInstance();
			this._model=model;
			this._controller=controller;
			this.addEventListener(Event.ADDED_TO_STAGE, startBuild);
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		private function init():void
		{		
			//Camera Panning
			this._cameraPan=new Object();
			this._cameraPan.scroll_y = 0;
			this._cameraPan.keepplayerat_y = 270;
			
			this._allowClick=false;
			this._pl1="blank";
			this._pl2="blank";
			this._inputList=new Array();
			this._obsHolderAi="blank";
			this._obsHolderPl="blank";
			this._awardPlacement=560;

			//Timer
			this._timer = new MiniGame_Timer(90);
			
			//Parallax Bg
			var objTypes:Array=new Array();
			/*
			var objSky:parallaxObject=new parallaxObject("sky", new Scene_Sky(), "image", "holder" , 0, "normal", "still", "1", 0, 0, 584, 489.95, "fix", "fix");
			var objTrack:parallaxObject=new parallaxObject("track", new Scene_Track(), "image", "holder", 8, "normal", "veryfast", "continuous", 0, 507.45, 590, 62, "fix", "fix");
			var objWall:parallaxObject=new parallaxObject("wall", new Scene_Wall(), "image", "holder", 7, "normal", "still", "1", 0, 481, 590, 27, "fix", "fix");
			var objTreeA:parallaxObject=new parallaxObject("treeA", new Scene_Tree01(), "image", "holder", 6, "medium", "fast", "medium", 0, 375, 82, 119, "fix", "fix");
			var objTreeB:parallaxObject=new parallaxObject("treeB", new Scene_Tree02(), "image", "holder", 5, "small", "medium", "large", 0, 430, 40, 58, "fix", "fix");
			var objCloudA:parallaxObject=new parallaxObject("cloudA", new Scene_Cloud(), "image", "holder", 4, "medium", "slow", "verylarge", 0, 500, 125, 31, "cloud", "cloud");
			var objMount:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 3, "large", "slow", "small", 0, 481, 201, 46, "fix", "fix");
			//var objMount1:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 2, "verylarge", "veryslow", "small", 0, 481, 201, 46, "fix", "fix");
			//var objCloudB:parallaxObject=new parallaxObject("cloudB", new Scene_Cloud(), "image", "holder", 1, "very small", "veryslow", "verysmall", 0, 400, 60, 50, "fix", "random");
			objTypes.push(objSky);
			objTypes.push(objTrack);
			objTypes.push(objWall);
			objTypes.push(objTreeA);
			objTypes.push(objTreeB);
			objTypes.push(objCloudA);
			objTypes.push(objMount);
			//objTypes.push(objMount1);
			//objTypes.push(objCloudB);
			this._parallaxBg=new parallaxBg();
			this._parallaxBgController=new parallaxBgController(this._parallaxBg);
			this._parallaxBgView=new parallaxBgView(this._parallaxBg, this._parallaxBgController, objTypes);
			*/
			var objSky:parallaxObject=new parallaxObject("sky", new Scene_Sky(), "image", "holder" , 0, "scaleY", "still", "1", 0, 0, 584, 489.95, "fix", "fix");
			var objTrack:parallaxObject=new parallaxObject("track", new Scene_Track(), "image", "holder", 6, "normal", "veryfast", "continuous", 0, 489.95, 578, 62, "fix", "fix");
			var objWall:parallaxObject=new parallaxObject("wall", new Scene_Wall(), "image", "holder", 5, "normal", "veryfast", "continuous", 0, 464, 578, 27, "fix", "fix");
			var objTreeA:parallaxObject=new parallaxObject("treeA", new Scene_Tree01(), "image", "holder", 4, "small", "fast", "large", 0, 475, 82, 119, "fix", "fix");
			var objTreeB:parallaxObject=new parallaxObject("treeB", new Scene_Tree02(), "image", "holder", 3, "small", "medium", "verylarge", 0, 470, 40, 58, "fix", "fix");
			var objMount:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 2, "large", "slow", "small", 0, 475, 201, 46, "fix", "fix");
			
			var objCloudA:parallaxObject=new parallaxObject("cloudA", new Scene_Cloud(), "image", "holder", 1, "medium", "slow", "verylarge", 0, 500, 125, 31, "cloud", "cloud");
			//var objMount1:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 2, "verylarge", "slow", "small", 0, 481, 201, 46, "fix", "fix");
			//var objCloudB:parallaxObject=new parallaxObject("cloudB", new Scene_Cloud(), "image", "holder", 1, "verysmall", "veryslow", "verylarge", 0, 400, 60, 50, "cloud", "cloud");
			
			objTypes.push(objSky);
			objTypes.push(objTrack);
			objTypes.push(objWall);
			objTypes.push(objTreeA);
			objTypes.push(objTreeB);
			objTypes.push(objCloudA);
			objTypes.push(objMount);
			//objTypes.push(objMount1);
			//objTypes.push(objCloudB);
			this._parallaxBg=new parallaxBg();
			this._parallaxBg=new parallaxBg();
			this._parallaxBg.stageWidth=584;
			this._parallaxBg.stageHeight=551.95;
			this._parallaxBgView=new ParallaxManager(this._parallaxBg, objTypes);
			
			//var drum:Ob_Drum = new Ob_Drum();
			//var banana:Ob_Banana = new Ob_Banana();
			var drumMC:MC_Drum=new MC_Drum();
			drumMC.name="drum"
			var obstacleTypes:Array = new Array();
			//obstacleList.push(null);
			obstacleTypes.push(drumMC);
			//obstacleList.push(banana);
			this._controller.obstacleTypes=obstacleTypes;
			
			var ap:AW_AP=new AW_AP();
			var xp:AW_XP=new AW_XP();
			var coin:AW_Coin=new AW_Coin();
			var awardTypes:Array=new Array();
			awardTypes.push(ap); //0
			awardTypes.push(xp); //1
			awardTypes.push(coin); //2
			this._controller.awardTypes=awardTypes;	
				
			setDisplay();
			setListeners();
			startClockTimer();
		}
		private function setDisplay():void
		{
			var screen:Bitmap = new Bitmap(new UI_Screen()); 
			screen.name = "screenUi"
			this.addChild(screen);
			var mask:Bitmap=new Bitmap(new Scene_Sky());
			mask.width=584;
			mask.height=378.95;
			mask.x=29.3;//+this._xAxis;
			mask.y=25.5;//+this._yAxis;
			this.addChild(mask);
			
			//layers
			var layersList:Array=new Array();
			var screenLayer:Sprite=new Sprite();
			screenLayer.name="screenBg";
			this._parallaxBgView.name="parallaxBg";
			this._parallaxBgView.x=29.3;
			//this._parallaxBgView.y=-164;
			this._parallaxBgView.y=-144;
			screenLayer.addChild(this._parallaxBgView);
			var objectHolder:Sprite=new Sprite();
			screenLayer.addChild(objectHolder);
			screenLayer.mask=mask;
			this.addChild(screenLayer);
			//Avatar
			var avatarList:Array=new Array;
			var avatarChar:Avatar;
			var maxLength:int = this._model.playerList.length;
			var playerList:Array=this._model.playerList;
			for (var num:int = 0; num <maxLength; num++)
			{
				avatarChar = new Avatar(playerList[num].charInfo, playerList[num].gender);
				avatarChar.name = "gamePlayer"+playerList[num].name;
				avatarChar.ymov=0;
				avatarChar.accel=0;
				avatarChar.xmov=0;
				avatarChar.gravity=1.4;
				
				avatarChar.myHeight=150.1;
				avatarChar.myWidth=78.45;
				
				var avatarHolder:Sprite=new Sprite();
				var portrait:MiniGame_Portrait;
				var playerEmotion:MiniGame_Emotion;
				if(playerList[num].isPlayer==true)
				{
					avatarChar.isPlayer=true;
					//avatarChar.x = 90;
					//avatarChar.y = 270;
					//avatarHolder=new Sprite();
					//avatarChar.myHeight=150.1;
					//avatarChar.myWidth=78.45;
					
					avatarChar.scaleX1=-1
					avatarHolder.x=90;
					avatarHolder.y=270;
					avatarHolder.name="playerSprite"
						
					if(playerList[num].myPicture!=null)
					{
						portrait=new MiniGame_Portrait(new Bitmap(playerList[num].myPicture.bitmapData), new Bitmap(new UI_PortraitHolder()), new MC_ArrowAnim());
					}
					else
					{
						portrait=new MiniGame_Portrait(null, new Bitmap(new UI_PortraitHolder()), new MC_ArrowAnim());
					}
					portrait.name="playerPortrait"
					portrait.y-=portrait.height+10;
					avatarChar.portrait=portrait;
					
					playerEmotion=new MiniGame_Emotion();
					avatarChar.emotion=playerEmotion;
					
					avatarHolder.addChild(avatarChar);
					avatarHolder.addChild(portrait);
					
					avatarHolder.addChild(playerEmotion);
					
					this.addChild(avatarHolder);
				}
				else
				{//AI
					avatarChar.isPlayer=false;
					//avatarChar.x = 120;
					//avatarChar.y = 245;
					//avatarChar.myHeight=150.1;
					//avatarChar.myWidth=78.45;
					
					avatarChar.scaleX1=-1
					avatarHolder.x=120;
					avatarHolder.y=245;
					avatarHolder.name="aiSprite"
						
					if(playerList[num].myPicture!=null)
					{
						portrait=new MiniGame_Portrait(new Bitmap(playerList[num].myPicture.bitmapData), new Bitmap(new UI_PortraitHolder()), new MC_ArrowAnim());
					}
					else
					{
						portrait=new MiniGame_Portrait(null, new Bitmap(new UI_PortraitHolder()), new MC_ArrowAnim());
					}
					portrait.name="aiPortrait"
					portrait.y-=portrait.height+10;
					avatarChar.portrait=portrait;
					
					playerEmotion=new MiniGame_Emotion();
					avatarChar.emotion=playerEmotion;
					
					avatarHolder.addChild(avatarChar);
					avatarHolder.addChild(portrait);
					
					avatarHolder.addChild(playerEmotion);
					
					screenLayer.addChild(avatarHolder);
				}
				avatarList.push(avatarChar);
			}
			this._controller.avatarList=avatarList;
			layersList.push(screenLayer);
			this._controller.layersList=layersList;		
						
			this._topPanel = new MiniGameRunningManTopPanel(stage, true,  screen.x, screen.y, this);
			this._topPanel.name="toppanel"
				
			//Race Progress Bar
			var a:MiniGame_Portrait;
			var b:MiniGame_Portrait;
			if(playerList[0].myPicture!=null)
			{
				a=new MiniGame_Portrait(new Bitmap(playerList[0].myPicture.bitmapData), new Bitmap(new UI_PortraitHolder()), null);
			}
			else
			{
				a=new MiniGame_Portrait(null, new Bitmap(new UI_PortraitHolder()), null);
			}
			a.width=a.width/2;
			a.height=a.height/2;
			if(playerList[1].myPicture!=null)
			{
				b=new MiniGame_Portrait(new Bitmap(playerList[1].myPicture.bitmapData), new Bitmap(new UI_PortraitHolder()), null);
			}
			else
			{
				b=new MiniGame_Portrait(null, new Bitmap(new UI_PortraitHolder()), null);
			}
			b.width=b.width/2;
			b.height=b.height/2;
			
			this._progressBar=new MiniGame_RaceProgressBar(new Bitmap(new UI_ProgressBar()), b, a);
			this.addChild(this._progressBar);
			this._progressBar.x=83.45;
			this._progressBar.y=40.85;
		}
		private function setListeners():void
		{
			this._timer.addEventListener("TimeUpdated", monitorTime);
			this._timer.addEventListener("GameLoop", gameLoop);
			this.addEventListener(MouseEvent.MOUSE_UP, jumpClick);
			this._controller.avatarList[0].avatarEvent.addEventListener("FinishAnimationLoop", avatarHandlerAI);
			this._controller.avatarList[1].avatarEvent.addEventListener("FinishAnimationLoop", avatarHandlerPlayer);
			
			this._model.addEventListener("RemovedObstacle", removedObstaclesOnStage);
			this._model.addEventListener("UpdateObstacleList", updateObstaclesOnStage);
			this._model.addEventListener("UpdateObstacleListContent", updateObstacleListData);
			
			this.addEventListener("POST_VICTORY", removeEvent);
			this.addEventListener("CLOSE", removeEvent);
			this.addEventListener("SHARE_REWARD", removeEvent);
		}
		private function startClockTimer():void
		{
			this._timer.startClockTimer();
			this._model.avatarList[0].playAnimation(GlobalData.RIVAL_READY, 1, 0);
			this._model.avatarList[1].playAnimation(GlobalData.PLAYER_READY, 1, 0);
		}
		private function startGame():void
		{
			this._controller.gameState="GAME_PLAYS";
			this._allowClick = true;
			this._timer.startGameTimer();
			this._model.avatarList[0].playAnimation(GlobalData.RIVAL_RUN, 1, 0);
			this._model.avatarList[1].playAnimation(GlobalData.PLAYER_RUN, 1, 0);
		}
		private function runningManAi():void
		{
			var base:int=100;
			var result:int = Math.floor((Math.random() * base) + 1);
			var intel:int = this._model.playerList[0].inteligence;
			
			var avatars:Array=this._model.avatarList;
			
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			var disp:DisplayObject=spLayer.getChildByName("aiSprite")
			if (result<=intel)
			{
				if(avatars[0].jumpState==false)
				{
					avatars[0].playAnimation(GlobalData.RIVAL_JUMP, 1, 0);
					avatars[0].ymov=-16;	
					avatars[0].gravity=1.4;
					avatars[0].jumpState=true;
					this._controller.avatarList=avatars;
					this._aiJump=true;
				}	
			}
			else
			{
				//fail to jump
				this._aiJump=false;
			}
		}
		private function positionAiPortrait():void
		{
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			var disp:DisplayObject=spLayer.getChildByName("aiSprite");	
			if(disp.x<0)
			{
				this._model.avatarList[0].portrait.y=-140;
				this._model.avatarList[0].portrait.x=160;
				this._model.avatarList[0].portrait.moveArrow(1);
			}
			else if(disp.x>620)
			{
				this._model.avatarList[0].portrait.y=-140;
				this._model.avatarList[0].portrait.x=-190;
				this._model.avatarList[0].portrait.moveArrow(5);
			}
			else if(disp.x > 0 && disp.x < 620)
			{
				this._model.avatarList[0].portrait.y=-105.85;
				this._model.avatarList[0].portrait.x=0;
				this._model.avatarList[0].portrait.moveArrow(3);
			}
		}
		private function winLogic():void
		{
			var winner:String;
			var looser:String;
			//this._gameState = false;
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			var dispPl:DisplayObject=this.getChildByName("playerSprite");	
			var dispAI:DisplayObject=spLayer.getChildByName("aiSprite");	
			
			var avatars:Array=this._model.avatarList;
			
			if(dispAI.x > (dispPl.x + 30))
			{
				//ai winner
				avatars[1].emotion.playEmo(5);
				avatars[1].playAnimation(GlobalData.PLAYER_LOSE, 1, 0);
				avatars[0].emotion.playEmo(6);
				avatars[0].playAnimation(GlobalData.RIVAL_WIN, 1, 0);
				winner="ai";
				looser="user";
			}
			else if(dispAI.x < (dispPl.x + 30))
			{
				//player winner
				avatars[1].emotion.playEmo(6);
				avatars[1].playAnimation(GlobalData.PLAYER_WIN, 1, 0);
				avatars[0].emotion.playEmo(5);
				avatars[0].playAnimation(GlobalData.RIVAL_LOSE, 1, 0);				
				winner="user";
				looser="ai";
			}
			else if(dispAI.x == (dispPl.x + 30))
			{
				//draw
				avatars[1].emotion.playEmo(5);
				avatars[1].playAnimation(GlobalData.PLAYER_LOSE, 1, 0);
				avatars[1].emotion.playEmo(5);
				avatars[0].playAnimation(GlobalData.RIVAL_LOSE, 1, 0);
				winner="ai";
				looser="user";
			}
			this._controller.raceData.winner=winner;
			this._controller.raceData.looser=looser;			
				
			var masterRecord:Object=new Object();
			masterRecord.gameName="runningman";
			var xp:int=0;
			var ap:int=0;
			var coin:int=0;
			var recordList:Array=this._model.inputList;
			var maxRecord:int=recordList.length;
			for(var num:int=0; num<maxRecord; num++)
			{
				if(recordList[num].xp=="1")
				{
					xp++;
				}
				if(recordList[num].ap=="1")
				{
					ap++;
				}
				if(recordList[num].coin=="1")
				{
					coin++;
				}				
			}
			masterRecord.xpEarned=String(xp);
			masterRecord.apEarned=String(ap);
			masterRecord.coinEarned=String(coin);
			masterRecord.winner=winner;
			masterRecord.playerRecord=this._model.inputList;
			this._controller.masterRecord=masterRecord;
			//trace("GameName:" + masterRecord.gameName + " xpEarned:" + masterRecord.xpEarned + " apEarned:" + masterRecord.apEarned + " coinEarned:" + masterRecord.coinEarned + " winner:" +masterRecord.winner)
		}
		private function raceResult():void
		{
			if(this._pl1=="end" && this._pl2=="end")
			{
				//this._gameState = false;
				
				//_reward = new VictoryRewardController( stage, 50, 50, this );
				//var popUp:UI_EndPopUp=new UI_EndPopUp();
				
				//this.addChild(popUp);
				//popUp.x+=130;
				//popUp.y+=40;
				var _versus:VersusPopUpController;
				var sp1:Sprite =new Sprite();
				var sp2:Sprite=new Sprite();
				if(this._model.playerList[1].myPicture!=null)
				{
					sp1.addChild(new Bitmap(this._model.playerList[1].myPicture.bitmapData));
					sp1.width+=3;
					sp1.height+=3;
				}
				if(this._model.playerList[0].myPicture!=null)
				{
					sp2.addChild(new Bitmap(this._model.playerList[0].myPicture.bitmapData));
					sp2.width+=3;
					sp2.height+=3;
				}
				if(this._model.raceData.winner=="user")
				{
					_versus = new VersusPopUpController(  140 ,  31 , this );
					_versus.setWindowValues(_versus.WIN , 1 );
					//this._model.playerList[1].myPicture.width+=7;
					//this._model.playerList[1].myPicture.height+=7;
					//this._model.playerList[0].myPicture.width+=7;
					//this._model.playerList[0].myPicture.height+=7;
					if(this._model.playerList[1].myPicture!=null)
					{
						_versus.setPicLeft(sp1);
					}
					if(this._model.playerList[0].myPicture!=null)
					{
						_versus.setPicRight(sp2);
					}
					_versus.show();
				}
				else if(this._model.raceData.winner == "ai")
				{
					_versus = new VersusPopUpController( 140 ,  31 , this );
					_versus.setWindowValues(_versus.LOSE , 1 );
					//this._model.playerList[1].myPicture.width+=7;
					//this._model.playerList[1].myPicture.height+=7;
					//this._model.playerList[0].myPicture.width+=7;
					//this._model.playerList[0].myPicture.height+=7;
					if(this._model.playerList[1].myPicture!=null)
					{
						_versus.setPicLeft(sp1);
					}
					if(this._model.playerList[0].myPicture!=null)
					{
						_versus.setPicRight(sp2);
					}
					_versus.show();
				}						
			}
		}
		private function obstaclesRemove():void
		{
			var removeObstacle:String= this._controller.checkObstacleOnStage();

			if (removeObstacle != "blank")
			{
				var layerList:Array=this._model.layersList;
				var spLayer:Sprite=layerList[0];
				this._obstacleOnStage = this._model.obstacleList;
				spLayer.removeChild(spLayer.getChildByName(removeObstacle));
				
			}
		}
		private function checkRaceLeader():String
		{
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			var dispPl:DisplayObject=this.getChildByName("playerSprite");	
			var dispAI:DisplayObject=spLayer.getChildByName("aiSprite");	
			var result:String="RunningMan:malfunction"
			if(dispAI.x > (dispPl.x + 30))
			{
				//ai lead
				result="ai";
			}
			else if(dispAI.x < (dispPl.x + 30))
			{
				//player lead
				result="player";
			}
			else if(dispAI.x == (dispPl.x + 30))
			{
				//draw
				result="ai";
			}		
			return result;
		}
		private function aiAcceleration():void
		{
			var avatars:Array=this._model.avatarList;
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			var disp:DisplayObject=spLayer.getChildByName("aiSprite");
			if(avatars[0].accelState==true)
			{
				if(disp.x >= -80 && disp.x <= 700)
				{
					avatars[0].xmov+=avatars[0].accel;
					disp.x+=avatars[0].xmov;
					this._progressBar.rival.x+=avatars[0].xmov/30;
				}
			}
			if(disp.x < -80)
			{
				disp.x=-80;
			}
			if(disp.x > 700)
			{
				disp.x=700;
			}
			if(disp.x >= 0 && disp.x <= 613)
			{
				this._aiOnStage=true;
			}
			else
			{
				this._aiOnStage=false;
			}
		}
		private function gravity():void
		{
			var avatars:Array=this._model.avatarList;
			var maxAvatar:int=avatars.length;
			for(var num:int=0; num<maxAvatar; num++)
			{
				if(avatars[num].jumpState==true)
				{
					//gravity
					var disp:DisplayObject;
					if(avatars[num].isPlayer==true)
					{
						disp=this.getChildByName("playerSprite");
					}
					else
					{
						var layerList:Array=this._model.layersList;
						var spLayer:Sprite=layerList[0];
						disp=spLayer.getChildByName("aiSprite");
					}
					avatars[num].ymov+=avatars[num].gravity;
					disp.y+=avatars[num].ymov
					//acceleration
					/*if(avatars[num].jumpState==true && avatars[num].isPlayer==false)
					{
					avatars[num].xmov+=avatars[num].accel;
					disp.x+=avatars[num].xmov;
					}*/
					
					if(disp.y>270 && avatars[num].isPlayer==true)
					{
						avatars[num].jumpState=false;
						disp.y=270;
						avatars[num].ymov*=-1;
					}
					if(disp.y>245 && avatars[num].isPlayer==false)
					{
						avatars[num].jumpState=false;
						disp.y=245;
						avatars[num].ymov*=-1;
						disp.x+=avatars[num].accel=0;
						avatars[num].xmov=0;
					}
				}
			}
			this._controller.avatarList=avatars;
			
			if(_dropHolder!=null)
			{
				if(_dropHolder.onGround==false)
				{
					_dropHolder.ymov+=0.7;
					_dropHolder.bitmap.y+=_dropHolder.ymov
					if(_dropHolder.bitmap.y>253.85)
					{
						_dropHolder.bitmap.alpha-=0.1
					}
					if(_dropHolder.bitmap.y>363.85)
					{
						_dropHolder.bitmap.y=363.85;
						_dropHolder.ymov=0;
						//_dropHolder.onGround=true
						this.removeChild(_dropHolder.bitmap);
						_dropHolder=null;
					}
				}
				/*else if(_dropHolder.onGround==true)
				{
					_dropHolder.xmov+=0.7;
					_dropHolder.bitmap.x+=_dropHolder.xmov
					if(_dropHolder.bitmap.x>_awardPlacement)
					{
						_dropHolder.bitmap.x=_awardPlacement;
						_awardPlacement-=25;
						_dropHolder.xmov=0;
						_dropHolder=null;
					}
				}*/
			}
		}
		private function renderScreen():void
		{
			var screenLayer:DisplayObject=this.getChildByName("screenBg");
			var ideal_y:Number =this._cameraPan.keepplayerat_y - _camfocusY;
			var step_y:Number = Math.floor(screenLayer.y + (ideal_y-screenLayer.y)*.2);
			screenLayer.y = step_y;
		}
		private function checkCollision():void
		{
			if(this._model.obstacleList[0]!=null)
			{
				var avatars:Array=this._model.avatarList;
				var layerList:Array=this._model.layersList;
				var spLayer:Sprite=layerList[0];
				
				var maxLength:int=this._obstacleList.length;
				var num:int=0;
				while(num<maxLength)
				{
					var obstacle:DisplayObject=spLayer.getChildByName(this._model.obstacleList[num].obstacleName);
					//ai
					var dispObAi:DisplayObject=spLayer.getChildByName("aiSprite");
					var dispObAi1:DisplayObject=avatars[0];
					var mc:MovieClip=this._model.obstacleList[num].myObCollider;
					
					if((obstacle.x<(dispObAi.x)) && (this._obsHolderAi!=this._model.obstacleList[num].obstacleName))
					{
						this._obsHolderAi=this._model.obstacleList[num].obstacleName;
						if(this._aiCollide==0)
						{//Perfect Jump AI
							avatars[0].emotion.playEmo(4);
							//avatars[0]=gameLogic(0, avatars[0], dispObAi, true);
						}
						else
						{//Miss Ai
							avatars[0].emotion.playEmo(2);
							//avatars[0]=gameLogic(0, avatars[0], dispObAi, false);
						}
					}
					
					if(dispObAi1.hitTestObject(this._model.obstacleList[num].myCollider)==true)
					{
						if(this._aiState == false)
						{
							
							this._aiCollide=0;
							this.runningManAi();
							this._aiState = true;
							if(this._aiJump==true)
							{
								avatars[0]=gameLogic(0, avatars[0], dispObAi, true);
								//trace("outside ai jump")
							}
						}
					}
					if(dispObAi1.hitTestObject(mc)==true)
					{
						if(this._aiCollide==0)
						{
							this._aiCollide++;
							if(this._aiJump==true)
							{
								avatars[0].playAnimation(GlobalData.RIVAL_CRY, 1, 0);
								//trace("outside ai jump")
							}
							else
							{
								avatars[0].playAnimation(GlobalData.RIVAL_CRY, 1, 0);
								//avatars[0].playAnimation(GlobalData.RACE_RIVAL_FALL, 1, 0);
								//trace("outside ai fail jump")
							}
							avatars[0]=gameLogic(0, avatars[0], dispObAi, false);
						}
					}
					//player
					var dispObPl:DisplayObject=this.getChildByName("playerSprite");
					if((obstacle.x<(dispObPl.x)) && (this._obsHolderPl!=this._model.obstacleList[num].obstacleName))
					{
						this._obsHolderPl=this._model.obstacleList[num].obstacleName;
						var playerResult:Object=new Object();
						if(this._plCollide==0)
						{//Perfect
							playerResult.user="player";
							playerResult.state="Perfect";
							if(avatars[1].jumpState==true)
							{
								playerResult.jump="success_jump";
							}
							else
							{
								playerResult.jump="cheat_jump";
							}
							playerResult.obstacle=this._model.obstacleList[num].obstacleName;
							var ob:Object=this._controller.generateAwardItems();
							switch(ob.id)
							{
								case 0: //ap
								{
									playerResult.xp="0";
									playerResult.ap="1";
									playerResult.coin="0";
									break;
								}
								case 1: //xp
								{
									playerResult.xp="1";
									playerResult.ap="0";
									playerResult.coin="0";
									break;
								}
								case 2: //coin
								{
									playerResult.xp="0";
									playerResult.ap="0";
									playerResult.coin="1";
									break;
								}					
							}
							playerResult.raceleader=checkRaceLeader();
							monitorPlayerState(playerResult, ob);
							
							avatars[1].emotion.playEmo(4);
							
							//avatars[0].jumpState=true;
							avatars[0]=gameLogic(1, avatars[0], dispObAi, false);
						}
						else
						{//Miss
							playerResult.user="player";
							playerResult.state="Miss";
							if(avatars[1].jumpState==true)
							{
								playerResult.jump="miss_jump";
								avatars[1].playAnimation(GlobalData.PLAYER_CRY, 1, 0);
							}
							else
							{
								playerResult.jump="no_jump";
								avatars[1].playAnimation(GlobalData.PLAYER_FALL, 1, 0);
							}
							playerResult.obstacle=this._model.obstacleList[num].obstacleName;
							playerResult.xp="0";
							playerResult.ap="0";
							playerResult.coin="0";
							playerResult.raceleader=checkRaceLeader();
							monitorPlayerState(playerResult, null);
							avatars[1].emotion.playEmo(2);
							//avatars[0].jumpState=true;
							
							
							if(this._aiJump==false)
							{
								avatars[0]=gameLogic(1, avatars[0], dispObAi, true);
								//trace("outside ai jump")
							}
						}
					}
					
					if(dispObPl.hitTestObject(mc)==true)
					{	//miss and final
						if(this._plCollide==0)
						{
							this._plCollide++;
						}
					}
					else if(dispObPl.hitTestObject(this._model.obstacleList[num].myCollider)==true)
					{
						if(this._plState == false)
						{
							//reset
							this._plCollide=0;
							this._plState =true;
						}
					}
					num++;
				}//loop
				this._controller.avatarList=avatars;
			}
		}
		private function gameLogic(index:int, avatar:Avatar, character:DisplayObject, dec:Boolean):Avatar
		{
			var normal:Number=0.25;
			var base:Number=50;
			var str:int=this._model.playerList[index].strength;
			var speed:Number=(str/base)*normal;
			if(index==0) //ai action
			{
				if(character.x >= -80 && character.x <= 700)
				{
					if(dec==true)
					{
						avatar.accel=speed;
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr-=1;
						//trace("on stage-ai: overtake->" + this._playerLeadCtr)
					}
					else
					{
						speed*=-1;
						avatar.accel=speed;
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr+=1;
						//trace("on stage-ai: miss->" + this._playerLeadCtr)
					}
				}
				else if(character.x > 590)
				{
					if(dec==false)
					{
						speed*=-1;
						avatar.accel=speed;
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr+=1;
						//trace("off stage-ai: miss->" + this._playerLeadCtr)
					}
				}
				else if(character.x < 0)
				{
					if(dec==true)
					{
						avatar.accel=speed;
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr-=1;
						//trace("off stage-ai: overtake->" + this._playerLeadCtr)
					}
				}
			}
			else //player action
			{
				if(character.x >= -80 && character.x <= 700)
				{
					if(dec==true)
					{
						avatar.accel=speed; //miss
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr-=1;
						//trace("on stage-player: miss->" + this._playerLeadCtr)
						
					}
					else
					{
						speed*=-1;
						avatar.accel=speed; //overtake
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr+=1;
						//trace("on stage-player: overtake->"  + this._playerLeadCtr)
					}
				}
				else if(character.x > 590)
				{
					if(dec==false)
					{
						speed*=-1;
						avatar.accel=speed; //overtake
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr+=1;
						//trace("off stage-player: overtake->"  + this._playerLeadCtr)
					}
				}
				else if(character.x < 0)
				{
					if(dec==true)
					{
						avatar.accel=speed; //miss
						avatar.xmov=0;
						avatar.accelState=true;
						//this._playerLeadCtr-=1;
						//trace("off stage-player: miss->" + this._playerLeadCtr)
					}
				}
			}
			return avatar;
		}
		private function destroyMe():void
		{		
			this._model.gameState="GAME_END";
			this._timer.removeEventListener("TimeUpdated", monitorTime);
			this._timer.removeEventListener("GameLoop", gameLoop);
			//this.removeEventListener(MouseEvent.MOUSE_UP, jumpClick);
			//this._controller.avatarList[0].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandlerAI);
			//this._controller.avatarList[1].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandlerPlayer);
			this._model.avatarList[0].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandlerAI);
			this._model.avatarList[1].avatarEvent.removeEventListener("FinishAnimationLoop", avatarHandlerPlayer);
			this._model.avatarList[0].terminateMe();
			this._model.avatarList[1].terminateMe();
			
			this.removeEventListener("POST_VICTORY", removeEvent);
			this.removeEventListener("CLOSE", removeEvent);
			this.removeEventListener("SHARE_REWARD", removeEvent);
			
			
			
			this._topPanel.removeSelf();
			this._timer.destroyMe();
			
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
			this._model=null;
			this._controller=null;
			this._timer=null;
			
			this._parallaxBg=null;
			//this._parallaxBgController=null;
			this._parallaxBgView=null;
			
			this._cameraPan=null;
			
			this._pl1=null;
			this._pl2=null;
			this._inputList = null;
			
			_popUpUIManager = PopUpUIManager.getInstance();
			_popUpUIManager.removeWindow( WindowPopUpConfig.RUNNING_MAN_POP_UP );
		}
		private function monitorPlayerState(playerState:Object, awardItem:Object):void
		{

			if(playerState.state=="Perfect")
			{
				this._topPanel.getStatus(2, 60, 350 ,150);
			}
			else if(playerState.state=="Good")
			{
				this._topPanel.getStatus(0, 60, 350 ,150);
			}
			else if(playerState.state=="Miss")
			{
				this._topPanel.getStatus(1, 60, 350 ,150);
			}
			if(awardItem!=null)
			{
				_dropHolder=awardItem;
				this.addChild(_dropHolder.bitmap);
			}
			this._controller.userRecord(playerState); //save data
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		private function startBuild(evt:Event):void
		{
			init();
		}
		private function monitorTime(evt:Event):void
		{
			var lapseTime:int = Number(evt.target.timerSeconds + (evt.target.timerMinutes * 60));
			if ((evt.target.timerMinutes*60) + evt.target.timerSeconds <= 4)//this._model.startDelay)
			{
				//count down
				this._countDown+=1;
				if(this._countDown==1)
				{
					var fxready:Bitmap=new Bitmap(new FX_Ready());
					fxready.name="fx_ready"
					fxready.x=(646/2)-50;
					fxready.y=(458/3);
					this.addChild(fxready);
				}
				else if(this._countDown==2)
				{
					this.removeChild(this.getChildByName("fx_ready"));
					var fxset:Bitmap=new Bitmap(new FX_Set());
					fxset.name="fx_set";
					fxset.x=(646/2)-25;
					fxset.y=(458/3);
					this.addChild(fxset);
				}
				else if(this._countDown==3)
				{
					this.removeChild(this.getChildByName("fx_set"));
					var fxgo:Bitmap=new Bitmap(new FX_Go());
					fxgo.name="fx_go";
					fxgo.x=(646/2)-25;
					fxgo.y=(458/3);
					this.addChild(fxgo);
					
					var fxglove:MovieClip=new MC_Gloves();
					fxglove.name="fx_glove";
					fxglove.x=(646/2)-40;
					fxglove.y=(458/3)+50;
					this.addChild(fxglove);
				}
				else if(this._countDown==4)
				{
					this.removeChild(this.getChildByName("fx_go"));
					this.removeChild(this.getChildByName("fx_glove"));
				}
			}
			if(((evt.target.timerMinutes*60) + evt.target.timerSeconds) == this._model.startDelay || this._model.startDelay==0)
			{
				//Game Start! //trigger once
				startGame();
				this._controller.obstaclePlacement();
				
			}
			else
			{
				if (((evt.target.timerMinutes*60) + evt.target.timerSeconds) > this._model.startDelay)
				{
					this._pbRun=true;
					//this._minutes=evt.target.timerMinutes;
					//this._seconds=evt.target.timerSeconds;
					if((evt.target.timerSeconds % this._model.obstacleInterval)==0 && lapseTime <= this._model.raceDuration)
					{
						//this._controller.generateObstacles();
						this._controller.moveObstacleOnStage();
					}
					if(this._countDown<5)
					{
						this._progressBar.rival.x+=this._progressBar.progressBar.width/(this._model.maxGameTime-this._model.startDelay);
						this._progressBar.player.x+=this._progressBar.progressBar.width/(this._model.maxGameTime-this._model.startDelay);
					}
					this._seconds++;
					//1 second tick	
				}
				if(((evt.target.timerMinutes*60) + evt.target.timerSeconds) == this._model.maxGameTime)
				{
					//trace("maxTime:"+this._seconds)
					this.removeEventListener(MouseEvent.MOUSE_UP, jumpClick);
					this._pbRun=false;
					this._timer.stopGameTimer();
					this._countDown=5;
					winLogic();
					var layerList:Array=this._model.layersList;
					var spLayer:Sprite=layerList[0];
					var dispAi:DisplayObject=spLayer.getChildByName("aiSprite");
					dispAi.scaleX*=-1;
					dispAi.x=460;
					var dispPl:DisplayObject=this.getChildByName("playerSprite");
					dispPl.y=270;
					//_camfocusY=dispPl.y;
					dispPl.x=160;
					var screenLayer:DisplayObject=this.getChildByName("screenBg");
					screenLayer.y = 0;
					
					
					
					var avatars:Array=this._model.avatarList;
					avatars[1].portrait.visible=false;
					avatars[0].portrait.visible=false;
					
					
					var win1:FX_Win=new FX_Win();
					var win2:FX_Win=new FX_Win();
					var lose:FX_Lose=new FX_Lose();
					if(this._model.masterRecord.winner=="user")
					{
						win1.x=30;
						win1.y=120;
						win2.x=340;
						win2.scaleX*=-1;
						win2.y=10;
						lose.x=360;
						lose.y=160;
					}
					else
					{
						lose.x=140;
						lose.y=160;
						win1.x=350;
						win1.y=10;	
						win2.x=590;
						win2.scaleX*=-1;
						win2.y=120;
					}
					this.addChild(win1);
					this.addChild(win2);
					this.addChild(lose);

					/*
					this._countDown=0;
					this._timer.stopClockTimer();
					this._controller.avatarList[1].jumpState=true;
					var disp:DisplayObject=this.getChildByName("playerSprite");
					disp.y=270;
					winLogic();
					*/
				}
				if(this._countDown<=7 && this._countDown>=5)
				{
					if(this._countDown==7)
					{
						this._pl1="end";
						this._pl2="end";
						this._timer.stopClockTimer();
						raceResult();
					}
					else
					{
						this._countDown++;
					}
				}
			}
		}
		private function gameLoop(evt:Event):void
		{
			this._parallaxBgView.parallaxBgLoop();
			this.aiAcceleration();
			this.gravity();
			var disp:DisplayObject=this.getChildByName("playerSprite");	
			_camfocusY=disp.y;
			this.renderScreen();
			this.positionAiPortrait();
			this._controller.updateObstaclePosition();
			//this._controller.moveObstacleOnStage();
			//this.obstaclesRemove();
			
			this.checkCollision();
			this._topPanel.statusUpdate();
			//this.progressBarRun();
		}
		private function progressBarRun():void
		{
			if(this._pbRun==true)
			{
				var r:Number=(this._progressBar.progressBar.width/this._model.raceDuration+3)/60;
				var p:Number=(this._progressBar.progressBar.width/this._model.raceDuration+3)/60;
				this._progressBar.rival.x+=r;
				this._progressBar.player.x+=p;
			}
		}
		private function jumpClick(evt:MouseEvent):void
		{
				if(this._controller.gameState=="GAME_PLAYS")
				{
					var avatars:Array=this._model.avatarList;
					if(avatars[1].jumpState==false)
					{
						avatars[1].ymov=-16;
						avatars[1].jumpState=true;
						this._controller.avatarList=avatars;
						avatars[1].playAnimation(GlobalData.PLAYER_JUMP, 1, 0);
					}	
			}
		}
		private function avatarHandlerAI(evt:Event):void
		{
			//if(this._model.avatarList[0].getLastAnimation()=="racelosestop" || this._model.avatarList[0].getLastAnimation()=="racewin")
			if(this._model.avatarList[0].getLastAnimation()==GlobalData.RIVAL_LOSE)
			{
				this._model.avatarList[0].setDefaultStand(GlobalData.RIVAL_LOSE);
				/*
				if(this._countDown==9)
				{
					this._pl1="end";
					raceResult();
				}*/
			}
			else if(this._model.avatarList[0].getLastAnimation()==GlobalData.RIVAL_WIN)
			{
				this._model.avatarList[0].setDefaultStand(GlobalData.RIVAL_WIN);
				/*
				if(this._countDown==9)
				{
					this._pl1="end";
					raceResult();
				}*/
			}
			else if(this._model.avatarList[0].getLastAnimation()==GlobalData.RIVAL_READY)
			{
				this._model.avatarList[0].playAnimation(GlobalData.RIVAL_READY, 1, 0);
			}
			else
			{
				this._model.avatarList[0].playAnimation(GlobalData.RIVAL_RUN, 1, 0);
			}
			var avatars:Array=this._model.avatarList;
			this._aiState = false;
			if(avatars[0].accelState==true)
			{
				avatars[0].accelState=false;
				avatars[0].accel=0;
			}
		}
		private function avatarHandlerPlayer(evt:Event):void
		{
			//if(this._model.avatarList[1].getLastAnimation()=="racelosestop" || this._model.avatarList[1].getLastAnimation()=="racewin")
			if(this._model.avatarList[1].getLastAnimation()==GlobalData.PLAYER_LOSE)
			{
				this._model.avatarList[1].setDefaultStand(GlobalData.PLAYER_LOSE);
				/*if(this._countDown==9)
				{
					this._pl2="end";
					raceResult();
				}*/
			}
			else if(this._model.avatarList[1].getLastAnimation()==GlobalData.PLAYER_WIN)
			{
				this._model.avatarList[1].setDefaultStand(GlobalData.PLAYER_WIN);
				/*if(this._countDown==9)
				{
					this._pl2="end";
					raceResult();
				}*/
			}
			else if(this._model.avatarList[1].getLastAnimation()==GlobalData.PLAYER_READY)
			{
				this._model.avatarList[1].playAnimation(GlobalData.PLAYER_READY, 1, 0);
			}
			else
			{
				this._model.avatarList[1].playAnimation(GlobalData.PLAYER_RUN, 1, 0);
			}
			this._plState =false;
			var avatars:Array=this._model.avatarList;
			//avatars[1].alpha=1;
		}
		private function updateObstaclesOnStage(evt:Event):void
		{
			//UPdate List
			var layerList:Array=this._model.layersList;
			var spLayer:Sprite=layerList[0];
			this._obstacleOnStage = this._model.obstacleList;
			spLayer.addChild(this._model.obstacleList[(this._model.obstacleList.length - 1)])
			this._obstacleList=this._model.obstacleList;
			//this._plCollide=0;
		}
		private function updateObstacleListData(evt:Event):void
		{
			this._obstacleOnStage = this._model.obstacleList;
			this._obstacleList=this._model.obstacleList;
		}
		private function removedObstaclesOnStage(evt:Event):void
		{
		}
		private function removeEvent(evt:Event):void
		{
			//_popUpUiManager.removeWindow( WindowPopUpConfig.RUNNING_MAN_POP_UP );
			destroyMe();
		}
	}
}