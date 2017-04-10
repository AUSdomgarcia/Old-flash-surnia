package com.surnia.socialStar.ui.mainMenuUI.view 
{	
	import com.fluidLayout.FluidLayoutEvent;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.component.Button;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.ui.mainMenuUI.view.CharacterPanelBtn;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.tooltip.MiniTooltipManager;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.dialogue.event.DialogueEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.utils.points.Points;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MainMenuUI extends Sprite
	{
		/*-------------------------------------------------------------Constant-----------------------------------------------*/
		
		
		/*-------------------------------------------------------------Properties---------------------------------------------*/
		private var _mc:MainMenuUIMC;
		private var _mainMenuUIEvent:MainMenuUIEvent;
		private var _es:EventSatellite;
		private var _characterPanelBtn:CharacterPanelBtn;
		private var _bm:ButtonManager;
		
		private var _mainMenuTool:MainMenuPopUpTool;		
		private var _sdc:ServerDataController;
		private var _popUpUiManager:PopUpUIManager;
		private var _dialogue:DialogueEvent;
		private var _mtm:MiniTooltipManager = MiniTooltipManager.instance;
		private var _gd:GlobalData;
		/*-------------------------------------------------------------Constructor--------------------------------------------*/
		
		
		public function MainMenuUI() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			_gd = GlobalData.instance;			
			prepareControllers();		
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			
			setDisplay();
			registerTooltipItem();
		}	
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-------------------------------------------------------------Methods-----------------------------------------------*/
		private function registerTooltipItem():void {
			
			//var offsetY:Number = -60;
			
			_mtm.registerItem(_mc.inventoryBtn, "Inventory", -_mc.inventoryBtn.x, (-_mc.inventoryBtn.height) - _mc.inventoryBtn.y);
			_mtm.registerItem(_mc.collectionBtn, "Collection", -_mc.collectionBtn.x, (-_mc.collectionBtn.height) - _mc.collectionBtn.y);
			_mtm.registerItem(_mc.setupBtn, "Set", -_mc.setupBtn.x, (-_mc.setupBtn.height) - _mc.setupBtn.y);
			//_mtm.registerItem(_mc.toolBtn, "Tools", -_mc.toolBtn.x, (-_mc.toolBtn.height) - _mc.toolBtn.y);
			_mtm.registerItem(_mc.cancelBtn, "Cancel", -_mc.cancelBtn.x, (-_mc.cancelBtn.height ) - _mc.cancelBtn.y);
		}
		
		private function setDisplay():void 
		{	
			_bm = new ButtonManager();
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			_mc = new MainMenuUIMC();
			addChild( _mc );
			
			_bm.addBtnListener( _mc.inventoryBtn );
			_bm.addBtnListener( _mc.collectionBtn );
			_bm.addBtnListener( _mc.setupBtn );
			//_bm.addBtnListener( _mc.toolBtn );
			_bm.addBtnListener( _mc.storyBtn );
			_bm.addBtnListener( _mc.cancelBtn );
			
			_mc.storyBtn.gotoAndStop( 1 );
			
			update();			
		}
		
		
		private function update():void 
		{
			_gd.shopBtnXyPos = Points.getGlobalPoints( _mc.setupBtn );
			//trace( "[MainMenuUI]: pos xy", _gd.shopBtnXyPos.x, _gd.shopBtnXyPos.y );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
				_bm.removeBtnListener( _mc.inventoryBtn );
				_bm.removeBtnListener( _mc.collectionBtn );
				_bm.removeBtnListener( _mc.setupBtn );
				//_bm.removeBtnListener( _mc.toolBtn );
				_bm.removeBtnListener( _mc.storyBtn );
				_bm.removeBtnListener( _mc.cancelBtn );
				if ( this.contains( _mc )  ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		private function prepareControllers():void 
		{
			_sdc = ServerDataController.getInstance();
			_popUpUiManager = PopUpUIManager.getInstance();
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( SSEvent.FRIENDCHARLISTXML_LOADED, onFriendCharlistLoaded );
			_es.addEventListener( SSEvent.CHARLISTXML_LOADED, onMyCharListLoaded );
			
			_es.addEventListener( SSEvent.FRIENDOFFICESTATEXML_LOADED, onFriendOfficeStateLoaded );
			_es.addEventListener( SSEvent.OFFICESTATEXML_LOADED, onLoadMyOfficeState );
			
			_es.addEventListener( PopUIEvent.GO_BACK_HOME, onGoBackHome );			
			_es.addEventListener( FluidLayoutEvent.DONE_TWEENING, onFluidLayoutDoneTweening );
		}	
		
		private function addMainMenuTool():void 
		{
			if( _mainMenuTool == null ){
				_mainMenuTool = new MainMenuPopUpTool();
				addChild( _mainMenuTool );
				_mainMenuTool.x = _mc.toolBtn.x - 5;
				_mainMenuTool.y = _mc.toolBtn.y - 187;
				_mainMenuTool.addEventListener( MainMenuUIEvent.REMOVE_MAIN_MENU_TOOL_PANEL, onRemoveMainMenuTool );
			}else {
				removeMainMenuTool();
			}
		}		
		
		private function removeMainMenuTool():void 
		{
			if ( _mainMenuTool != null ) {
				if ( this.contains( _mainMenuTool ) ) {
					this.removeChild( _mainMenuTool );
					_mainMenuTool = null;
				}
			}
		}	
		
		private function removeDialogueWindowPopUP():void 
		{
			_popUpUiManager.removeWindow( WindowPopUpConfig.DIALOGUE_WINDOW );
		}
		
		
		private function loadMyOfficeData():void 
		{	
			_popUpUiManager.loadWindow( WindowPopUpConfig.DIALOGUE_WINDOW , 0, 0, true, 0, 0 );	
			_dialogue = new DialogueEvent( DialogueEvent.HOME_DIALOGUE );
			_es.dispatchEvent( _dialogue );
			
			_gd.officeStateDataArray = [new Array()];			
			_gd.officeId = _gd.myFbId;
			_sdc.updateHomeViewData();
			_sdc.updateMyCharlist();		
		}
		
		/*-------------------------------------------------------------Setters-----------------------------------------------*/
		
		/*-------------------------------------------------------------Getters-----------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers-----------------------------------------*/
		
		private function onButtonClick(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			var mainMenuEvent:MainMenuUIEvent;
			
			_bm.addBtnListener( _mc.inventoryBtn );
			_bm.addBtnListener( _mc.collectionBtn );
			_bm.addBtnListener( _mc.setupBtn );
			//_bm.addBtnListener( _mc.toolBtn );
			_bm.addBtnListener( _mc.storyBtn );
			_bm.addBtnListener( _mc.cancelBtn );		
			
			var popUpUIManager:PopUpUIManager = PopUpUIManager.getInstance();
			popUpUIManager.removeCurrentWindow();
			popUpUIManager.removeCurrentSubWindow();
			
			switch ( btnName ) 
			{					
				case "inventoryBtn":					
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_INVENTORY );
					_es.dispatchESEvent( mainMenuEvent );
					removeMainMenuTool();
					//trace( "inventoryBtn.........." );
					break;
				
				case "collectionBtn":					
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_COLLECTION );
					_es.dispatchESEvent( mainMenuEvent );
					removeMainMenuTool();
					//trace( "collectionBtn.........." );
					break;
				
				case "setupBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_SETUP );
					_es.dispatchESEvent( mainMenuEvent );
					removeMainMenuTool();
					//trace( "setupBtn.........." );
					break;
				
				//case "toolBtn":
					//mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_TOOLS );
					//_es.dispatchESEvent( mainMenuEvent );					
					//break;
				
				case "storyBtn":
					trace( "officeId", GlobalData.instance.officeId, "selectedFbId", GlobalData.instance.selectedFriendFbId );					
					if ( !GlobalData.instance.npcView  ){
						if ( GlobalData.instance.officeId != null ) {
							if ( GlobalData.instance.officeId != GlobalData.instance.myFbId ) {
								loadMyOfficeData();
							}else{
								mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_STORY_MODE );
								_es.dispatchESEvent( mainMenuEvent );
							}
						}else{
							mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_STORY_MODE );
							_es.dispatchESEvent( mainMenuEvent );
						}
					}else {
						loadMyOfficeData();
					}					
					removeMainMenuTool();
					//trace( "storyBtn.........." );
					break;
				
				case "cancelBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.CANCEL_TOOL );
					_es.dispatchESEvent( mainMenuEvent );
					removeMainMenuTool();
					trace( "cancelBtn.........." );
					break;
				
				default:					
					break;
			}			
		}
		
		private function onButtonRollOut(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;			
			
			switch ( btnName ) 
			{				
				case "storyBtn":
					if ( GlobalData.instance.officeId != GlobalData.instance.myFbId ) {
						_mc.storyBtn.gotoAndStop( 3 );
					}else {
						_mc.storyBtn.gotoAndStop( 1 );
					}
					break;				
				
				default:					
					e.obj.btn.gotoAndStop( 1 );
					break;
			}					
		}
		
		private function onButtonRollOver(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;			
			
			switch ( btnName ) 
			{				
				case "storyBtn":		
					_mtm.unregisterItem(_mc.storyBtn);			
					if (!_gd.friendView){
						_mtm.registerItem(_mc.storyBtn, "Story Mode", -_mc.storyBtn.x, (-_mc.storyBtn.height * .7) - _mc.storyBtn.y);
					} else {
						_mtm.registerItem(_mc.storyBtn, "Return Back", -_mc.storyBtn.x, (-_mc.storyBtn.height * .7) - _mc.storyBtn.y);
					}
					
					if ( GlobalData.instance.officeId != GlobalData.instance.myFbId  ) {
						_mc.storyBtn.gotoAndStop( 4 );
					}else {
						_mc.storyBtn.gotoAndStop( 2 );
					}
					break;
				
				case "setupBtn":
					//update();
					//var tutEvent = new TutorialEvent( TutorialEvent.SHOW_ARROW_GUIDE_SHOP_BTN );
					//_es.dispatchESEvent( tutEvent );
					break;
				
				default:					
					e.obj.btn.gotoAndStop( 2 );
					break;
			}
		}		
		
		private function onRemoveMainMenuTool(e:MainMenuUIEvent):void 
		{
			removeMainMenuTool();
		}
		
		private function onLoadMyOfficeState(e:SSEvent):void 
		{	
			trace( "MainMenu MyOffice State loaded................................" );
			GlobalData.instance.officeId = GlobalData.instance.myFbId;
			
			if( _mc != null ){
				_mc.storyBtn.gotoAndStop( 1 );
			}
		}	
		
		private function onMyCharListLoaded(e:SSEvent):void 
		{
			trace( "MainMenu MY Charlist loaded................................" );
			GlobalData.instance.officeId = GlobalData.instance.myFbId;
			
			if( _mc != null ){
				_mc.storyBtn.gotoAndStop( 1 );			
			}
		}
		
		private function onGoBackHome(e:PopUIEvent):void 
		{
			trace( "go back home!!!!!!!!!!!!! myfbid", GlobalData.instance.myFbId );
			//GlobalData.instance.selectedFriendFbId = null;
			GlobalData.instance.officeId = GlobalData.instance.myFbId;
			
			if( _mc != null ){
				_mc.storyBtn.gotoAndStop( 1 );			
			}
		}
		
		private function onFriendOfficeStateLoaded(e:SSEvent):void 
		{
			trace( "MainMenu FriendOffice State loaded................................" );			
			//if ( GlobalData.instance.npcView ) {
			//GlobalData.instance.officeId = null;
			//}else {
			GlobalData.instance.officeId = GlobalData.instance.selectedFriendFbId;			
			//}
			
			if( _mc != null ){
				_mc.storyBtn.gotoAndStop( 3 );			
			}
		}
		
		private function onFriendCharlistLoaded(e:SSEvent):void 
		{
			trace( "MainMenu friend Charlist loaded................................" );			
			//if ( GlobalData.instance.npcView ) {
			//GlobalData.instance.officeId = null;
			//}else{
			GlobalData.instance.officeId = GlobalData.instance.selectedFriendFbId;			
			//}			
			if( _mc != null ){
				_mc.storyBtn.gotoAndStop( 3 );
			}
			//removeDialogueWindowPopUP();
		}		
		
		private function onFluidLayoutDoneTweening(e:FluidLayoutEvent):void 
		{
			update();
		}
	}
	
}