package com.surnia.socialStar.ui.avatar.hiringUI.components.hiringUIAvatarWindow.view 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Windz
	 * @email strikerwindz@gmail.com
	 */
	
	public class AvatarHiringUIAvatarWindowView extends Sprite
	{
		private var _view:AvatarHiringUIAvatarWindow;	// this is the avatar hiring window
														// that would be inserted inside
														// the avatar hiring UI Main container
		
		/*
		 * CONSTRUCTOR
		 */
		public function AvatarHiringUIAvatarWindowView():void
		{
			initMainBody();
			initElements();
		}
		
		// intializes the main avatar window body
		private function initMainBody():void
		{
			_view = new AvatarHiringUIAvatarWindow;
			addChild( _view );
		}
		
		// initialize other elements inside the main body
		// like buttons, movieclips, etc...
		private function initElements():void
		{
			_view.hire_mc.gotoAndStop(1);
			_view.hire_mc.addEventListener( MouseEvent.MOUSE_OVER, _onHireMcOver );
			_view.hire_mc.addEventListener( MouseEvent.MOUSE_OUT, _onHireMcOut );
		}
		
		// event handler for _container.hire_mc mouse over
		private function _onHireMcOver( e:MouseEvent ) : void
		{
			e.currentTarget.buttonMode = true;
			e.currentTarget.gotoAndStop(2);
		}
		
		// event handler for _container.hire_mc mouse out
		private function _onHireMcOut( e:MouseEvent ) : void
		{
			e.currentTarget.buttonMode = false;
			e.currentTarget.gotoAndStop(1);
		}
		
		// removes all elements within this class and event listeners
		public function clean():void
		{
			_view.hire_mc.removeEventListener( MouseEvent.MOUSE_OVER, _onHireMcOver );
			_view.hire_mc.removeEventListener( MouseEvent.MOUSE_OUT, _onHireMcOut );
		}
		
	}

}