package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.ui.popUI.data.MiniMapPopInstantCompleteData;
	import com.surnia.socialStar.ui.popUI.events.MiniMapPopUpDialogEvent;
	import com.surnia.socialStar.ui.popUI.views.MiniMapInstantCompleteWindow;
	import com.surnia.socialStar.ui.popUI.views.MiniMapInstantCompleteWindow;
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * ...
	 * @author domz
	 */
	public class MiniMapPopConfirmationWindowTest extends Sprite
	{
		private var model:MiniMapPopInstantCompleteData;
		private var manager:MiniMapInstantCompleteWindow;
		
		public function MiniMapPopConfirmationWindowTest( stref:Stage , parent:Sprite)
		{
			trace(this, "WINTEST" );
			model = new MiniMapPopInstantCompleteData( stref );
			manager = new MiniMapInstantCompleteWindow( model , parent );
			addChild( manager );
		}
	}
}