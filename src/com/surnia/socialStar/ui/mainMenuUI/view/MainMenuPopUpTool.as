package com.surnia.socialStar.ui.mainMenuUI.view 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class MainMenuPopUpTool extends Sprite
	{
		
		/*--------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		private var _mc:MainToolPopUpMC;
		private var _bm:ButtonManager;
		private var _es:EventSatellite;
		
		/*--------------------------------------------------------------------------Constructor---------------------------------------------------------------*/
		
		public function MainMenuPopUpTool() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*--------------------------------------------------------------------------Methods------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_es = EventSatellite.getInstance();
			
			_bm = new ButtonManager();
			_mc = new MainToolPopUpMC();
			addChild( _mc );			
			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onButtonClick );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onButtonRollOver );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onButtonRollOut );
			
			_bm.addBtnListener( _mc.moveBtn );
			_bm.addBtnListener( _mc.rotateBtn );
			_bm.addBtnListener( _mc.sellBtn );
			_bm.addBtnListener( _mc.toolBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		/*--------------------------------------------------------------------------Setters------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Getters------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		private function onButtonClick(e:ButtonEvent):void 
		{
			var mainMenuEvent:MainMenuUIEvent;
			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{			
				case "moveBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SELECT_MOVE_TOOL );
					_es.dispatchESEvent( mainMenuEvent );
					trace( "moveBtn" );					
				break;
				
				case "rotateBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SELECT_ROTATE_TOOL );
					_es.dispatchESEvent( mainMenuEvent );
					trace( "rotateBtn" );
				break;
				
				case "sellBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SELECT_SELL_TOOL );
					_es.dispatchESEvent( mainMenuEvent );
					trace( "sellBtn" );
				break;
				
				case "toolBtn":
					mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.SELECT_RETURN_TOOL );
					_es.dispatchESEvent( mainMenuEvent );
					trace( "returnBtn" );					
				break;
				
				default:					
				break;
			}
			
			mainMenuEvent = new MainMenuUIEvent( MainMenuUIEvent.REMOVE_MAIN_MENU_TOOL_PANEL );
			dispatchEvent( mainMenuEvent );
		}
		
		private function onButtonRollOut(e:ButtonEvent):void 
		{
			e.obj.btn.gotoAndStop( 1 );
		}
		
		private function onButtonRollOver(e:ButtonEvent):void 
		{
			e.obj.btn.gotoAndStop( 2 );			
		}
	}

}