package com.surnia.socialStar.minigames.components.parallaxBg
{
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Droids
	 */
	[SWF(backgroundColor="0x000000", frameRate="30", width="1000", height="568")]
	public class testParallaxBg extends MovieClip
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _myTimer:MiniGame_Timer;
		private var _model:parallaxBg;
		private var _controller:parallaxBgController;
		private var _view:parallaxBgView;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function testParallaxBg()
		{
			init();
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		public function init():void
		{
			//var mask:Sprite=new Sprite();		
			//addChild(new Bitmap(new Scene_Sky()));
			
			//mask.height=600
			this.mask=new Bitmap(new Scene_Sky());
			//this.mask=mask;
			mask.height=578.10;
			_myTimer=new MiniGame_Timer(99, 100);
			_myTimer.addEventListener("TimeUpdated", monitorTime);
			_myTimer.addEventListener("GameLoop", gameLoop);
			
			var objTypes:Array=new Array();
			/*
			var sky:Sprite=new Sprite();
			sky.addChild(new Bitmap(new Scene_Sky()));
			sky.height=489.95;
			var mount:Scene_Mountain=new Scene_Mountain();
			var track:Scene_Track=new Scene_Track();
			var wall:Scene_Wall=new Scene_Wall();
			var tree1:Scene_Tree01=new Scene_Tree01();
			var tree2:Scene_Tree02=new Scene_Tree02();
			var cloud:Scene_Cloud=new Scene_Cloud();
			*/
			var objSky:parallaxObject=new parallaxObject("sky", new Scene_Sky(), "image", "holder" , 0, "normal", "still", "1", 0, 0, 584, 489.95, "fix", "fix");
			var objTrack:parallaxObject=new parallaxObject("track", new Scene_Track(), "image", "holder", 8, "normal", "veryfast", "continuous", 0, 507.45, 590, 62, "fix", "fix");
			var objWall:parallaxObject=new parallaxObject("wall", new Scene_Wall(), "image", "holder", 7, "normal", "still", "1", 0, 481, 590, 27, "fix", "fix");
			var objTreeA:parallaxObject=new parallaxObject("treeA", new Scene_Tree01(), "image", "holder", 6, "medium", "fast", "medium", 0, 372, 82, 119, "fix", "fix");
			var objTreeB:parallaxObject=new parallaxObject("treeB", new Scene_Tree02(), "image", "holder", 5, "small", "medium", "verylarge", 0, 430, 40, 58, "fix", "fix");
			var objCloudA:parallaxObject=new parallaxObject("cloudA", new Scene_Cloud(), "image", "holder", 4, "medium", "slow", "verysmall", 0, 500, 125, 31, "fix", "random");
			var objMount:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 3, "large", "slow", "small", 0, 481, 201, 46, "fix", "fix");
			//var objMount1:parallaxObject=new parallaxObject("mount", new Scene_Mountain(), "image", "holder", 2, "verylarge", "veryslow", "small", 0, 481, 201, 46, "fix", "fix");
			var objCloudB:parallaxObject=new parallaxObject("cloudB", new Scene_Cloud(), "image", "holder", 1, "very small", "veryslow", "verysmall", 0, 400, 60, 50, "fix", "random");
			//var objMask:parallaxObject=new parallaxObject("mask", mask, "sprite", 8, "normal", "still", "1");
					
			objTypes.push(objSky);
			objTypes.push(objTrack);
			objTypes.push(objWall);
			objTypes.push(objTreeA);
			objTypes.push(objTreeB);
			objTypes.push(objCloudA);
			objTypes.push(objMount);
			//objTypes.push(objMount1);
			objTypes.push(objCloudB);
			//objTypes.push(objMask);
			
			
			
			this._model=new parallaxBg();
			this._controller=new parallaxBgController(this._model);
			this._view=new parallaxBgView(this._model, this._controller, objTypes);
			
			
			setDisplay();
		}
		public function setDisplay():void
		{
			//this._view.x+=50
			this.addChild(this._view);
			_myTimer.startGameTimer();
			//_myTimer.startClockTimer();
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		private function monitorTime(evt:Event):void
		{
			if(evt.target.timerSeconds==10)
			{
				_myTimer.stopGameTimer();
			}
		}
		private function gameLoop(evt:Event):void
		{
			this._view.parallaxBgLoop();
		}
	}
}