package com.surnia.socialStar.views.ringCommand 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.views.ringCommand.events.RingCommandEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class CommandBox extends Sprite
	{
		/*-----------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _mc:commandMC;
		private var _bm:ButtonManager;
		private var _command:String;
		private var _gd:GlobalData;
		private var _es:EventSatellite;
		/*-----------------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function CommandBox( command:String ) 
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			_command = command;
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
		
		/*-----------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new commandMC();
			addChild( _mc );			
			_mc.gotoAndStop( _command );
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc );			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc );
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
		
		/*-----------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		public function set mc(value:commandMC):void 
		{
			_mc = value;
		}
		/*-----------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function get mc():commandMC 
		{
			return _mc;
		}
		/*-----------------------------------------------------------------------------Eventhandlers--------------------------------------------------------*/
		private function onClickBtn(e:ButtonEvent):void 
		{
			//var btnName:String = e.obj.name;
			trace( "click command box", _command );
			var ringCommandEvent:RingCommandEvent;
			
			switch ( _command ) 
			{
				case GlobalData.COMMAND_MOVE:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_MOVE_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_ROTATE:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_ROTATE_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );		
				break;
				
				case GlobalData.COMMAND_SELL:					
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SELL_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );					
				break;
				
				case GlobalData.COMMAND_COLLECT:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_COLLECT_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_STAFF:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_HIRE_STAFF_OFFICE_OBJECT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_INFO:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SHOW_CONTESTANT_INFO );
					_es.dispatchESEvent( ringCommandEvent );
				break;				
				
				case GlobalData.COMMAND_REST:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REST_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_SOOTHE:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SOOTHE_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_CHEER:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_CHEER_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_SHOP:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_SHOP_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_INVENTORY:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_PUT_TO_INVENTORY );
					_es.dispatchESEvent( ringCommandEvent );
				break;				
				
				case GlobalData.COMMAND_INVENTORY_CONTESTANT:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_PUT_TO_INVENTORY_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_TRAINING:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_TRAIN_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_STOP:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_STOP_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_PLAY:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_PLAY_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_FAST:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_FAST_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_RECRUIT:					
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_RECRUIT_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_FIRE:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_FIRE_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_ACTION1:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_ACTION1_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_ACTION1_LOCK:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_ACTION1_LOCK_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_ACTION2:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_ACTION2_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_ACTION2_LOCK:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_ACTION2_LOCK_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_MOVE_CONTESTANT:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_MOVE_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				case GlobalData.COMMAND_STOP_RESTING:
					ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_STOP_RESTING_CONTESTANT );
					_es.dispatchESEvent( ringCommandEvent );
				break;
				
				default:
				break;
			}
			
			ringCommandEvent = new RingCommandEvent( RingCommandEvent.ON_REMOVE_RING_COMMAND );
			_es.dispatchESEvent( ringCommandEvent );
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			//var btnName:String = e.obj.name;			
			//trace( "roll out command box" );
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			//var btnName:String = e.obj.name;			
			//trace( "roll over command box" ); charshop
		}
	}

}