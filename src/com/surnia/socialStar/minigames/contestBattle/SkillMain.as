package com.surnia.socialStar.minigames.contestBattle 
{
	import com.surnia.socialStar.minigames.contestBattle.components.IconComponent;
	import com.surnia.socialStar.minigames.contestBattle.components.TalentTab;
	import com.surnia.socialStar.ui.popUI.views.characterPanel.components.button.SwitchComponent;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author DF
	 */
	public class SkillMain extends Sprite
	{	
		private var _talentTab:TalentTab;
		
		private var _select:SwitchComponent;
		public function SkillMain() 
		{
			initialization();
			display();
			addListener();
		}
		
		private function initialization():void {
			_select = new SwitchComponent(onSelect, new SelectMC);
			_select.y = 200;
			addChild(_select);
			
			//set Talent Icon to array
			var arrayTalentIcon:Array = [new SkillIdle1, new SkillIdle2, new SkillIdle3, new SkillIdle4, new SkillIdle5];
			
			_talentTab = new TalentTab(onActive, arrayTalentIcon, 2, 100);	
			
			_talentTab.compressDisplayActiveTab();
			//_talentTab.removeListener();
			//_talentTab.setSelectedSkill(2);
		}
		private function display():void {
			
			_talentTab.x = 300;
			_talentTab.y = 300;			
			addChild(_talentTab);	
			
			var icon:ContestIcon = new ContestIcon;
			
			//select icon			
			icon.gotoAndStop(4);
			var iconComponent:IconComponent = new IconComponent(icon, 200, 100, 50, 50);
			addChild(iconComponent);
			
			var mem:MemoryProfiler = new MemoryProfiler();
			addChild(mem);			
			var frame:FrameRateViewer = new FrameRateViewer();
			addChild(frame);
		}
		
		private function onSelect(val:int):void {
			_talentTab.collapseTabClear();
		}
		
		private function addListener():void {
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function onActive(ID:int):void {
			trace(this, "RETURN ACTIVE ID ", ID);
		}
		
		private function onUpdate(e:Event):void {
			_talentTab.onUpdate();			
		}
	}

}