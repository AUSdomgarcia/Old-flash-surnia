package 
{		
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import com.surnia.socialStar.controllers.imageLoader.ImageLoader;
	import com.surnia.socialStar.controllers.swfLoader.SwfLoader;
	import com.surnia.socialStar.test.AddingCharTest;
	import com.surnia.socialStar.test.HireCharWindowTest;
	import com.surnia.socialStar.test.ImageExtractorTest;
	import com.surnia.socialStar.test.ImageLoaderTest;
	import com.surnia.socialStar.test.JsManagerTest;
	import com.surnia.socialStar.test.LoaderMaxTest;
	import com.surnia.socialStar.test.MainUITest;	
	import com.surnia.socialStar.test.QuestIconTest;
	import com.surnia.socialStar.test.ServerDataControllerTest;
	import com.surnia.socialStar.test.SimpleServer;
	import com.surnia.socialStar.test.StreamSocketTest;
	import com.surnia.socialStar.test.TestDataManager;
	import com.surnia.socialStar.test.TestLoadSwf;
	import com.surnia.socialStar.test.TutorialSample;
	import com.surnia.socialStar.test.UtilityTest;
	import com.surnia.socialStar.test.XmlExtractorTest;
	import com.surnia.socialStar.utils.dataManager.DataManager;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author monsterpatties
	 */
	
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			//var mainUITest:MainUITest = new MainUITest();
			//addChild(  mainUITest );
			
			//addChild( new SwfLoader() );
			addChild( new FrameRateViewer() );
			addChild( new MemoryProfiler() );
			//addChild( new XmlExtractorTest() );
			//addChild( new ServerDataControllerTest() );
			//addChild( new JsManagerTest() );
			
			///addChild( new TestDataManager() );
			//addChild( new AddingCharTest() );
			//addChild( new ImageExtractor() );
			//addChild( new StreamSocketTest() );
			//addChild( new ImageExtractorTest() );
			//addChild( new SimpleServer() );
			//addChild( new HireCharWindowTest() );
			
			//addChild( new TutorialSample() );
			//addChild( new QuestIconTest() );
			//addChild( new ImageLoaderTest() );
			//addChild( new UtilityTest() );
			addChild( new LoaderMaxTest() );
		}
	}

}