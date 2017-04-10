package com.surnia.socialStar.sceneHandler.component 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class MessageSeparator extends Sprite
	{
		private var _txtMessage:TextField;
		private var _numLines:int = 3;
		private var _totalChar:int = 0;
		
		private var messagePart:Array = [];
		public function MessageSeparator() 
		{			
			initialization();
			defaultSettings();
			display();
		}
		
		private function initialization():void 
		{
			_txtMessage = new TextField;		
		}
		
		private function defaultSettings():void 
		{
			_txtMessage.maxChars = 10;
			_txtMessage.width = 200;
            
			_txtMessage.multiline = true;
			_txtMessage.wordWrap = true;	
			_txtMessage.maxChars = 10;
			_txtMessage.selectable = false;
		}
		
		private function display():void 
		{
			if (_txtMessage != null) {
				addChild(_txtMessage);
			}
		}		
		
		private function divideMessage():void 
		{	
			var _totalLines:int = _txtMessage.numLines;
			
			//divide the total line lenght of message to the set number of lines
			var _numMessage:int = _totalLines / _numLines;
			//check if there is a last remainder line.
			var _modMessage:int = _totalLines % _numLines;
			
			//check if there is a remainder line
			if (_modMessage > 0) {
				_modMessage = 1;
			}
			
			var _msgStart:int = 0;
			var _msgEnd:int = 0;
			
			//divide the message and put to array
			for (var i:int = 0; i < _numMessage + _modMessage; i++ ) {				
				for (var j:int = 0; j < _numLines; j++ ) {
					_totalChar += _txtMessage.getLineLength(j);
				}				
				
				if(_msgEnd == 0){
					_msgEnd = _totalChar;
				}
			
				trace(this, "Messages:" ,i, " lines:", j, " msgStart:",_msgStart, " msgEnd:",_msgEnd, " _totalChar:", _totalChar, "RETURN SUBSTRING:", _txtMessage.text.substr(_msgStart, _msgEnd )); 
				//push meesage to array
				messagePart.push(_txtMessage.text.substr(_msgStart, _msgEnd ));
				_msgStart = _totalChar;				
			}		
		}
		
		public function messageNPC(message:String = "message", numLines:int = 1):void {				
			_txtMessage.text = message;
			_numLines = numLines;
			
			_txtMessage.height = _numLines * 18;
			
			divideMessage();		
		}	
	}
}