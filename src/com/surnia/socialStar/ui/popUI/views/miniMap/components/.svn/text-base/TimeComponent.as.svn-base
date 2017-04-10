package com.surnia.socialStar.ui.popUI.views.miniMap.components
{
	public class TimeComponent
	{
		public static const TIME_SEC:int = 0;
		public static const TIME_MIN:int = 1;
		public static const TIME_HR:int = 2;
	
		private var ctr:int = 0;
		private var sec:int = 0;
		private var min:int = 0;
		private var hr:int = 0;
		
		private var isGo:Boolean = true;
		public function TimeComponent(InitialTime:int = 0, type:int = TimeComponent.TIME_SEC)
		{			
			initialTime(InitialTime, type);
		}
		
		public function initialTime(InitialTime:int = 0, type:int = TimeComponent.TIME_SEC):void {
			
			switch(type) {
				case 0:
					sec = InitialTime;
				break;
				case 1:
					min = InitialTime;
				break;
				case 2:
					hr = InitialTime;
				break;
				
			}
		}
		
		public function stopTimer():void {
			isGo = false;
			
		}
		public function continueTimer():void {
			isGo = true;
		}
		
		public function resetTimer():void {
			ctr = 0;
			sec = 0;
			min = 0;
			hr  = 0;
			isGo == true
		
		}
		public function updateTimer():void {		
			
			if (isGo == true) {
				ctr++;
				if(ctr >=30){
					ctr = ctr-30;
					sec++;				
				}
				
				if(sec >= 60){
					sec = sec -60;
					min++;
				}	
				
				if(min >= 60){
					min = min -60;
					hr++;
				}	
			
			}
			
		}
		
		public function get getPerSecond():int {
			
			return sec;
		}
		
		public function get getPerMinute():int{
			return min;
		}
		
		public function get getPerHour():int{
			return hr;
		}
		
	}
}