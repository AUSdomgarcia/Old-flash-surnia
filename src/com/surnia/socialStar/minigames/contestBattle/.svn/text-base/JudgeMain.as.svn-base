package com.surnia.socialStar.minigames.contestBattle 
{
	import com.surnia.socialStar.minigames.contestBattle.components.JudgeTab;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author DF
	 */
	public class JudgeMain extends Sprite
	{
		private var _judgeTab:JudgeTab;
		public function JudgeMain() 
		{
			initialization();
			display();
		}
		
		private function initialization():void {
			_judgeTab = new JudgeTab(onSelect);
			
			_judgeTab.setJudgeIcon(2, 2);
			_judgeTab.setJudgeIcon(0, 2);
			_judgeTab.setJudgeIcon(1, 3);
			_judgeTab.setJudgeIcon(2, 4);
			_judgeTab.setJudgeIcon(2, 5);
		}
		
		private function display():void {
			addChild(_judgeTab);
			
			var mem:MemoryProfiler = new MemoryProfiler();
			addChild(mem);			
			var frame:FrameRateViewer = new FrameRateViewer();
			addChild(frame);
		}
		
		private function onSelect(judge:int, iconType:int):void {
			trace(this, "JUDGE ",judge, " ICON TYPE ", iconType );
		}
	}

}