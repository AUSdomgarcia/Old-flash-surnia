package com.surnia.socialStar.minigames.popupUI.manager 
{
	import com.surnia.socialStar.minigames.popupUI.model.VersusWindowModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	/**
	 * 
	 * ...
	 * @author domz
	 */
	public class VersusWindowManager 
	{
		private var model:VersusWindowModel;
		private var target:Sprite;
		private var globalX:Number = 0;
		private var globalY:Number = 0;
	
		private var mcLeft:Sprite;
		private var mcRight:Sprite;
		
		private var layer0:Sprite;
		private var layer1:Sprite;
		
		public function VersusWindowManager( m:VersusWindowModel, _x:Number, _y:Number, sp:Sprite ) 
		{
			globalX = _x;
			globalY = _y;
			
			target = sp;
			model = m;
			init();
		}
		private function init():void {
		
		}
		
		public function setStr( str:String, index:Number ):void {
			model.arrText[index].push( str );
		}
		
		public function setWindow( str:String, index:Number ):void {
			//instantiate window as a whole
			model.window = new VersusWindow();
			model.window.x = globalX;
			model.window.y = globalY;
			
			layer0 = new Sprite();
			layer1 = new Sprite();
			
			
			model.newformat.color = 0x008080;
			model.newformat.size = 12;
			model.newformat.align="left";				
			model.newformat.font = "Arial Bold";
			model.window.TEXT.defaultTextFormat = model.newformat;
					
			switch( str ) {
				case model.WINNER:
					model.window.WINDOW.gotoAndStop(1);
					
					model.window.LEFTSTATUS.gotoAndStop(1);
					model.window.RIGHTSTATUS.gotoAndStop(2);
				
					//Set text
					model.window.TEXT.text = String ( model.arrText[1][index] );
					
					//set Position
					model.window.LEFTSTATUS.x = model.window.WINDOW.x + 95;
					model.window.LEFTSTATUS.y = model.window.WINDOW.y + 85 + model.window.FBPictureLEFT.height;
					
					model.window.RIGHTSTATUS.x = model.window.WINDOW.x + 205;
					model.window.RIGHTSTATUS.y = model.window.FBPictureLEFT.y - 28;
					
					layer1.addChild( model.window.LEFTSTATUS );
					layer1.addChild( model.window.RIGHTSTATUS );
					
				break;
				case model.LOSE:
					model.window.WINDOW.gotoAndStop(2);
					
					model.window.LEFTSTATUS.gotoAndStop(2);
					model.window.RIGHTSTATUS.gotoAndStop(1);
					
					//Set text
					model.window.TEXT.text = String ( model.arrText[0][index] );
					
					model.window.LEFTSTATUS.y = 36;
					model.window.RIGHTSTATUS.y = 109;
					
					//Regroup Position
					model.window.TEXT.y = model.window.WINDOW.y + 270;
					model.window.SHAREBTN.y = model.window.WINDOW.y + 320;
					

					layer1.addChild( model.window.LEFTSTATUS );
					layer1.addChild( model.window.RIGHTSTATUS );
					
					//set Position
					model.window.FBPictureLEFT.y = model.window.WINDOW.y + 63;
					model.window.FBPictureRIGHT.y = model.window.WINDOW.y + 63;	
					model.window.FBPictureLEFT.x = model.window.WINDOW.x + 105;
					model.window.FBPictureRIGHT.x = model.window.WINDOW.x + 221;
					
				break;
				
			}
			addListener();
		}
		private function addListener():void {
			model.window.CLOSEBTN.addEventListener(MouseEvent.ROLL_OVER, onOver);
			model.window.SHAREBTN.addEventListener(MouseEvent.ROLL_OVER, onOver);
			
			model.window.CLOSEBTN.addEventListener(MouseEvent.ROLL_OUT, onOut);
			model.window.SHAREBTN.addEventListener(MouseEvent.ROLL_OUT, onOut);
			
			model.window.CLOSEBTN.addEventListener(MouseEvent.CLICK, onClick );
			model.window.SHAREBTN.addEventListener(MouseEvent.CLICK, onClick );
		}
		
		private function onOver( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.window.CLOSEBTN:
					model.window.CLOSEBTN.gotoAndStop(2);
				break;
				case model.window.SHAREBTN:
					model.window.SHAREBTN.gotoAndStop(2);
				break;
				
				
			}
		}
		
		private function onClick( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.window.CLOSEBTN:
					removeListener();
					removeItem();
					target.dispatchEvent( new Event ( model.CLOSE ));
				break;
				case model.window.SHAREBTN:
					removeListener();
					removeItem();
					target.dispatchEvent( new Event ( model.SHARE) );
				break;
				
			}
		}
		
		private function onOut( e:MouseEvent ):void {
			switch( e.currentTarget ) {
				case model.window.CLOSEBTN:
					model.window.CLOSEBTN.gotoAndStop(1);
				break;
				case model.window.SHAREBTN:
					model.window.SHAREBTN.gotoAndStop(1);
				break;
			}
		}
		
		public function setLeftPic( mc:Sprite ):void {
			mcLeft = mc;
			mcLeft.y = model.window.FBPictureLEFT.y;
			mcLeft.x = model.window.FBPictureLEFT.x;
			layer0.addChild( mcLeft );
		}
		
		public function setRightPic( mc:Sprite  ):void {
			mcRight = mc;
			mcRight.y = model.window.FBPictureRIGHT.y;
			mcRight.x = model.window.FBPictureRIGHT.x;
			layer0.addChild( mcRight );
		}
		
		public function addItem():void {
			target.addChild( model.window );
			layer0.x = model.window.x;
			layer0.y = model.window.y;
			
			layer1.x = model.window.x;
			layer1.y = model.window.y;
			
			target.addChild( layer0 );
			target.addChild( layer1 );
		}
		
		public function removeItem():void {
			removeListener();
			model.window.TEXT.text = "";
			target.removeChild( model.window );
			target.removeChild( layer0 );
			target.removeChild( layer1 );
			mcLeft = null;
			mcRight = null;
			model.window = null;
			layer0 = null;
			layer1 = null;
		}

		public function removeListener():void {
			
			model.window.CLOSEBTN.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			model.window.SHAREBTN.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			model.window.CLOSEBTN.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			model.window.SHAREBTN.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			
			model.window.CLOSEBTN.removeEventListener(MouseEvent.CLICK, onClick );
			model.window.SHAREBTN.removeEventListener(MouseEvent.CLICK, onClick );
		}
		
//end
	}
}