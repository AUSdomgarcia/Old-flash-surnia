package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.ui.popUI.data.MinimapCharacterListModel;
	import com.surnia.socialStar.ui.popUI.views.MinimapCharacterListManager;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author domz
	 */
	public class MinimapCharacterPanelTest extends Sprite
	{
		private var model:MinimapCharacterListModel;
		private var manager:MinimapCharacterListManager;
		
		public function MinimapCharacterPanelTest( $stref:Stage , $pt:Sprite ) 
		{
			model = new MinimapCharacterListModel( $stref );
			manager = new MinimapCharacterListManager( model, $pt );
			$pt.addChild( manager );
		}
	}

}