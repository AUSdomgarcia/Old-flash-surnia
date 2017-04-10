package 
{
	import com.surnia.socialStar.data.XMLLinkData;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.xml.XMLNode;

	public class ShopXMLManager extends Sprite
	{

		public static var CHAR_INFO_DOWNLOADED:String = new String("charinfodownloaded");
		public static var CHAR_INFO_UPLOADED:String = new String("charinfouploaded");
		public static var INVENTORY_LIST_DOWNLOADED:String = new String("inventorylistdownloaded");
		public static var ITEM_LIST_DOWNLOADED:String = new String("itemlistdownloaded");
		public static var BUY_ITEM_UPLOADED;
		private var charLoader:URLLoader;
		private var itemLoader:URLLoader;
		public var ibdbase:Array;
		public var indbase:Array;
		public var cdbase:Array;
		public var userCoin:Number;
		public var userName:String;
		public var userCash:Number;
		public var userTicket:Number;
		public var debugxml:XML;
		public var gender:Number;

		private var url:String;
		private var id:String;

		public function ShopXMLManager(serverURL:String, userID:String,gend:Number)
		{
			url = serverURL;
			id = userID;
			charLoader=new URLLoader();
			itemLoader=new URLLoader();
			ibdbase=new Array();
			indbase=new Array();
			cdbase=new Array();
			gender = gend;
		}
		public function shopRequestItemUpdate(str:String=""):void
		{
			if (str == "")
			{
				itemLoader.load(new URLRequest( XMLLinkData.mainLink + "public/data/charactershop.xml"));
				itemLoader.addEventListener(Event.COMPLETE,itemRequestComplete);
			}
			else
			{
				itemLoader.load(new URLRequest(str));
				itemLoader.addEventListener(Event.COMPLETE,itemRequestComplete);
			}
		}
		private function itemRequestComplete(e:Event):void
		{
			var xmlData:XML = new XML(e.target.data);
			parseItemXML(xmlData);
		}
		private function parseItemXML(xml:XML):void
		{
			debugxml = xml;
			var i:Number;
			var arr:Array;
			ibdbase=new Array();

			arr=new Array();
			arr = arr.concat(parsItemAttributes(xml['cloth']['top']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['handitem']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['shirt']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['hat']['item']));
			ibdbase.push(arr);

			arr=new Array();
			arr = arr.concat(parsItemAttributes(xml['cloth']['pants']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['bottom']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['dress']['item']));
			arr = arr.concat(parsItemAttributes(xml['cloth']['shoes']['item']));
			ibdbase.push(arr);

			arr=new Array();
			arr = arr.concat(parsItemAttributes(xml['cloth']['set']['item']));
			ibdbase.push(arr);

			arr=new Array();
			arr = arr.concat(parsItemAttributes(xml['cloth']['accessory']['item']));
			arr = arr.concat(parsItemAttributes(xml['body']['hair']['item']));
			ibdbase.push(arr);

			arr=new Array();
			arr = arr.concat(parsItemAttributes(xml['body']['jawline']['item']));
			arr = arr.concat(parsItemAttributes(xml['body']['expression']['item']));
			arr = arr.concat(parsItemAttributes(xml['body']['color']['item']));
			ibdbase.push(arr);

			dispatchEvent(new Event(ITEM_LIST_DOWNLOADED));
		}
		private function parsItemAttributes(xml:XMLList):Array
		{
			var arr:Array=new Array();
			var arr2:Array=new Array();
			var i:Number;
			var str:String;
			for (i=0; i<xml.length(); i++)
			{
				if (Number(xml[i].attribute("gender"))==gender || Number(xml[i].attribute("gender"))==2)
				{
					arr=new Array();
					arr.push(xml[i].attribute("id"));
					arr.push(xml[i].attribute("name"));
					arr.push(Number(xml[i].attribute("coincost")));
					arr.push(Number(xml[i].attribute("starcost")));
					arr.push(Number(xml[i].attribute("sellprice")));
					arr.push(xml[i].attribute("img"));
					arr.push(Number(xml[i].attribute("expire")));
					arr.push(Number(xml[i].attribute("fn")));
					arr.push(xml[i].attribute("descrip"));
					arr.push(Number(xml[i].attribute("hot")));
					arr.push(Number(xml[i].attribute("new")));
					arr.push(xml[i].attribute("eff"));
					str = xml[i].attribute("def");
					if (str=="0")
					{
						arr.push("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
					}
					else
					{
						arr.push(str);
					}
					arr2.push(arr);
				}

			}
			return arr2;
		}




		public function shopRequestUserUpdate(str:String=""):void
		{
			if (str =="")
			{
				charLoader.load(new URLRequest( XMLLinkData.mainLink + "characters/inventory"));
				charLoader.addEventListener(Event.COMPLETE,charRequestComplete);
			}
			else
			{
				charLoader.load(new URLRequest(str));
				charLoader.addEventListener(Event.COMPLETE,charRequestComplete);
			}
		}
		private function charRequestComplete(e:Event):void
		{
			var xmlData:XML = new XML(e.target.data);
			parseInventoryXML(xmlData);
		}
		private function parseInventoryXML(xml:XML):void
		{
			debugxml = xml;
			var i:Number;
			var arr:Array=new Array();
			indbase=new Array();

			arr = arr.concat(parseInventoryAttributes(xml['cloth']['top']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['handitem']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['shirt']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['hat']['item']));

			arr = arr.concat(parseInventoryAttributes(xml['cloth']['pants']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['bottom']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['dress']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['cloth']['shoes']['item']));

			arr = arr.concat(parseInventoryAttributes(xml['cloth']['set']['item']));

			arr = arr.concat(parseInventoryAttributes(xml['cloth']['accessory']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['body']['hair']['item']));

			arr = arr.concat(parseInventoryAttributes(xml['body']['jawline']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['body']['expression']['item']));
			arr = arr.concat(parseInventoryAttributes(xml['body']['color']['item']));

			indbase = arr;

			dispatchEvent(new Event(INVENTORY_LIST_DOWNLOADED));
		}
		private function parseInventoryAttributes(xml:XMLList):Array
		{
			var arr:Array=new Array();
			var arr2:Array=new Array();
			var i:Number;
			var str:String;
			for (i=0; i<xml.length(); i++)
			{
				arr=new Array();
				arr.push(xml[i].attribute("id"));
				arr.push(xml[i].attribute("name"));
				arr.push(Number(xml[i].attribute("coincost")));
				arr.push(Number(xml[i].attribute("starcost")));
				arr.push(Number(xml[i].attribute("sellprice")));
				arr.push(xml[i].attribute("img"));
				arr.push(Number(xml[i].attribute("expire")));
				arr.push(Number(xml[i].attribute("fn")));
				arr.push(xml[i].attribute("descrip"));
				arr.push(Number(xml[i].attribute("hot")));
				arr.push(Number(xml[i].attribute("new")));
				arr.push(xml[i].attribute("eff"));
				str = xml[i].attribute("def");
				if (str=="0")
				{
					arr.push("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
				}
				else
				{
					arr.push(str);
				}
				arr.push(xml[i].attribute("entry"));
				arr2.push(arr);
			}
			return arr2;
		}
		function isFlesh(str:String):Boolean
		{
			var bb:Boolean = false;
			if (parseInt(str.substr(0,2),16)>0)
			{
				bb = true;
			}
			if (parseInt(str.substr(4,2),16)>0)
			{
				bb = true;
			}
			if (parseInt(str.substr(6,2),16)>0)
			{
				bb = true;
			}
			if (parseInt(str.substr(8,2),16)>0)
			{
				bb = true;
			}
			if (parseInt(str.substr(10,2),16)>0)
			{
				bb = true;
			}
			if (parseInt(str.substr(184,6),16)>0)
			{
				bb = true;
			}
			return bb;
		}
	}

}