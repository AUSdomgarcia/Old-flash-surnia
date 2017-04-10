package com.surnia.socialStar.minigames.contestBattle 
{
	import com.surnia.socialStar.minigames.contestBattle.components.CompetitionBar;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author DF
	 */
	public class contestBattleMain extends Sprite
	{
		private var _competitionBar:CompetitionBar;
		
		private var _addButton:SwitchComponent;
		private var _removeButton:SwitchComponent;
		public function contestBattleMain() 
		{
			initialization();
			display();			
		}
		
		private function initialization():void {
		
			_competitionBar = new CompetitionBar(onFinish, new BlackBarMC, new BlackBarMC, new MeterMC, new BarBlueMC, new RedBarMC, 25 , 50);
			_competitionBar.x = 50;
			_competitionBar.y = 50;
			
			
			_addButton = new SwitchComponent(onAdd, new SelectMC);
			_removeButton = new SwitchComponent(onDeduct, new SelectMC);
		}
		
		private function display():void {	
			//var contestStage:ContestStageMC = new ContestStageMC;
			
			addChild(contestStage);
			addChild(_competitionBar);
			
			_addButton.x = 50
			_addButton.y = _competitionBar.height + 100;
			addChild(_addButton);
			
			_removeButton.x = _addButton.width + 100;
			_removeButton.y =_competitionBar.height + 100;
			addChild(_removeButton);
		}
		
		private function onAdd(val:int):void {
			_competitionBar.addPoints(10);
			trace(this, "CURRENT POINTS ", _competitionBar.getCurrentPoints);
		}
		
		private function onDeduct(val:int):void {
			_competitionBar.deductPoints(10);
		}
		
		
		private function onFinish(result:int):void {
			if(result ==0){
				trace(this, "W I N !!!");
			}
			else {
				trace(this, "L O S E !!!");
			}
		}
		
		
	}

}