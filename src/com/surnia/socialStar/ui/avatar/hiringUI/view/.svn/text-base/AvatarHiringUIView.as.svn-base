package com.surnia.socialStar.ui.avatar.hiringUI.view 
{
	import flash.display.Sprite;
	
	import com.surnia.socialStar.ui.avatar.hiringUI.data.AvatarHiringUIData;
	import com.surnia.socialStar.ui.avatar.hiringUI.components.hiringUIAvatarWindow.view.AvatarHiringUIAvatarWindowView;
	
	/**
	 * ...
	 * @author Windz
	 * @email strikerwindz@gmail.com
	 */
	
	public class AvatarHiringUIView extends Sprite
	{
		private var _data:AvatarHiringUIData;					// this is the data of the Hiring UI
																// w/c is passed from the HiringUIMain class
		
		private var _container:AvatarHiringUIMainContainer;		// this is the main container movieclip in the library/swc
		private var _avatarWindowsAry:Array;					// this is the array for the number of avatar windows
		
		/*
		 * CONSTRUCTOR
		 */
		public function AvatarHiringUIView( DATA:AvatarHiringUIData ):void
		{
			_data = DATA;
			
			initMainContainer();
			initAvatarWindows();
		}
		
		// initialize the main container and elements
		private function initMainContainer():void
		{
			_container = new AvatarHiringUIMainContainer;
			addChild( _container );
		}
		
		// initialize the avatar windows
		private function initAvatarWindows():void
		{
			_avatarWindowsAry = new Array();
			for ( var i:int = 0; i < _data.AVATAR_WINDOWS_TOTAL; i++ )
			{
				var _window:AvatarHiringUIAvatarWindowView = new AvatarHiringUIAvatarWindowView;
				var _offset:int = ( _container.mask_mc.width - (_data.AVATAR_WINDOWS_TOTAL * _window.width) ) / ( _data.AVATAR_WINDOWS_TOTAL + 1 );
				var _distance:int = (_window.width * i);
				_window.x = _container.mask_mc.x + ( (_window.width * i) + (_offset * i + _offset) );
				_window.y = _container.mask_mc.y + ( (_container.mask_mc.height - _window.height) / 2 );
				_avatarWindowsAry.push( _window );
				_container.addChild( _window );
			}
		}
		
		// clean all elements within this class and event listeners
		public function clean():void
		{
			// remove each avatar windows in the main container
			while ( _avatarWindowsAry.length > 0 )
			{
				var _window:AvatarHiringUIAvatarWindowView = _avatarWindowsAry.pop();
				_window.clean();
				_container.removeChild( _window );
			}
			
			// remove the main container
			if ( _container != null ) {
				removeChild( _container );
			}
			
		}
		
	}

}