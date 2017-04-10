package com.surnia.socialStar.ui.friendUI.view 
{	
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.ui.component.Button;
	import com.surnia.socialStar.ui.friendUI.config.FriendUIConfig;	
	import com.surnia.socialStar.ui.friendUI.controller.FriendUIController;	
	import com.surnia.socialStar.ui.friendUI.events.FriendUIEvent;	
	import com.surnia.socialStar.utils.assetLoader.AssetLoader;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.system.System;
	/**
	 * ...
	 * @author ...
	 */
	public class FriendUIScroller extends Sprite
	{
		
		/*-------------------------------------------------------Constant------------------------------------------------------*/
		
		
		/*-------------------------------------------------------Properties---------------------------------------------------*/
		private var _friendUIBoxs:Array;
		//private var _friends:XML;
		private var _horizontalSpace:Number = -2;
		private var _xposSpace:Number = 45;
		private var _yposSpace:Number = 30;
		private var _maxxCount:Number = 5;
		
		
		private var _assetLoader:AssetLoader;
		private var _nextImage:int;
		private var _friends:Array;
		
		private var _rightBtn:Button;
		private var _rightBtn2:Button;
		private var _rightBtn3:Button;
		
		private var _leftBtn:Button;
		private var _leftBtn2:Button;
		private var _leftBtn3:Button;
		
		private var _start:int;		
		
		//private var _box:BoxMC;
		private var _friendUIController:FriendUIController;
		
		private var _sdc:ServerDataController;
		/*-------------------------------------------------------Constructor--------------------------------------------------*/
		
		public function FriendUIScroller(  ) 
		{			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			_sdc = ServerDataController.getInstance();
			prepareControllers();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			
			//if ( FriendUIConfig.isLive ) {
				//loadImages();
			//}			
			
			setDisplay();
			
			addBtns();
			trace( "friendScroller init..........................." );
			//addBox();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*--------------------------------------------------------Methods------------------------------------------------------*/
		private function setDisplay():void 
		{
			_friendUIBoxs = new Array();
			
			//trace( "fbid to load.............................", _friends.friend[ 0 ].@fbid );
			//var image:* = _assetLoader.getFbImage( _friends.friend[ 0 ].@fbid   );			
			//trace( "image check: ", image );
			//addChild( image );			
			
			//var len:int = _friends.length;
			var friendUIBox:FriendUIBox;
			for (var i:int = 0; i < 7; i++) 
			{
				//trace( "Friend # ",i,": ", _friends.fbId[ i ],  _friends.name[ i ], _friends.imageUrl[ i ] );
				
				if( i < 6 ){
					if ( FriendUIConfig.isLive ){						
						if ( i == 5 ) {
							friendUIBox = new FriendUIBox( "add", "1", new Sprite()  );
						}else{
							friendUIBox = new FriendUIBox(   );
						}
					}else {
						friendUIBox = new FriendUIBox(   );
					}
					addChild( friendUIBox );
					friendUIBox.y = 80;
					friendUIBox.x = ( ( friendUIBox.width  + _horizontalSpace ) * i ) + _xposSpace;
					
					_friendUIBoxs.push( friendUIBox );
				}else{
					friendUIBox = new FriendUIBox( "npc", "99", new Sprite()  );
					addChild( friendUIBox );
					friendUIBox.y = 80;
					friendUIBox.x = ( ( friendUIBox.width  + _horizontalSpace ) * i ) + _xposSpace;
				}
			}
		}		
		
		//private function OnMe(e:MouseEvent):void 
		//{
			//_sdc.updateMyCharlist();
			//_sdc.updateHomeViewData();		
			//trace( "load Me.................................." );
		//}
		
		private function OnClickRez(e:MouseEvent):void 
		{
			//_sdc.loadRezChar();
			//_sdc.ViewRez();
			trace( "load res.................................." );
		}
		
		//public function updateFriendUIBox(  ):void 
		//{	
			//if( _friends != null ){			
				//for (var i:int = 0; i < _maxxCount; i++) 
				//{
					//if ( FriendUIConfig.isLive ) {
						//if( _friendUIBoxs[ i ] != null ){
							//if ( _friends[ i ] != null ){							
								//if ( i <= 2 ) {
									//if ( _friends[ i + _start ].name != null && _friends[ i + _start ].fbId != null && _friends[ i + _start ].level != null ) {
										//_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, _friends[ i + _start ].level, _assetLoader.getFbImage( _friends[ i + _start ].fbId ), _friends[ i + _start ].fbId, _friends[ i + _start ].me  );
									//}
								//}else{									
									//if( i != 3 ){
										//var newIndex:int = i -1;										
										//if ( _friends[ newIndex + _start ].name != null && _friends[ newIndex + _start ].fbId != null && _friends[ newIndex + _start ].level != null ) {
											//_friendUIBoxs[ i ].updateData( _friends[ newIndex + _start ].name + i, _friends[ newIndex + _start ].level, _assetLoader.getFbImage( _friends[ newIndex + _start ].fbId ) , _friends[ newIndex + _start ].fbId, _friends[ newIndex + _start ].me );
										//}else {
											//_friendUIBoxs[ i ].updateData( null,null, null, null , null );
										//}
									//}
								//}							
							//}else {
								//_friendUIBoxs[ i ].updateData( null,null, null, null, null );
							//}
						//}
					//}else {
						//if( _friendUIBoxs[ i ] != null ){
							//if( _friends[ i ] != null ){
								//_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, i.toString(), new Sprite() , "me" );
							//}
						//}
					//}				
				//}			
			//}
		//}
		
		public function updateFriendUIBox(  ):void 
		{	
			if( _friends != null ){			
				for (var i:int = 0; i < _maxxCount; i++) 
				{
					if ( FriendUIConfig.isLive ) {
						if( _friendUIBoxs[ i ] != null ){
							if ( _friends[ i ] != null && _friends[ i + _start ] != null ){
								if ( _friends[ i + _start ].name != null && _friends[ i + _start ].fbId != null && _friends[ i + _start ].level != null ) {
									_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, _friends[ i + _start ].level, _assetLoader.getFbImage( _friends[ i + _start ].fbId ), _friends[ i + _start ].fbId, _friends[ i + _start ].me, _friends[ i + _start ].he, _friends[ i + _start ].bug, _friends[ i + _start ].boo  );
								}								
							}else {
								_friendUIBoxs[ i ].updateData( null,null, null, null, null,0,0,0 );
							}
						}
					}else {
						if( _friendUIBoxs[ i ] != null ){
							if( _friends[ i ] != null ){
								_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, i.toString(), new Sprite() , "me", _friends[ i + _start ].he, _friends[ i + _start ].bug, _friends[ i + _start ].boo );
							}
						}
					}				
				}			
			}
		}
		
		public function updateFriendUIBoxText( friendData:Array ):void 
		{	
			_friends = friendData;
			trace( " show text here.................. ", _friends );
			if( _friends != null ){			
				for (var i:int = 0; i < _maxxCount; i++) 
				{
					if ( FriendUIConfig.isLive ) {
						if ( _friends[ i ] != null && _friends[ i + _start ] != null ){
							if ( _friends[ i + _start ].name != null && _friends[ i + _start ].fbId != null && _friends[ i + _start ].level != null ){
								_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, _friends[ i + _start ].level, null, _friends[ i + _start ].fbId, _friends[ i + _start ].me, _friends[ i + _start ].he, _friends[ i + _start ].bug, _friends[ i + _start ].boo  );
							}
						}else {
							_friendUIBoxs[ i ].updateData( null,null, null, null, null, 0,0,0 );
						}
					}else {
						if( _friends[ i ] != null ){
							_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, i.toString(), new Sprite() , "me", _friends[ i + _start ].he, _friends[ i + _start ].bug, _friends[ i + _start ].boo );
						}
					}
				}				
				loadImages( _friends );
			}
		}
		
		//public function updateFriendUIBoxText( friendData:Array ):void 
		//{	
			//_friends = friendData;
			//trace( " show text here.................. ", _friends );
			//if( _friends != null ){			
				//for (var i:int = 0; i < _maxxCount; i++) 
				//{
					//if ( FriendUIConfig.isLive ) {
						//if ( _friends[ i ] != null ){							
							//if ( i <= 2 ){
								//if ( _friends[ i + _start ].name != null && _friends[ i + _start ].fbId != null && _friends[ i + _start ].level != null ) {
									//_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, _friends[ i + _start ].level, null, _friends[ i + _start ].fbId, _friends[ i + _start ].me  );
								//}
							//}else{							
								//if( i != 3 ){
									//var newIndex:int = i -1;
									//if ( _friends[ newIndex + _start ].name != null && _friends[ newIndex + _start ].fbId != null && _friends[ newIndex + _start ].level != null ) {
										//_friendUIBoxs[ i ].updateData( _friends[ newIndex + _start ].name + i, _friends[ newIndex + _start ].level, null , _friends[ newIndex + _start ].fbId, _friends[ newIndex + _start ].me );
									//}else {
										//_friendUIBoxs[ i ].updateData( null,null, null, null , null );
									//}
								//}
							//}							
						//}else {
							//_friendUIBoxs[ i ].updateData( null,null, null, null, null );
						//}
					//}else {
						//if( _friends[ i ] != null ){
							//_friendUIBoxs[ i ].updateData( _friends[ i + _start ].name + i, i.toString(), new Sprite() , "me" );
						//}
					//}
				//}
				//
				//loadImages( _friends );
			//}
		//}
		
		private function removeDisplay():void 
		{	
			removeBtns();			
			
			var len:int = _friendUIBoxs.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _friendUIBoxs[ i ] != null ) {
					if ( this.contains( _friendUIBoxs[ i ] ) ) {
						this.removeChild( _friendUIBoxs[ i ] );
						_friendUIBoxs[ i ] = null;
					}
				}				
			}			
		}
		
		public function loadImages( friends:Array = null ):void 
		{		
			if ( _friends != null ){				
				//trace( "dawdwadawdwa",Capabilities.playerType );
				/*
				"StandAlone" for the Flash StandAlone Player
				"External" for the Flash Player version used by the external player, or test movie mode
				"PlugIn" for the Flash Player browser plug-in
				"ActiveX" for the Flash Player ActiveX Control used by Microsoft Internet Explorer
				*/				
				var runingOn:String = Capabilities.playerType;
				
				if ( runingOn != 'StandAlone' ) {
					if( _friends == null ){
						_friends = friends;
					}
					_assetLoader = AssetLoader.getInstance();
					_assetLoader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onAssetLoadComplete );
					if( _friends[ _nextImage  ].imageUrl != null && _friends[ _nextImage ].fbId != null ){
						_assetLoader.loadImage( _friends[ _nextImage  ].imageUrl, true, true, _friends[ _nextImage ].fbId );
					}
				}else {
					trace( "this game is running on offline version no friend image will be loaded..." );
				}
			}
		}
		
		
		private function addBtns():void 
		{
			_rightBtn = new Button( new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN ),new RightBtnMC,567, 85 );
			addChild( _rightBtn );
			_rightBtn.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN, clickRightBtn );
			
			_rightBtn2 = new Button( new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN2 ),new RightBtn2MC,567, 115 );			
			addChild( _rightBtn2 );
			_rightBtn2.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN2, clickRightBtn2 );			
			
			_rightBtn3 = new Button( new FriendUIEvent( FriendUIEvent.CLICK_RIGHT_BTN3 ), new RightBtn3MC, 567,145 );
			addChild( _rightBtn3 );
			_rightBtn3.addEventListener( FriendUIEvent.CLICK_RIGHT_BTN3, clickRightBtn3 );
			
			
			_leftBtn = new Button( new FriendUIEvent( FriendUIEvent.CLICK_LEFT_BTN ),new LeftBtnMC,15, 85 );			
			addChild( _leftBtn );
			_leftBtn.addEventListener( FriendUIEvent.CLICK_LEFT_BTN, clickLeftBtn );
			
			
			_leftBtn2 = new Button( new FriendUIEvent( FriendUIEvent.CLICK_LEFT_BTN2 ),new LeftBtn2MC,10, 115 );			
			addChild( _leftBtn2 );
			_leftBtn2.addEventListener( FriendUIEvent.CLICK_LEFT_BTN2, clickLeftBtn2 );			
			
			_leftBtn3 = new Button( new FriendUIEvent( FriendUIEvent.CLICK_LEFT_BTN3 ),new LeftBtn3MC,12, 145 );			
			addChild( _leftBtn3 );
			_leftBtn3.addEventListener( FriendUIEvent.CLICK_LEFT_BTN3, clickLeftBtn3 );		
		}		
		
		
		
		private function removeBtns():void 
		{			
			if ( _rightBtn != null ) {
				_rightBtn.removeEventListener( FriendUIEvent.CLICK_RIGHT_BTN, clickRightBtn );
				if ( this.contains( _rightBtn ) ) {
					this.removeChild( _rightBtn );
					_rightBtn = null;
				}
			}
			
			if ( _rightBtn2 != null ) {
				_rightBtn2.removeEventListener( FriendUIEvent.CLICK_RIGHT_BTN2, clickRightBtn2 );
				if ( this.contains( _rightBtn2 ) ) {
					this.removeChild( _rightBtn2 );
					_rightBtn2 = null;
				}
			}
			
			if ( _rightBtn3 != null ) {
				_rightBtn3.removeEventListener( FriendUIEvent.CLICK_RIGHT_BTN3, clickRightBtn3 );
				if ( this.contains( _rightBtn3 ) ) {
					this.removeChild( _rightBtn3 );
					_rightBtn3 = null;
				}
			}
			
			if ( _leftBtn != null ) {
				_leftBtn.removeEventListener( FriendUIEvent.CLICK_LEFT_BTN, clickLeftBtn );
				if ( this.contains( _leftBtn ) ) {
					this.removeChild( _leftBtn );
					_leftBtn = null;
				}
			}
			
			if ( _leftBtn2 != null ) {
				_leftBtn2.removeEventListener( FriendUIEvent.CLICK_LEFT_BTN2, clickLeftBtn2 );
				if ( this.contains( _leftBtn2 ) ) {
					this.removeChild( _leftBtn2 );
					_leftBtn2 = null;
				}
			}
			
			if ( _leftBtn3 != null ) {
				_leftBtn3.removeEventListener( FriendUIEvent.CLICK_LEFT_BTN3, clickLeftBtn3 );
				if ( this.contains( _leftBtn3 ) ) {
					this.removeChild( _leftBtn3 );
					_leftBtn3 = null;
				}
			}
		}
		
		
		private function clickRightBtn( e:FriendUIEvent ):void 
		{
			if( _friends != null  ){
				if( _start + _maxxCount <= _friends.length ){
					_start++;				
					updateFriendUIBox();
				}else {
					trace( "max right!!" );
				}
			}
		}
		
		private function  clickRightBtn2( e:FriendUIEvent ):void 
		{
			if( _friends != null  ){
				if( ( _start + 4 ) + _maxxCount <= _friends.length ){
					_start += 4;
					updateFriendUIBox();				
				}else {
					trace( "max right!!" );
				}
			}
		}
		
		private function  clickRightBtn3( e:FriendUIEvent ):void 
		{
			if( _friends != null  ){
				if( ( _start + 8 ) + _maxxCount <= _friends.length ){
					_start += 8;					
					updateFriendUIBox();
				}else {
					trace( "max right!!" );
				}
			}
		}
		
		
		private function  clickLeftBtn( e:FriendUIEvent ):void {
			if( _friends != null  ){
				if( _start > 0 ){
					_start--;					
					updateFriendUIBox();
				}else {
					trace( "max left!!" );
				}
			}
		}
		
		private function  clickLeftBtn2( e:FriendUIEvent ):void {
			if( _friends != null  ){
				if( _start - 4 > 0 ){
					_start -= 4;					
					updateFriendUIBox();
				}else {
					trace( "max left!!" );
				}
			}
		}
		
		private function  clickLeftBtn3( e:FriendUIEvent ):void {
			if( _friends != null  ){
				if( _start - 8 > 0 ){
					_start -= 8;					
					updateFriendUIBox();
				}else {
					trace( "max left!!" );
				}
			}
		}		
		
		private function prepareControllers():void 
		{
			_friendUIController = FriendUIController.getInstance();			
		}	
		
		/*-------------------------------------------------------Setters------------------------------------------------------*/
		
		/*-------------------------------------------------------Getters------------------------------------------------------*/
		
		/*-------------------------------------------------------EventHandlers------------------------------------------------*/
		private function onAssetLoadComplete(e:AssetLoaderEvent):void 
		{				
			var len:int = _friends.length;		
			if ( _assetLoader.loadedFbImages.length >= len ) {
				trace( "all friends images loaded!!!!!!!!......................" );				
				updateFriendUIBox();
			}else {
				_nextImage++;
				loadImages();
			}
		}		
	}

}