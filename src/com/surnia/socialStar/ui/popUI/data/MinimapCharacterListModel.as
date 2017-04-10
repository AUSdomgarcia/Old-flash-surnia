package com.surnia.socialStar.ui.popUI.data 
{
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author domz
	 */
	public class MinimapCharacterListModel extends Sprite
	{
		private var stref:Stage;
		public var btnLeft:UIMapLBUTTON = new UIMapLBUTTON();
		public var btnRight:UIMapRButton = new UIMapRButton();
		public var closeBtn:UICloseBtn = new UICloseBtn();
		
		public var faceHolder_mc:MovieClip; /* FEMALE_AVATARs or FEMALE_AVATARs */
		public var faceHolder_arr:Array = [];
		
		public var listHolder:MovieClip;
		public var listBg:BGList = new BGList();
		public var _stref:Stage;
		
		public var classPrice_2darr:Array = [ new Array() ];
		
		public function MinimapCharacterListModel( s:Stage ) 
		{
			_stref = s;
			ServerDataExtractor.instance.updateData(GlobalData.CHARLIST_DATA , "charlistCharShop.xml");
		}
			
			/*var obj:Object = GlobalData.instance.getClassPriceDataByType( 1 );
			trace( "Sample", obj.type );
			classPrice_2darr = GlobalData.instance.classPriceDataArray;
			this.dispatchEvent( new Event( "VALUES_READY" ));
			*/
		
		
	//end
	}
}