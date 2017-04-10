package com.surnia.socialStar.ui.popUI.views 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	//import com.surnia.socialStar.minigames.runningMan.RunningManView;
	import com.surnia.socialStar.ui.popUI.components.AbstractWindow;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.itemShopUI.ItemShopPopUp;
	import com.surnia.socialStar.ui.popUI.itemShopUI.OfficeInventoryPopUp;
	import com.surnia.socialStar.ui.popUI.views.miniMap.MiniMapWindow;
	import com.surnia.socialStar.ui.popUI.views.staff.StaffView;
	import flash.display.StageDisplayState;
	import flash.system.Capabilities;
	
	import flash.display.Sprite;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class PopUpUIManager extends Sprite
	{
		/*-----------------------------------------------------------------------Constant-------------------------------------------------------------------------*/
		private static var _instance:PopUpUIManager;
		/*-----------------------------------------------------------------------Properties-----------------------------------------------------------------------*/
		private var _popUpWindows:Array;
		private var _popUIHolder:Sprite;
		
		private var _currentWindow:AbstractWindow;
		private var _currentSubWindow:AbstractWindow;
		private var _transBg:TransBgMC;
		private var _isWindowActive:Boolean;
		private var _isSubWindowActive:Boolean;
		private var _popUpUIEvent:PopUIEvent;	
		private var _es:EventSatellite;
		private var _gd:GlobalData;
		
		private var _subWindows:Array = new Array();
		/*-----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function PopUpUIManager( enforcer:SingletonEnforcer ) 
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			prepareHolders();
			prepareWindows();
		}
		
		private function init():void 
		{			
			trace( "init PopUpUIManager......................." );
			_isWindowActive = false;
			_isSubWindowActive = false;
		}		
		
		public static function getInstance():PopUpUIManager 
		{
			if ( PopUpUIManager._instance == null ) {
				PopUpUIManager._instance = new PopUpUIManager( new SingletonEnforcer() );
			}
			
			return PopUpUIManager._instance;
		}
		
		/*-----------------------------------------------------------------------Methods-------------------------------------------------------------------------*/	
		
		
		private function prepareWindows():void 
		{
			addWindow( new InviteFriendsPopUpWindow( WindowPopUpConfig.INVITE_FRIENDS_POPUP_WINDOW, new InviteFriendPopUpMC() ) );
			addWindow( new ChangeOfficeNamePopUP( WindowPopUpConfig.CHANGE_OFFICE_NAME_POP_UP, new ChangeOfficeNamePopUpMC()  ) );			
			addWindow( new ActionPointPopUpWindow( WindowPopUpConfig.ACTION_POPUP_WINDOW, new ActionPointWindowPopUpMC() )  );
			addWindow( new GetCoinPopUpWindow( WindowPopUpConfig.COIN_POPUP_WINDOW, new GetCoinPopUpWindowMC() )  );			
			addWindow( new OfficeInventoryPopUp( WindowPopUpConfig.OFFICE_INVENTORY_POPUP_WINDOW, new ShopBGMC() )  );
			addWindow( new FriendPopUp( WindowPopUpConfig.FRIEND_POPUP_WINDOW, new FriendPopUpMC() )  );
			addWindow( new SellPopUpWindow( WindowPopUpConfig.SELL_POPUP_WINDOW, new SellPopUpMC() )  );
			addWindow( new MiniMapWindow( WindowPopUpConfig.MINI_MAP_POPUP_WINDOW )  );
			addWindow( new ItemShopHolder( WindowPopUpConfig.BUILD_SHOP_POPUP, new ContainerMain() )  );			
			//addWindow( new RunningManWrapper( WindowPopUpConfig.RUNNING_MAN_POP_UP )  );
			addWindow( new HireCharWindow( WindowPopUpConfig.HIRE_CHAR_WINDOW , new ShopBGMC() )  );
			addWindow( new DialogueWindow( WindowPopUpConfig.DIALOGUE_WINDOW, new DialogueMC() )  );
			addWindow( new StaffWindow( WindowPopUpConfig.STAFF_WINDOW, new StaffMC() )  );
			addWindow( new CrewWindow( WindowPopUpConfig.CREW_WINDOW, new CrewMC()  )  );
			addWindow( new CharShopWindow( WindowPopUpConfig.CHARSHOP_WINDOW, new mc_shop() )  );
			addWindow( new AvatarToolWindow( WindowPopUpConfig.AVATAR_TOOL_WINDOW, new AvatarTooltip() ) );
			addWindow( new TutWindow( WindowPopUpConfig.TUTORIAL_WINDOW , new TutMC() ) );
			//addWindow( new TutWindow( WindowPopUpConfig.TUTORIAL_WINDOW ) );
			addWindow( new ComingSoonWindow( WindowPopUpConfig.COMING_SOON_WINDOW, new ComingSoonMC()  ) );
			addWindow( new QuestPopUpWindow( WindowPopUpConfig.QUEST_WINDOW, new QuestWindowMC()  ) );			
			addWindow( new RewardWindow( WindowPopUpConfig.REWARD_WINDOW, new RewardWindowMC()  ) );
			addWindow( new LevelUpWindow( WindowPopUpConfig.LEVEL_UP_WINDOW, new LevelUpWindowMC()  ) );
			addWindow( new CraftingWindow ( WindowPopUpConfig.COLLECTION_WINDOW, new CraftingUIMainContainer() ) );
			addWindow( new ContestantSelectionWindow ( WindowPopUpConfig.CONTESTANT_SELECION_WINDOW, new CharacterPanelMC() ) );
			addWindow( new EventSceneWindow ( WindowPopUpConfig.EVENT_SCENE_WINDOW ) );
			addWindow( new ContestantInfoWindow ( WindowPopUpConfig.CONTESTANT_INFORMATION_WINDOW, new ContestantInformationWindow()  ) );
			addWindow( new MessageWindow ( WindowPopUpConfig.MESSAGE_WINDOW, new MessageWindowMC()  ) );
			addWindow( new ThanksForVisitingWindow ( WindowPopUpConfig.THANKS_FOR_VISITING_WINDOW, new ThankForVisitingMC()  ) );
			
			//not in used
			//addWindow( new HirePopUpWindow( WindowPopUpConfig.HIRE_POPUP_WINDOW, new HirePopUpWindowMC() ) );
			//addWindow( new ItemShopWindow( WindowPopUpConfig.ITEM_SHOP_POPUP_WINDOW, new ItemShopPopUpWindowMC() )  );
			//addWindow( new ItemShopPopUp( WindowPopUpConfig.ITEM_SHOP_POPUP_WINDOW, new ShopBGMC() )  );
		}
		
		
		private function prepareHolders():void 
		{
			_popUpWindows = new Array();
			_popUIHolder = new Sprite();
			addChild( _popUIHolder );
		}
		
		/**
		 * for adding pop up window 
		 * @param	popUpWindow - this window must be extends AbstractWindow
		 */
		
		public function addWindow( popUpWindow:AbstractWindow ):void 
		{
			_popUpWindows.push( popUpWindow );
		}		
		
		
		/**
		 * 
		 * @param	whichWindow -  for loading window you can select window by accessing WindowPopUpConfig
		 */
		public function loadWindow( whichWindow:String , xPad:Number = 0, yPad:Number = 0 , center:Boolean = true, xPos:Number = 0, yPos:Number = 0 ):void 
		{			
			trace( "[PopUpUIManager]: load window ",whichWindow  );
			_isWindowActive = true;
			var obj:Object = searchWindow( whichWindow );
			
			if ( obj.found ) {
				if ( obj.currentWindow != _currentWindow  ||  obj.currentWindow.windowName == WindowPopUpConfig.AVATAR_TOOL_WINDOW  ) {
					removeCurrentWindow(  );		
					
					if( whichWindow != WindowPopUpConfig.FRIEND_POPUP_WINDOW  ){
						trace( "window to load: ", whichWindow );						
						addTransparentWindow();
					}
					
					if ( whichWindow == WindowPopUpConfig.AVATAR_TOOL_WINDOW ) {						
						removeTransparentWindow();
					}			
					
					_currentWindow = obj.currentWindow;
					_currentWindow.clearWindow();
					_popUIHolder.addChild( _currentWindow );
					//trace( "see",_currentWindow,_currentWindow.winWidth, _currentWindow.winHeight );
					if ( _currentWindow.winWidth != 0 && _currentWindow.winHeight != 0 && center  ){						
						var runningOn:String = Capabilities.playerType;
						if ( runningOn != 'StandAlone' ) {
							if ( stage.displayState == StageDisplayState.NORMAL ) {
								//var adjustmentX:int = 150;
								//var adjustmentY:int = 150;
								var adjustmentX:int = 0;
								var adjustmentY:int = 0;
								
								trace( "[PopUpUIManager]: load window for fluid _gd.offsetWidth", _gd.offsetWidth, "_gd.offsetHeight",_gd.offsetHeight  );
								_currentWindow.x = ( (  _gd.offsetWidth/ 2 ) - ( _currentWindow.winWidth / 2 ) + xPad ) - adjustmentX ;
								_currentWindow.y = ( ( _gd.offsetHeight / 2 ) - ( _currentWindow.winHeight / 2 ) + yPad ) - adjustmentY ;
							}else {
								trace( "[PopUpUIManager]: load window for full screen _gd.screenWidth", _gd.screenWidth, "_gd.screenHeight",_gd.screenHeight  );
								_currentWindow.x = ( (  _gd.screenWidth/ 2 ) - ( _currentWindow.winWidth / 2 ) + xPad ) - adjustmentX;
								_currentWindow.y = ( ( _gd.screenHeight / 2 ) - ( _currentWindow.winHeight / 2 ) + yPad ) - adjustmentY;
							}														
						}else{
							_currentWindow.x = ( ( GameConfig.GAME_WIDTH / 2 ) - ( _currentWindow.winWidth / 2 ) + xPad ) - adjustmentX;
							_currentWindow.y = ( ( GameConfig.GAME_HEIGHT / 2 ) - ( _currentWindow.winHeight / 2 ) + yPad ) - adjustmentY;							
						}						
					}else {						
						if ( whichWindow == WindowPopUpConfig.FRIEND_POPUP_WINDOW  ) {
							_currentWindow.x = xPos;
							_currentWindow.y = yPos;
						}else {
							_currentWindow.x = xPos;
							_currentWindow.y = yPos - 50;
						}						
					}
					
					
					_currentWindow.initWindow();
					_currentWindow.alpha = 0;
					TweenLite.to( _currentWindow, 0.5, { alpha:1 } );
					
					
					//trace( "pop up window loaded succesfully", _popUIHolder.numChildren, this.numChildren );
				}else {
					//trace( "can't load window currently loaded......", _popUIHolder.numChildren, this.numChildren );
				}
			}else {
				//trace( "[popup manager]: that popup window does not exist!........" );
			}
			
			
			_popUpUIEvent = new PopUIEvent( PopUIEvent.ON_LOAD_WINDOW );			
			_es.dispatchESEvent( _popUpUIEvent );
		}	
		
		private function addTransparentWindow():void 
		{
			if( _transBg == null ){
				_transBg = new TransBgMC();
				_popUIHolder.addChild( _transBg );
				trace( "add trabs bg1............." );
			}else {
				removeTransparentWindow();
				_transBg = new TransBgMC();
				_popUIHolder.addChild( _transBg );
				trace( "add trabs bg2............." );
			}
		}
		
		private function removeTransparentWindow():void 
		{
			if ( _transBg != null ) {
				if ( _popUIHolder.contains( _transBg ) ) {
					_popUIHolder.removeChild( _transBg );
					_transBg = null;
					trace( "remove trabs bg............." );
				}
			}
		}
		
		/*
		public function loadSubWindow( whichWindow:String , xPad:Number = 0, yPad:Number = 0 , center:Boolean = true, xPos:Number = 0, yPos:Number = 0 ):void 
		{				
			trace( "[PopUpUIManager]: load sub window ",_isSubWindowActive  );
			//_isSubWindowActive = true;
			var obj:Object = searchWindow( whichWindow );
			if ( obj.found ) {
				//chekc if window that will be load is same with the current main window
				//if not equal then continue
				if ( obj.currentWindow != _currentSubWindow ) {
					//removes the current subWindow
					//removeCurrentSubWindow(  );
					
					trace( "window to subload: ", whichWindow );
					//if the window is not tutorial add transparent bg
					if( whichWindow != WindowPopUpConfig.TUTORIAL_WINDOW ){						
						//addTransparentWindow();
					}					
					
					var subWindow:AbstractWindow = obj.currentWindow;
					subWindow.clearWindow;
					_subWindows.push( subWindow );
					_popUIHolder.addChild( subWindow );
					
					//here the popUpUI window manager centered the subWindow base on the current screen of the game
					if ( subWindow.winWidth != 0 && subWindow.winHeight != 0 && center  ) {
						
						var runningOn:String = Capabilities.playerType;			
						if ( runningOn != 'StandAlone' ) {
							if ( stage.displayState == StageDisplayState.NORMAL ) {				
								subWindow.x = (  _gd.offsetWidth/ 2 ) - ( subWindow.winWidth / 2 ) + xPad;
								subWindow.y = ( _gd.offsetHeight / 2 ) - ( subWindow.winHeight / 2 ) + yPad;
							}else{							
								subWindow.x = (  _gd.screenWidth/ 2 ) - ( subWindow.winWidth / 2 ) + xPad;
								subWindow.y = ( _gd.screenHeight / 2 ) - ( subWindow.winHeight / 2 ) + yPad;
							}							
						}else {
							if ( _currentWindow != null ) {
								subWindow.x = ( _currentWindow.winWidth / 2 ) - ( subWindow.winWidth / 2 ) + xPad;
								subWindow.y = ( _currentWindow.winHeight / 2 ) - ( subWindow.winHeight / 2 ) + yPad;
							}else {
								subWindow.x = ( stage.stageWidth / 2 ) - ( subWindow.winWidth / 2 ) + xPad;
								subWindow.y = ( stage.stageHeight / 2 ) - ( subWindow.winHeight / 2 ) + yPad;
							}														
						}						
					}else {
						subWindow.x = xPos;
						subWindow.y = yPos;
					}
					subWindow.initWindow();
					subWindow.alpha = 0;
					TweenLite.to( subWindow, 0.5, { alpha:1 } );					
				}else{
					//trace( "can't load window currently loaded......", _popUIHolder.numChildren, this.numChildren );
				}
			}else {
				//trace( "[popup manager]: that popup window does not exist!........" );
			}
			
			_popUpUIEvent = new PopUIEvent( PopUIEvent.ON_LOAD_SUB_WINDOW );			
			_es.dispatchESEvent( _popUpUIEvent );
		}
		*/
		
		
		public function loadSubWindow( whichWindow:String , xPad:Number = 0, yPad:Number = 0 , center:Boolean = true, xPos:Number = 0, yPos:Number = 0 ):void 
		{				
			trace( "[PopUpUIManager]: load sub window ",_isSubWindowActive  );
			_isSubWindowActive = true;
			var obj:Object = searchWindow( whichWindow );
			if ( obj.found ) {
				//chekc if window that will be load is same with the current main window
				//if not equal then continue
				if ( obj.currentWindow != _currentSubWindow ) {
					//removes the current subWindow
					removeCurrentSubWindow(  );
					
					trace( "window to subload: ", whichWindow );
					//if the window is not tutorial add transparent bg
					if( whichWindow != WindowPopUpConfig.TUTORIAL_WINDOW ){						
						addTransparentWindow();
					}				
					
					//pass the search new window to current subwindow
					_currentSubWindow = obj.currentWindow;
					
					//make sure that the new window data is all clear
					_currentSubWindow.clearWindow();
					
					//add the new subWindow
					_popUIHolder.addChild( _currentSubWindow );				
					
					//here the popUpUI window manager centered the subWindow base on the current screen of the game
					if ( _currentSubWindow.winWidth != 0 && _currentSubWindow.winHeight != 0 && center  ) {
						
						var runningOn:String = Capabilities.playerType;			
						if ( runningOn != 'StandAlone' ) {
							if ( stage.displayState == StageDisplayState.NORMAL ) {				
								_currentSubWindow.x = (  _gd.offsetWidth/ 2 ) - ( _currentSubWindow.winWidth / 2 ) + xPad;
								_currentSubWindow.y = ( _gd.offsetHeight / 2 ) - ( _currentSubWindow.winHeight / 2 ) + yPad;
							}else{							
								_currentSubWindow.x = (  _gd.screenWidth/ 2 ) - ( _currentSubWindow.winWidth / 2 ) + xPad;
								_currentSubWindow.y = ( _gd.screenHeight / 2 ) - ( _currentSubWindow.winHeight / 2 ) + yPad;
							}							
						}else {
							if ( _currentWindow != null ) {
								_currentSubWindow.x = ( _currentWindow.winWidth / 2 ) - ( _currentSubWindow.winWidth / 2 ) + xPad;
								_currentSubWindow.y = ( _currentWindow.winHeight / 2 ) - ( _currentSubWindow.winHeight / 2 ) + yPad;
							}else {
								_currentSubWindow.x = ( stage.stageWidth / 2 ) - ( _currentSubWindow.winWidth / 2 ) + xPad;
								_currentSubWindow.y = ( stage.stageHeight / 2 ) - ( _currentSubWindow.winHeight / 2 ) + yPad;
							}														
						}						
					}else {
						_currentSubWindow.x = xPos;
						_currentSubWindow.y = yPos;
					}
					_currentSubWindow.initWindow();
					_currentSubWindow.alpha = 0;
					TweenLite.to( _currentSubWindow, 0.5, { alpha:1 } );					
				}else {
					//trace( "can't load window currently loaded......", _popUIHolder.numChildren, this.numChildren );
				}
			}else {
				//trace( "[popup manager]: that popup window does not exist!........" );
			}
			
			_popUpUIEvent = new PopUIEvent( PopUIEvent.ON_LOAD_SUB_WINDOW );			
			_es.dispatchESEvent( _popUpUIEvent );
		}
		
		
		public function removeCurrentWindow( ):void 
		{			
			if ( _currentWindow != null ) {
				_isWindowActive = false;
				_currentWindow.clearWindow();				
				if( _popUIHolder.contains( _currentWindow ) ){
					_popUIHolder.removeChild( _currentWindow );
					_currentWindow = null;
					removeTransparentWindow();					
				}
			}
		}		
		
		public function removeCurrentSubWindow( ):void 
		{			
			if ( _currentSubWindow != null ) {				
				_isSubWindowActive = false;
				_currentSubWindow.clearWindow();
				if( _popUIHolder.contains( _currentSubWindow ) ){
					_popUIHolder.removeChild( _currentSubWindow );
					_currentSubWindow = null;					
					removeTransparentWindow();
				}
			}
		}
		
		public function removeWindow( windowName:String ):void 
		{			
			var window:Object = searchWindow( windowName );
			
			if ( window.found  ) {
				if ( window.currentWindow != null ) {										
					if ( window.currentWindow == _currentWindow ){
						removeTransparentWindow();
						removeCurrentWindow();
					}else if ( window.currentWindow == _currentSubWindow ){
						removeTransparentWindow();
						removeCurrentSubWindow(); 
					}				
				}
			}
		}
		
		public function searchWindow( which:String ):Object
		{
			var obj:Object = new Object();
			
			for each ( var a:* in _popUpWindows ){
				if ( a.windowName == which ){
					//trace( "found: ", a.windowName);
					obj.currentWindow = a
					obj.found = true;
					break;
				}				
			}
			
			return obj;
		}		
		
		
		public function removeSubWindowByName( windowName:String ):void 
		{
			var len:int = _subWindows.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _subWindows[ i ].windowName == windowName ) {
					var window:AbstractWindow = _subWindows[ i ];
					window.clearWindow();
					if( _popUIHolder.contains( window ) ){
						_popUIHolder.removeChild( window );
						_subWindows[ i ] = null;
						_subWindows.splice( i, 1 );
						
						if( _subWindows.length == 0 ){
							removeTransparentWindow();
						}
					}
					break;
				}
			}
		}
		
		/*-----------------------------------------------------------------------Setters-------------------------------------------------------------------------*/
		public function set currentWindow(value:AbstractWindow):void 
		{
			_currentWindow = value;
		}
		
		public function set currentSubWindow(value:AbstractWindow):void 
		{
			_currentSubWindow = value;
		}
		
		public function set isWindowActive(value:Boolean):void 
		{
			_isWindowActive = value;
		}
		
		public function set isSubWindowActive(value:Boolean):void 
		{
			_isSubWindowActive = value;
		}
		/*-----------------------------------------------------------------------Getters-------------------------------------------------------------------------*/
		public function get currentWindow():AbstractWindow 
		{
			return _currentWindow;
		}
		
		public function get currentSubWindow():AbstractWindow 
		{
			return _currentSubWindow;
		}		
		
		public function get isWindowActive():Boolean 
		{
			return _isWindowActive;
		}		
		
		public function get isSubWindowActive():Boolean 
		{
			return _isSubWindowActive;
		}		
		/*-----------------------------------------------------------------------EventHandlers-------------------------------------------------------------------*/		
	}

}


class SingletonEnforcer {}