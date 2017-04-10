package com.surnia.socialStar.ui.mainMenuUI.view 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.ui.mainMenuUI.events.MainMenuUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class CharacterPanelBtn extends Sprite
	{
		/*-------------------------------------------------------Constant-----------------------------------------------------------------------------*/		
		
		/*-------------------------------------------------------Properties----------------------------------------------------------------------------*/		
		private var _mc:CharacterPanelBtnMC;
		private var _es:EventSatellite;
		private var _mainMenuUIEvent:MainMenuUIEvent;
		private var _bm:ButtonManager;
		/*-------------------------------------------------------Constructor---------------------------------------------------------------------------*/		
		
		public function CharacterPanelBtn() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			prepareControllers();
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-------------------------------------------------------Methods-----------------------------------------------------------------------------*/		
		private function setDisplay():void 
		{
			_bm = new ButtonManager();
			_mc = new CharacterPanelBtnMC();
			addChild( _mc );
			
			_bm.addBtnListener( _mc.tradeBtn );
			_bm.addBtnListener( _mc.closetBtn );
			_bm.addBtnListener( _mc.charBtn );
			_bm.addBtnListener( _mc.hireBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}		
		
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){	
				_bm.removeBtnListener( _mc.tradeBtn );
				_bm.removeBtnListener( _mc.closetBtn );
				_bm.removeBtnListener( _mc.charBtn );
				_bm.removeBtnListener( _mc.hireBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();				
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		
		private function prepareControllers():void 
		{
			_es = EventSatellite.getInstance();			
		}
		/*-------------------------------------------------------Setters-----------------------------------------------------------------------------*/		
		
		/*-------------------------------------------------------Getters-----------------------------------------------------------------------------*/		
		
		/*-------------------------------------------------------EventHandlers------------------------------------------------------------------------*/
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "charBtn":
					//trace( "char btn panel click!!!!!!" );
					_mc.gotoAndStop( 1 );
				break;
				
				case "closetBtn":
					//trace( "closet btn panel click!!!!!!" );
					_mc.gotoAndStop( 1 );
				break;
				
				case "tradeBtn":					
					_mc.gotoAndStop( 1 );
				break;
				
				case "hireBtn":					
					_mc.gotoAndStop( 1 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;			
			
			switch ( btnName ) 
			{
				case "charBtn":
					//trace( "char btn panel click!!!!!!" );
					_mc.gotoAndStop( 2 );
				break;
				
				case "closetBtn":
					//trace( "closet btn panel click!!!!!!" );
					_mc.gotoAndStop( 3 );
				break;
				
				case "tradeBtn":					
					_mc.gotoAndStop( 4 );
				break;			
				
				case "hireBtn":
					_mc.gotoAndStop( 5 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "charBtn":
					//trace( "char btn panel click!!!!!!" );
					_mainMenuUIEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_CHARACTER_POP_UP_WINDOW );
				break;
				
				case "closetBtn":
					//trace( "closet btn panel click!!!!!!" );
					_mainMenuUIEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_CLOSET_POP_UP_WINDOW );
				break;
				
				case "tradeBtn":
					//trace( "trade btn panel click!!!!!!" );
					_mainMenuUIEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_TRADE_POP_UP_WINDOW );
				break;
				
				case "hireBtn":
					//trace( "trade btn panel click!!!!!!" );
					_mainMenuUIEvent = new MainMenuUIEvent( MainMenuUIEvent.SHOW_HIRE_POP_UP_WINDOW );
				break;
				
				default:
					
				break;
			}
			
			if( _mainMenuUIEvent != null ){
				_es.dispatchESEvent( _mainMenuUIEvent );
			}
			
			//_mainMenuUIEvent = new MainMenuUIEvent( MainMenuUIEvent.REMOVE_CHARACTER_PANEL );
			//dispatchEvent( _mainMenuUIEvent );
		}
	}

}