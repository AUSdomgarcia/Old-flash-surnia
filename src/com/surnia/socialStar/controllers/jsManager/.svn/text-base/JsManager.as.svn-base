package com.surnia.socialStar.controllers.jsManager 
{
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author JC
	 */
	public class JsManager 
	{
		
		/*--------------------------------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Properties--------------------------------------------------------*/
		private static var _instance:JsManager;
		/*--------------------------------------------------------------------------------Constructor-------------------------------------------------------*/
		
		
		public function JsManager( enforcer:SingeltonEnforcer ) 
		{
			
		}
		
		
		public static function getInstance():JsManager 
		{
			if ( JsManager._instance == null ) {
				JsManager._instance =  new JsManager( new SingeltonEnforcer() );
			}
			
			return JsManager._instance;
		}
		/*--------------------------------------------------------------------------------Methods----------------------------------------------------------*/
		
		
		/**
		 * 
		 * @param	script - the actual javascript 
		 */
		public function runJS(script:String):void {	
			var url:URLRequest = new URLRequest("javascript:" + script + " void(0);");
			navigateToURL(url, "_self");
		}
		
		/**
		 * 
		 * @param	jsMethod - method that will be called from javascript
		 * @param	params - a value that will  be passed ( optional ) 
		 */
		
		//use this if you want call back from js		
		public function callJs( jsMethod:String, params:String = "" ):void {
			ExternalInterface.addCallback( jsMethod + "callback",  callFromJavaScript );
			ExternalInterface.call(jsMethod, params);
			trace( "call js............" );			
		}
		
		public function addCallBackJS( jsMethod:String, params:String = "" ):void 
		{
			ExternalInterface.addCallback( jsMethod,  callFromJavaScript );
		}
		
		
		public function callFromJavaScript( success:String ):void 
		{
			trace( "my call back ako..................................................",success );
		}
		//public function callJs():void {				
			//ExternalInterface.call("jsFunction", "hello world");
			//trace( "call js............" );
		//}
		
		//use this if you dont want call back from js
		public function execJs( jsMethod:String, params:String = "" ):void 
		{
			ExternalInterface.call(jsMethod, params);
			trace( "exec js............" );	
		}
		/*--------------------------------------------------------------------------------Setters----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Getters----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------EventHandlers-----------------------------------------------------*/
		
	}
}

class SingeltonEnforcer {}