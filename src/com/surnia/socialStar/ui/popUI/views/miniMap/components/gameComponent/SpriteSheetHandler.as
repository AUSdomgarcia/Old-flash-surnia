package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author DF
	 */
	public class SpriteSheetHandler extends Sprite implements IEntity 
	{
		private var rect:Rectangle
		private var px:int, py:int;
		private var ppoint:Point = new Point(px, py);
		
		private var canvas:BitmapData;
		private var bm:Bitmap;
		private var rectx:int = 0, recty:int = 0;
		
		private var _sprite:BitmapData;
		private var _spriteRow:int;
		private var _spriteColumn:int;
		private var _spriteSheet:Bitmap;
		
		private var animType:int =0;
		
		public function spriteSheetHandler(spriteSheet:Bitmap, row:int = 1, column:int = 1) 
		{
			_spriteSheet = spriteSheet;
			_sprite = (_spriteSheet).bitmapData
			_spriteRow		= spriteSheet.width / row;
			_spriteColumn	= spriteSheet.height / column;
			
			canvas  = new BitmapData(_spriteRow, _spriteColumn, true, 0xffffffff);
			
			sheetInit();	
			addListeners();			
		}
		
		private function sheetInit():void {
			rect = new Rectangle(rectx, recty, _spriteRow, _spriteColumn);	
			bm = new  Bitmap(canvas)
			addChild(bm);				
		}
		
		public function animationBySingleRow():void {
			animType = 0;			
		}
		
		public function animationByRow():void {
			animType = 1;			
		}
		
		public function animationByColumn():void {
			animType = 2;	
		}
		
		private function animationType(dir:int):void {
			
			if (animType == 0) {
				rect.x = _spriteRow * 0;					
			}
			
			if(animType == 1){
				switch(dir) {
					case 0:
						rect.y = _spriteColumn * dir;					
						
					break;
					case 1:
						rect.y = _spriteColumn * dir;					
						
					break;
					case 2:
						rect.y = _spriteColumn * dir;					
						
					break;
					case 3:					
						rect.y = _spriteColumn * dir;		
						//rect.y = 72;
						
					break;
					
				}				
			}
			
			if (animType == 2) {
				switch(dir) {
					case 0:
						rect.x = _spriteRow * dir;					
					
					break;
					case 1:
						rect.x = _spriteRow * dir;					
						
					break;
					case 2:
						rect.x = _spriteRow * dir;					
						
					break;
					case 3:
						rect.x = _spriteRow * dir;					
						
					break;
					
				}				
			}			
			
			//type 3 is imediately passed to walk method
			animate(animType);
			
		}
		
		private function animate(type:int):void {
			//if animType byRow
			if (type == 0 || type == 1) {
				if (rect.x < _spriteSheet.width) {
					rect.x += _spriteColumn;
				}
				else{
					rect.x = 0;
				}
			}
			
			// if animType byColumn
			if (type == 2) {
				if (rect.y < _spriteSheet.height) {
					rect.y += _spriteRow;
				}
				else{
					rect.y = 0;
				}
			}
			
			//type 3
			if (type == 3) {
				for (var i:int = 0; i < _spriteRow; i++) {
					rect.y = _spriteColumn * i;
					rect.x = 0;
					
					if (rect.x < _spriteSheet.width) {
						rect.x += _spriteColumn;
					}					
				}
			}			
		
		}
		public function animateSprite(direction:int = 0):void {			
			if (animType == 0) {
				animationType(direction);
			}
			else {
				animationType(direction);
			}			
		}
		public function render():void {
			canvas.copyPixels(_sprite, rect, ppoint);			
		}
		
		//IENTITY implement methods
		public function addListeners():void {
		
		}
		
		public function removeListeners():void {
			
		}
		
		public function setXY(X:int, Y:int):void {
			this.x = X;
			this.y = Y;
		}
		
		public function get getXY():Point {
			var pt:Point;
			
			pt.x = this.x;
			pt.y = this.y;
			
			return pt;
		}
	}

}