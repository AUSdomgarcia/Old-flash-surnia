package com.surnia.socialStar.ui.popUI.views 
{
	import com.surnia.socialStar.ui.popUI.data.MiniMapPopInstantCompleteData;
	import com.surnia.socialStar.ui.popUI.events.MiniMapPopUpDialogEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author domz
	 */
	public class MiniMapInstantCompleteWindow extends MovieClip
	{
		private var m:MiniMapPopInstantCompleteData;
		private var s:Sprite;
		private var newEvent:MiniMapPopUpDialogEvent;
		
		public function MiniMapInstantCompleteWindow( model:MiniMapPopInstantCompleteData , parent:Sprite ) 
		{
			s = parent;
			m = model;
			model.mcWindowBg.x = model.stref.stageWidth / 2 - model.mcWindowBg.width / 2;
			model.mcWindowBg.y = model.stref.stageHeight / 2 - model.mcWindowBg.height / 2 -  120;
			
			m.txtDialog.width = 170;
			m.txtDialog.height = 60;
			m.txtDialog.selectable = false;
			
			
			//m.txtDialog.text = "ARE YOU SURE YOU WANT \n AN INSTANT COMPLETE ?";
			m.txtDialog.x = model.mcWindowBg.x + 85;
			m.txtDialog.y = model.mcWindowBg.y + model.mcWindowBg.height / 2 - 25;
			
			
			m.mcBtnOk.x = model.mcWindowBg.x + 78;
			m.mcBtnOk.y = model.mcWindowBg.y + 127.5;
			m.mcBtnOk.gotoAndStop( 1 );
			
			m.mcBtnCancel.y = model.mcBtnOk.y;
			m.mcBtnCancel.x = model.mcBtnOk.x + 98;
			m.mcBtnCancel.gotoAndStop( 1 );
			
			m.mcBtnOk.addEventListener( MouseEvent.ROLL_OUT, onOUT );
			m.mcBtnCancel.addEventListener( MouseEvent.ROLL_OUT, onOUT );
			
			m.mcBtnOk.addEventListener( MouseEvent.ROLL_OVER, onOver );
			m.mcBtnCancel.addEventListener( MouseEvent.ROLL_OVER, onOver );
			
			m.mcBtnOk.addEventListener( MouseEvent.CLICK, onClick );
			m.mcBtnCancel.addEventListener( MouseEvent.CLICK, onClick );
			
			addChild( m.mcWindowBg );
			addChild( m.mcBtnOk );
			addChild( m.mcBtnCancel );
			addChild( m.txtDialog );
		}
		
		public function set setPopUpText( str:String ):void {
			m.txtDialog.text = str;
		}
		
		public function get getPopUpText():String {
			return m.txtDialog.text;
		}
		
		private function onOUT( e:Event ):void {
			switch ( e.currentTarget ) {
				case m.mcBtnOk:
					e.currentTarget.gotoAndStop( 1 );
				break;
				case m.mcBtnCancel:
					e.currentTarget.gotoAndStop( 1 );
				break;
			}
		}
		
		private function onOver( e:Event ):void {
			var val:Boolean;
			switch ( e.currentTarget ) {
				case m.mcBtnOk:
					val = true;
					e.currentTarget.gotoAndStop( 2 );					
				break;
				case m.mcBtnCancel:
					val = false;
					e.currentTarget.gotoAndStop( 2 );
				break;
			}
		}
		private function onClick( e:Event ):void {
				var val:Boolean;
			switch ( e.currentTarget ) {
				case m.mcBtnOk:
					val = true;
					e.currentTarget.gotoAndStop( 2 );					
				break;
				case m.mcBtnCancel:
					val = false;
					e.currentTarget.gotoAndStop( 2 );
				break;
			}
			newEvent = new MiniMapPopUpDialogEvent( MiniMapPopUpDialogEvent.LOAD_BOOLEAN );
			newEvent.obj.boolean = val;
			s.dispatchEvent( newEvent );
		}
//end
	}
}