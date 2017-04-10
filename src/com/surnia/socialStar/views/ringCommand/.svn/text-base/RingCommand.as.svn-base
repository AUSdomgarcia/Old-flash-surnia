package com.surnia.socialStar.views.ringCommand 
{
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.views.ringCommand.events.RingCommandEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class RingCommand extends Sprite
	{
		/*--------------------------------------------------------------------------Constant-------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private var _commands:Array;
		private var _commandBoxHolder:Sprite;
		private var _ringCommands:Array;
		private var _es:EventSatellite;
		private var _gd:GlobalData;
		/*--------------------------------------------------------------------------Constructor----------------------------------------------------------------*/		
		
		/**
		 * 
		 * @param	commands - array of string commands
		 */
		
		public function RingCommand(  ) 
		{			
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			//ring command
			_es.addEventListener( RingCommandEvent.ON_SHOW_RING_COMMAND, onShowRingCommand );
			_es.addEventListener( RingCommandEvent.ON_REMOVE_RING_COMMAND, onRemoveRingCommand );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );			
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		
		private function setDisplay( commands:Array ):void 
		{			
			if( commands != null ){
				_commands = commands;
				_commandBoxHolder = new Sprite();
				addChild( _commandBoxHolder );
				if ( stage != null ) {
					_commandBoxHolder.x = stage.mouseX;
					_commandBoxHolder.y = stage.mouseY;
				}
				_ringCommands = new Array();
				
				var len:int = _commands.length;
				var commandBox:CommandBox;
				
				for (var i:int = 0; i < len; i++) 
				{
					commandBox = new CommandBox( _commands[ i ] );
					_commandBoxHolder.addChild( commandBox );
					_ringCommands.push( commandBox );
				}
				
				var speed:Number = 0.4;
				var distance:int = 50;
				var distance2:int = 60;
				
				if( _ringCommands != null ){
					if( len == 1 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance , ease:Elastic.easeOut } );
					}else if ( len == 2 ) {
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { y:_ringCommands[ 1 ].mc.y + distance , ease:Elastic.easeOut } );
					}else if ( len == 3 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , ease:Elastic.easeOut } );
					}else if ( len == 4 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 3 ].mc, speed, { y:_ringCommands[ 3 ].mc.y + distance , ease:Elastic.easeOut } );
					}else if ( len == 5 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , ease:Elastic.easeOut } );				
						TweenLite.to( _ringCommands[ 3 ].mc, speed, { x:_ringCommands[ 3 ].mc.x - distance / 2 , y:_ringCommands[ 3 ].mc.y + distance2, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 4 ].mc, speed, { x:_ringCommands[ 4 ].mc.x + distance / 2 ,y:_ringCommands[ 4 ].mc.y + distance2, ease:Elastic.easeOut } );
					}else if ( len == 6 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance /2 , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , ease:Elastic.easeOut } );
						
						TweenLite.to( _ringCommands[ 3 ].mc, speed, { y: _ringCommands[ 3 ].mc.y + distance * 1.5 , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 4 ].mc, speed, { x:_ringCommands[ 4 ].mc.x - distance ,y: _ringCommands[ 4 ].mc.y + distance, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 5 ].mc, speed, { x:_ringCommands[ 5 ].mc.x + distance , y: _ringCommands[ 5 ].mc.y + distance,  ease:Elastic.easeOut } );
					}else if ( len == 7 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance /2 , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , ease:Elastic.easeOut } );
						
						TweenLite.to( _ringCommands[ 3 ].mc, speed, { x:_ringCommands[ 3 ].mc.x - distance * 0.5 , y:_ringCommands[ 3 ].mc.y + distance * 1.95, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 4 ].mc, speed, { x:_ringCommands[ 4 ].mc.x + distance * 0.5  , y:_ringCommands[ 4 ].mc.y + distance * 1.95, ease:Elastic.easeOut } );				
						
						TweenLite.to( _ringCommands[ 5 ].mc, speed, { x:_ringCommands[ 5 ].mc.x - distance ,y: _ringCommands[ 5 ].mc.y + distance, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 6 ].mc, speed, { x:_ringCommands[ 6 ].mc.x + distance , y: _ringCommands[ 6 ].mc.y + distance,  ease:Elastic.easeOut } );
					}else if ( len == 8 ){
						TweenLite.to( _ringCommands[ 0 ].mc, speed, { y: -distance /2 , ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 1 ].mc, speed, { x:_ringCommands[ 1 ].mc.x - distance , y: -distance /2, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 2 ].mc, speed, { x:_ringCommands[ 2 ].mc.x + distance , y: -distance /2, ease:Elastic.easeOut } );
						
						TweenLite.to( _ringCommands[ 3 ].mc, speed, { x:_ringCommands[ 5 ].mc.x - distance , y:_ringCommands[ 3 ].mc.y + distance * 1.5, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 4 ].mc, speed, { x:_ringCommands[ 6 ].mc.x + distance , y:_ringCommands[ 4 ].mc.y + distance * 1.5, ease:Elastic.easeOut } );				
						
						TweenLite.to( _ringCommands[ 5 ].mc, speed, { x:_ringCommands[ 5 ].mc.x - distance ,y: _ringCommands[ 5 ].mc.y + distance/2, ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 6 ].mc, speed, { x:_ringCommands[ 6 ].mc.x + distance , y: _ringCommands[ 6 ].mc.y + distance / 2,  ease:Elastic.easeOut } );
						TweenLite.to( _ringCommands[ 7 ].mc, speed, { x:_ringCommands[ 7 ].mc.x , y: _ringCommands[ 6 ].mc.y + distance * 1.5,  ease:Elastic.easeOut } );
					}
				}			
			}
		}
		
		private function removeDisplay():void 
		{
			//_es.removeEventListener( RingCommandEvent.ON_SHOW_RING_COMMAND, onShowRingCommand );
			//_es.removeEventListener( RingCommandEvent.ON_REMOVE_RING_COMMAND, onRemoveRingCommand );
			
			if( _ringCommands != null && _commandBoxHolder != null && _commands != null ){
				var len:int = _ringCommands.length;
				
				for (var i:int = 0; i < len; i++) 
				{
					if ( _ringCommands[ i ] != null ) {
						if ( _commandBoxHolder.contains( _ringCommands[ i ] ) ) {
							_commandBoxHolder.removeChild( _ringCommands[ i ] );
							_ringCommands[ i ] = null;
							_ringCommands.splice( i, 1 );
						}
					}
				}
					
				if ( this.contains( _commandBoxHolder ) ) {
					this.removeChild( _commandBoxHolder );
					_commandBoxHolder = null;
				}			
				
				_commands = new Array();
				_ringCommands = new Array();				
			}			
		}		
		
		/*--------------------------------------------------------------------------Methods-------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------EventHandlers-------------------------------------------------------------*/
		private function onRemoveRingCommand(e:RingCommandEvent):void 
		{			
			removeDisplay();			
		}
		
		private function onShowRingCommand(e:RingCommandEvent):void 
		{			
			if ( e.obj != null ) {
				removeDisplay();
				setDisplay( e.obj.commands );
			}
			trace( "[ISoroom]: show ring commands=============>" );
		}
	}

}