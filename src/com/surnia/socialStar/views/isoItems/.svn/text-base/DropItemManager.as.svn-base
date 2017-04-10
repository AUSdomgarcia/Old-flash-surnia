package com.surnia.socialStar.views.isoItems
{
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.ImageLoader;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;
	import com.surnia.socialStar.controllers.imageLoader.ImageLoaders;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import com.surnia.socialStar.data.TrainingData;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.isoItems.config.DropItemManagerConfig;
	import com.surnia.socialStar.views.isoItems.events.DropItemEvent;
	import com.surnia.socialStar.views.isoObjects.views.IsoObject;
	import com.surnia.socialStar.views.nodes.CharacterNode;
	import com.surnia.socialStar.views.nodes.event.CharacterNodeEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class DropItemManager extends Sprite
	{
		/*-------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		
		private static var _instance:DropItemManager;
		private var _isoView:IsoView;
		private var _isoScene:IsoScene;
		private var _stage:Stage;
		private var _es:EventSatellite;
		private var _popUpUIManager:PopUpUIManager;
		
		private var _imageLoader:ImageLoaders;
		private var _gd:GlobalData;
		private var _xPos:int;
		private var _yPos:int;
		private var _zPos:int;
		private var _exp:int;
		
		private var _currentId:String;
		private var _miniGameCollectionId:String;
		private var _miniGameCollectionUrl:String;
		private var _holder:MovieClip;
		private var _gImageLoader:ImageLoader;
		private var _imageStorage:ImageStorage;
		
		private var _cidSet:Array = new Array();
		
		/*-------------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		public function DropItemManager(enforcer:SingletonEnforcer)
		{
			_gd = GlobalData.instance;
			_imageLoader = ImageLoaders.getInstance();
			_es = EventSatellite.getInstance();
			_popUpUIManager = PopUpUIManager.getInstance();
			
			_imageStorage = ImageStorage.getInstance();
			
			_es.addEventListener(DropItemEvent.ON_CLICK_DROP_ITEM, onPickDropItem);
			_es.addEventListener(IsoRoomEvent.ON_DROP_REWARDS, onDropRewards);
			_es.addEventListener(ServerDataControllerEvent.END_TRAIN_COMPLETE, onDropRewardAfterTraining);
			_es.addEventListener(CharacterNodeEvent.CHARACTER_RESTINGDONE, onRestDone);
		
			//weird?? this one below
			//_es.removeEventListener( ServerDataControllerEvent.ON_GET_MINIGAME_RESULT_COMPLETE , onDropMiniGameReward );			
		}
		
		public static function getInstance():DropItemManager
		{
			if (DropItemManager._instance == null)
			{
				DropItemManager._instance = new DropItemManager(new SingletonEnforcer());
			}
			//trace( "es get instance" );
			return DropItemManager._instance;
		}
		
		/*-------------------------------------------------------------------------Method--------------------------------------------------------------------*/
		public function init(isoView:IsoView, isoScene:IsoScene, stage:Stage):void
		{
			_isoView = isoView;
			_isoScene = isoScene;
			_stage = stage;
		}
		
		public function dropItem(whatItem:int, xPos:int, yPos:int, zPos:int, image:Bitmap = null, id:String = null, exp:int = 0):void
		{
			trace("[DropItemManager]: check exp 2", exp);
			
			var dropItem:DropItem = new DropItem(DropItemManagerConfig.LENGTH, DropItemManagerConfig.WIDTH, DropItemManagerConfig.HEIGHT, new Object(), xPos, yPos, zPos, _isoView, _stage, _isoScene, whatItem, image, id, exp);
		
		}
		
		/*
		   public function dropMiniGameReward():void
		   {
		   trace( "[DropItemManager]: drop Collection reward for miniGame 1" );
		   if ( _gd.currentRewardData != null ){
		   trace( "[DropItemManager]: drop Collection reward for miniGame 2" );
		   _miniGameCollectionId = _gd.currentRewardData.collection;
		   _miniGameCollectionUrl = _gd.currentRewardData.collectionpath;
		
		   var bm:Bitmap = _imageLoader.getImage( _miniGameCollectionId , _miniGameCollectionUrl );
		   if ( bm != null ) {
		   trace( "[DropItemManager]: drop Collection reward for miniGame 3" );
		   dropItem( DropItemManagerConfig.COLLECTION_ITEM, 5 * GlobalData.instance.CELL_SIZE , 5 * GlobalData.instance.CELL_SIZE, DropItemManagerConfig.DEPTH, bm, _miniGameCollectionId );
		   _miniGameCollectionId = null;
		   _miniGameCollectionUrl = null;
		   }else {
		   trace( "[DropItemManager]: drop Collection reward for miniGame 4" );
		   _imageLoader.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onDropCollection );
		   }
		   }
		   }
		 */
		
		private function loadRewardImage(label:String, url:String):void
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
			config.name(label);
			_gImageLoader = new ImageLoader(url, config);
			_gImageLoader.load();
		}
		
		/*-------------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		
		//movie clip that is animated when click
		private function onPickDropItem(e:DropItemEvent):void
		{			
			var dropItems:DropItems = new DropItems(e.obj.drop, e.obj.id, e.obj.exp);
			addChild(dropItems);
			dropItems.x = e.obj.x;
			dropItems.y = e.obj.y;			
			trace( "[DropItemManager]: show animation of drop rewards========================>>> x", dropItems.x, "y", dropItems.y );
		}
		
		private function onDropRewards(e:IsoRoomEvent):void
		{
			if (e.obj != null)
			{
				dropItem(DropItemManagerConfig.COIN, e.obj.x, e.obj.y, DropItemManagerConfig.DEPTH);
				trace("drop reward now......................");
			}
		}
		
		private function onDropRewardAfterTraining(e:ServerDataControllerEvent):void
		{
			trace("[DropItemManager endTraining ]: exp 1st", e.obj.exp);
			var isoObject:IsoObject = _gd.currentIsoObject;
			_currentId = e.obj.id;
			_exp = e.obj.exp;			
			_cidSet.push( e.obj.cid );
			
			//var bm:Bitmap = _imageLoader.getImage( e.obj.id , e.obj.url );
			loadRewardImage(e.obj.id, e.obj.url);
			
			var len:int = _gd.trainingQeuee.length;
			
			for (var i:int = 0; i < len; i++)
			{
				var traingingdat:TrainingData = _gd.trainingQeuee[i];
				if (traingingdat.cid == e.obj.cid)
				{
					traingingdat.exp = e.obj.exp;
					traingingdat.rid = e.obj.id;
					dropItem(DropItemManagerConfig.EXP, traingingdat.xpos, traingingdat.ypos, DropItemManagerConfig.DEPTH, null, null, e.obj.exp);
					//_gd.trainingQeuee[ i ] = null;
					//_gd.trainingQeuee.splice( i, 1 );
					break;
				}
			}
		
			//if ( bm != null ){				
			//trace( "[DropItemManager endTraining ]: exp 2nd", e.obj.exp );
			//dropItem( DropItemManagerConfig.COLLECTION_ITEM, isoObject.x, isoObject.y, DropItemManagerConfig.DEPTH, bm, e.obj.id, e.obj.exp );
			//}else {
			//_imageLoader.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onLoadDropImageComplete );
			//}			
		}
		
		//private function onLoadDropImageComplete(e:ImageLoaderEvent):void 
		//{
		//if( _currentId == e.obj.id ){
		//var isoObject:IsoObject = _gd.currentIsoObject;
		//var bm:Bitmap = _imageLoader.getImage( _currentId );
		//dropItem( DropItemManagerConfig.COLLECTION_ITEM, isoObject.x, isoObject.y, DropItemManagerConfig.DEPTH, bm, _currentId , _exp );
		//}
		//}	
		
		//private function onDropCollection(e:ImageLoaderEvent):void 
		//{
		//trace( "[DropItemManager]: drop Collection reward for miniGame 5" );
		//if ( _miniGameCollectionId == e.obj.id ) {
		//trace( "[DropItemManager]: drop Collection reward for miniGame 6" );
		//var bm:Bitmap = _imageLoader.getImage( _miniGameCollectionId );
		//dropItem( DropItemManagerConfig.COLLECTION_ITEM, 5 * GlobalData.instance.CELL_SIZE, 5 * GlobalData.instance.CELL_SIZE, DropItemManagerConfig.DEPTH, bm, _miniGameCollectionId, _exp );
		//_miniGameCollectionId = null;
		//_miniGameCollectionUrl = null;
		//}
		//}
		//
		//private function onDropMiniGameReward(e:ServerDataControllerEvent):void 
		//{
		//dropMiniGameReward();
		//}
		
		private function onRestDone(e:CharacterNodeEvent):void
		{
			//var len:int = _gd.restingQeuee.length;			
			var charNode:CharacterNode = e.params.charNode;
			
			//if( len > 0  ){
				//for (var i:int = 0; i < len; i++)
				//{
					//var traingingdat:TrainingData = _gd.restingQeuee[i];					
					//if( traingingdat != null ){
						//if ( traingingdat.cid == charNode.charID ) {								
							//dropItem(DropItemManagerConfig.EXP, traingingdat.xpos, traingingdat.ypos, DropItemManagerConfig.DEPTH, null, null, 1 );
							//_gd.restingQeuee[i] = null;
							//_gd.restingQeuee.splice(i, 1);							
							//break;
						//}
					//}					
				//}			
			//}			
			
			dropItem(DropItemManagerConfig.EXP, charNode.x, charNode.y, DropItemManagerConfig.DEPTH, null, null, 1 );
			trace("[DropItemManager]: dispatched onRestDone", charNode);
		}
		
		private function _completeHandler(event:LoaderEvent):void
		{
			trace("Finished loading one reward window image " + event.target);
			trace("Reward window" + event.target.name, "content", event.target.content);
			
			_imageStorage.addImage(event.target.name, _holder);			
			var image:Bitmap = null;
			image = _imageStorage.getImage(event.target.name);						
				
			var len:int = _gd.trainingQeuee.length;
			var len2:int = _cidSet.length;
			
			if( len > 0 && len2 > 0 && image != null ){
				for (var i:int = 0; i < len; i++)
				{
					var traingingdat:TrainingData = _gd.trainingQeuee[i];
					for (var j:int = 0; j < len2; j++) 
					{					
						if( traingingdat != null && _cidSet[ j ] != null ){
							if ( traingingdat.cid == _cidSet[ j ] ) {
								dropItem(DropItemManagerConfig.COLLECTION_ITEM, traingingdat.xpos, traingingdat.ypos, DropItemManagerConfig.DEPTH, image, traingingdat.rid, traingingdat.exp);
								_gd.trainingQeuee[i] = null;
								_gd.trainingQeuee.splice(i, 1);
								_cidSet[ j ] = null;
								_cidSet.splice( j, 1 );
								break;
							}					
						}
					}		
				}			
			}
		}
		
		private function _ioErrorHandler(event:LoaderEvent):void
		{
			trace("[ drop item Manager ] reward image load IOError:", event);
		}
		
		private function _failHandler(event:LoaderEvent):void
		{
			trace("[ drop item Manager ] reward image failed to load:", event);
		}
		
		private function _progressHandler(event:LoaderEvent):void
		{
			trace("[ drop item Manager ] reward image percent loaded check: ", event.target.progress );
		}
	}
}

class SingletonEnforcer
{
}