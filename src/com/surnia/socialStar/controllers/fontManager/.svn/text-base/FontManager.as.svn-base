package com.surnia.socialStar.controllers.fontManager 
{
	 import com.greensock.loading.SWFLoader;
	 import flash.display.Loader;
	 import flash.display.Sprite;
	 import flash.events.Event;
	 import flash.net.URLRequest;
	 import flash.text.AntiAliasType;
	 import flash.text.engine.ElementFormat;
	 import flash.text.engine.FontDescription;
	 import flash.text.engine.TextBlock;
	 import flash.text.engine.TextElement;
	 import flash.text.engine.TextLine;
	 import flash.text.Font;
	 import flash.text.FontStyle;
	 import flash.text.TextField;
	 import flash.text.TextFieldAutoSize;
	 import flash.text.TextFormat;
	 import ru.etcs.utils.FontLoader;
	 
	
	
	
	 
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FontManager extends Sprite
	{
		/*-----------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		private static var _instance:FontManager;
		private var _fontLoader:SWFLoader;
		
		private var _loader:FontLoader = new FontLoader();
		private var _txtFormatSet:Array = new Array();
		/*-----------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		
		public function FontManager( enforcer:SingletonEnforcer ) 
		{			
		}
		
		public static function getInstance():FontManager 
		{
			if ( FontManager._instance == null ) {
				FontManager._instance = new FontManager( new SingletonEnforcer() );
			}
			
			return FontManager._instance;
		}
		
		/*-----------------------------------------------------------------------------Methods-------------------------------------------------------------*/
		
		//private function loadFonts():void 
		//{
			//_fontLoader = new SWFLoader("http://202.124.129.14/socialstars/public/swf/font.swf", {onComplete:completeHandler});
			//_fontLoader.load();	
		//}
		//
		//private function completeHandler(e:LoaderEvent):void {
			//var fontClass:Class = _fontLoader.getClass("TestFont");
			//var Arial:Class = fontClass.TestFont2;
			//Font.registerFont(Arial );
			//trace("loaded successfully");
		//}
		
		 public function loadAllFonts():void {
			 //loadFonts();
			 
			//http://202.124.129.14/socialstars/public/swf/main.swf
			//loadArial("http://202.124.129.14/socialstars/public/swf/arial.swf");
			//loadArial("http://202.124.129.14/arial.swf");
			loadArial("../bin/arial.swf");
			//loadErasbd("http://202.124.129.14/socialstars/public/swf/_erasbd.swf");
			trace( "[FontManager]: before loading prestige===================================================>>>" );
			var realFontName:String=new String();
			var fontArray:Array = Font.enumerateFonts(true);
			trace( "[FontManager]: before loading prestige===================================================>>> fontArray len", fontArray.length );
			for (var item in fontArray) {
				//if (fontArray[item].fontName==fontName) {
					realFontName = fontArray[item].fontName;
					trace( "[FontManager]: ", realFontName );
					//break;
				//}
			}
			
			trace( "[FontManager]: before loading prestige===================================================>>>" );
			
			//loadTunga( "http://202.124.129.14/socialstars/public/swf/_tunga.swf" );
			//loadSimkoto( "http://202.124.129.14/socialstars/public/swf/simkoto.swf" );
            //loadArial("arial.swf");
			//loadErasbd("_erasbd.swf");			
          }

          private function loadErasbd(url:String):void {
               var loader:Loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE, erasbdLoaded);
               loader.load(new URLRequest(url));
          }	  
		  
		  private function loadArial( url:String ):void {
               var loader:Loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE, arialLoaded );
               loader.load(new URLRequest(url));
          }		  
		  
          public function drawText():void {
               var tf:TextField = new TextField();
               //tf.defaultTextFormat = new TextFormat("Arial", 16, 0);
			   //tf.defaultTextFormat = getTxtFormat( "Eras Light ITC", 25, 0 );
			   //tf.defaultTextFormat = getTxtFormat( "Arial", 25, 0 );
			   //tf.defaultTextFormat = new TextFormat("Eras Light ITC", 16, 0);
			   //tf.defaultTextFormat = new TextFormat("Eras Demi ITC", 25, 0);
			   tf.defaultTextFormat = getTxtFormat( "Eras Demi ITC", 25, 0 );
			   
               tf.embedFonts = true;
               tf.antiAliasType = AntiAliasType.ADVANCED;
               tf.autoSize = TextFieldAutoSize.LEFT;
               tf.border = true;
               //tf.text = "Scott was here\nScott was here too\nblah scott...:;*&^% 12345678940 !#@$#@%#$^&*% ";
               //tf.rotation = 15;
			   tf.text = "aaA12354";

               addChild(tf);
			   tf.x = 150;
			   tf.y = 200;
          }
		
		  
		  public function loadSwfFont():void 
		  {
			this._loader.addEventListener(Event.COMPLETE, this.handler_complete);
			//this._loader.load(new URLRequest('../bin/sample.swf')); // textLayout.swc is embedded
			//this._loader.load(new URLRequest('../bin/fonts.swf')); // textLayout.swc is embedded
			this._loader.load(new URLRequest( "http://202.124.129.14/socialstars/public/swf/fonts.swf" )); // textLayout.swc is embedded			
			//this._loader.load(new URLRequest( "http://202.124.129.14/socialstars/public/swf/sample.swf" )); // textLayout.swc is embedded			
//			this._loader.load(new URLRequest('fonts_fte_rsl.swf')); // Flash CS5 FTE's RSL preloader also supported 
		  }
		 
		  public function getTxtFormat( fontName:String , fontSize:int = 8, fontColor:* = 0 ):TextFormat 
		  {
			var len:int = _txtFormatSet.length;
			var txtFormat:TextFormat = _txtFormatSet[ i ].font;			
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _txtFormatSet[ i ].name == fontName ) {
					txtFormat = _txtFormatSet[ i ].font;
					break;
				}
			}
			
			txtFormat.size = fontSize;
			txtFormat.color = fontColor;			
			
			return txtFormat;
			
		  }
		  
		/*-----------------------------------------------------------------------------Setters-------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------Getters-------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------EventHandlers-------------------------------------------------------*/
		private function fontLoaded(event:Event):void{
			var FontLibrary:Class = event.target.applicationDomain.getDefinition("_Erasbd") as Class;
            Font.registerFont(FontLibrary._Erasbd);
			//drawText();
		}
		
		private function erasbdLoaded(e:Event):void 
		{
			trace( "[Font Manager]: erasbd font loaded", e.target );
			var FontLibrary:Class = e.target.applicationDomain.getDefinition("_Erasbd") as Class;
			var era:Class = FontLibrary._Erasbd;
			Font.registerFont(era);
			
			//var fl:Object = ObjectUtil.clone(FontLibrary);
			//for (var i:Object in fl)
			//Font.registerFont(FontLibrary[i]);
			
			//Font.registerFont(FontLibrary._Erasbd);
			/*
			trace( "[FontManager]: see ===> ",FontLibrary._Erasbd2 );			
            Font.registerFont(FontLibrary._Erasbd2 );
			//trace( Font.enumerateFonts() );
			*/
			
			/*
			var realFontName:String=new String();
			var fontArray:Array=Font.enumerateFonts(true);
			for (var item in fontArray) {
				//if (fontArray[item].fontName==fontName) {
					realFontName = fontArray[item].fontName;
					trace( "[FontManager]: ", realFontName );
					//break;
				//}
			}
			*/
		}	
		
		
		private function arialLoaded(e:Event):void 
		{
			trace( "[Font Manager]: arial font loaded", e.target );
			var FontLibrary:Class = e.target as Class;
			//var FontLibrary:Class = e.target.applicationDomain.getDefinition("_Arial") as Class;
			Font.registerFont(FontLibrary._Arial );			 
			
			
			//for each (var font:Font in FontLibrary ) {
				//trace( "[ Font Manager ]: font =====>>>", font );
				//Font.registerFont((font as Object).constructor);
			//}
			
			//Font.registerFont(FontLibrary._Arial);
			//var font:* = new FontLibrary().MyFont;			
			//Font.registerFont( new FontLibrary().MyFont);
		}
		
		private function handler_complete(event:Event):void {
			var fonts:Array = this._loader.fonts;
			var y:Number = 50;
			var fd:FontDescription;
			var ef:ElementFormat;
			var te:TextElement;
			var tb:TextBlock;
			var tl:TextLine;
			
			for each (var font:Font in fonts) {
				
				var text:String = font.fontName;
				trace( "font Manager == check font name: ", font.fontName );
				var tf:TextFormat = new TextFormat(font.fontName, 20);
				
				switch (font.fontStyle) {
					case FontStyle.BOLD:
						tf.bold = true;
						break;
					case FontStyle.BOLD_ITALIC:
						tf.bold = true;
						tf.italic = true;
						break;
					case FontStyle.ITALIC:
						tf.italic = true;
						break;
				}
				
				var obj:Object = new Object();
				obj.name = font.fontName;
				obj.font = tf;
				_txtFormatSet.push( obj );				
				/*
				if (font.fontType == FontType.EMBEDDED_CFF) {
					fd = new FontDescription(font.fontName, tf.bold ? FontWeight.BOLD : FontWeight.NORMAL, tf.italic ? FontPosture.ITALIC : FontPosture.NORMAL, FontLookup.EMBEDDED_CFF);
					ef = new ElementFormat(fd, 20);
					te = new TextElement(text + ' [CFF]', ef);
					tb = new TextBlock(te);
					tl = tb.createTextLine(null, 300);
					tl.x = 300;
					tl.y = y;
					super.addChild(tl);
					y += 40;
				} else {
					this._field.appendText(text+'\n');
					this._field.setTextFormat(tf, this._field.length-text.length-1, this._field.length);
				}*/
			}
			
			drawText();
		}
	}

}


class SingletonEnforcer{}