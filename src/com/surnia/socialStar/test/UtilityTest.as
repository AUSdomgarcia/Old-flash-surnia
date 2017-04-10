package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.utils.stringUtilManager.StringUtilManager;
	import flash.display.Sprite;
	import org.casalib.util.StringUtil;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class UtilityTest extends Sprite
	{
		
		public function UtilityTest() 
		{
			var str:String = "Book_happy Lv.99";		
			
			
			trace( StringUtilManager.getStringAndNumber( str ) ); 
			
			//var letter:String = StringUtil.getLettersFromString( str );
			//var number:String = StringUtil.getNumbersFromString( str );
			//var finalStr:String = letter.toLowerCase() + number.toLowerCase();
			//trace( finalStr );
			
			//var str2:String = str.toLowerCase();
			//var str3:Array = str2.split( " " );
			//var str4:String = str3.join( " " ) ;
			//trace( str4 );
		}
		
	}

}