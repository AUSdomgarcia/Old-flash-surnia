package com.surnia.socialStar.sceneHandler.view 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.surnia.socialStar.sceneHandler.controller.SceneHandlerController;
	import com.surnia.socialStar.sceneHandler.data.SceneHandlerData;
	import com.surnia.socialStar.sceneHandler.event.SceneHandlerEvent;
	
	
	public class SceneHandlerView extends Sprite
	{
		private var _sceneUI:SceneUIContainer;
		private var _sceneData:SceneHandlerData;
		private var _sceneController:SceneHandlerController;
		private var _es:EventSatellite;
		
		public function SceneHandlerView( scnData:SceneHandlerData, scnController:SceneHandlerController )
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener( SceneHandlerEvent.DATA_LOADED, init );
			_es.addEventListener( SceneHandlerEvent.CURRENT_SCENE_CHANGE, _updateDisplay );
			_es.addEventListener( SceneHandlerEvent.CURRENT_SEQUENCE_CHANGE, _updateDisplay );
			_es.addEventListener( SceneHandlerEvent.BUTTON_CHANGE, _buttonChange );
			_sceneData = scnData;
			_sceneController = scnController;
		}
		
		private function init(e:SceneHandlerEvent):void
		{
			initMainUI();
			initButtons();
			initContents();
		}
		
		private function initMainUI():void
		{
			_sceneUI = new SceneUIContainer;
			_sceneUI.x = (760 - _sceneUI.width) / 2;
			_sceneUI.y = (630 - _sceneUI.height) / 2;
			addChild(_sceneUI);
		}
		
		private function initButtons():void
		{
			_sceneUI.continue_btn.gotoAndStop(1);
			_sceneUI.continue_btn.buttonMode = true;
			_sceneUI.continue_btn.addEventListener(MouseEvent.MOUSE_OVER, _sceneController.buttonOver );
			_sceneUI.continue_btn.addEventListener(MouseEvent.MOUSE_OUT, _sceneController.buttonOut );
			_sceneUI.continue_btn.addEventListener(MouseEvent.MOUSE_DOWN, _sceneController.buttonPress );
			
			_sceneUI.done_btn.gotoAndStop(1);
			_sceneUI.done_btn.buttonMode = true;
			_sceneUI.done_btn.addEventListener(MouseEvent.MOUSE_OVER, _sceneController.buttonOver );
			_sceneUI.done_btn.addEventListener(MouseEvent.MOUSE_OUT, _sceneController.buttonOut );
			_sceneUI.done_btn.addEventListener(MouseEvent.MOUSE_DOWN, _sceneController.buttonPress );
		}
		
		private function initContents():void
		{
			try {
				_sceneUI.avatar_mc.gotoAndStop( _sceneData.getNpcAvatar(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber) );
			}catch (e:Error) {
				_sceneUI.avatar_mc.gotoAndStop(1);
				trace('SceneHandlerView::initContentsError=Error:' + e );
			}
			_sceneUI.npcName_txt.text = _sceneData.getNpcName(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber);
			_sceneUI.npcScript_txt.text = _sceneData.getNpcScript(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber);
		}
		
		
		
		private function _updateDisplay(e:SceneHandlerEvent):void
		{
			try {
				_sceneUI.avatar_mc.gotoAndStop( _sceneData.getNpcAvatar(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber) );
			}catch (e:Error) {
				_sceneUI.avatar_mc.gotoAndStop(1);
				trace('SceneHandlerView::_currentSequenceChanged=Error:' + e );
			}
			_sceneUI.npcName_txt.text = _sceneData.getNpcName(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber);
			_sceneUI.npcScript_txt.text = _sceneData.getNpcScript(_sceneData.currentSceneNumber, _sceneData.currentSequenceNumber);
		}
		
		
		private function _buttonChange(e:SceneHandlerEvent):void
		{
			switch (_sceneData.buttonVisible)
			{
				case 'continue_btn' :
					_sceneUI.continue_btn.visible = true;
					_sceneUI.done_btn.visible = false;
					break;
					
				case 'done_btn' :
					_sceneUI.continue_btn.visible = false;
					_sceneUI.done_btn.visible = true;
					break;
			}
		}
		
		
	}

}