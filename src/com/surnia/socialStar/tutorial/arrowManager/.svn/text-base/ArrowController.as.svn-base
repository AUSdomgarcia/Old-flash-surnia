package com.surnia.socialStar.tutorial.arrowManager 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.components.ArrowGuide;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ArrowController extends Sprite
	{
		/*-------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private var _es:EventSatellite;
		private var _arrowGuide:ArrowGuide;
		private var _gd:GlobalData;
		/*-------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		
		public function ArrowController() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			_es.addEventListener( TutorialEvent.SHOW_ARROW_GUIDE, onShowArrowGuide );
			_es.addEventListener( TutorialEvent.SHOW_ARROW_GUIDE_SHOP_BTN, onShowShopBtnArrow );			
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
		}			
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeArrowGuide();
		}
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/
		
		private function showArrowGuide( dir:int, xPos:int, yPos:int ):void 
		{
			_arrowGuide = new ArrowGuide( dir, xPos, yPos );
			addChild( _arrowGuide );
		}
		
		private function removeArrowGuide():void 
		{
			if ( _arrowGuide != null ) {
				if ( this.contains( _arrowGuide ) ) {
					this.removeChild( _arrowGuide );
					_arrowGuide = null;
				}
			}
		}
		
		/*-------------------------------------------------------------Setters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters--------------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
		private function onShowArrowGuide(e:TutorialEvent):void 
		{
			showArrowGuide( e.obj.dir, e.obj.x, e.obj.y );
		}
		
		private function onShowShopBtnArrow(e:TutorialEvent):void 
		{
			trace( "[Arrow Controller]", _gd.shopBtnXyPos.x, _gd.shopBtnXyPos.y );
			var p:Point = globalToLocal( new Point( _gd.shopBtnXyPos.x, _gd.shopBtnXyPos.y ) );
			//showArrowGuide( 2, _gd.shopBtnXyPos.x, _gd.shopBtnXyPos.y );
			showArrowGuide( 2, p.x, p.y );
		}
	}

}