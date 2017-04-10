package com.surnia.socialStar.crafting.Material 
{
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.system.Security;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.crafting.event.CraftingEvent;
	
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	public class BoxDataHolder extends Sprite
	{
		private var _es:EventSatellite;
		private var imgLoader:Loader;
		
		public var boxMC:MovieClip;
		private var titleText:TextField;
		private var qtyDisplayText:TextField;
		private var imageHolder:Sprite;
		
		//btn
		private var starBtn:StarBtn;
		private var askBtn:AskButton;
		private var title:String;
		public var picURL:String;
		public var maxqty:Number;
		public var qtyhave:Number;
		public var starLen:Number;
		public var id:String;		
		
		private var funct:String;
		private var qtyDisplay:String;
		
		private var BoldText:TextFormat;
		
		
		public function BoxDataHolder( _id:String, _url:String, _title:String, _maxqty:Number, _qtyhave:Number ,_funct:String, _starLen:Number ) 
		{
			_es = EventSatellite.getInstance();
			
			starLen = _starLen;
			funct = _funct;
			boxMC = new BoxHolder();
			
			id = _id;
			picURL = _url;
			title = _title;
			maxqty = _maxqty;
			qtyhave = _qtyhave;
			
			boxDisplaySwaper( funct );	
		}
		
		private function boxDisplaySwaper( str:String ):void 
		{
			if (picURL != "")
			{
				imageLoader( picURL );
			}
			
			switch( str ) 
			{
				case "material":
						initMaterialText();
						boxMC.title.text = title;
						boxMC.title.selectable = false;
						// boxMC.amtDisplay.text = "" + qtyhave + "/" + maxqty; 
						boxMC.amtDisplay.text = qtyhave; 
						boxMC.amtDisplay.selectable = false;
						boxMC.amtDisplay.setTextFormat( BoldText );
						boxMC.title.setTextFormat(BoldText);
					break;
					
				case "craft":
						boxMC.amtDisplay.text = "" + qtyhave + "/" + maxqty;
						boxMC.amtDisplay.selectable = false;
						boxMC.title.text = "";
						
						//------------------
						// STAR BUTTON
						//-----------------
						starBtn = new StarBtn;
						starBtn.x = (boxMC.x + boxMC.width / 2) - starBtn.width / 2;
						starBtn.y = boxMC.y + boxMC.height - starBtn.height;
						starBtn.buttonMode = true;
						starBtn.addEventListener( MouseEvent.MOUSE_OVER, _onBoxDataHolderBtnOver );
						starBtn.addEventListener( MouseEvent.MOUSE_OUT, _onBoxDataHolderBtnOut );
						starBtn.addEventListener( MouseEvent.MOUSE_DOWN, _onBoxDataHolderStarBtnPress );
						starBtn.star.text = String( starLen );
						
						//------------------
						// ASK BUTTON
						//-----------------
						askBtn = new AskButton;
						askBtn.x = (boxMC.x + boxMC.width / 2) - askBtn.width / 2;
						askBtn.y = starBtn.y - 70;
						askBtn.buttonMode = true;
						askBtn.addEventListener( MouseEvent.MOUSE_OVER, _onBoxDataHolderBtnOver );
						askBtn.addEventListener( MouseEvent.MOUSE_OUT, _onBoxDataHolderBtnOut );
						askBtn.addEventListener( MouseEvent.MOUSE_DOWN, _onBoxDataHolderAskBtnPress );
					break;
					
				case "main":
						initMaterialText();
						boxMC.title.text = title;
						boxMC.title.selectable = false;
						boxMC.amtDisplay.text = "0";
						boxMC.amtDisplay.selectable = false;
						boxMC.amtDisplay.setTextFormat(BoldText);
						boxMC.title.setTextFormat(BoldText);
					break;
				
			}
		}
		
		private function initMaterialText():void 
		{
			BoldText = new TextFormat();
			BoldText.bold = true;
		}
		
		private function imageLoader( str:String ):void {
			// imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, imageLoading);
			try
			{
				imgLoader = new Loader();
				imgLoader.load(new URLRequest( str ));
				imgLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, imageLoaded );
				imgLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, imageLoaderEvent );
			}
			catch (e:Error)
			{
				trace('BoxDataHolder::imageLoader=' + e);
			}
		}
		
		private function imageLoaded( e:Event ):void 
		{
			// addChild( imgLoader.content );
			/*var image:Bitmap = new Bitmap( e.target.content.bitmapData );
			image.smoothing = true;
			boxMC.mcholder.addChild(image);
			addItem();*/
			if ( e.target.content.bitmapData.width > boxMC.width || e.target.content.bitmapData.height > boxMC.height )
			{
				var _mat:Matrix = new Matrix();
				
				var _scaleAmt:Number = getScale( e.target.content.bitmapData.width, e.target.content.bitmapData.height, boxMC.width - 10, boxMC.height - 10 );
				
				_mat.scale( _scaleAmt, _scaleAmt );
				
				var _scaledW:Number = e.target.content.bitmapData.width * _scaleAmt;
				var _scaledH:Number = e.target.content.bitmapData.height * _scaleAmt;
				
				//var _bmpData:BitmapData = new BitmapData(e.target.content.bitmapData.width, e.target.content.bitmapData.height, true, 0);
				
				var _bmpData:BitmapData = new BitmapData( _scaledW , _scaledH, true, 0 );
				_bmpData.draw( e.target.content.bitmapData, _mat, null, null, null, true );
				var _img:Bitmap = new Bitmap( _bmpData );
				
				_img.x = ( boxMC.width - _scaledW ) / 2;
				//_img.y = ( boxMC.height - _scaledH ) / 2;
				
				boxMC.mcholder.addChild( _img );
			}
			else
			{
				var image:Bitmap = new Bitmap( e.target.content.bitmapData );
				image.smoothing = true;
				image.x = ( boxMC.width - e.target.content.bitmapData.width ) / 2;
				image.y = ( boxMC.height - e.target.content.bitmapData.height ) / 2;
				boxMC.mcholder.addChild(image);
			}
			addItem();
		}
		
		//--------------------------------------------------------------------------------------
		// this function gets the scale percentage of the image based on the containers size
		// @ _w = width of the passed bitmap
		// @ _h = height of the passed bitmap
		// @ _containerWidth = width of the container movieclip which will contain the bitmap
		// @ _containerWidth = height of the container movieclip which will contain the bitmap
		//--------------------------------------------------------------------------------------
		private function getScale(_w:Number, _h:Number, _containerWidth:Number, _containerHeight:Number):Number
		{
			var _val:Number;
			if ( _w > _h )
			{
				_val = ( 100 * _containerWidth ) / _w;
			}
			else if ( _w < _h )
			{
				_val = ( 100 * _containerHeight ) / _h;
			}
			return _val * .01;
		}
		
		private function addItem():void 
		{	
			addChild( boxMC );
			if ( starBtn != null ) 
			{
				addChild( starBtn );
				addChild( askBtn );
			}
		}
		
		public function removeItem():void {
			if ( qtyDisplayText != null ) {
				boxMC.removeChild( qtyDisplayText );
			}
			if ( titleText != null ) {
				boxMC.removeChild( titleText );
			}
			if ( boxMC != null ) {
				removeChild( boxMC );
			}
		}
		
		public function get container():MovieClip
		{
			return boxMC;
		}		
		
		private function _onBoxDataHolderBtnOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
		}
		
		private function _onBoxDataHolderBtnOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		private function _onBoxDataHolderStarBtnPress(e:MouseEvent):void
		{
			//trace('\nBoxDataHolder->_onBoxDataHolderStarBtnPress, called');
			ServerDataController.getInstance().buyMaterial( String( id ) );
		}
		
		private function _onBoxDataHolderAskBtnPress(e:MouseEvent):void
		{
			//trace('\nBoxDataHolder->_onBoxDataHolderAskBtnPress, called');
			//var _e:CraftingEvent = new CraftingEvent( CraftingEvent.RESET_ALL );
			//_es.dispatchESEvent( _e );
			try
			{
				ServerDataController.getInstance().askMaterial( String( id ) );
				//ServerDataController.getInstance().claimCollection( String( id ) );
			}
			catch ( e:Error )
			{
				trace( 'BoxDataHolder->_onBoxDataHolderAskBtnPress, error=' + e.message );
			}
		}
		
		private function imageLoaderEvent( e:IOErrorEvent ) : void
		{
			imgLoader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, imageLoaderEvent );
			trace( 'BoxDataHolder->imageLoaderEvent, image loading event error' );
		}
		
		
		
		
		
		
		
	}

}