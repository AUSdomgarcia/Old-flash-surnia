package com.surnia.socialStar.ui.popUI.views 
{	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.ImageLoader;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import com.surnia.socialStar.data.QuestRewardData;
	import com.surnia.socialStar.data.RewardData;
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import com.surnia.socialStar.views.isoItems.DropItemManager;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class RewardWindow extends AbstractWindow
	{		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:RewardWindowMC;
		private var _bm:ButtonManager;
		private var _popUpUIManager:PopUpUIManager;
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		private var _dropItemManager:DropItemManager;
		private var _gd:GlobalData;
		
		private var _rewardImgCnt:int;
		private var _rewardImgSet:Array;
		
		
		private var _rewardSets:Array;
		private var _holder:MovieClip;		
		private var _gImageLoader:ImageLoader;
		private var _imageStorage:ImageStorage;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function RewardWindow( windowName:String, windowSkin:MovieClip ) 
		{
			super( windowName, windowSkin );
		}		
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();			
			_sdc = ServerDataController.getInstance();			
			
			_popUpUIManager =  PopUpUIManager.getInstance();
			_dropItemManager = DropItemManager.getInstance();
			
			super.initWindow();	
			setDisplay();
			
			//to do "GlobalData.instance.currentCompletedQuestData" this should be convert to array in the future  for example you completed multiple quest at the same time or morethan one quest.
			if ( GlobalData.instance.currentCompletedQuestData.length > 0 ) {
				_es.addEventListener( ServerDataControllerEvent.ON_GET_END_QUEST_DATA_COMPLETE, onGetCompleteQuestDataComplete );
				_sdc.getCompleteQuestData( GlobalData.instance.currentCompletedQuestData[ 0 ].id );
			}else {
				updateData();
			}
		}		
		
		override public function clearWindow():void 
		{
			super.clearWindow();			
			removeDisplay();
		}
		
		private function setDisplay():void 
		{
			_mc = new RewardWindowMC();
			addChild( _mc );
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.postRewardBtn );
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.postRewardBtn );
				_bm.removeBtnListener( _mc.closeBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function updateData( obj:Object = null ):void 
		{
			trace( "[RewardWindow]: update reward window information...................................." );
			var len:int;
			
			if ( obj != null ){
				
				len = obj.rewards.length;
				var questReward:QuestRewardData;
				_rewardSets = new Array();
				
				_mc.reward1.visible = false;
				_mc.reward2.visible = false;
				_mc.reward3.visible = false;
				_mc.reward4.visible = false;
				_mc.reward5.visible = false;
				
				for (var i:int = 0; i < len; i++) 
				{
					trace( "[Reward window]: check quest reward index: ", i , "Label: ", obj.rewards[ i ].label, "Image: ", obj.rewards[ i ].image, "quantity", obj.rewards[ i ].quantity, "id", obj.rewards[ i ].id, "type", obj.rewards[ i ].type, "material", obj.rewards[ i ].material  );
					questReward = new QuestRewardData();
					questReward.label = obj.rewards[ i ].label;
					questReward.image = _gd.absPath + obj.rewards[ i ].image;
					questReward.quantity = obj.rewards[ i ].quantity;
					questReward.id = obj.rewards[ i ].id;
					questReward.type = obj.rewards[ i ].type;
					questReward.material = obj.rewards[ i ].material;
					_rewardSets.push( questReward );
					
					if ( i == 0 ){
						_mc.reward1.visible = true;
						if ( obj.rewards[ i ] != null ){
							_mc.reward1.txtQty.text = obj.rewards[ i ].quantity + " " + obj.rewards[ i ].label;
						}
					}else if ( i == 1 ){
						_mc.reward2.visible = true;
						if ( obj.rewards[ i ] != null ){
							_mc.reward2.txtQty.text = obj.rewards[ i ].quantity + " " + obj.rewards[ i ].label;
						}
					}else if ( i == 2 ){
						_mc.reward3.visible = true;
						if ( obj.rewards[ i ] != null ){
							_mc.reward3.txtQty.text = obj.rewards[ i ].quantity + " " + obj.rewards[ i ].label;
						}
					}else if ( i == 3 ){
						_mc.reward4.visible = true;
						if ( obj.rewards[ i ] != null ){
							_mc.reward4.txtQty.text = obj.rewards[ i ].quantity + " " + obj.rewards[ i ].label;
						}
					}else if ( i == 4 ){
						_mc.reward5.visible = true;
						if ( obj.rewards[ i ] != null ){
							_mc.reward5.txtQty.text = obj.rewards[ i ].quantity + " " + obj.rewards[ i ].label;
						}
					}					
				}				
				
				_mc.txtNpcScript.text = obj.npcscript;
				_mc.txtReward.text = "you receieved Coin " + obj.coin + " and  Experienced " + obj.pexp;				
				
				_sdc.setPlayerCoin( int( obj.coin ) );
				_sdc.setPlayerExperience( int( obj.pexp ) );
				
				var questCommand:String = _gd.currentCompletedQuestData[ 0 ].questcommand;
				trace( "[Reward Windows]: quest command quest end..........." );	
				_sdc.getScene( "quest_" + questCommand + "_end" );			
				//_gd.currentCompletedQuestData.shift();
				
				//new 
				_rewardImgCnt = 0;
				_rewardImgSet = new Array();				
				_imageStorage = ImageStorage.getInstance();
				var found:Boolean = _imageStorage.search( _rewardSets[ _rewardImgCnt ].label );
				if ( found ){					
					var image:Bitmap = _imageStorage.getImage( _rewardSets[ _rewardImgCnt ].label );
					_rewardImgSet.push( image );
					_rewardImgCnt++;
				
					var len:int = _rewardSets.length;
					if ( _rewardImgCnt < len ) {
						trace( "[RewardWindow]: load another reward" );
						loadRewardImage();
					}else {
						//done loading all reward images
						showAllRewardImage();
					}
				}else {	
					loadRewardImage();
				}				
			}			
		}
		
		private function loadRewardImage():void 
		{			
			//load image for reward here
			var config:ImageLoaderVars = new ImageLoaderVars();
			_holder = new MovieClip();
			config.container(_holder);
			config.onComplete(_completeHandler);
			config.onProgress(_progressHandler);
			config.onIOError(_ioErrorHandler);
			config.onFail(_failHandler);
			config.autoDispose(true);
			config.name(_rewardSets[ _rewardImgCnt ].label );
			_gImageLoader = new ImageLoader( _rewardSets[ _rewardImgCnt ].image, config);
			_gImageLoader.load();
		}
		
		private function showAllRewardImage():void 
		{
			trace( "[Reward window]: show all reward images!============================================>>" );
			var len:int = _rewardImgSet.length;
			var offsetX:Number = 5;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _rewardImgSet[ i ] != null ) {					
					if ( i == 0 ) {
						if ( _rewardImgSet[ i ] != null ) {
							_mc.reward1.addChild( _rewardImgSet[ i ] );
							_rewardImgSet[ i ].x = ( ( _mc.reward1.width / 2 ) - ( _rewardImgSet[ i ].width / 2 ) ) + offsetX;
							_rewardImgSet[ i ].y = ( _mc.reward1.height / 2 ) - ( _rewardImgSet[ i ].height / 2 );
						}
					}else if ( i == 1 ) {
						if ( _rewardImgSet[ i ] != null ) {
							_mc.reward2.addChild( _rewardImgSet[ i ] );
							_rewardImgSet[ i ].x = ( ( _mc.reward2.width / 2 ) - ( _rewardImgSet[ i ].width / 2 ) ) + offsetX;
							_rewardImgSet[ i ].y = ( _mc.reward2.height / 2 ) - ( _rewardImgSet[ i ].height / 2 );
						}
					}else if ( i == 2 ) {
						if ( _rewardImgSet[ i ] != null ) {
							_mc.reward3.addChild( _rewardImgSet[ i ] );
							_rewardImgSet[ i ].x = ( ( _mc.reward3.width / 2 ) - ( _rewardImgSet[ i ].width / 2 ) ) + offsetX;
							_rewardImgSet[ i ].y = ( _mc.reward3.height / 2 ) - ( _rewardImgSet[ i ].height / 2 );
						}
					}else if ( i == 3 ) {
						if ( _rewardImgSet[ i ] != null ) {
							_mc.reward4.addChild( _rewardImgSet[ i ] );
							_rewardImgSet[ i ].x = ( ( _mc.reward4.width / 2 ) - ( _rewardImgSet[ i ].width / 2 ) ) + offsetX;
							_rewardImgSet[ i ].y = ( _mc.reward4.height / 2 ) - ( _rewardImgSet[ i ].height / 2 );
						}
					}else if ( i == 4 ) {
						if ( _rewardImgSet[ i ] != null ) {
							_mc.reward5.addChild( _rewardImgSet[ i ] );
							_rewardImgSet[ i ].x = ( ( _mc.reward5.width / 2 ) - ( _rewardImgSet[ i ].width / 2 ) ) + offsetX;
							_rewardImgSet[ i ].y = ( _mc.reward5.height / 2 ) - ( _rewardImgSet[ i ].height / 2 );
						}
					}					
				}				
			}
		}
		
		private function removeCurrentRewardAndShowNextReward():void 
		{
			_gd.currentCompletedQuestData.shift();
			
			if( _gd.currentCompletedQuestData.length > 0 ){
				if ( !_popUpUIManager.isWindowActive ){
					_popUpUIManager.loadWindow( WindowPopUpConfig.REWARD_WINDOW );
				}else {
					_popUpUIManager.loadSubWindow( WindowPopUpConfig.REWARD_WINDOW );
				}
			}
		}
		
		private function imageLoadError():void 
		{
			var image:Bitmap = new Bitmap();
			_rewardImgSet.push( image );
			_rewardImgCnt++;
			
			var len:int = _rewardSets.length;
			
			if ( _rewardImgCnt < len ){
				trace( "[RewardWindow]: load reward image" );
				loadRewardImage();
			}else {
				//done loading all reward images
				showAllRewardImage();
			}
		}
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			_es = EventSatellite.getInstance();			
			
			switch ( btnName ) 
			{
				case "postRewardBtn":
					//throw qid here
					_sdc.postVictoryReward( GlobalData.instance.currentCompletedQuestData[ 0 ].id );
					//_dropItemManager.dropMiniGameReward();
					//_popUpUIManager.removeWindow( WindowPopUpConfig.REWARD_WINDOW );
					trace( "[ QuestCompleteWindow ]:click post reward..........." );					
				break;
				
				case "closeBtn":					
					trace( "cancel btn click..........." );
					//_dropItemManager.dropMiniGameReward();
					_popUpUIManager.removeWindow( WindowPopUpConfig.REWARD_WINDOW );
					removeCurrentRewardAndShowNextReward();					
				break;
				
				default:					
				break;
			}			
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "postRewardBtn":					
					_mc.postRewardBtn.gotoAndStop( 1 );
				break;
				
				case "closeBtn":					
					_mc.closeBtn.gotoAndStop( 1 );
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
				case "postRewardBtn":					
					_mc.postRewardBtn.gotoAndStop( 2 );
				break;
				
				case "closeBtn":					
					_mc.closeBtn.gotoAndStop( 2 );
				break;
				
				default:					
				break;
			}
		}
		
		private function onGetCompleteQuestDataComplete(e:ServerDataControllerEvent):void 
		{
			updateData( e.obj )			
		}
		
		private function _completeHandler(event:LoaderEvent):void {			
			trace("Finished loading one reward window image " + event.target);
			trace( "Reward window" + event.target.name , "content", event.target.content );			
			
			_imageStorage.addImage( event.target.name, _holder );
			var image:Bitmap = _imageStorage.getImage( _rewardSets[ _rewardImgCnt ].label );
			_rewardImgSet.push( image );
			_rewardImgCnt++;
			
			var len:int = _rewardSets.length;
			
			if ( _rewardImgCnt < len ){
				trace( "[RewardWindow]: load reward image" );
				loadRewardImage();
			}else {
				//done loading all reward images
				showAllRewardImage();
			}		
		}
		
		private function _ioErrorHandler(event:LoaderEvent):void {
			trace("[ REWARD WINDOW ] reward image load IOError:", event);
			imageLoadError();
		}
		
		private function _failHandler(event:LoaderEvent):void {
			trace("[ REWARD WINDOW ] reward image failed to load:", event);
			imageLoadError();
		}
		
		private function _progressHandler(event:LoaderEvent):void {			
			trace( "[REWARD WINDOW ] reward image percent loaded check: ", event.target.progress , "_rewardImgCnt: ", _rewardImgCnt );
			//imageLoadError();
		}
		
		
	}
}