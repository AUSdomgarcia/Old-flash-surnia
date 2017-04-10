package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.crafting.CraftingMain;
	import com.surnia.socialStar.ui.popUI.components.*;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class CraftingWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _crafting:CraftingMain;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function CraftingWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();	
			setDisplay();
		}
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}		
		
		private function setDisplay():void {
			_crafting = new CraftingMain();
			addChild( _crafting );
		}
		
		
		private function removeDisplay():void 
		{
			if ( _crafting != null ) {
				if ( this.contains( _crafting ) ) {
					this.removeChild( _crafting );
					_crafting = null;
				}
			}
		}
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}