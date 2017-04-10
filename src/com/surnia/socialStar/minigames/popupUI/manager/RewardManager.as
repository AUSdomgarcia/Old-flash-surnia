package com.surnia.socialStar.minigames.popupUI.manager 
{
	import com.surnia.socialStar.minigames.popupUI.model.RewardModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author domz
	 */
	public class RewardManager extends Sprite
	{
		public var model:RewardModel;
		private var target:Sprite;
		private var layer0:Sprite;
		private var layer1:Sprite;
		private var globalX:Number = 0;
		private var globalY:Number = 0;
		private var isShareto:Boolean = false;
		private var isInvite:Boolean = false;
		
		public function RewardManager( m:RewardModel, x:Number, y:Number, spt:Sprite )  
		{
			globalX = x;
			globalY = y;
			
			target = spt;
			model = m;
			init();
		}
		private function init():void {
			trace("EXIST");
		}
		
		public function setReward( str:String, index1:Number, index2:Number ):void {
			layer0 = new Sprite();
			layer1 = new Sprite();
			
			model.arrTxt[ index1 ][ index2 ];
			
			model.window = new VictoryRewardWindow();
			model.window.x = globalX;
			model.window.y = globalY;
			
			model.modelFormat.color = 0x008080;
			model.modelFormat.size = 12;
			model.modelFormat.align="left";				
			model.modelFormat.font = "Arial Bold";
			model.window.TXT1.defaultTextFormat = model.modelFormat;
			model.window.TXT2.defaultTextFormat = model.modelFormat;
			
			switch( str ) {
				case model.WIN:
				
					model.window.TXT1.text = String(model.arrTxt[ 0 ][ index1 ] );
					model.window.TXT2.text = String(model.arrTxt[ 1 ][ index2 ] );;
					model.shareTo.x = model.window.x + model.window.width / 2 -  model.shareTo.width / 2;
					model.shareTo.y = model.window.y + 287;
					
					model.window.WINDOW.gotoAndStop(2);
					layer0.addChild( model.shareTo );
					isShareto = true;
				break;
					
				case model.LOSE:
					model.window.TXT1.text = String(model.arrTxt[ 0 ][ index1 ] );
					model.window.TXT2.text = String(model.arrTxt[ 1 ][ index2 ] );
					
					model.inviteMc.x = model.window.x + model.window.width / 2 -  model.inviteMc.width / 2;
					model.inviteMc.y = model.window.y + 279;
					layer1.addChild( model.inviteMc );
					isInvite = true;
				break;
			}
			addListener();
		}
		
		public function addListener():void {
			if ( isShareto ){
				model.shareTo.addEventListener(MouseEvent.ROLL_OVER, onOver );
				model.shareTo.addEventListener(MouseEvent.ROLL_OUT, onOut );
				model.shareTo.addEventListener(MouseEvent.CLICK, onClick );
			} else if ( isInvite ) {
				model.inviteMc.addEventListener(MouseEvent.ROLL_OVER, onOver );
				model.inviteMc.addEventListener(MouseEvent.ROLL_OUT, onOut );
				model.inviteMc.addEventListener(MouseEvent.CLICK, onClick );
			}
			
			model.window.CLOSE.addEventListener(MouseEvent.ROLL_OVER, onOver);
			model.window.CLOSE.addEventListener(MouseEvent.ROLL_OUT, onOut);
			model.window.CLOSE.addEventListener(MouseEvent.CLICK, onClick);	
		}
		
		private function onOver( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.shareTo:
					model.shareTo.gotoAndStop( 2 );
				break;
				case model.inviteMc:
					model.inviteMc.gotoAndStop( 2 );
				break;
				case model.window.CLOSE:
					model.window.CLOSE.gotoAndStop( 2 );
				break;
				
			}
		}
		
		private function onOut( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.shareTo:
					model.shareTo.gotoAndStop( 1 );
				break;
				case model.inviteMc:
					model.inviteMc.gotoAndStop( 1 );
				break;
				case model.window.CLOSE:
					model.window.CLOSE.gotoAndStop( 1 );
				break;
			}
		}
		private function onClick( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.shareTo:
					removeItem();
					target.dispatchEvent( new Event( model.SHARE ));
				break;
				case model.inviteMc:
					removeItem();
					target.dispatchEvent( new Event( model.INVITE ));
				break;
				case model.window.CLOSE:
						removeItem();
					target.dispatchEvent( new Event( model.CLOSEME ));
				break;
			}
		}
		
		public function addItem():void {
			target.addChild( model.window );
			target.addChild( layer1 );
			target.addChild( layer0 );
		}
		
		public function removeItem():void {
			removeListener();
			target.removeChild( layer1 );
			target.removeChild( layer0 );
			target.removeChild( model.window );
			model.window = null;
			layer0 = null;
			layer1 = null;
		}
		
		public function removeListener():void {
			if ( isShareto ){
				model.shareTo.removeEventListener(MouseEvent.ROLL_OVER, onOver );
				model.shareTo.removeEventListener(MouseEvent.ROLL_OUT, onOut );
				model.shareTo.removeEventListener(MouseEvent.CLICK, onClick );
			} else if ( isInvite ) {
				model.inviteMc.removeEventListener(MouseEvent.ROLL_OVER, onOver );
				model.inviteMc.removeEventListener(MouseEvent.ROLL_OUT, onOut );
				model.inviteMc.removeEventListener(MouseEvent.CLICK, onClick );
			}
			
			model.window.CLOSE.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			model.window.CLOSE.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			model.window.CLOSE.removeEventListener(MouseEvent.CLICK, onClick);	
		}
//end
	}
}