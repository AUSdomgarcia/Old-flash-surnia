package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.minigames.runningMan.model.BackgroundItemModel;
	import com.surnia.socialStar.minigames.runningMan.model.StatusModel;
	import com.surnia.socialStar.minigames.runningMan.view.BackgroundItemManager;
	import com.surnia.socialStar.minigames.runningMan.view.StatusManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author domz
	 */
	public class MiniGameRunningManTest extends Sprite
	{
		public var bmodel:BackgroundItemModel;
		public var bmanager:BackgroundItemManager;
		public var RACE_END:String = "RACE_END";
		private var target:Sprite;
		private var slowSpeed:Number = 0.1;
		
		public function MiniGameRunningManTest( _stref:Stage , bgX:Number, bgY:Number, _sp:Sprite )
		{
			target = _sp;
			bmodel = new BackgroundItemModel( _stref );
			bmanager = new BackgroundItemManager( bmodel ,bgX ,bgY , _sp  );
		}	
		
		public function start():void {
			bmodel.isStart = true;
		}
		public function onUpdate():void {
			if ( bmodel.isStart )
			bmanager.onUpdate();
		}
		public function stop():void {
			bmodel.isStart = false;
			target.dispatchEvent( new Event( RACE_END ));
		}
		
		public function setObjSpeed( road:Number = 0, mountain:Number = 0, fTree:Number = 0, bTree:Number = 0, sky:Number = 0 ):void {
			bmodel.roadSpeed = road;
			bmodel.mountainSpeed = mountain;
			bmodel.treeSpeed = fTree;
			bmodel.treeSpeedBack = bTree;
			bmodel.cloudSpeed = sky;
		}
		
		public function slowDown():void {
			setObjSpeed( bmodel.roadSpeed - 4, bmodel.mountainSpeed - 0.1,
								  bmodel.treeSpeed - 1, bmodel.treeSpeedBack - 0.5, 
								  bmodel.cloudSpeed - 0.1 );
		}
		
		public function normalSpeed():void {
			setObjSpeed( 8, 0.2, 2, 1.2, 0.5 );
		}
		public function removeItem():void {
			bmanager.removeItem();
		}
	}
}