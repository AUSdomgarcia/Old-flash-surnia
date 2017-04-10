package com.surnia.socialStar.sceneHandler.controller 
{
	import com.surnia.socialStar.sceneHandler.data.SceneHandlerData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class SceneHandlerController extends Sprite
	{
		private var _sceneData:SceneHandlerData;
		
		
		public function SceneHandlerController( scnData:SceneHandlerData ) 
		{
			_sceneData = scnData;
		}
		
		
		public function buttonOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
		}
		
		
		public function buttonOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		
		public function buttonPress(e:MouseEvent):void
		{
			//trace('SceneHandlerController::buttonPress=clicked on \'' + e.currentTarget.name + '\'' );
			switch( e.currentTarget.name )
			{
				case 'continue_btn' :
					_sceneData.currentSequenceNumber++;
					break;
					
				case 'done_btn' :
					_sceneData.currentSequenceNumber++;
					break;
			}
		}
		
	}

}