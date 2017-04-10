package com.surnia.socialStar.views.isoItems 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.views.isoItems.events.DropItemEvent;
	import eDpLib.events.ProxyEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author JC
	 */
	public class DropItem extends Sprite
	{
		/*------------------------------------------------------------------Constant---------------------------------------------------------------------*/			
		
		/*------------------------------------------------------------------Properties--------------------------------------------------------------------*/		
		private var _isoSprite:IsoSprite;
		private var _width:Number = 0;
		private var _length:Number = 0;
		private var _height:Number = 0;
		private var _mc:MovieClip;
		private var _obj:Object;
		
		private var _xPos:int;
		private var _yPos:int;
		private var _zPos:int;
		private var _isoView:IsoView;
		private var _isoScene:IsoScene;
		private var _stage:Stage;		
		
		private var _drop:int;
		private var _id:String;
		
		private var _dropItemEvent:DropItemEvent;
		private var _es:EventSatellite;
		private var _timer:Timer;
		private var _tick:int;
		private var _duration:int;
		
		private var _hasMove:Boolean;
		private var _gd:GlobalData;
		private var _exp:int;
		/*------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		/**
		 * 
		 * @param	width
		 * @param	length
		 * @param	height
		 * @param	mc
		 * @param	obj
		 * @param	xPos
		 * @param	yPos
		 * @param	zPos
		 * @param	isoView
		 * @param	stage
		 * @param	scene
		 * @param	drop 0 - coin, 1- ap, 2 - exp, 3 - red star, 4 - black star ,default - coin  
		 */
		
		
		public function DropItem( 	 width:Number, length:Number, height:Number
									,obj:Object, xPos:int, yPos:int , zPos:int , isoView:IsoView  
									,stage:Stage , scene:IsoScene, drop:int, image:Bitmap = null, id:String = null, exp:int = 0	) 
		{			
			trace( "[DropItem]: exp", exp );
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			
			_width = width;
			_length = length;
			_height = height;
			
			_drop = drop;
			_id = id;
			_exp = exp;
			
			if( _drop == GlobalData.DROP_COIN  ){
				_mc = new CoinRewardMC();
				_duration = 4;
			}else if( _drop == GlobalData.DROP_AP ){
				_mc = new ApRewardMC();
				_duration = 5;
			}else if( _drop == GlobalData.DROP_EXP ){
				_mc = new ExpRightMC();
				_duration = 6;
			}else if( _drop == GlobalData.DROP_RED_STAR ){
				_mc = new RedStartRewardMC();
				_duration = 6;
			}else if( _drop == GlobalData.DROP_BLACK_STAR ){
				_mc = new BlackStaRewardMC();
				_duration = 6;
				_mc.gotoAndStop( "left" );
			}else if( _drop == GlobalData.DROP_BLACK_STAR ){
				_mc = new BlackStaRewardMC();
				_duration = 6;
				_mc.gotoAndStop( "left" );
			}else if ( _drop == 5 ){				
				//_mc = new BankBookMC();				
				//_mc.scaleX = -_mc.scaleX;
				
				if ( image == null ) {
					_mc = new BankBookMC();
				}else {
					_mc = new MovieClip();
					_mc.addChild( image );
				}			
				
				//var pt:Pt = new Pt( _xPos, _yPos, _zPos );				
				//var newPt:Pt = IsoMath.isoToScreen( pt  )				
				//var temp:Point = new Point(newPt.x, newPt.y);
				//temp = stage.localToGlobal(temp);
				//return globalToLocal(temp);
				//
				//_mc.x = temp.x;
				//_mc.y = temp.y;
				_duration = 6;			
				
				//TweenMax.to(_mc, 0.5, {bezierThrough:[{x:132, y:102}, {x:179, y:170}]});
			}else {
				_mc = new CoinRewardMC();
			}
			
			_obj = obj;
			_xPos = xPos
			_yPos = yPos;
			_zPos = 10;
			
			_isoView = isoView;
			_stage = stage;
			_isoScene = scene;
			
			
			_isoSprite = new IsoSprite();
			_isoSprite.setSize( _width, _length, _height );
			_isoSprite.sprites = [ _mc ];
			
			_isoSprite.moveTo( _xPos , _yPos  , _zPos );
			
			_isoScene.addChild( _isoSprite );
			
			trace ("_x "  + _xPos, "_y "  + _yPos, "_z "  + _zPos);	
			
			
			addTimer();
			_isoSprite.addEventListener( MouseEvent.CLICK, onAnimate );
			//_isoSprite.x = _xPos;
			//_isoSprite.y = _yPos;
			//TweenMax.to(_isoSprite, 1, { bezierThrough:[ { x:132, y:102 }, { x:179, y:170 } ] , onUpdate:onRendmerMe } );						
			//TweenMax.to(_isoSprite, 0.1, { bezierThrough:[ { x:132, y:102 }, { x:179, y:170 } ] } );									
			//TweenLite.to( _mc, 1 , { y:50 , onUpdate:onRendmerMe } );
			//TweenMax.to(_isoSprite, 1, { bezierThrough:[ { x:20, z:50 }, { x:50, z:0 } ] , onUpdate:onRendmerMe } );						
			//TweenMax.to(_mc, 1, { bezierThrough:[ { x:20, z:30 }, { x:50, y:40 } ] , onUpdate:onRendmerMe } );			
			//TweenLite.to( _isoSprite, 1 , { x:_isoSprite.x + 20 , onUpdate:onRendmerMe } );
			//TweenLite.to( _isoSprite, 1 , { x:_isoSprite.y + 30 , onUpdate:onRendmerMe } );
			TweenMax.to( _isoSprite, 0.3, { z:100, yoyo:true , repeat:1,  startAt:{ z:1}, onUpdate:onRendmerMe, onComplete:OnUpdatePosition } );
			//TweenMax.to( _isoSprite, 0.3, { z:100, yoyo:true , repeat:1,  startAt:{ z:1}, onUpdate:onRendmerMe } );	
			_isoScene.render();			
		}	
		
		/*------------------------------------------------------------------Methods-------------------------------------------------------------------*/	
		
		private function OnUpdatePosition():void 
		{
			if( _isoSprite != null && _isoScene != null ){
				_isoSprite.z = 10;
				_isoScene.render();
			}
		}
		
		private function onRendmerMe():void 
		{
			_isoScene.render();
		}
		
		private function onRemoveMe():void 
		{			
			if ( _isoSprite != null ) {
				_isoSprite.removeEventListener( MouseEvent.CLICK, onAnimate );
				if ( _isoScene.contains( _isoSprite ) ) {
					_isoScene.removeChild( _isoSprite );
					_isoSprite = null;
				}
			}
			
			if ( _mc != null ) {
				_mc = null;
			}
			trace( "clear coin................ ", _mc, _isoSprite );
		}
		
		private function OnRemoveRenderer():void 
		{			
			removeEventListener( Event.ENTER_FRAME, onRender );
		}
		
		private function addTimer():void 
		{
			_timer = new Timer( 1000 );
			_timer.addEventListener( TimerEvent.TIMER, onTick );
			_timer.start();			
		}
		
		private function removeTimer():void 
		{
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER, onTick );
			_timer = null;
			_tick = 0;			
		}
		
		
		private function moveDrops():void 
		{
			_hasMove = true;
			removeTimer();
			
			var newPt:Point = _isoView.isoToLocal( new Pt( _isoSprite.x, _isoSprite.y ) );
			_dropItemEvent = new DropItemEvent( DropItemEvent.ON_CLICK_DROP_ITEM );
			var obj:Object = new Object();			
			obj.x = newPt.x;
			obj.y = newPt.y;			
			obj.id = _id;			
			obj.drop = _drop;
			obj.exp = _exp;			
			_es.dispatchESEvent( _dropItemEvent , obj );
			
			onRemoveMe();
		}
		
		/*------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		public function set isoSprite(value:IsoSprite):void 
		{
			_isoSprite = value;
		}
		/*------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		public function get isoSprite():IsoSprite 
		{
			return _isoSprite;
		}
		/*------------------------------------------------------------------EventHandlers-------------------------------------------------------------*/		
		
		private function onAnimate( e:ProxyEvent ):void 
		{	
			if( !_hasMove ){
				moveDrops();
			}			
		}
		
		private function onRender(e:Event):void 
		{			
			_isoScene.render();
		}
		
		private function onTick(e:TimerEvent):void 
		{
			if ( _tick >= _duration ) {
				if( !_hasMove ){
					moveDrops();					
				}else {
					removeTimer();
				}
			}
			//trace( "tick.....drop!!", _drop, "tick", _tick );
			_tick++;
			
		}
	}

}