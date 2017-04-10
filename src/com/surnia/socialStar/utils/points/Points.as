package com.surnia.socialStar.utils.points 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Points 
	{
		/*-----------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		
		/*-----------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		public function Points() 
		{
			
		}
		
		public static function getGlobalPoints( mc:MovieClip ):Point 
		{
			var point:Point = mc.localToGlobal( new Point( mc.x, mc.y ) );
			
			return point;
		}
		
	}

}