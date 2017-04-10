package com.surnia.socialStar.tutorial.components 
{
	import com.fluidLayout.FluidObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TutNpcGuide extends Sprite
	{		
		/*-------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private var _mc:TutGuideMC;
		private var _type:String;
		private var _script:String;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _offsetX:int;
		private var _offsetY:int;
		/*-------------------------------------------------------------Constructor------------------------------------------------------------------------*/	
		public function TutNpcGuide( type:String, script:String, xPos:Number, yPos:Number, offsetX:int, offsetY:int ) 
		{
			_type = type;
			_script = script;
			_xPos = xPos;
			_yPos = yPos;
			_offsetX = offsetX;
			_offsetY = offsetY;
			
			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}		
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new TutGuideMC();
			addChild( _mc );
			//_mc.txtScript.defaultTextFormat = new TextFormat("_Erasbd2", 16, 0);			
            //_mc.txtScript.embedFonts = true;
            //_mc.txtScript.antiAliasType = AntiAliasType.ADVANCED;
			
			updateDisplay( _script,_xPos,_yPos,_offsetX,_offsetY );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		public function updateDisplay( script:String, xPos:Number, yPos:Number, offsetX:int, offsetY:int ):void 
		{
			trace( "[TutNpcGuide]: length script", script.length, "xpos",xPos );
			var len:int = script.length;
			
			if ( xPos == 0 ){				
				if ( len >= 158  ) {
					_mc.gotoAndStop( "largeLeft" );
				}else if ( len < 158 && len >= 100  ) {
					_mc.gotoAndStop( "mediumLeft" );
				}else if ( len < 100 && len >= 0  ) {
					_mc.gotoAndStop( "smallLeft" );
				}
				
			}else if ( xPos == 1 ){				
				if ( len >= 158  ) {
					_mc.gotoAndStop( "largeRight" );
				}else if ( len < 158 && len >= 100  ) {
					_mc.gotoAndStop( "mediumRight" );
				}else if ( len < 100 && len >= 0  ) {
					_mc.gotoAndStop( "smallRight" );
				}
				
			}
			
			
			//_mc.txtScript.defaultTextFormat = new TextFormat("Arial", 16, 0);			
            //_mc.txtScript.embedFonts = true;
            //_mc.txtScript.antiAliasType = AntiAliasType.ADVANCED;
            //tf.autoSize = TextFieldAutoSize.LEFT;
            
			
			_mc.txtScript.text = script;	
			
			var tutGuideParam:* = {
				x:xPos,
				y:yPos,
				offsetX:offsetX,
				offsetY:offsetY
			}
			new FluidObject(_mc,tutGuideParam );
		}
		
		/*-------------------------------------------------------------Setters--------------------------------------------------------------------------*/
		public function set type(value:String):void 
		{
			_type = value;
		}
		/*-------------------------------------------------------------Getters--------------------------------------------------------------------------*/
		public function get type():String 
		{
			return _type;
		}
		/*-------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
		
	}

}