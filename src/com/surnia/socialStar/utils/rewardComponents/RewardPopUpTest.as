package com.surnia.socialStar.utils.rewardComponents
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author Droids
	 */
	[SWF(backgroundColor="0x000000", frameRate="30", width="1000", height="568")]

	public class RewardPopUpTest extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _waterDisp:Water_Dispenser;
		private var _popUp:RewardPopUpMain;
		private var _ui:FX_vendo;
		private var _ui2:FX_vendo2;
		private var _ui3:FX_vendo3;
		
		private var _a1:Fx_1;
		private var _a2:FX_2;
		private var _a3:FX_3;
		private var _a4:FX_4;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function RewardPopUpTest()
		{
			this._a1=new Fx_1();	
			this._a1.x=400;
			this._a1.y=80;					
			this._a2=new FX_2();	
			this._a2.x=400;
			this._a2.y=160;		
			this._a3=new FX_3();	
			this._a3.x=400;
			this._a3.y=240;		
			this._a4=new FX_4();	
			this._a4.x=600;
			this._a4.y=80;		
			
			
			this._ui=new FX_vendo();	
			this._ui.x=10;
			this._ui.y=200;
			this._ui2=new FX_vendo2();	
			this._ui2.x=10;
			this._ui2.y=80;			
			this._ui3=new FX_vendo3();	
			this._ui3.x=200;
			this._ui3.y=80;			
			
			
			this._waterDisp=new Water_Dispenser();
			this._waterDisp.x=200;
			this._waterDisp.y=200;
			
			this._popUp=new RewardPopUpMain(this._waterDisp, 0, 2, 11);
			this._popUp=new RewardPopUpMain(this._ui, 0, 0, 4);
			this._popUp=new RewardPopUpMain(this._ui2, 0, 1, 25);
			this._popUp=new RewardPopUpMain(this._ui3, 0, 2, 35);
			
			this._popUp=new RewardPopUpMain(this._a1, 0, 3, 1);
			this._popUp=new RewardPopUpMain(this._a2, 0, 4, 1);
			this._popUp=new RewardPopUpMain(this._a3, 0, 1, 10);
			this._popUp=new RewardPopUpMain(this._a4, 0, 0, 60);

			this.addChild(this._a1);
			this.addChild(this._a2);
			this.addChild(this._a3);
			this.addChild(this._a4);
			
			this.addChild(this._ui3);
			this.addChild(this._ui2);
			this.addChild(this._ui);
			this.addChild(this._waterDisp);
			
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
	}
}