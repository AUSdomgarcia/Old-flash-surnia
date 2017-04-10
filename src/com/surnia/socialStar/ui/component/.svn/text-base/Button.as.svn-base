package com.surnia.socialStar.ui.component 
{	
	import com.surnia.socialStar.ui.component.AbstractButton;
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Button extends AbstractButton
	{
		
		/*---------------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _mc:MovieClip;
		private var _friendUIEvent:FriendUIEvent;
		/*---------------------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		public function Button( event:*,mc:MovieClip, xPos:Number, yPos:Number  ) 
		{
			super( event, mc, xPos, yPos  );
			_mc = mc;
		}
		
		/*---------------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------Gettters--------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		override public function onClickBtn(e:MouseEvent):void 
		{
			super.onClickBtn(e);
			
			//_friendUIEvent = new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN );
			//dispatchEvent( _friendUIEvent );			
		}
		
		override public function onRollOverBtn(e:MouseEvent):void 
		{
			super.onRollOverBtn(e);
			_mc.gotoAndStop( 2 );
			
		}
		
		override public function onRollOutBtn(e:MouseEvent):void 
		{
			super.onRollOutBtn(e);
			_mc.gotoAndStop( 1 );
		}
		
		
	}

}