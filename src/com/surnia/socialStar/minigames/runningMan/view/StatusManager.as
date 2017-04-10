package com.surnia.socialStar.minigames.runningMan.view 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.surnia.socialStar.minigames.runningMan.model.StatusModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author domz
	 */
	public class StatusManager extends Sprite
	{
		private var m:StatusModel;
		private var targetMc:Sprite;
		private var isLive:Boolean;
		private var _x:Number;
		private var _y:Number;
		private var isStatusShow:Boolean = false;
		private var statusCtr:Number = 0;
		private var _numX:Number = 0;
		private var _numY:Number = 0;
													// just check if live or not to display status
		public function StatusManager( _m:StatusModel , _isLive:Boolean, x:Number, y:Number, _sp:Sprite ) 
		{
			_x = x;
			_y = y;
			
			targetMc = _sp;
			m = _m;
			isLive = _isLive;
			init();
			
		}
		
		public function getStatus( index:Number, XposDefault:Number, YposDefault:Number, yPosDestination:Number ):void {
			_numY = yPosDestination;
			_numX = XposDefault;
			switch( index ) {
				case 0:
				m.sprHolder = new Sprite();
				m.goodMc = new StatusGood();
				m.sprHolder.addChild(m.goodMc);
				isStatusShow = true;
				break;
				case 1:
				m.sprHolder = new Sprite();
				m.missMc = new StatusMiss();
				m.sprHolder.addChild(m.missMc);
				isStatusShow = true;
				break;
				case 2:
				m.sprHolder = new Sprite();
				m.perfectMc = new StatusPerfect();
				m.sprHolder.addChild(m.perfectMc);
				isStatusShow = true;
				break;
			}
			
			m.sprHolder.x = XposDefault;
			m.sprHolder.y = YposDefault;
			m.showStatusHolder_arr.push(m.sprHolder);
			isStatusShow = true;
		}	
		
		public function updateStatusShow():void {
			if( isStatusShow ) {
				for (var i:int = 0; i < m.showStatusHolder_arr.length; i++) 
				{
					targetMc.addChild( m.showStatusHolder_arr[i] );
					TweenLite.to( m.sprHolder , 1, { x: x + _numX, y: _numY, alpha: 0 } );
					
					if ( m.showStatusHolder_arr[i].y == _numY ) {
						targetMc.removeChild( m.showStatusHolder_arr[i] );
						m.showStatusHolder_arr.splice( i , 1 );
					}
				}
			}
		}
		
		private function init():void {
			//Check for stutus
			m.statusMC.x = _x + 60;
			m.statusMC.y = _y + 40;
			
			if (isLive) {
				m.statusMC.visible = isLive;
				//targetMc.addChild( m.statusMC ); /
			}else {
				m.statusMC.visible = isLive;
				//targetMc.addChild( m.statusMC );
			}
			
			m.glovesMc = new glovesUI();
			m.glovesMc.x = _x + 290;
			m.glovesMc.y = _y + 86;
			//targetMc.addChild( m.glovesMc );
			
			
			
			var txtFormat:TextFormat = new TextFormat();
			var glow:GlowFilter = new GlowFilter();
			
			glow.color = 0xFE702C;
			glow.alpha = 1;
			glow.blurX = 5;
			glow.blurY = 5;
			glow.quality = 1;
			m.roundStatic.filters = [glow];
			
			txtFormat.color = 0xFFFF00;
			txtFormat.size = 18;
			txtFormat.font = "Arial Bold";
			txtFormat.align = "center";		
			
			m.roundStatic.defaultTextFormat = txtFormat;
			m.roundStatic.width = 100;
			m.roundStatic.height = 300;
			
			m.roundStatic.selectable = false;
			m.roundStatic.x = _x + 270;
			m.roundStatic.y = _y + 40;
			//targetMc.addChild( m.roundStatic );
			
			
			var txtFormat2:TextFormat = new TextFormat();
			var glow2:GlowFilter = new GlowFilter();
			
			glow2.color = 0x000000;
			glow2.alpha = 1;
			glow2.blurX = 5;
			glow2.blurY = 5;
			glow2.quality = 1;
			m.weekTxt.filters = [glow2];
			
			txtFormat2.color = 0xFFFFFF;
			txtFormat2.size = 18;
			txtFormat2.font = "Arial Bold";
			txtFormat2.align = "center";
			
			m.weekTxt.defaultTextFormat = txtFormat2;
			m.weekTxt.selectable = false;
			m.weekTxt.x = _x + 500;
			m.weekTxt.y = _y + 30;
			//targetMc.addChild( m.weekTxt );
			
		}
		
		public function removeStatus():void {
			//targetMc.removeChild( m.statusMC );
			//targetMc.removeChild( m.glovesMc );
			//targetMc.removeChild( m.roundStatic );
			//targetMc.removeChild( m.weekTxt );
		}
		
		public function set setWeekText( str:String ):void {
			m.weekTxt.text = str;
			
		}
		
		public function set setRoundText( str:String ):void {
			m.roundStatic.text = str;
		}

//end
	}
}