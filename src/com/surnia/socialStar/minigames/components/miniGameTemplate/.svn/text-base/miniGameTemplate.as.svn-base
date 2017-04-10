package com.surnia.socialStar.minigames.components.miniGameTemplate
{
	import com.surnia.socialStar.minigames.components.player.MiniGamePlayerData;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame;
	import com.surnia.socialStar.utils.assetLoader.AssetLoader;
	import flash.system.Capabilities;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.Security;

	/**
	 * ...
	 * @author Droids
	 */
	public class miniGameTemplate extends MovieClip // implements IGame
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		public static const _GAME_WIDTH:Number=646;
		public static const _GAME_HEIGHT:Number=458;
		public static const _GAME_CENTER_WIDTH:Number=_GAME_WIDTH/2;
		public static const _GAME_CENTER_HEIGHT:Number=_GAME_HEIGHT/2;		
		/*
		private var _GAME_WIDTH:Number=646;
		private var _GAME_HEIGHT:Number=458;
		private var _GAME_CENTER_WIDTH:Number=_GAME_WIDTH/2;
		private var _GAME_CENTER_HEIGHT:Number=_GAME_HEIGHT/2;
		*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		//Df
		private var _parentDisplay:DisplayObjectContainer;
		private var _result:Object;
		private var _parent:Sprite;
		
		private var _loader:Loader;
		private var _urlRequest:URLRequest;
		private var _listImage:Array;
			
		protected var currentPlayerData:MiniGamePlayerData;
		protected var competitorData:MiniGamePlayerData;
		
		private var _assetloader:AssetLoader;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function miniGameTemplate(playerData:MiniGamePlayerData, rivalData:MiniGamePlayerData)
		{
			initGameData(playerData, rivalData);
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		private function initGameData( playerData:MiniGamePlayerData, rivalData:MiniGamePlayerData):void
		{			
			_listImage=new Array();
			currentPlayerData=playerData;
			competitorData=rivalData;
			//_parent=parent;
			//startGame(); //Temporary
			
			if( currentPlayerData != null ){
				if( currentPlayerData.myPictureURL!="")
				{
					loadImage(currentPlayerData.myPictureURL);
				}
				else
				{
					initPlayerImage();
				}
			}
			//loadImage_FbId(competitorData.myFacebookID);
			
		}
		/*
		private function loadImage_FbId(id:String):void
		{
			//AssetLoader.getInstance();
			var x:Bitmap=AssetLoader.getInstance().getFbImage("710088564")
			trace("Its ok")
			this.addChild( x );
		}
		*/
		private function loadImage(path:String):void
		{
			if(path!="")
			{
				_loader=new Loader();
				_urlRequest=new URLRequest(path);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				_loader.load(_urlRequest);
			}
			else
			{
				initPlayerImage();
			}
		}
		protected function initPlayerImage():void
		{
			currentPlayerData.isPlayer = true;
			competitorData.isPlayer = false;
			if(_listImage.length!=0)
			{
				currentPlayerData.myPicture=_listImage[0];
				competitorData.myPicture=_listImage[1];
			}
			else
			{					
				var runingOn:String = Capabilities.playerType;				
				if( runingOn != 'StandAlone' ){
					_assetloader = AssetLoader.getInstance();				
					currentPlayerData.myPicture = _assetloader.getFbImage( "1814776654" );
					competitorData.myPicture = _assetloader.getFbImage( "700186557" );
				}else {
					trace( "this game is running on offline version no friend image will be loaded..." );
				}				
				//currentPlayerData.myPicture=new Bitmap(new UI_NPCFace());
				//competitorData.myPicture = new Bitmap(new UI_NPCFace());				
				//currentPlayerData.myPicture=AssetLoader.getInstance().getFbImage(currentPlayerData.myFacebookID);
				//competitorData.myPicture=AssetLoader.getInstance().getFbImage( competitorData.myFacebookID );
			}
			startGame();
		}
		protected function startGame():void{}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*
		public function get GAME_WIDTH():Number
		{
			return this._GAME_WIDTH;
		}
		public function get GAME_HEIGHT():Number
		{
			return this._GAME_HEIGHT;
		}
		public function get GAME_CENTER_WIDTH():Number
		{
			return this._GAME_CENTER_WIDTH;
		}
		public function get GAME_CENTER_HEIGHT():Number
		{
			return this._GAME_CENTER_HEIGHT;
		}
		*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		private function onIOError(evt:IOErrorEvent):void
		{
			trace("[MiniGameTemplates]: ioError................................")
		}
		protected function collectEndGameResult(evt:Event):void{}
		private function loaded(evt:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(evt.target);
			
			var bitmap:Bitmap=evt.target.loader.content;
			
			//var sp:Sprite=new Sprite()
			//sp.addChild(loaderInfo.loader)
			//_listImage.push(sp);
			_listImage.push(bitmap);
			if(_listImage.length==2)
			{
				initPlayerImage();
			}
			else
			{
				loadImage(competitorData.myPictureURL);
			}
		}
		
		//private function onClick(e:MouseEvent):void {
		//	dispatchResult();			
		//}
		
		/* INTERFACE com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame */
	/*	
		public function dispatchResult():void 
		{
			//var params:Object = new Object;
			
			//params.game = this;
			//params.result = _result;
			_parent.dispatchEvent(new MapEvent(MapEvent.GAME_FINISHED));		
		}
		
		public function get gameResult():Object{
			return _result;
		}
		
		public function show(parentDisplay:DisplayObjectContainer):void 
		{
			_parentDisplay = parentDisplay;
			
			//hide();
			_parentDisplay.addChild(this);
			
			//this.x = X;
			//this.y = Y;
		}
		
		public function remove():void 
		{			
			if (_parentDisplay != null) {			
				if (this != null) {
					
					_parentDisplay.removeChild(this);
				}
			}
		}
		
		public function get visibility():Boolean 
		{
			return this.visible;
		}
		*/
	}
}