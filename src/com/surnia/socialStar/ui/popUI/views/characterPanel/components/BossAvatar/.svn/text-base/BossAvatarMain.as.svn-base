package com.surnia.socialStar.ui.popUI.views.characterPanel.components.BossAvatar
{
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	


	/**
	 * ...
	 * @author Droids
	 */	
	public class BossAvatarMain extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _effects:Object;
		private var _bossIndex:uint;
		private var _timer:Timer;
		private var _scaleX:Number;
		private var _scaleY:Number;
		
		private var _period:Number;
		private var _frameRate:uint=24;
		private var _beforeTime:int=0;
		private var _afterTime:int=0;
		private var _timeDiff:int=0;
		private var _sleepTime:int=0;
		private var _overSleepTime:int=0;
		private var _excess:int=0;
		
		private var _screenBD:BitmapData;
		private var _screenB:Bitmap;
		private var _shapeBD:BitmapData;
		
		private var _bitmapUrl:String;
		private var _bCtr:int;
		private var _bitmapHolder:BitmapData;
		private var _loader:Loader;
		private var _urlRequest:URLRequest;
		private var _bitmapLoaded:Boolean;
		private var _gd:GlobalData  = GlobalData.instance;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function BossAvatarMain(bossIndex:uint, scaleX:Number, scaleY:Number, fps:int = 24)
		{
			this._bossIndex=bossIndex;
			this._scaleX=scaleX;
			this._scaleY=scaleY;
			this._frameRate=fps;	
			//this.addEventListener(Event.ADDED_TO_STAGE, startBuild);
			this.addEventListener(Event.REMOVED_FROM_STAGE, startRemove);
			loadImage();
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function loadImage():void
		{
			switch(this._bossIndex)
			{
				case 0://singer
				{					
					this._bitmapUrl= _gd.absPath +  "public/data/imgs/minigame/boss/singing_0/idol_idle_140x190.png";
					break;	
				}
				case 1://actor
				{
					this._bitmapUrl= _gd.absPath + "public/data/imgs/minigame/boss/acting_1/prince_idle_150x220.png";
					break;
				}
				case 2://model
				{
					this._bitmapUrl= _gd.absPath + "public/data/imgs/minigame/boss/modeling_2/beauty_idle_160x220.png";
					break;
				}
			}
			this._urlRequest=new URLRequest(this._bitmapUrl);
			this._loader=new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			this._loader.load(this._urlRequest);
			
		}
		private function init():void
		{
			this._effects=new Object();
			this._effects.layers=new Array();
			this._effects.mode=0;
			this._effects.iterator=0;
			
			var bossLayer:Object=new Object();
			bossLayer.name="bossLayer";
			bossLayer.iterator=0;
			bossLayer.items=new Array();
			//trace(this._bossIndex)
			switch(this._bossIndex)
			{
				case 0://singer
				{
					bossLayer.boss1_idle=new Droids_Sprite(this._bitmapHolder, 7, 10, 66, 0, 0, 140, 190, true);
					break;	
				}
				case 1://actor
				{
					bossLayer.boss1_idle=new Droids_Sprite(this._bitmapHolder, 13, 7, 85, 0, 0, 150, 220, true);
					break;
				}
				case 2://model
				{
					bossLayer.boss1_idle=new Droids_Sprite(this._bitmapHolder, 6, 8, 45, 0, 0, 160, 220, true);
					break;
				}
			}
			
			bossLayer.boss1_idle.resize(this._scaleX, this._scaleY);
			
			
			bossLayer.items.push(bossLayer.boss1_idle);
			this._effects.layers.push(bossLayer);
			
			
			
				
			this._period=1000/_frameRate;
			
			
			this._timer=new Timer(this._period, 1);
			this._timer.addEventListener(TimerEvent.TIMER, loop);
			

			setDisplay();
		}
		private function setDisplay():void
		{
			createBitmapScreen();
			this._timer.start();
		}
		private function createBitmapScreen():void
		{
			this._screenBD=new BitmapData(this._effects.layers[0].items[0].width, this._effects.layers[0].items[0].height, true, 0x00AA00);
			var sp:Sprite=new Sprite()
			sp.graphics.lineStyle(1, 0xFFFFFF);
			sp.graphics.beginFill(0xFFFFFF);
			sp.graphics.drawRect(0,0,this._effects.layers[0].items[0].width, this._effects.layers[0].items[0].height);
			sp.graphics.endFill();
			//addChild(sp);
			this._shapeBD=new BitmapData(this._effects.layers[0].items[0].width, this._effects.layers[0].items[0].height, true, 0x00AA00);
			
			this._shapeBD.draw(sp);
			this._screenBD.copyPixels(this._shapeBD, new Rectangle(0, 0, this._effects.layers[0].items[0].width, this._effects.layers[0].items[0].height), new Point(0,0));
			this._screenB=new Bitmap(this._screenBD);
			this.addChild(this._screenB);
		}
		private function updateBitmapInfo():void
		{		
			var maxLayers:int=this._effects.layers.length;
			var maxItems:int;
			for(var layerIndx:int=0; layerIndx < maxLayers; layerIndx++)
			{
				maxItems=this._effects.layers[layerIndx].items.length;
				for(var itemIndx:int=0; itemIndx < maxItems; itemIndx++)
				{					
					//data
					var obj:Object=new Object();
					obj.bitmap=this._effects.layers[layerIndx].items[itemIndx].bitmapData;
					obj.items=this._effects.layers[layerIndx].items[itemIndx].maxItems;
					obj.x=this._effects.layers[layerIndx].items[itemIndx].x;
					obj.y=this._effects.layers[layerIndx].items[itemIndx].y;
					obj.width=this._effects.layers[layerIndx].items[itemIndx].width;
					obj.height=this._effects.layers[layerIndx].items[itemIndx].height;
					obj.col_indx=this._effects.layers[layerIndx].items[itemIndx].col_indx;
					obj.row_indx=this._effects.layers[layerIndx].items[itemIndx].row_indx;
					obj.col=this._effects.layers[layerIndx].items[itemIndx].maxColumns;
					obj.row=this._effects.layers[layerIndx].items[itemIndx].maxRows;
					obj.iterator=this._effects.layers[layerIndx].items[itemIndx].iterator;
					obj.loop=this._effects.layers[layerIndx].items[itemIndx].loop;
					obj.itemList=this._effects.layers[layerIndx].items[itemIndx].itemList;
					//copy pixel
					this._screenBD.copyPixels(obj.itemList[obj.iterator], new Rectangle(0,0,obj.width, obj.height), new Point(obj.x, obj.y));
					obj.iterator++;				
					if(obj.items==obj.iterator)
					{
						if(obj.loop==true)
						{
							obj.iterator=0;
						}
						else
						{
							obj.iterator=obj.items-1;
						}
					}
					this._effects.layers[layerIndx].items[itemIndx].iterator=obj.iterator;
					//obj=null;
				}//loop
			}//loop
		}
		private function renderBitmap():void
		{
			this._screenBD.lock();
			renderBackground();
			this._screenBD.unlock();
		}
		private function renderBackground():void
		{
			this._screenBD.copyPixels(this._shapeBD, new Rectangle(0,0,this._effects.layers[0].items[0].width, this._effects.layers[0].items[0].height),new Point(0,0));
		}
 		private function destroyMe():void
		{
			if(this._bitmapLoaded==true)
			{
				this._timer.stop();
				this._timer.removeEventListener(TimerEvent.TIMER, loop);
				while(this.numChildren)
				{
					this.removeChildAt(0);
				}
				//this._effects.layers[layerIndx].items[itemIndx]
				this._screenBD.dispose();
				this._screenBD=null
				this._screenB=null;
				this._shapeBD.dispose();
				this._shapeBD=null;
			}
			else
			{
				this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
				this._urlRequest=null;
				this._loader=null;
			}
		}
		/*-----------------------------------------------CallBackHandlers---------------------------------------------*/
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function onLoadComplete(e:Event):void
		{
			var bit:Bitmap=Bitmap(e.target.loader.content);
			this._bitmapHolder=bit.bitmapData;	
			//convertByteToBitmap(convertBitmapDataToByte(bit.bitmapData))
			//convertByteToBitmap(PNGEncoder.encode(bit.bitmapData, false, 1, 0));		
			
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			bit=null;
			this._urlRequest=null;
			this._loader=null;
			init();
			this._bitmapLoaded=true;
		}
		private function loop(e:TimerEvent):void
		{
			_beforeTime=getTimer();
			_overSleepTime=(_beforeTime-_afterTime)-_sleepTime;
			
			updateBitmapInfo();
			//renderBitmap();
			//_func1();
			//_func2();
			
			_afterTime=getTimer();
			_timeDiff=_afterTime-_beforeTime;
			_sleepTime=(_period-_timeDiff)-_overSleepTime;
			if(_sleepTime<=0)
			{
				_excess-=_sleepTime;
				_sleepTime=2;
			}
			this._timer.reset();
			this._timer.delay=_sleepTime;
			this._timer.start();
			
			while(_excess>_period)
			{
				updateBitmapInfo();
				//_func1();
				_excess-=_period;
			}
		}
		private function startBuild(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, startBuild);
			//init();
		}
		private function startRemove(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, startRemove);
			destroyMe();
		}
	}
}