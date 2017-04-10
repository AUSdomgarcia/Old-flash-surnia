package 
{

	public class SpriteDNAManager
	{
		public var mdbase:Array=new Array();

		public function SpriteDNAManager()
		{
			// constructor code
			initDNAMap();
		}
		public function applyItem(char:String,item:String,...parameters):String
		{
			var i:Number;
			var str:String;
			var str1:String;
			var str2:String;
			var i1:Number;
			var i2:Number;
			str="";
//			trace("1:"+char);
//			trace("2:"+item);
			//combine the bodyparts
			for (i=0; i<80; i++)
			{
				str1=char.substr(i*2,2);
				str2=item.substr(i*2,2);
				if (str2=="00")
				{
					str +=  str1;
				}
				else if (str2=="-1")
				{
					str +=  "00";
				}
				else
				{
					str +=  str2;
				}
			}
			//combine the colors
			
			for (i=0; i<22; i++)
			{
				str1=char.substr(i*6+160,6);
				str2=item.substr(i*6+160,6);
				if (str2=="000000")
				{
					str +=  str1;
				}
				else
				{
					str +=  str2;
				}
			}
			
			return (str);
		}
		private function initDNAMap():void
		{
			mdbase=new Array();
			mdbase.push(["hair",000,2]);
			mdbase.push(["hat",002,2]);
			mdbase.push(["eye",004,2]);
			mdbase.push(["nose",006,2]);
			mdbase.push(["mouth",008,2]);
			mdbase.push(["jawline",010,2]);
			mdbase.push(["color",012,2]);
			mdbase.push(["glasses",014,2]);
			mdbase.push(["accessory",016,2]);
			//mdbase.push(["null",018,2]);
			//mdbase.push(["null",020,2]);
			//mdbase.push(["null",022,2]);
			//mdbase.push(["null",024,2]);
			//mdbase.push(["null",026,2]);
			//mdbase.push(["null",028,2]);
			//mdbase.push(["null",030,2]);
			//mdbase.push(["null",032,2]);
			//mdbase.push(["null",034,2]);
			//mdbase.push(["null",036,2]);
			//mdbase.push(["null",038,2]);
			mdbase.push(["accessory",040,2]);
			mdbase.push(["handitem",042,2]);
			mdbase.push(["torsolayer",044,2]);
			mdbase.push(["topofshoeforward",046,2]);
			mdbase.push(["topofshoeback",048,2]);
			mdbase.push(["handinfront",050,2]);
			mdbase.push(["shoulderforward",052,2]);
			mdbase.push(["shoulderback",054,2]);
			mdbase.push(["armforward",056,2]);
			mdbase.push(["armback",058,2]);
			mdbase.push(["handforward",060,2]);
			mdbase.push(["handback",062,2]);
			mdbase.push(["hairbehindhead",064,2]);
			//mdbase.push(["null",066,2]);
			//mdbase.push(["null",068,2]);
			//mdbase.push(["null",070,2]);
			//mdbase.push(["null",072,2]);
			//mdbase.push(["null",074,2]);
			//mdbase.push(["null",076,2]);
			//mdbase.push(["null",078,2]);
			mdbase.push(["hipforward",080,2]);
			mdbase.push(["hipback",082,2]);
			mdbase.push(["legforward",084,2]);
			mdbase.push(["legback",086,2]);
			mdbase.push(["shoeforward",088,2]);
			mdbase.push(["shoeback",090,2]);
			mdbase.push(["skirtlayer1",092,2]);
			mdbase.push(["skirtlayer2",094,2]);
			//mdbase.push(["null",096,2]);
			//mdbase.push(["null",098,2]);
			//mdbase.push(["null",100,2]);
			//mdbase.push(["null",102,2]);
			//mdbase.push(["null",104,2]);
			//mdbase.push(["null",106,2]);
			//mdbase.push(["null",108,2]);
			//mdbase.push(["null",110,2]);
			//mdbase.push(["null",112,2]);
			//mdbase.push(["null",114,2]);
			//mdbase.push(["null",116,2]);
			//mdbase.push(["null",118,2]);
			mdbase.push(["cashitemlayer",120,2]);
			//mdbase.push(["null",122,2]);
			//mdbase.push(["null",124,2]);
			//mdbase.push(["null",126,2]);
			//mdbase.push(["null",128,2]);
			//mdbase.push(["null",130,2]);
			//mdbase.push(["null",132,2]);
			//mdbase.push(["null",134,2]);
			//mdbase.push(["null",136,2]);
			//mdbase.push(["null",138,2]);
			//mdbase.push(["null",140,2]);
			//mdbase.push(["null",142,2]);
			//mdbase.push(["null",144,2]);
			//mdbase.push(["null",146,2]);
			//mdbase.push(["null",148,2]);
			//mdbase.push(["null",150,2]);
			//mdbase.push(["null",152,2]);
			//mdbase.push(["null",154,2]);
			//mdbase.push(["null",156,2]);
			//mdbase.push(["null",158,2]);
			mdbase.push(["colhair",160,6]);
			mdbase.push(["colhairborder",166,6]);
			mdbase.push(["coleye",172,6]);
			mdbase.push(["coleyeborder",178,6]);
			mdbase.push(["colskin",184,6]);
			mdbase.push(["colskinborder",190,6]);
			mdbase.push(["coltop",196,6]);
			mdbase.push(["coltopborder",202,6]);
			mdbase.push(["colbottom",208,6]);
			mdbase.push(["colbottomborder",214,6]);
			mdbase.push(["colnose",220,6]);
			mdbase.push(["colnoseborder",226,6]);
			mdbase.push(["colmouth",232,6]);
			mdbase.push(["colmouthborder",238,6]);
			mdbase.push(["colshoes",244,6]);
			mdbase.push(["colshoesborder",250,6]);
			mdbase.push(["colhat",256,6]);
			mdbase.push(["colhatborder",262,6]);
			mdbase.push(["colheadaccessory",268,6]);
			mdbase.push(["colheadaccessoryborder",274,6]);
			mdbase.push(["colhandaccessory",280,6]);
			mdbase.push(["colhandaccessoryborder",286,6]);
		}

	}

}