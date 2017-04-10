package com.surnia.socialStar.ui.popUI.views.miniMap.worldMapMain.components 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author df
	 */
	public class DynamicButton extends MovieClip
	{		
		public static const MOUSE_OVER:String = "mouse over";
		public static const	MOUSE_OUT:String = "mouse out";
		
		private var _loadCtr:int = 0;
		private var _loadTotal:int = 2;	//BUTTON OVER/ BUTTON OUT
		
		private var _callBack:Function;		
		private var _buttonID:int;
		
		private var _buttonOverURL:String;
		private var _buttonOutURL:String;
		
		private var _loaderOver:Loader;
		private var _loaderOut:Loader;
		
		private var _overBmp:Bitmap;
		private var _outBmp:Bitmap;
		
		private var _overMC:MovieClip;
		private var _outMC:MovieClip;
		
		public function DynamicButton(callBack:Function = null, buttonOverURL:String = null, buttonOutURL:String = null, buttonID:int = 0) 
		{
			
			_callBack 		= callBack;
			_buttonOverURL	= buttonOverURL;
			_buttonOutURL	 = buttonOutURL;
			
			instantiation();
			loadURL();
		}
		
		private function instantiation():void 
		{
			_loaderOver = new Loader;
			_loaderOut = new Loader;
			
			_overMC = new MovieClip;
			_outMC	= new MovieClip;
		}
		
		private function loadURL():void 
		{
			_loaderOver.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedOverImage);
			_loaderOver.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherOver);
			_loaderOver.load(new URLRequest(_buttonOverURL));	
			
			_loaderOut.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedOutImage);
			_loaderOut.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcherOut);
			_loaderOut.load(new URLRequest(_buttonOutURL));	
		}		
		
		private function errorCatcherOut(e:Event):void 
		{
			trace(this, "ERROR RETURN LOADING BUTTON OVER ERROR!!!");		
			trace(this, "RETURN URL LINK:", _buttonOverURL);
			
		}
		
		private function errorCatcherOver(e:Event):void 
		{
			trace(this, "ERROR RETURN LOADING BUTTON OVER ERROR!!!");		
			trace(this, "RETURN URL LINK:", _buttonOutURL);
		}
		
		
		private function loadedOutImage(e:Event):void 
		{
			_outBmp	= e.target.content;	
			_outMC.addChild(_outBmp);
			
			checkTotalLoad();
		}
		
		private function loadedOverImage(e:Event):void 
		{
			_overBmp	= e.target.content;	
			_overMC.addChild(_overBmp);
			
			checkTotalLoad();
		}
		
		private function checkTotalLoad():void {
			_loadCtr++;			
			if (_loadCtr >= _loadTotal) {	
				trace(this, "RETURN LOAD BUTTON COMPLETE _loadCtr:", _loadCtr);
				switchImage(DynamicButton.MOUSE_OUT)
				addListener();
			}
		}
		
		private function switchImage(buttonMode:String):void {
			switch(buttonMode) {
				case DynamicButton.MOUSE_OVER: 
					if (_outMC != null) {
						if (this.contains(_outMC)) {
							removeChild(_outMC);
						}
					}
					
					if (_overMC != null) {
						addChild(_overMC);
					}
				break;
				case DynamicButton.MOUSE_OUT: 
					if (_overMC != null) {
						if (this.contains(_overMC)) {
							removeChild(_overMC);
						}
					}
					
					if (_outMC != null) {
						addChild(_outMC);
					}
				break;
				
			}
		}
		
		private function addListener():void {
			_overMC.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			_overMC.addEventListener(MouseEvent.CLICK, onClick);
			_outMC.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			_callBack(_buttonID);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			switchImage(DynamicButton.MOUSE_OVER);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			switchImage(DynamicButton.MOUSE_OUT);
		}
	}

}