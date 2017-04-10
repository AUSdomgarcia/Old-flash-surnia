package com.surnia.socialStar.test 
{	
	import com.adobe.serialization.json.JSON;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author JC
	 */
	public class ServerDataControllerTest extends Sprite
	{
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties---------------------------------------------------------------------*/
		private var _sdc:ServerDataController;
		private var _es:EventSatellite;
		/*----------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		
		public function ServerDataControllerTest() 
		{
			_es = EventSatellite.getInstance();
			//_es.addEventListener( ServerDataControllerEvent.PLAYER_COIN_CHANGE, onPlayerCoinChange );	
			//_es.addEventListener( ServerDataControllerEvent.PLAYER_EXPERIENCE_CHANGE, onPlayerExpChange );
			_es.addEventListener( ServerDataControllerEvent.BUY_OFFICE_ITEM_COMPLETE, onBuyComplete );
			
			_sdc = ServerDataController.getInstance();
			
			//add coin
			//_sdc.setPlayerCoin( 10 );
			
			//subtract coin
			//_sdc.setPlayerCoin( -8 );
			
			//_sdc.setPlayerExperience(  100 );
			//_sdc.setPlayerExperience(  20 );
			//_sdc.setBgm( "0" );
			//_sdc.setBgm( "1" );
			
			//_sdc.updateAp();
			
			
			/*
			var data:Array = new Array();
			var gameHistory:Array = new Array();
			var toJson:Array = new Array();
			
			var obj:Object;
			var states:Array = [ "hit", "miss" ];
			var leaders:Array = [ "user", "ai" ];
			var rnd:int = ( Math.random() * 2 ) + 1;
			var prop:Array = [ "name", "state", "xp","ap", "coin", "leader" ];
			
			
			for (var i:int = 0; i < 5; i++) 
			{				
				obj = new Object();
				obj.name = "runningman";
				rnd = Math.floor( Math.random() * 2 );
				obj.state = states[ rnd ];
				obj.xp = "1";
				obj.ap = "2";
				obj.coin = "2";
				rnd = Math.floor( Math.random() * 2 );
				obj.leader = leaders[ rnd ];
				gameHistory.push( obj );
			}
			*/
			
			
			//for (var j:int = 0; j < gameHistory.length; j++) 
			//{
				//for (var k:int = 0; k < prop.length; k++) 
				//{
					//toJson[ prop[ k ] ] = gameHistory[ j ].name;
				//}				
			//}
			
			//trace( "jsonko: ",JSON.encode( toJson ) );
			
			//data[ 'name' ] = gameHistory[ 0 ].name;
			//data[ 'state' ] = gameHistory[ 0 ].state;
			//data[ 'xp' ] = gameHistory[ 0 ].exp;
			//data[ 'ap' ] = gameHistory[ 0 ].ap;
			//data[ 'coin' ] = gameHistory[ 0 ].coin;
			//data[ 'leader' ] = gameHistory[ 0 ].coin;
			
			//trace( "json", JSON.encode( gameHistory) );
			//_variables.data = JSON.encode( data);
			//_sdc.setReward();
			//_sdc.buyItem( "97jNSX3VVg4dextxjNC" );
			
			//_sdc.askFriend( "nfcaller", "wallpost/askcoin" );
			//_sdc.askFriend( "wallpost", "askcoin" );
			
			//_sdc.dropCoin( "sasas", 50 );
			
			_sdc.getInventoryList();
			
			
			/*
			var arrObj1:Array = new Array();
			var obj1:Object;
			for (var i:int = 0; i < 5; i++) 
			{
				obj1 = new Object();
				obj1.name = "ha" + i;
				obj1.cid = "c1" + i;				
				arrObj1.push( obj1 );				
			}
			
			
			var arrObj2:Array = new Array();
			var obj2:Object;
			for (var j:int = 0; j < 5; j++) 
			{
				obj2 = new Object();
				obj2.name2 = "he" + j;
				obj2.cid2 = "c2" + j;				
				arrObj2.push( obj2 );				
			}
			
			var arrObj3:Array = new Array();
			var obj3:Object;
			for (var k:int = 0; k < 5; k++) 
			{
				obj3 = new Object();
				obj3.name3 = "hi" + j;
				obj3.cid3 = "c3" + j;				
				arrObj3.push( obj3 );				
			}

			
			var arr:Array = new Array();
			arr.push( arrObj1 );
			arr.push( arrObj2 );
			arr.push( arrObj3 );			
			
			//var c:int;
			//for each ( var e:* in arr ) 
			//{				
				//for ( var l:* in e ) 
				//{		
					//if( c <= 4 ){
						//trace( "l", l, e[ l ].name );
					//}
					//
					//if( c <= 9 && c >= 5 ){
						//trace( "l", l, e[ l ].name2 );
					//}
					//
					//if( c <= 14 && c >= 10 ){
						//trace( "l", l, e[ l ].name3 );
					//}
					//
					//c++;
				//}				
			//}
			
			
			var Json:String = JSON.encode( arr );
			trace( "see json", Json );
			
			var json2:Object = JSON.decode( Json );
			
			trace( "json2", json2 );
			
			
			for ( var prop:* in json2 ) 
			{
				trace( "decoded", prop, json2[ prop ].name );				
			}
			
			var c:int;
			for each ( var e:* in json2 ) 
			{				
				for ( var l:* in e ) 
				{		
					if( c <= 4 ){
						trace( "l_see", l, e[ l ].name );
					}
					
					if( c <= 9 && c >= 5 ){
						trace( "l_see", l, e[ l ].name2 );
					}
					
					if( c <= 14 && c >= 10 ){
						trace( "l_see", l, e[ l ].name3 );
					}
					
					c++;
				}				
			}			
			*/
		}
		
		private function onPlayerExpChange(e:ServerDataControllerEvent):void 
		{
			trace( "added exp: ", e.obj.te );			
		}
		
		
		/*----------------------------------------------------------------------Properties------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		private function onPlayerCoinChange(e:ServerDataControllerEvent):void 
		{
			trace( "player coin change:", e.obj );
		}
		
		private function onBuyComplete(e:ServerDataControllerEvent):void 
		{
			//entryId
			trace( "e server buy complete objId", e.obj.entryid );
			//_itemObj.entryId = e.obj.entryId;
			//trace( "on Buy complete:............>> ", _itemObj.entryId, _itemObj.pos, _itemObj.id, _itemObj.cat );
			//_es.dispatchESEvent( _ofcShopUIEvent , _itemObj );			
			//_popUpUiManager.removeCurrentWindow();
		}
		
		private function onBuyFailed(e:ServerDataControllerEvent):void 
		{
			trace( "on Buy Failed.................................................... ^^)) " );
			//todo
			//call oopsy server data sync erro
		}
		
	}

}