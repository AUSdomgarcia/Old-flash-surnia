package com.surnia.socialStar.minigames.popupUI.test 
{
	import com.surnia.socialStar.minigames.popupUI.manager.VersusWindowManager;
	import com.surnia.socialStar.minigames.popupUI.model.VersusWindowModel;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author domz
	 */
	public class VersusPopUpController extends Sprite
	{
		private var model:VersusWindowModel;
		private var manager:VersusWindowManager;
		public var LOSE:String = new String();
		public var WIN:String = new String();
		public var SHARE:String;
		
		public function VersusPopUpController(  x:Number, y:Number, spt:Sprite )
		{
			model = new VersusWindowModel();
			manager = new VersusWindowManager( model, x, y, spt );
			
			LOSE = model.LOSE;
			WIN = model.WINNER;
			SHARE = model.SHARE;
		}
		
		public function setWindowValues( str:String, num:Number ):void {
			manager.setWindow( str , num );
		}
		
		public function show():void {
			manager.addItem();
		}
		
		public function setPicLeft( spt:Sprite ):void {
			manager.setLeftPic( spt );
		}
		
		public function setPicRight( spt:Sprite ):void {
			manager.setRightPic( spt );
		}
		
		public function setDialog( str:String, arrIndex:Number ):void {
			manager.setStr( str , arrIndex );
		}
		
		public function removeSelf():void {
			manager.removeItem();
		}
//end
	}
}