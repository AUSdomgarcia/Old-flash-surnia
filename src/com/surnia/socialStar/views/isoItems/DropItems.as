package com.surnia.socialStar.views.isoItems 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.imageStorage.ImageStorage;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author JC
	 */
	public class DropItems extends Sprite
	{
		/*------------------------------------------------------------------Constant-------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private var _mc:MovieClip;
		private var _drop:int;
		private var _id:String;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		//private var _imageLoader:ImageLoaders; 
		private var _exp:int;
		private var _imageStorage:ImageStorage;
		/*------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		
		/**
		 * 
		 * @param	drop 0 - coin, 1 - ap, 2 -exp, 3 - redstar, 4 -black star
		 */
		
		public function DropItems( drop:int, id:String = null, exp:int = 0 ) 
		{
			_imageStorage = ImageStorage.getInstance();
			trace( "[DropItems] check exp ", exp );
			_id = id;
			_drop = drop;			
			_exp = exp;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			//_imageLoader = ImageLoaders.getInstance();
			_sdc = ServerDataController.getInstance();
			_gd = GlobalData.instance;			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*------------------------------------------------------------------Methods-------------------------------------------------------------------*/
		private function setDisplay():void 
		{			
			if( _drop == GlobalData.DROP_COIN ){
				_mc = new CoinRewardMC();
			}else if ( _drop == GlobalData.DROP_AP ){
				_mc = new ApRewardMC();	
			}else if ( _drop == GlobalData.DROP_EXP ){
				_mc = new ExpRightMC();
			}else if ( _drop == GlobalData.DROP_RED_STAR ){
				_mc = new RedStartRewardMC();
			}else if ( _drop == GlobalData.DROP_BLACK_STAR ){
				_mc = new BlackStaRewardMC();
			}else if ( _drop == 5 ) {
				
				_mc = new MovieClip();
				var image:Bitmap = _imageStorage.getImage( _id );
				//var image:Bitmap = _imageLoader.getImage( _id );
				_mc.addChild( image );
				//_mc = new BankBookMC();
			}
			
			addChild( _mc );
			
			//if( _mc.mc != null ){
				//_mc.mc.gotoAndStop( "end" );
			//}			
			
			if( _drop == GlobalData.DROP_COIN ){
				TweenLite.to( _mc, 1, { x:75, y:20, onComplete:removeMe } );	
			}else if( _drop == GlobalData.DROP_AP ){
				TweenLite.to( _mc, 1, { x:410, y:20, onComplete:removeMe} );	
			}else if ( _drop == GlobalData.DROP_EXP ) {				
				//TweenLite.to( _mc, 1, { x:_gd.levelMCPos.x, y:_gd.levelMCPos.y, onComplete:removeMe} );	
				var newPoint:Point = globalToLocal( new Point( 917 , 30 ) );
				TweenLite.to( _mc, 1, { x:newPoint.x, y:newPoint.y, onComplete:removeMe} );	
				trace( "[DropItems]: go animate now please boom _gd.levelMCPos.xy!!....x", _gd.levelMCPos.x, "y" , _gd.levelMCPos.y );
				//TweenLite.to( _mc, 1, { x:_gd.levelMCPos.x, y:_gd.levelMCPos.y, onComplete:removeMe} );				
				trace( "[DropItems]: go animate now please boom!!....x", this.x, "y" , this.y );
				trace( "[DropItems]: go animate now please boom!!....mc", _mc.x, "y" , _mc.y );
				//TweenLite.to( _mc, 2, { x: newPoint.x + 100, y:newPoint.y} );	
			}else if( _drop == GlobalData.DROP_RED_STAR ){
				TweenLite.to( _mc, 1, { x:0, y:200, onComplete:removeMe} );	
			}else if( _drop == GlobalData.DROP_BLACK_STAR ){
				TweenLite.to( _mc, 1, { x:0, y:300, onComplete:removeMe} );	
			}else if ( _drop == 5 ) {
				TweenLite.to( _mc, 1, { x:75, y:20, onComplete:removeMe } );
			}else{
				TweenLite.to( _mc, 1, { x:75, y:20, onComplete:removeMe } );				
			}
		}		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
					trace( "remove drop item after animation" );
				}
			}
		}
		
		private function removeMe():void 
		{
			removeDisplay();			
			if( _drop == GlobalData.DROP_COIN ){
				_sdc.setPlayerCoin( _gd.coinReward );
				_sdc.pickReward( "coin", _gd.coinReward );
			}
			
			if( _drop == GlobalData.DROP_AP ){				
				_sdc.setPlayerActionPoints( GlobalData.AP_MINUS_VALUE );
				_sdc.pickReward( "ap", GlobalData.AP_ADD_VALUE );
			}
			
			if ( _drop == GlobalData.DROP_EXP ) {
				//_sdc.setPlayerExperience( GlobalData.EXP_ADD_VALUE );
				//_sdc.pickReward( "pexp", GlobalData.EXP_ADD_VALUE );
				trace( "[DropItems ] call server check exp", _exp );
				_sdc.setPlayerExperience( _exp );
				_sdc.pickReward( "pexp", _exp );
			}
			
			if ( _drop == GlobalData.DROP_RED_STAR ) {
				_sdc.pickReward( "redstar", GlobalData.RED_STAR_ADD_VALUE );
				_sdc.pickReward( "redstar", GlobalData.RED_STAR_ADD_VALUE );
				//add redstar call here server call
			}
			
			if ( _drop == GlobalData.DROP_BLACK_STAR ){
				_sdc.pickReward( "blackstar", GlobalData.BLACK_STAR_ADD_VALUE );
				_sdc.pickReward( "blackstar", GlobalData.BLACK_STAR_ADD_VALUE );
				//add blackstar call here server call
			}
		}
		/*------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------EventHandlers-------------------------------------------------------------------*/		
	}

}