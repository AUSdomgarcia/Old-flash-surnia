package com.surnia.socialStar.ui.popUI.views.eventScene
{
	import com.fluidLayout.FluidObject;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.SceneData;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.eventScene.event.EventSceneEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;

	public class EventScenePopup extends Sprite
	{
		private var _eventSceneData:SceneData;
		private var _eventSceneUI:SceneUIContainer;
		private var _index:int = 0;
		private var _npcImageContainer:Sprite;
		private var _len:int;
		private var _es:EventSatellite = EventSatellite.getInstance();
		private var _bm:ButtonManager;
		private var _popUpUIManager:PopUpUIManager;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData = GlobalData.instance;
		private var _scriptFieldHeight:Number;
		private var _scriptFieldWidth:Number;
		private var _ssiImageContainer:Sprite;
		private var _ssiImageFrame:EventSceneFrame;
		private var _ssiimageObject:Sprite;
		private var _diaNPCImageContainer:Sprite;
		private var _mainContainer:Sprite;
		private var _offset:Number = 75;
		private var _fm:FontManager = FontManager.getInstance();
		
		public function EventScenePopup()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(ev:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// init start config
			_sdc = ServerDataController.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			_eventSceneData = GlobalData.instance.sceneData[ 0 ];
			_len = _eventSceneData.script.length;
			_bm = new ButtonManager();
			
			initContainers();
			initNPC();
			initScript();
			//_eventSceneData.hasScript = 0;
			initSSI();
			
			//init the recursive display
			initSceneUIDisplay(_index);
			
			// add listerners
			//addListeners();
			addListeners();
			updatePosition();
		}
		
		private function addListeners():void{
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			
			_es.addEventListener(EventSceneEvent.EVENTSCENE_UPDATEPOSTION, updatePosition);
		}

		private function initContainers():void{
			// init dialogue ui
			
			// init the main container to control the hierarchy of image depth even for dynamic images
			_mainContainer = new Sprite();
			addChild(_mainContainer);
			
			// add the main container for the frame and the main object. For central and individual image control
			_ssiImageContainer = new Sprite();
			_mainContainer.addChild(_ssiImageContainer);
			
			_diaNPCImageContainer = new Sprite();
			_mainContainer.addChild(_diaNPCImageContainer);
		}
		
		private function initScript():void{
			// if has dialogue scripts
			if (_eventSceneData.hasScript == 1){
				
				_eventSceneUI = new SceneUIContainer();
				
				/*_eventSceneUI.npcNameTextField.defaultTextFormat = _fm.getTxtFormat ("Eras Demi ITC", 10);
				_eventSceneUI.npcNameTextField.embedFonts = true;
				_eventSceneUI.npcNameTextField.antiAliasType = AntiAliasType.ADVANCED;
				
				_eventSceneUI.npcDescTextField.defaultTextFormat = _fm.getTxtFormat ("Eras Demi ITC", 10);
				_eventSceneUI.npcDescTextField.embedFonts = true;
				_eventSceneUI.npcDescTextField.antiAliasType = AntiAliasType.ADVANCED;*/
				
				_scriptFieldHeight = _eventSceneUI.height;
				_scriptFieldWidth = _eventSceneUI.width;
				_diaNPCImageContainer.addChild(_eventSceneUI);
				//_eventSceneUI.x = (_gd.stage.stageWidth - _eventSceneUI.width)/2;
				_eventSceneUI.y = _offset;
				
				// set the npc name 
				var npcName:Array = _eventSceneData.npcName;
				_eventSceneUI.npcNameTextField.text = npcName[ 0 ];
				trace ("npc name text: " + _eventSceneUI.npcNameTextField.text);
				
				if (_len > 1){
					disableButton(_eventSceneUI.doneBtn);
				} else {
					enableButton(_eventSceneUI.continueBtn);
				}
				_bm.addBtnListener( _eventSceneUI.continueBtn );
				_bm.addBtnListener( _eventSceneUI.doneBtn );
			} else {
				_scriptFieldHeight = 174;
				_scriptFieldWidth = 578;
			}
		}
		
		private function initNPC():void{
			// if npc image exists
			if (_eventSceneData.hasNpcImage == 1){
				_npcImageContainer = new Sprite();
				_diaNPCImageContainer.addChild(_npcImageContainer);
			}
		}
		
		private function initSSI():void{
			// if ssi image exists
			if (_eventSceneData.hasSsi == 1){
				_ssiImageFrame = new EventSceneFrame();
				_ssiimageObject = new Sprite();
				_ssiImageContainer.addChild(_ssiimageObject);
				_ssiImageContainer.addChild(_ssiImageFrame);
				//_ssiImageContainer.x = (_gd.stage.stageWidth - _ssiImageContainer.width)/2;
				//_ssiImageContainer.x = (_gd.stage.stageWidth - _ssiImageFrame.width)/2;
				if (_eventSceneUI != null){
					_eventSceneUI.x = (_ssiImageFrame.width - _eventSceneUI.width) / 2;
				}
				
				if (_eventSceneUI != null){
					//_ssiImageContainer.y = _eventSceneUI.y - 50;
					_ssiImageContainer.y = _eventSceneUI.y - _offset;
				} else {
					//_ssiImageContainer.y = ((_gd.stage.stageWidth - _ssiImageContainer.height)/2) + 50;
					_ssiImageContainer.y = ((_gd.stage.stageWidth - _ssiImageContainer.height)/2) + 50;
				}
				
				if (_eventSceneData.hasScript == 0){
					_ssiImageContainer.addEventListener(MouseEvent.CLICK, onSSIClick);
				}
				_ssiImageFrame.alpha = 0;
			}
		}
		
		private function onSSIClick(ev:MouseEvent):void{
			if (_index >= _eventSceneData.ssiImage.length-1){
				_sdc.finishEventSceme( _eventSceneData.id );
				_es.dispatchEvent(new EventSceneEvent(EventSceneEvent.EVENTSCENE_DONE));
			} else {
				trace( "ssi image click..........." );
				_index++;
				initSceneUIDisplay(_index);
				//_popUpUIManager.removeWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
			}
		}
		
		private function destroy(e:Event):void 
		{
			if (_eventSceneData.hasScript == 1){
				_bm.removeBtnListener( _eventSceneUI.doneBtn );
				_bm.removeBtnListener( _eventSceneUI.continueBtn );
			}
			
			if (_eventSceneData.hasSsi == 1){
				_ssiImageContainer.addEventListener(MouseEvent.CLICK, onSSIClick);
			}
		
			_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn);
			_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
			_bm.clearButtons();
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);	
			_es.removeEventListener(EventSceneEvent.EVENTSCENE_UPDATEPOSTION, updatePosition);
		}
		
		private function updatePosition(ev:EventSceneEvent = null):void{
			if (_mainContainer != null){
				
				/*var mainOffsetX:int = -(_mainContainer.width / 2);
				var mainOffsetY:int = -(_mainContainer.height / 2);
				
				var mainParam = {
					x:.5,
					y:.5,
					offsetX:mainOffsetX,
					offsetY:mainOffsetY
				}
				new FluidObject(_mainContainer,mainParam );*/
				
				var xPos:Number =  (_gd.stage.stageWidth - _mainContainer.width)/2;
				var yPos:Number =  (_gd.stage.stageHeight - _mainContainer.height)/2;
				_mainContainer.x = xPos;
				_mainContainer.y = yPos;
				//TweenLite.to(_mainContainer, .5, {x:xPos, y:yPos});
			}
		}
		
		private function disableButton(buttonSprite:MovieClip):void{
			//buttonSprite.enabled = false;
			buttonSprite.mouseEnabled = false;
			buttonSprite.alpha = 0;
		}
		
		private function enableButton(buttonSprite:MovieClip):void{
			//buttonSprite.enabled = true;
			buttonSprite.mouseEnabled = true;
			buttonSprite.alpha = 1;
		}
		
		//private function addListeners():void{
			//_eventSceneUI.continueBtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			//_eventSceneUI.doneBtn.addEventListener(MouseEvent.CLICK, onClickHandler);
		//}
		
		//private function onClickHandler(ev:Event):void{
			//switch(ev.target)
			//{
				//case _eventSceneUI.doneBtn:
				//{
					//removeListeners();
					//_es.dispatchEvent(new EventSceneEvent(EventSceneEvent.EVENTSCENE_DONE));
					//break;
				//}
					//
				//case _eventSceneUI.continueBtn:
				//{
					//_index++;
					//initSceneUIDisplay(_index);
					//break;
				//}
			//}
		//}
		
		//private function removeListeners():void{
			//_eventSceneUI.continueBtn.removeEventListener(MouseEvent.CLICK, onClickHandler);
			//_eventSceneUI.doneBtn.removeEventListener(MouseEvent.CLICK, onClickHandler);
		//}
		
		private function initSceneUIDisplay(index:int):void{
			if (_eventSceneData.hasScript == 1){
				// check if last index
				if (_len-1 == index){
					disableButton(_eventSceneUI.continueBtn);
					enableButton(_eventSceneUI.doneBtn);
				} else {
					enableButton(_eventSceneUI.continueBtn);
					disableButton(_eventSceneUI.doneBtn);
				}
				_eventSceneUI.npcNameTextField.text = _eventSceneData.npcName[ index ];
				trace ("npc name text: " + _eventSceneUI.npcNameTextField.text);
				_eventSceneUI.npcDescTextField.text = _eventSceneData.script[index];
				trace ("npc desc text: " + _eventSceneUI.npcDescTextField.text);
			}
			
			if (_eventSceneData.hasNpcImage == 1){
				if (index > 0){
					removeNpcImage(_eventSceneData.npcImage[index-1]);
				}
				setUpNpcImage(_eventSceneData.npcImage[index]);
			}
			
			if (_eventSceneData.hasSsi == 1){
				if (index > 0){
					removeSSIImage(_eventSceneData.ssiImage[index-1]);
				}
				setUpSSIImage(_eventSceneData.ssiImage[index]);
			}
		}
		
		private function setUpSSIImage(ssiImage:Bitmap):void{
			_ssiimageObject.addChild(ssiImage);
			//ssiImage.x = (_scriptFieldWidth - ssiImage.width)/2;
			//npcImg.x = 0;
			//ssiImage.y = 381 + 20 -ssiImage.width;
		}
		
		private function removeSSIImage(ssiImage:Bitmap):void{
			if (_ssiImageContainer.contains(ssiImage)){
				_ssiimageObject.removeChild(ssiImage);
			}
		}
		
		private function setUpNpcImage(npcImg:Bitmap):void{
			_npcImageContainer.addChild(npcImg);
		
			npcImg.x = /*(_gd.stage.stageWidth - npcImg.width)/2 +*/ 180 + _offset;
			//npcImg.x = 0;
			npcImg.y = 42 + _offset;
		}
		
		private function removeNpcImage(npcImg:Bitmap):void{
			if (_npcImageContainer.contains(npcImg)){
				_npcImageContainer.removeChild(npcImg);
			}
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "doneBtn":					
					_eventSceneUI.continueBtn.gotoAndStop( 1 );
				break;
				
				case "continueBtn":					
					_eventSceneUI.continueBtn.gotoAndStop( 1 );
				break;
					
				default:
					
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "doneBtn":					
					_eventSceneUI.continueBtn.gotoAndStop( 2 );
				break;
				
				case "continueBtn":					
					_eventSceneUI.continueBtn.gotoAndStop( 2 );
				break;
				
				default:
					
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "doneBtn":
					trace( "ok btn click..........." );
					_sdc.finishEventSceme( _eventSceneData.id );
					_es.dispatchEvent(new EventSceneEvent(EventSceneEvent.EVENTSCENE_DONE));
					//_popUpUIManager.removeWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case "continueBtn":
					trace( "cancel btn click..........." );
					
					_index++;
					initSceneUIDisplay(_index);
					//_popUpUIManager.removeWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				case "_npcImageContainer":
					trace( "cancel btn click..........." );
					_index++;
					initSceneUIDisplay(_index);
					//_popUpUIManager.removeWindow( WindowPopUpConfig.EVENT_SCENE_WINDOW );
				break;
				
				default:
					
				break;
			}			
		}
		 
	}
}