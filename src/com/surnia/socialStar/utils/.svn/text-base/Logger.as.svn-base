package com.surnia.socialStar.utils
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	public class Logger
	{
		public static function tracer (classObj:Object, message:String):void{
			trace (String (classObj) + " : " + message);
			var msg:String = String (classObj) + " : " + message;
			
			var runningOn:String = Capabilities.playerType;			
			if( runningOn != 'StandAlone' ){				
				ExternalInterface.call( "console.log", msg );				
				trace( "[ tracer ]online mode..." );
			}else {
				trace( "[ tracer ]offline mode..." );
			}
		}
	}
}