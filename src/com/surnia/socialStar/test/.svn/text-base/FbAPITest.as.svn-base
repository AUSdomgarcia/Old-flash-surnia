package com.surnia.socialStar.test 
{
	import com.monsterPatties.config.GameConfig;
	import com.monsterPatties.utils.facebookAPI.events.FacebookApiEvent;
	import com.monsterPatties.utils.facebookAPI.FacebookAPI;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FbAPITest extends Sprite
	{
		/*--------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		private var _fb:FacebookAPI;
		/*--------------------------------------------------------------------------Construcor--------------------------------------------------------------*/
		
		public function FbAPITest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			prepareControllers();
			setDisplay();
			trace( "init fbTest!!....................." );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*--------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			
		}
		
		
		private function removeDisplay():void 
		{
			
		}
		
		private function prepareControllers():void {
			_fb = FacebookAPI.getInstance();
			_fb.initFacebookAPI( GameConfig.APP_ID  );
			_fb.login();
			_fb.addEventListener( FacebookApiEvent.LOGIN_COMPLETE, onLogInComplete );
			_fb.addEventListener( FacebookApiEvent.USER_DATA_COMPLETE, onUserDataLoaded );
			_fb.addEventListener( FacebookApiEvent.EXTRACT_FRIENDS_ID_COMPLETE, onExtractFriendIdComplete );
			_fb.addEventListener( FacebookApiEvent.EXTRACT_FRIENDS_DATA_COMPLETE, onExtractFriendDataComplete );
			_fb.addEventListener( FacebookApiEvent.EXTRACT_FRIENDS_IMAGE_COMPLETE, onExtractFriendImageComplete );
			addEventListener( MouseEvent.MOUSE_UP, onClickMovie );
		}				
		
		private function onClickMovie(e:MouseEvent):void 
		{
			
		}
		
		/*--------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		private function onLogInComplete(e:FacebookApiEvent):void 
		{
			trace( "login complete........... ^__________^" );
			_fb.getData( "/me" );			
		}
		
		private function onUserDataLoaded(e:FacebookApiEvent):void 
		{
			trace( "user data load complete!!.............." );
			addChild( _fb.userFbData.image );
			_fb.getData( "/me/friends" );	
		}
		
		private function onExtractFriendIdComplete(e:FacebookApiEvent):void 
		{			
			_fb.extractFriendsData();
			trace( "extract Friend id complete!!.............. ^_________________^" );
		}
		
		private function onExtractFriendDataComplete(e:FacebookApiEvent):void 
		{
			trace( "extract Friend data complete!!.............. ^_________________^" );
			_fb.setFriendImages();
		}
		
		private function onExtractFriendImageComplete(e:FacebookApiEvent):void 
		{
			trace( "friend image extract complete.................." );
		}
	}

}