package com.surnia.socialStar.views.bubbles 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JC
	 */
	public class Bubbles extends Sprite
	{
		
		/*-----------------------------------------------------------------Constant---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Properties-------------------------------------------------------------------------*/
		
		/*
		 *  testing docs 
		 * 
		 * 
		 * 
		 * 
		 */
		
		private var _mc:BubbleMC;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _status:String;
		
		/*-----------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		public function Bubbles( xPos:Number, yPos:Number, status:String = "none" ) 
		{
			_xPos = xPos;
			_yPos = yPos;
			_status = status;			
			setDisplay();
		}
		
		/*-----------------------------------------------------------------Methods---------------------------------------------------------------------------*/
		public function setDisplay():void 
		{
			_mc = new BubbleMC();
			addChild( _mc );
			_mc.x = _xPos;
			_mc.y = _yPos;
			_mc.gotoAndStop( _status );
		}
		
		public function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}		
		
		public function showBubble( type:String ):void 
		{
			//trace( "show bubbe type 1 ", type );
			if( _mc != null ){
				_mc.gotoAndStop( type );
				//trace( "show bubbe type 2 ", type );
			}
		}
		
		/*-----------------------------------------------------------------Setters---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Getters---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		
	}

}