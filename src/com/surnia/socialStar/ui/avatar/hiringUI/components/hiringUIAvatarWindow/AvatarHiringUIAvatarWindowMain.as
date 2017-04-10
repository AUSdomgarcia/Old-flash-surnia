package com.surnia.socialStar.ui.avatar.hiringUI.components.hiringUIAvatarWindow 
{
	import flash.display.Sprite;
	
	import com.surnia.socialStar.ui.avatar.hiringUI.components.hiringUIAvatarWindow.view.AvatarHiringUIAvatarWindowView;
	
	/**
	 * ...
	 * @author Windz
	 * @email strikerwindz@gmail.com
	 */
	
	public class AvatarHiringUIAvatarWindowMain extends Sprite
	{
		private var _view:AvatarHiringUIAvatarWindowView;
		
		public function AvatarHiringUIAvatarWindowMain():void
		{
			_view = new AvatarHiringUIAvatarWindowView;
			addChild( _view );
		}
		
	}

}