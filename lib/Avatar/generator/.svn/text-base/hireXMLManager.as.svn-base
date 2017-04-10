package 
{
	import com.surnia.socialStar.data.XMLLinkData;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;

	public class hireXMLManager extends Sprite
	{
		private var loader:URLLoader;
		private var sprtloader:Loader;
		public var cdbase:Array;
		public var xmlData:XML;
		public static var CHAR_UPDATED:String = "charupdated";
		public static var CHAR_LOADED:String = "loadingcomplete";
		private var numOfCharToTake:Number;
		public var files:Array;
		public var sdbase:Array;
		public var isLoading:Boolean;
		private var loadingIndex:Number;

		public function hireXMLManager()
		{
			// constructor code
			loader=new URLLoader();
			cdbase=new Array();
			files=new Array();
			sdbase=new Array();
			addToQueue( XMLLinkData.mainLink + "public/swf/male01.swf");
			addToQueue( XMLLinkData.mainLink + "public/swf/female01.swf");
		}

		public function load(str:String,num:Number=8):void
		{
			loader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,loaderComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,loaderError);
			loader.load(new URLRequest(str));
			numOfCharToTake = num;
		}
		
		private function loaderError(e:IOErrorEvent):void{
			trace("error");
		}
		private function loaderComplete(e:Event):void
		{
			var arr:Array;
			var i:Number;
			xmlData = new XML(e.target.data);
			arr = parsCharAttributes(xmlData['char']);
			for (i=0; i<numOfCharToTake; i++)
			{
				if (i>=arr.length)
				{
					break;
				}
				cdbase[i] = arr[i];
			}
			dispatchEvent(new Event(CHAR_UPDATED));
		}
		private function parsCharAttributes(xml:XMLList):Array
		{
			//trace(xml.length())
			var i:Number;
			var arr:Array=new Array();
			var arr2:Array=new Array();
			for (i=0; i<xml.length(); i++)
			{
				arr=new Array();
				arr.push(xml[i].attribute('premium')==true);
				arr.push(xml[i]['gender']);
				arr.push(xml[i]['name']);
				arr.push(xml[i]['def']);
				arr.push(Number(xml[i]['health']));
				arr.push(Number(xml[i]['sing']));
				arr.push(Number(xml[i]['acting']));
				arr.push(Number(xml[i]['attraction']));
				arr.push(Number(xml[i]['intelligent']));
				arr.push(xml[i]['siggy']);
				arr.push(xml[i]['grade']);
				arr.push(Number(xml[i]['cost']));
				arr2.push(arr);
			}
			return arr2;
		}
		
		public function addToQueue(str:String):void
		{
			// Add new Queue
			files.push(new Array(str,false, new Loader()));
			// If a loading not in progress, initiate a load
			if (!isLoading){
				processQueue();
			}
		}

		private function processQueue():void
		{
			var i:Number;
			var bb:Boolean;
			// Check for files have not yet been loaded
			for (i=0; i<files.length; i++)
			{
				if (files[i][1] == false)
				{
					// found an unloaded file, set the flag and break. The i will have the index
					bb = true;
					break;
				}
			}
			if (bb)
			{
				// if an unloaded file is found, load it
				loadSprite(i);
			}
			else
			{
				dispatchEvent(new Event("loadingcomplete"));
			}
		}
		private function loadSprite(num:Number):void
		{
			// load a soune file
			isLoading=true;
			loadingIndex = num;
			sprtloader=new Loader();
			sprtloader.load(new URLRequest(files[loadingIndex][0]));
			sprtloader.contentLoaderInfo.addEventListener(Event.COMPLETE, sComplete);
			sprtloader.addEventListener( IOErrorEvent.IO_ERROR, onErrorLoadingSwf );
		}
		

		private function sComplete(e:Event):void
		{
			files[loadingIndex][1] = true;
			files[loadingIndex][2] = sprtloader;
			isLoading=false;
			processQueue();
		}
		
		private function onErrorLoadingSwf(e:IOErrorEvent):void 
		{
			trace( "HireXMlManager erro can't load male and female swf!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" );
		}


	}

}