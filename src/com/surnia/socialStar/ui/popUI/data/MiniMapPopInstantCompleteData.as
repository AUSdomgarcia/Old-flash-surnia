package com.surnia.socialStar.ui.popUI.data 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	/**
	 * ...
	 * @author domz
	 */
	public class MiniMapPopInstantCompleteData 
	{
		public var mcWindowBg:dlgBoxMC = new dlgBoxMC();
		public var mcBtnOk:dlgOkNormalMC = new dlgOkNormalMC();
		public var mcBtnCancel:dlgCancelMC = new dlgCancelMC();
		public var txtDialog:TextField = new TextField();
		
		public var stref:Stage;
		
		public function MiniMapPopInstantCompleteData( s:Stage ) 
		{
			stref = s;
		}
		
	}

}