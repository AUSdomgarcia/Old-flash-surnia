package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.tutorial.views.Tutorial;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class TutorialSample extends Sprite
	{
		private var _tut:Tutorial;
		private var _es:EventSatellite;
		
		public function TutorialSample() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_tut = new Tutorial();
			addChild( _tut );
		}
		
	}

}