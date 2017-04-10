package 
{
	public class geometryFunctions
	{
		var rad:Number = 180 / Math.PI;
		var deg:Number = Math.PI / 180;


		public function geometryFunctions()
		{
			// constructor code
		}

		public function getAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var LWidth:Number = x2 - x1;
			var LHeight:Number = y1 - y2;
			var Angle:Number = 0;
			if (LWidth > 0)
			{
				Angle = Math.PI / 2;
			}
			if (LWidth < 0)
			{
				Angle = Math.PI / 2 * 3;
			}
			if (LHeight > 0)
			{
				Angle = Math.atan(LWidth / LHeight);
			}
			if (LHeight < 0)
			{
				Angle = Math.atan(LWidth / LHeight) + Math.PI;
			}
			return Angle;
		}
		public function rad2Deg(Num:Number):Number
		{
			if (Num < 0)
			{
				Num = Num + Math.PI * 2;
			}
			return Num*rad;
		}
		public function deg2Rad(Num:Number):Number
		{
			var Numb:Number = Num * deg;
			if (Numb > Math.PI)
			{
				Num = Num - Math.PI * 2;
				return Num;
			}
			else
			{
				return Numb;
			}
		}
		public function getHypo(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return (Math.sqrt((x2-x1)*(x2-x1)+(y1-y2)*(y1-y2)));
		}
		public function constrain(Num:Number):Number
		{
			if (Num > Math.PI)
			{
				while (Num>Math.PI )
				{
					Num = Num-(2*Math.PI);
				}
			}
			if (Num <  -  Math.PI)
			{
				while (Num<-Math.PI)
				{
					Num = Num+(2*Math.PI);
				}
			}
			return (Num);
		}

	}

}