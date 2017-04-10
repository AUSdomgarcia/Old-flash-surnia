package com.surnia.socialStar.ui.popUI.itemShopUI 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.ui.popUI.itemShopUI.events.ItemShopEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author JC
	 */
	public class ShopTab extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant-----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _mc:TabMC;
		private var _tabFrame:int;		
		private var _tabName:String;
		private var _active:Boolean;
		/*----------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		public function ShopTab( tabFrame:int, tabName:String ) 
		{
			_tabFrame = tabFrame;
			_tabName = tabName;
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
		
		/*----------------------------------------------------------------------Methods-------------------------------------------------------------------*/
		private function setDisplay():void 
		{		
			_mc = new TabMC();
			addChild( _mc );					
			_mc.gotoAndStop( _tabName );
			
			_mc.buttonMode = true;
			_mc.name = _tabName;
			_mc.addEventListener( MouseEvent.CLICK, onButtonClick );
			_mc.addEventListener( MouseEvent.ROLL_OVER, onButtonRollOver );
			_mc.addEventListener( MouseEvent.ROLL_OUT, onButtonRollOut );			
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
		
		/**
		 * 
		 * @param	status 1or 2 only
		 */
		public function setStatus( status:int ):void 
		{		
			if ( status > 2 ) {
				status = 1;				
			}
			
			if ( status == 1 ) {
				_active = false;
			}else{
				_active = true;
			}
			
			_mc.tab.gotoAndStop( status );			
		}
		
		/*----------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		public function set mc(value:TabMC):void 
		{
			_mc = value;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
		}
		
		public function set tabName(value:String):void 
		{
			_tabName = value;
		}
		/*----------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		public function get mc():TabMC 
		{
			return _mc;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function get tabName():String 
		{
			return _tabName;
		}	
		
		/*----------------------------------------------------------------------EventHandlers-------------------------------------------------------------*/
		private function onButtonClick(e:MouseEvent):void 
		{			
			trace( "tabName", e.currentTarget.name );	
			if ( _mc.tab.currentFrame == 1 ) {
				_mc.tab.gotoAndStop( 2 );				
				_active = true;
				
				var itemShopEvent:ItemShopEvent = new ItemShopEvent( ItemShopEvent.CHANGE_TAB );
				itemShopEvent.obj.name = e.currentTarget.name;
				dispatchEvent( itemShopEvent );				
			}else { 
				_mc.tab.gotoAndStop( 1 );
				_active = false;
			}			
		}
		
		private function onButtonRollOut(e:MouseEvent):void 
		{			
			TweenLite.to( _mc, 0.2, { y:0 } );
		}
		
		private function onButtonRollOver(e:MouseEvent):void 
		{			
			trace( "_active", _active );
			if( !_active ){
				TweenLite.to( _mc, 0.2, { y: -10 } );			
			}
		} 
	}

}