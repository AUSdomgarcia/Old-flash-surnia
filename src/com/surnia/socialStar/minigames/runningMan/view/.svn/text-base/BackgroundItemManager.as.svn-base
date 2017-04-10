package com.surnia.socialStar.minigames.runningMan.view 
{
	import com.greensock.TweenLite;
	import com.surnia.socialStar.minigames.runningMan.model.BackgroundItemModel;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author domz
	 */
	public class BackgroundItemManager extends Sprite
	{
		private var m:BackgroundItemModel;
		private var targetMC:Sprite;
		private var speed:Number = .60;
		private var xspeed:Number = 0;
		private var masking2:Sprite;
		
		private var layer0:Sprite = new Sprite();
		private var layer1:Sprite = new Sprite();
		private var layer2:Sprite = new Sprite();
		private var layer3:Sprite = new Sprite();
		private var layer4:Sprite = new Sprite();
		private var layer5:Sprite = new Sprite();
		private var layer6:Sprite = new Sprite();
		
		private var bgX:Number;
		private var bgY:Number;
		private var ctr:Number = 0;
		
		public function BackgroundItemManager( _m:BackgroundItemModel, x:Number, y:Number, _sp:Sprite )
		{
			targetMC = _sp;
			m = _m;
			bgX = x;
			bgY = y;
			init();
		}
		
		public function onUpdate():void {
			ctr++;
			updateRaceBg();
		}

		private function updateRaceBg():void {
			
			//Mountain
			for (var j:int = 0; j < m.bgObject_arrHolder2.length; j++) 
			{
				m.bgObject_arrHolder2[j].x -= m.mountainSpeed;
				
				
				if ( m.bgObject_arrHolder2[j].x <=  m.bgWindow.x - m.bgObject2.width ) {
					layer1.removeChild( m.bgObject_arrHolder2[j] );
					m.bgObject_arrHolder2.splice( j, 1 );
				}
				
				if (  m.bgObject_arrHolder2.length <= 1) {
					m.bgObject2 = new MountainMc();
					m.bgObject2.x = m.bgWindow.width + 320;
					m.bgObject2.y = m.bgWindow.y + 186;
					m.bgObject_arrHolder2.push( m.bgObject2 );
					layer1.addChild( m.bgObject2 );
				}
				
			}
			
			//Road
			for (var k:int = 0; k < m.road_arr.length; k++) 
			{
				m.road_arr[k].x -= m.roadSpeed;
				if ( m.road_arr[k].x <=  m.bgWindow.x - m.road.width ) {
					layer4.removeChild( m.road_arr[k] );
					m.road_arr.splice( k, 1 );			
						
						if ( m.road_arr.length <= 2 ) {
							m.road = new RoadMc();
							m.road.cacheAsBitmap = true;
							m.road.x = m.bgWindow.x + 500;
							m.road.y = m.wall.y + 25;
							m.road_arr.push( m.road );
							layer4.addChild( m.road );
						}
					}
			}
			
			//Front tree
			for (var i:int = 0; i < m.bgObject_arrHolder.length; i++) 
			{
				
				m.bgObject_arrHolder[i].x -= m.treeSpeed;
				
				if ( m.bgObject_arrHolder[i].x <= m.bgWindow.x - m.bgObject1.width ) {
					layer2.removeChild( m.bgObject_arrHolder[i] );
					m.bgObject_arrHolder.splice( i, 1 );
				}
				
				if ( m.bgObject_arrHolder.length <= 3 ) {
					m.bgObject1.cacheAsBitmap = true;
					m.bgObject1 = new TreeMc();
					m.bgObject1.x = m.bgWindow.x + 600;
					m.bgObject1.y = m.bgWindow.y + 120;
					m.bgObject_arrHolder.push( m.bgObject1 );
					layer2.addChild( m.bgObject1 );
				}
			}
			//Back tree
			for (var x:int = 0; x < m.bgObject_arrHolder3.length; x++) 
			{
				m.bgObject_arrHolder3[x].x -= m.treeSpeedBack;
				
				if ( m.bgObject_arrHolder3[ x ].x <= m.bgWindow.x - m.bgObject3.width ) {
					layer5.removeChild( m.bgObject_arrHolder3[ x ] );
					m.bgObject_arrHolder3.splice( x, 1 );
				}
				
				if ( m.bgObject_arrHolder3.length <= 3 ) {
					m.bgObject3.cacheAsBitmap = true;
					m.bgObject3 = new TreeMc2();
					m.bgObject3.x = m.bgWindow.x + 600;
					m.bgObject3.y = m.bgWindow.y + 177;
					m.bgObject_arrHolder3.push( m.bgObject3 );
					layer5.addChild( m.bgObject3 );
				}
			}
			//Cloud
			for (var h:int = 0; h < m.bgObject_arrHolder4.length; h++) 
			{
				
				m.bgObject_arrHolder4[ h ].x -= m.cloudSpeed;
				
				if ( m.bgObject_arrHolder4[ h ].x <= m.bgWindow.x - m.bgObject4.width ) {
					layer6.removeChild( m.bgObject_arrHolder4[ h ] );
					m.bgObject_arrHolder4.splice( h, 1 );
				}
				
				if ( m.bgObject_arrHolder4.length <= 3 ) {
					var numY:Number = Math.floor( Math.random() * 100 );
					
					m.bgObject4.cacheAsBitmap = true;
					m.bgObject4 = new CloudMc();
					m.bgObject4.x = m.bgWindow.x + 700;
					m.bgObject4.y = m.bgWindow.y + 60 + numY;
					m.bgObject_arrHolder4.push( m.bgObject4 );
					layer6.addChild( m.bgObject4 );
				}
			}
			
		}
		private function init():void {
			
		//Temporary
			backGroundWindow();
			setUpRaceBg();
			addMountain();
			addCloud();
			addBackMountain();
			addRollingRoad();
			addMasking();
			
			addChildItem();
		}
		
		private function addCloud():void {
			
			for (var i:int = 0; i < 3; i++) 
			{	
				m.bgObject4 = new CloudMc();
				var numY:Number = Math.floor( Math.random() * 100 );
				m.bgObject4.x = m.bgWindow.x + ( 300 * i );
				m.bgObject4.y = m.bgWindow.y + 60 + numY;
				m.bgObject_arrHolder4[i] = m.bgObject4;
				layer6.addChild( m.bgObject_arrHolder4[i] );
			}
		}
		
		private function addBackMountain():void {
			for (var i:int = 0; i < 4; i++) 
			{	
				m.bgObject3 = new TreeMc2;
				m.bgObject3.cacheAsBitmap = true;
				m.bgObject3.x = m.bgWindow.x + ( i * 160 );
				m.bgObject3.y = m.bgWindow.y + 177;
				m.bgObject_arrHolder3[i] = m.bgObject3;
				layer5.addChild( m.bgObject_arrHolder3[i] );
			}
		}
		
		private function setUpRaceBg():void {
			for (var i:int = 0; i < 4; i++) 
				{	
					m.bgObject1 = new TreeMc();
					m.bgObject1.cacheAsBitmap = true;
					m.bgObject1.x = m.bgWindow.x + ( i * 160 );
					m.bgObject1.y = m.bgWindow.y + 120;
					m.bgObject_arrHolder[i] = m.bgObject1;
					layer2.addChild( m.bgObject_arrHolder[i] );
				}
			}
		//-------------------------------------------------------------------------------------------< FOR TOMORROW >--------------------
		
		private function addMountain():void {
			for (var i:int = 0; i < 2; i++) 
			{
				m.bgObject2 = new MountainMc();
				m.bgObject2.cacheAsBitmap = true;
				m.bgObject2.y = m.bgWindow.y + 186;
				m.bgObject2.x = m.bgWindow.x + 500 * i;
				m.bgObject_arrHolder2[i] = m.bgObject2;
				layer1.addChild( m.bgObject_arrHolder2[i] );
			}
		}
		
		public function addMasking():void {
			m.masking = new Sprite();
			m.masking.graphics.beginFill( 0x00FF00 );
			m.masking.graphics.drawRect( m.bgWindow.x, m.bgWindow.y, m.bgWindow.width,  m.bgWindow.height );
			m.masking.graphics.endFill();
			targetMC.addChild( m.masking );
			
			m.masking2 = new Sprite();
			m.masking2.graphics.beginFill( 0x00FF00 );
			m.masking2.graphics.drawRect( m.bgWindow.x, m.bgWindow.y, m.bgWindow.width,  m.bgWindow.height );
			m.masking2.graphics.endFill();
			targetMC.addChild( m.masking2 );
			
			m.masking3 = new Sprite();
			m.masking3.graphics.beginFill( 0x00FF00 );
			m.masking3.graphics.drawRect( m.bgWindow.x, m.bgWindow.y + 258, m.road.width - 24,  m.road.height );
			m.masking3.graphics.endFill();
			targetMC.addChild( m.masking3 );
			
			m.masking4 = new Sprite();
			m.masking4.graphics.beginFill( 0x00FF00 );
			m.masking4.graphics.drawRect( m.bgWindow.x, m.bgWindow.y ,m.bgWindow.width,  m.bgWindow.height );
			m.masking4.graphics.endFill();
			targetMC.addChild( m.masking4 );
			
			m.masking5 = new Sprite();
			m.masking5.graphics.beginFill( 0x00FF00 );
			m.masking5.graphics.drawRect( m.bgWindow.x, m.bgWindow.y, m.bgWindow.width,  m.bgWindow.height );
			m.masking5.graphics.endFill();
			targetMC.addChild( m.masking5 );
			
			layer1.mask = m.masking;
			layer2.mask = m.masking2;
			layer4.mask = m.masking3;
			layer5.mask = m.masking4;
			layer6.mask = m.masking5;
			
		}
		public function addRollingRoad():void {
			
			m.wall = new WallMc();
			m.wall.x = m.bgWindow.x;
			m.wall.height += 1.2;
			m.wall.y = m.bgWindow.y + 230;
			
			for (var i:int = 0; i < 3; i++) 
			{
				m.road = new RoadMc();
				m.road.x = m.bgWindow.x + ( m.road.width * i );
				m.road.y = m.wall.y + 25;
				m.road_arr[i] = m.road;
				layer4.addChild( m.road_arr[i] );
			}
			layer3.addChild( m.wall );
		}
		
		
		public function addChildItem():void {
			targetMC.addChild(layer0 );
			targetMC.addChild( layer6 );
			targetMC.addChild(layer1 );
			targetMC.addChild( layer5 );
			targetMC.addChild( layer2 );
			targetMC.addChild( layer3 );
			targetMC.addChild( layer4 );
		}
		
		public function backGroundWindow():void {
			m.bgWindow = new SkyMc();
			m.bgWindow.width = m.bgWindow.width + 5;
			m.bgWindow.x = bgX + 28;
			m.bgWindow.y = bgY + 25;
			layer0.addChild( m.bgWindow );
		}
		
		public function removeItem():void {
			
			targetMC.removeChild(layer0 );
			targetMC.removeChild( layer6 );
			targetMC.removeChild(layer1 );
			targetMC.removeChild( layer5 );
			targetMC.removeChild( layer2 );
			targetMC.removeChild( layer3 );
			targetMC.removeChild( layer4 );
			
			layer0 = null;
			layer1 = null;
			layer2 = null;
			layer3 = null;
			layer4 = null;
			layer5 = null;
			layer6 = null;
		}
		public function addText():void {
			
		}
//end
	}
}