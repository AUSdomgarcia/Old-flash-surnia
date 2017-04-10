package com.surnia.socialStar.ui.popUI.views 
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.data.MinimapCharacterListModel;
	import com.surnia.socialStar.ui.popUI.events.MiniMapPopUpDialogEvent;
	import com.surnia.socialStar.ui.popUI.events.XMLEvent;
	
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class MinimapCharacterListManager extends Sprite
	{
		
		private var model:MinimapCharacterListModel;
		private var _parent:Sprite;
		private var closeMap:MiniMapPopUpDialogEvent;
		private var headDef_arr:Array = [];
		private var maskingShape:Shape;
		private var masking_arr:Array = [];
		private var index:Number = 0;
		private var arrList:Array = [];
		private var headDef_str:String;
		
		//info
		private var hairColor:String;
		private var charName:String;
		private var charID:String;
		private var level:Number = 0;
		private var exp:Number = 0;
		private var genderHolder:String;
		private var charDef:String;
		private var str:Number = 0;
		private var sing:Number = 0;
		private var rank:Number = 0;
		private var attract:Number = 0;
		private var acting:Number = 0;
		private var intellingent:Number = 0;
		
		private var hair:Number;
		private var eye:Number;
		private var nose:Number;
		private var jaw:Number;
		private var lips:Number;
		private var ears:Number;
		
		
		private var currIndex:Number;
		
		
		public function MinimapCharacterListManager( $m:MinimapCharacterListModel, $pt:Sprite ) 
		{
			_parent = $pt;
			model = $m;
			initBg();
			listenEventSatellite();
		}
		private function listenEventSatellite():void {
			EventSatellite.getInstance().addEventListener(SSEvent.CHARLISTXML_LOADED, onLoaded);
		}
		
		private function onLoaded( ev:SSEvent ):void {
			if ( model.faceHolder_arr != null ) {
				model.faceHolder_arr = [];
			}
			
			for (var i:int = 0; i < GlobalData.instance.characterListDataXML.char.length(); i++) 
			{
				// getting head definition
				headDef_arr[i] =  GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_DEFINITION];
				// creating mask
				maskingShape = new Shape();
				maskingShape.graphics.lineStyle();
				maskingShape.graphics.beginFill(0x4BBA1D,1);
				maskingShape.graphics.drawRect(0,0,65,57);
				maskingShape.graphics.endFill();
				masking_arr[i] = maskingShape;
			
					// Getting right assets
					if( GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GENDER] == XMLEvent.HEAD_DEF_MALE ){
						model.faceHolder_mc = new AVATARMALE();
						model.faceHolder_arr.push( model.faceHolder_mc );
					} 
					if ( GlobalData.instance.charListDataArray[i][GlobalData.CHARLIST_GENDER] == XMLEvent.HEAD_DEF_FEMALE ) {
						model.faceHolder_mc = new FEMALE_AVATARs();
						model.faceHolder_arr.push( model.faceHolder_mc );
					}
			}
					// Listeners
					if ( model.faceHolder_arr.length < 7 ) {
						removeListener();
					}else {
						addListener();
					}
			displayList( index );
		}
		
		private function initBg():void {
			initButtonAndBackground();
			addItem();
			// SAMPLE FOR DISPATCH VALUES
			model.addEventListener( "VALUES_READY" , onXMLLoaded);
		}
		
		private function onXMLLoaded( e:Event ):void {
			
		}
		
		public function initButtonAndBackground():void {
			//bg
			model.listBg.x = ( GameConfig.GAME_WIDTH / 2 ) - model.listBg.width / 2;			
			model.listBg.y =  540;
			//buttons
			model.closeBtn.x = model.listBg.x + 560;
			model.closeBtn.y = model.listBg.y;
			
			model.btnRight.x = model.listBg.x + 510;
			model.btnRight.y = 570;
			model.btnLeft.x = model.listBg.x + 6;
			model.btnLeft.y = 570;
		}
		
		private function addItem():void {
			addChild( model.listBg );
			addChild( model.btnRight );
			addChild( model.btnLeft );
			addChild( model.closeBtn );
			
		}
		
		private function removeItem():void {
			removeChild( model.listBg );
			removeChild( model.btnRight );
			removeChild( model.btnLeft );
			removeChild( model.closeBtn );
		}
		
		private function addListener():void {
			
			model.btnLeft.addEventListener(MouseEvent.MOUSE_DOWN, onDown, false, 0, true);
			model.btnRight.addEventListener(MouseEvent.MOUSE_DOWN, onDown, false, 0, true);
			model.btnLeft.addEventListener(MouseEvent.MOUSE_UP, onUP, false, 0, true);
			model.btnRight.addEventListener(MouseEvent.MOUSE_UP, onUP, false, 0, true);
			
			model.closeBtn.addEventListener( MouseEvent.ROLL_OUT, onCRollout, false, 0, true);
			model.closeBtn.addEventListener( MouseEvent.CLICK, onCExit , false, 0, true);			
			model.closeBtn.addEventListener( MouseEvent.ROLL_OVER, onCRollover, false, 0, true);
			
		}
		
			private function removeListener():void {
			
			model.btnLeft.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			model.btnRight.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			model.btnLeft.removeEventListener(MouseEvent.MOUSE_UP, onUP);
			model.btnRight.removeEventListener(MouseEvent.MOUSE_UP, onUP);
			
			model.closeBtn.removeEventListener( MouseEvent.ROLL_OUT, onCRollout);
			model.closeBtn.removeEventListener( MouseEvent.CLICK, onCExit);			
			model.closeBtn.removeEventListener( MouseEvent.ROLL_OVER, onCRollover);
			
		}
		
		//------------------------------------------------------ METHODS ------------------------------------------------------------
		private function tintColor(mc:Sprite, colorNum:Number, alphaSet:Number):void {
			var cTint:Color = new Color();
			cTint.setTint(colorNum, alphaSet);
			mc.transform.colorTransform = cTint;
		}
		
		public function displayList( index:Number ):void {
			
			arrList = new Array( "hMC0", "hMC1", "hMC2", "hMC3", "hMC4", "hMC5");
			for ( var i:int = 0; i < arrList.length ; i++ )
			{	

				if( index >= model.faceHolder_arr.length ) {
					break;
				}
					masking_arr[i].x = model.listBg[ arrList[i] ].x;
					masking_arr[i].y = model.listBg[ arrList[i] ].y;
					
					/* INCLUDE LIMITATION FOR EXTRA GRAPHICS( only hair is updated )
					* hat, earings
					*/
					/*
					if ( headDef_arr[ index ].substr(0, 2) == 00  ) {
						model.faceHolder_arr[ index ].FHAIR.visible = false;
						model.faceHolder_arr[ index ].BHAIR.visible = false;
					}else {
						model.faceHolder_arr[ index ].FHAIR.visible = true;
						model.faceHolder_arr[ index ].BHAIR.visible = true;
					}
					*/
					
					model.faceHolder_arr[ index ].x = model.listBg[ arrList[i] ].x + 2;
					model.faceHolder_arr[ index ].y = model.listBg[ arrList[i] ].y + 2;
					
					//mask
					model.faceHolder_arr[ index ].mask = masking_arr[i];
					model.listBg.addChild( model.faceHolder_arr [ index ] );
					model.listBg.addChild( masking_arr[i] );
					
					//http://www.colorcombos.com/color-scheme-279.html
					
					model.faceHolder_arr[ index ].FHAIR.gotoAndStop( headDef_arr[ index ].substr(0, 2) );	
					tintColor( model.faceHolder_arr[ index ].FHAIR, parseInt( headDef_arr[ index ].substr(2, 6),16) , .8);
					
					model.faceHolder_arr[ index ].BHAIR.gotoAndStop( headDef_arr[ index ].substr(0, 2) );
					tintColor( model.faceHolder_arr[ index ].BHAIR, parseInt( headDef_arr[ index ].substr(2, 6),16) , .8);
					
					model.faceHolder_arr[ index ].EYE.gotoAndStop( headDef_arr[ index ].substr(0, 2) );
					
					model.faceHolder_arr[ index ].NOSE.gotoAndStop( headDef_arr[ index ].substr(4, 2) );
					model.faceHolder_arr[ index ].FSHAPE.gotoAndStop( headDef_arr[ index ].substr(6, 2) );
					model.faceHolder_arr[ index ].LIP.gotoAndStop( headDef_arr[ index ].substr(8, 2) );
					
					/*
					obj['hair'] = parseInt(description.substr(0,2),16);
					*/
					model.faceHolder_arr[ index ].addEventListener( MouseEvent.CLICK, onSelected );
					index++;	
			} 
		}
		
		private function clearDisplay( index:Number ):void {
			for(var i:Number = 0; i < arrList.length; i++){
					model.listBg.removeChild( model.faceHolder_arr [ index ] );
					index++;
					model.faceHolder_arr[ index ];
				}
		}
		
		private function onCRollover( e:MouseEvent ):void {
			model.closeBtn.scaleX = 1.2;
			model.closeBtn.scaleY = 1.2;
			model.closeBtn.x = model.closeBtn.x - 10;
			model.closeBtn.gotoAndStop(2);
		}
		
		private function onSelected( e:Event ):void {
		/* 	for (var i:int = 0; i < model.faceHolder_arr.length; i++) 
			{
				if ( e.currentTarget == model.faceHolder_arr[i] )
				currIndex = i; 
			}
				//Dispatch Values
				headDef_str = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_DEFINITION ];
				genderHolder = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_GENDER ];
				charID = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_CID ];
				level =  GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_LEVEL ];
				exp =  GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_EXP ];		
				charName = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_NAME ];
				str = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_STRENGTH ];
				sing = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_SING ];
				rank = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_RANK ];
				attract = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_ATTRACTION ];
				acting = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_ACTING ];
				intellingent = GlobalData.instance.charListDataArray[ currIndex ][ GlobalData.CHARLIST_INTELLIGENCE ];
				
				
				hair = headDef_arr[ currIndex ].substr(0, 2);
				hairColor = headDef_arr[ currIndex ].substr(2, 6);
 				eye = headDef_arr[ currIndex ].substr(0, 2);
				jaw = headDef_arr[ currIndex ].substr(6, 2);
				nose = headDef_arr[ currIndex ].substr(4, 2);
				lips = headDef_arr[ currIndex ].substr(8, 2);
				ears = headDef_arr[ currIndex ].substr(0, 2);
				
				/*ac0 = headDef_arr[ currIndex ].substr(0, 2);
				ac1 = headDef_arr[ currIndex ].substr(0, 2);
				ac2 = headDef_arr[ currIndex ].substr(0, 2);
				
					
				var facevalue:XMLEvent = new XMLEvent( XMLEvent.LOAD_XML_VALUES);
				
				facevalue.obj.Hair = hair; 
				facevalue.obj.hairColor = hairColor;
				
				facevalue.obj.Eye = eye;
				facevalue.obj.Jaw = jaw;
				facevalue.obj.Nose = nose;
				facevalue.obj.Lips = lips;
				facevalue.obj.Ears = ears;
				facevalue.obj.headDef_str = headDef_str;
				

				facevalue.obj.genderHolder = genderHolder;
				facevalue.obj.charID = charID;
				facevalue.obj.level = level;
				facevalue.obj.exp = exp;
				facevalue.obj.charName = charName;
				facevalue.obj.str = str
				facevalue.obj.sing = sing;
				facevalue.obj.rank = rank;
				facevalue.obj.attract = attract;
				facevalue.obj.acting = acting;
				facevalue.obj.intellingent = intellingent;
				facevalue.obj.intellingent = intellingent;
				_parent.dispatchEvent(facevalue );
				
		*/
		}
		
		private function onCExit( e:MouseEvent):void {
			closeMap = new MiniMapPopUpDialogEvent( MiniMapPopUpDialogEvent.CLICKED_CLOSE_MAP );
			closeMap.obj.str = "closeMapUI";
			_parent.dispatchEvent( closeMap )
			model.closeBtn.gotoAndStop(1);
			
		}
		
		private function onCRollout( e:MouseEvent ):void {
			model.closeBtn.gotoAndStop(1);
			model.closeBtn.scaleX = 1;
			model.closeBtn.scaleY = 1;
			model.closeBtn.x = model.closeBtn.x + 10;
		}
		
		private function onDown( e:MouseEvent ):void {
			clearDisplay( index );
			switch( e.currentTarget ) {
					case model.btnLeft :
					 model.btnLeft.gotoAndStop(2);
					 if( index > 0 )
						index--;
					
					break;
					
					case model.btnRight :
					model.btnRight.gotoAndStop(2);
					if( index <= model.faceHolder_arr.length - 7){
						index++;
					}
					
					break;
			}
			displayList(index);
		}
		
		private function onUP( e:MouseEvent ):void {
			
			switch( e.currentTarget ) {
					case model.btnLeft :
					 model.btnLeft.gotoAndStop(1);
					break;
					case model.btnRight :
					model.btnRight.gotoAndStop(1);
					break;
			}
		}
		
		
//end
	}
}