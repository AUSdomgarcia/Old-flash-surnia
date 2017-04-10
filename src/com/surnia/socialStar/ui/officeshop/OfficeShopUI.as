package com.surnia.socialStar.ui.officeshop
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenLite;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.imageExtractor.events.ImageExtractorEvent;
	import com.surnia.socialStar.controllers.imageExtractor.ImageExtractor;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import flash.text.AntiAliasType;
	//import com.surnia.socialStar.minigames.MovieGame.MovieGameController;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.officeshop.OfficeShopUIEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.views.display.IsoRoomEvent;
	import com.surnia.socialStar.views.isoObjects.data.IsoObjectData;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import Staff_fla.StaffDeskMC_8;
	
	/**
	 * ...
	 * @author Andrew Trinanes
	 * 8/18/2010
	 */
	
	public class OfficeShopUI extends Sprite 
	{
		private var mainCont:ContainerMain;
		private var pop:PopUP = new PopUP;
		private var itemBox:Array = new Array();
		private var categoryTab:Array = new Array();
		private var imageCont:Array = new Array();
		private var currentCategory:uint = 7;
		private var currentPage:uint;
		
		private var globalLevel:uint = 0;
		private var globalCoin:uint = 0;
		private var globalStar:uint = 0;
		// switched to expansion
		private var globalExpansion:int = GlobalData.instance.expansion;
		
		private var _es:EventSatellite;
		private var _ofcShopUIEvent:OfficeShopUIEvent;
		private var _imageExtractor:ImageExtractor;
		
		//vonline
		private var _isOnline:Boolean = true;
		private var firstrun:Boolean = false;
		
		public var objCat:String = "";
		public var objPos:String = "";
		
		//new
		private var _popUpUiManager:PopUpUIManager;
		private var _sdc:ServerDataController;
		private var _gd:GlobalData;
		
		private var itemNum:int = 0;
		private var gAllItems:Array = new Array();
		/*------------
		 * CONSTANTS
		 * ----------*/
		public static const ON_CLOSE:String = "on_close";
		private var _itemObj:Object;
		private var _isoObjectData:IsoObjectData;
		private var _itemData:Object;
		private var _fontManager:FontManager;
		
		
		public function OfficeShopUI():void 
		{
			_fontManager = FontManager.getInstance();
		}
		//FInit
		public function init():void 		
		{	
			_gd = GlobalData.instance;
			_es = EventSatellite.getInstance();
			//_es.addEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_COMPLETE, checkOwnItemComplete );
			//_es.addEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED, checkOwnItemFailed );
			
			_sdc = ServerDataController.getInstance();
			
			_es.addEventListener( ServerDataControllerEvent.BUY_OFFICE_ITEM_FAILED, onBuyFailed );
			_popUpUiManager = PopUpUIManager.getInstance();
		
			loadUI();
			loadItemContainer();

			addChild(pop);
			pop.visible = false;			
			populate(currentCategory, currentPage)			
			
			var isoRoomEvent:IsoRoomEvent = new IsoRoomEvent( IsoRoomEvent.ON_STOP_ISO_OFFICE_PAN );
			_es.dispatchESEvent( isoRoomEvent );
		}								
		
		private function loadPlayerStat(status:Boolean): void {			
			var runingOn:String = Capabilities.playerType;
			
			if ( runingOn != 'StandAlone' ) {
				trace( "officeshop ui: running online load real assets............................." );
				globalStar = GlobalData.instance.pSp;
				globalCoin = GlobalData.instance.pCoin;
				globalLevel = GlobalData.instance.pLvl;  
				globalExpansion = GlobalData.OFFICESTATE_DIMENSION;
			}else {
				trace( "officeshop ui: running offline loading temp assets............................." );
				globalLevel = 99; //Local
				globalCoin = 1000;
				globalStar = 100;
				globalExpansion = 10;
				firstrun = false;
				trace("Status:DEF C:[" + globalCoin + "] S:[" + globalStar + "] E:[" + globalExpansion + "] L:[" + globalLevel+"]");
			}
			//stats!
		}
		
		//FLoadItemContainer
		private function loadItemContainer():void {
			var spacer:int = 35;
			
			for (var i:int = 0; i <=7 ; i++) {
				itemBox[i] = new ContainerItem();
				imageCont[i] = new Icons();
				
				mainCont.addChild(itemBox[i]);
			    if (i <= 3) {
					itemBox[i].y = 170;
					itemBox[i].y = 170;
					itemBox[i].x = spacer +20;

				}else {
					if (i ==  4) {
						spacer = 35
						
					}
					itemBox[i].y = 180 + itemBox[i].height;
					itemBox[i].x = spacer +20;

				}
				spacer += itemBox[i].width + 5;
				itemBox[i].addEventListener(MouseEvent.ROLL_OVER, mouseOver);
				itemBox[i].addEventListener(MouseEvent.ROLL_OUT, mouseOut);
				itemBox[i].imageHolder.addChild(imageCont[i]);
				imageCont[i].gotoAndStop(1);
				imageCont[i].x = ( itemBox[i].imageHolder.width / 2 ) - 10;
				imageCont[i].y = 0;
				itemBox[i].visible = false;
			}
			trace("BU: Item Container Load Complete");
		}
		
		//FUI
		private function loadUI():void {
			var spacer:int = 10;
			mainCont = new ContainerMain();
			addChild(mainCont);
			mainCont.closeButton.addEventListener(MouseEvent.CLICK, closeBuildShop);
			mainCont.nextButton.gotoAndStop(1);
			mainCont.prevButton.gotoAndStop(1);
			// x01
			for (var i:int = 0; i <= 7; i++) {
				categoryTab[i] = new CategoryButtons();
				mainCont.addChild(categoryTab[i]);
				categoryTab[i].gotoAndStop(i + 1);
				categoryTab[i].y = 90;
				categoryTab[i].x = spacer + 38;
				spacer += categoryTab[i].width + 10
				categoryTab[i].name = "tab_" + i;
				categoryTab[i].addEventListener(MouseEvent.CLICK, catClick);
			}
			//needs name etc
			//catArray[currentCategory].active.gotoAndStop(2);
			
			trace("BU: Tabs Loaded");
			updateCategory(currentCategory);
		}
		
		//FupdateCategory
		private function updateCategory(cat:int):void {
			var len:int = categoryTab.length;
			for (var i:int = 0; i < len  ; i++) {
				if (i == cat) {
					categoryTab[i].y = 80;
					categoryTab[i].removeEventListener(MouseEvent.CLICK, catClick);
					categoryTab[i].removeEventListener(MouseEvent.ROLL_OVER, catHover);
					categoryTab[i].removeEventListener(MouseEvent.ROLL_OUT, catOut);
				}else {
					categoryTab[i].y = 90;
					categoryTab[i].addEventListener(MouseEvent.CLICK, catClick);
					categoryTab[i].addEventListener(MouseEvent.ROLL_OVER, catHover);
					categoryTab[i].addEventListener(MouseEvent.ROLL_OUT, catOut);
				}
			}
		}
		
		//MEClose
		private function closeBuildShop(e:MouseEvent):void {
			_popUpUiManager.removeCurrentWindow();
		}
		
		//FPopulate
		private function populate(category:int, position:int):void {			
			loadPlayerStat(_isOnline);
			var name:String = ""; 
			var type:String;
			var desc:String;
			var id:String;
			var req:String;
			var catname:String;

			var price:int;
			var pos:uint = (position * 8) ;
			var content:uint = 7;
			var totalItems:uint;
			var total:uint;
			var max:uint;
			var allItems:Array = [];
			
			if (category == 7) {
				var cter:int = 0;
				for (var m:int = 0; m < 7; m++) {
					var count:int = GlobalData.instance.officeStoreDataArray[m].length;
					for(var z:int = 0; z < count; z++){
						allItems.push(GlobalData.instance.officeStoreDataArray[m][z]);
						trace("ITM:"+cter+" \\"+allItems[cter]);
						cter++;
					}
				}
				
				if (itemNum == 0) {
					itemNum = cter;
					gAllItems = allItems;
				}
				
				totalItems = allItems.length;
				total = allItems.length - pos;
				max = allItems.length / 8;
				
				//totalItems = allItems.length-1;
				//total = allItems.length-1 - pos;
				//max = allItems.length / 8;
				
			}else{
				totalItems = GlobalData.instance.officeStoreDataArray[category].length;
				total = GlobalData.instance.officeStoreDataArray[category].length - pos;
				max = GlobalData.instance.officeStoreDataArray[category].length  / 8;
			}
			
			var isoObjectData:IsoObjectData;			
			trace("Generating Boxes:"+total)
			for (var i :int = 0 ; i <= 7; i++) {
				itemBox[i].visible = true;
				itemBox[i].buyButton.addEventListener(MouseEvent.CLICK, buyMenu);
				itemBox[i].buyButton.visible = true;
				
			}
			
			// Edit Here!
			
			for ( i = 0; i <=7; i++) 
			{
				if (category == 7) {
					if (i < total) {
						id = allItems[pos + i][GlobalData.OFFICESTORE_ID];
						isoObjectData = GlobalData.instance.extactData( null, id  );
						name = isoObjectData.name;
						desc = isoObjectData.desc;
						req = String( isoObjectData.unlocklevel );
						type = String(returnPriceAll(allItems, pos + i).substr(0, 2));
						catname = allItems[pos + i][GlobalData.OFFICESTORE_TYPE];
						price = Number(returnPriceAll(allItems, pos + i).substr(2, 5));
						//todoprice
						//typecheck
						
						switch (type) 
						{
							case "ST":  //star only
								itemBox[i].gotoAndStop(2);
									if (price > globalStar) {
										itemBox[i].itemOther.textColor = 0xFF0000;
									}else  {
										itemBox[i].itemOther.textColor = 0x000000;
									}
								itemBox[i].itemOther.text = price;
							break;
							case "CN":   //coin only
								itemBox[i].gotoAndStop(1);
								if (price > globalCoin) {
										itemBox[i].itemPrice.textColor = 0xFF0000;
									}else  {
										itemBox[i].itemPrice.textColor = 0x000000;
									}
								itemBox[i].itemPrice.text = price;
							break;
							
							case "BT":   //both coin and star
								itemBox[i].gotoAndStop(3);
								if (price > globalCoin) {
										itemBox[i].itemPrice.textColor = 0xFF0000;
									}else  {
										itemBox[i].itemPrice.textColor = 0x000000;
									}
								//trace("HOOOOOOOOOOOOOOOOOOOOOOOOOY" +globalStar+ GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR]);
								if (allItems[pos + i][GlobalData.OFFICESTORE_STAR] > globalStar) {
										itemBox[i].itemOther.textColor = 0xFF0000;
									}else  {
										itemBox[i].itemOther.textColor = 0x000000;
									}
								
								itemBox[i].itemPrice.text = price;
								itemBox[i].itemOther.text = uint(allItems[pos + i][GlobalData.OFFICESTORE_STAR]);
								//itemBox[i].buyButton.removeEventListener(MouseEvent.CLICK, buyMenu);
								trace("Disabled");
								if (category == 5) {
									trace("Current Expansion:" + globalExpansion);
									itemBox[i].itemOther.text = uint(allItems[pos + i][GlobalData.OFFICESTORE_STAR]) * globalExpansion;
									itemBox[i].itemPrice.text = uint(allItems[pos + i][GlobalData.OFFICESTORE_COIN]) * globalExpansion;
									}
							break;
							
							case "NA":
									itemBox[i].itemPrice.text = price;							
									itemBox[i].gotoAndStop(4);
							break;
							case "0":
							itemBox[i].buyButton.visible = false;
							itemBox[i].itemPrice.text = price;
							break;
							
							default:								
							break;
						}
					
						if (globalLevel >= uint(req)) {
							itemBox[i].itemReq.alpha = 0;
						}else {
							itemBox[i].itemReq.alpha = .8;
							itemBox[i].gotoAndStop(4);
							itemBox[i].itemReq.text = "Require\nlv. " + req;
							itemBox[i].buyButton.removeEventListener(MouseEvent.CLICK, buyMenu);
							trace("Disabled");
						}
						
						//end
						itemBox[i].itemName.text = name;
						itemBox[i].itemDesc.text = desc;
						itemBox[i].itemID.text = id;
						itemBox[i].itemPos.text = (pos + (i + 1));
						imageCont[i].alpha = 0;
						getImage(i, id );				
					}else {
						//if empty dont display itemBox
						trace("BOX"+i+": None");
						itemBox[i].visible = false;
					}				
				}else{
					if ( i < total){					
						id =  GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_ID];
						isoObjectData = GlobalData.instance.extactData( null, id  );
						//name = GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_NAME];
						name = isoObjectData.name;
						type = String(returnPrice(category, pos + i).substr(0, 2));
						//desc = GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_DESCRIPTION];	
						desc = isoObjectData.desc;					
						price = Number(returnPrice(category, pos + i).substr(2, 5));
						//req = GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_UNLOCKLEVEL];
						req = String( isoObjectData.unlocklevel );
						catname = GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_TYPE];
						trace("BOX" + i +" CT:"+catname+ " :NAME [" + name + "]/FRAME:"+(pos + (i+1)) + type + "/" + id + "/" + req);
						trace("C:" + price + " S: " + uint(GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR]));
						trace("Enabled");
						
						//display details
						switch (type) 
							{
								case "ST":  //star only
									itemBox[i].gotoAndStop(2);
										if (price > globalStar) {
											itemBox[i].itemOther.textColor = 0xFF0000;
										}else  {
											itemBox[i].itemOther.textColor = 0x000000;
										}
									itemBox[i].itemOther.text = price;
								break;
								case "CN":   //coin only
									itemBox[i].gotoAndStop(1);
									if (price > globalCoin) {
											itemBox[i].itemPrice.textColor = 0xFF0000;
										}else  {
											itemBox[i].itemPrice.textColor = 0x000000;
										}
									itemBox[i].itemPrice.text = price;
								break;
								case "BT":   //both coin and star
									itemBox[i].gotoAndStop(3);
									if (price > globalCoin) {
											itemBox[i].itemPrice.textColor = 0xFF0000;
										}else  {
											itemBox[i].itemPrice.textColor = 0x000000;
										}
									trace("HOOOOOOOOOOOOOOOOOOOOOOOOOY" +globalStar+ GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR]);
									if (GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR] > globalStar) {
											itemBox[i].itemOther.textColor = 0xFF0000;
										}else  {
											itemBox[i].itemOther.textColor = 0x000000;
										}
									
									itemBox[i].itemPrice.text = price;
									itemBox[i].itemOther.text = uint(GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR]);
									//itemBox[i].buyButton.removeEventListener(MouseEvent.CLICK, buyMenu);
									trace("Disabled");
									if (category == 5) {
										trace("Current Expansion:" + globalExpansion);
										itemBox[i].itemOther.text = uint(GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_STAR]) * globalExpansion;
										itemBox[i].itemPrice.text = uint(GlobalData.instance.officeStoreDataArray[category][pos + i][GlobalData.OFFICESTORE_COIN]) * globalExpansion;
										}
								break;
								case "NA":
										itemBox[i].itemPrice.text = price;
										itemBox[i].gotoAndStop(4);
								break;
								case "0":
								itemBox[i].buyButton.visible = false;
								itemBox[i].itemPrice.text = price;
								break;
								default:
									
								break;
							}
							if (globalLevel >= uint(req)) {
									itemBox[i].itemReq.alpha = 0;
								}else {
									itemBox[i].itemReq.alpha = .8;
									itemBox[i].gotoAndStop(4);
									itemBox[i].itemReq.text = "Require\nlv. " + req;
									itemBox[i].buyButton.removeEventListener(MouseEvent.CLICK, buyMenu);
									trace("Disabled");
								}
							itemBox[i].itemName.text = name;
							itemBox[i].itemDesc.text = desc;
							itemBox[i].itemID.text = id;
							itemBox[i].itemPos.text = (pos + (i + 1));
							imageCont[i].alpha = 0;
							getImage(i, id );
					}else{						
						trace("BOX"+i+": None");
						itemBox[i].visible = false;
					}				
				}
			}			
			trace("GEN: Icons Refreshed!");		
			pageNavigation(position, max);			
		}
		
		//FpageNav
		private function pageNavigation(prev:int, next:int):void {
			trace("PN" + prev + "/" + next);
			
			var nerf:int = next - prev;			
			mainCont.nextButton.gotoAndStop(1);
			mainCont.nextButton.addEventListener(MouseEvent.CLICK, nextPage);
			mainCont.nextButton.addEventListener(MouseEvent.ROLL_OVER, arrowHover);
			mainCont.prevButton.gotoAndStop(1);
			mainCont.prevButton.addEventListener(MouseEvent.CLICK, prevPage);
			mainCont.prevButton.addEventListener(MouseEvent.ROLL_OVER, arrowHover);
				
			if (prev != 0 ){				
				mainCont.nextButton.gotoAndStop(3);
				mainCont.nextButton.removeEventListener(MouseEvent.CLICK, nextPage);
				mainCont.nextButton.removeEventListener(MouseEvent.ROLL_OVER, arrowHover);
				
				if (prev != 0 && prev < next) {
					mainCont.nextButton.gotoAndStop(1);
					mainCont.nextButton.addEventListener(MouseEvent.CLICK, nextPage);
					mainCont.nextButton.addEventListener(MouseEvent.ROLL_OVER, arrowHover);
					mainCont.prevButton.gotoAndStop(1);
					mainCont.prevButton.addEventListener(MouseEvent.CLICK, prevPage);
					mainCont.prevButton.addEventListener(MouseEvent.ROLL_OVER, arrowHover);
				}
			}else if(prev == 0 && next == 0){
				mainCont.nextButton.gotoAndStop(3);
				mainCont.nextButton.removeEventListener(MouseEvent.CLICK, nextPage);
				mainCont.nextButton.removeEventListener(MouseEvent.ROLL_OVER, arrowHover);
				mainCont.prevButton.gotoAndStop(3);
				mainCont.prevButton.removeEventListener(MouseEvent.CLICK, prevPage);
				mainCont.prevButton.removeEventListener(MouseEvent.ROLL_OVER, arrowHover);
			}else if (nerf != 0) {
				mainCont.prevButton.gotoAndStop(3);
				mainCont.prevButton.removeEventListener(MouseEvent.CLICK, prevPage);
				mainCont.prevButton.removeEventListener(MouseEvent.ROLL_OVER, arrowHover);			
			}		
		}
		
		//FPrice
		private function returnPrice(cat:int, item:int):String {//itemOther
			var getGDCoinVal:String = GlobalData.instance.officeStoreDataArray[cat][item][GlobalData.OFFICESTORE_COIN];
			var getGDStarVal:String = GlobalData.instance.officeStoreDataArray[cat][item][GlobalData.OFFICESTORE_STAR];
			var price:String = "";
			if (getGDCoinVal != "0" && getGDStarVal != "0") {
				price = "BT" + getGDCoinVal;
				price =  "BT" + getGDCoinVal;
			}else if (getGDCoinVal == "0" && getGDStarVal != "0") {
				price = "ST" +getGDStarVal;
			}else if (getGDCoinVal != "0" && getGDStarVal == "0"){
				price = "CN" + getGDCoinVal;
			}else {	
				price = "NA0";
				}
			return price;
		}
		
		private function returnPriceAll(array:Array, item:int):String {
			var getGDCoinVal:String = array[item][GlobalData.OFFICESTORE_COIN];
			var getGDStarVal:String = array[item][GlobalData.OFFICESTORE_STAR];
			var price:String = "";
			if (getGDCoinVal != "0" && getGDStarVal != "0") {
				price = "BT" + getGDCoinVal;
				price =  "BT" + getGDCoinVal;
			}else if (getGDCoinVal == "0" && getGDStarVal != "0") {
				price = "ST" +getGDStarVal;
			}else if (getGDCoinVal != "0" && getGDStarVal == "0"){
				price = "CN" + getGDCoinVal;
			}else {	
				price = "NA0";
				}
			return price;
		}
		
		//FGetImage
		private function getImage(index:int, id:String):void {
			//var mc:MovieClip = new MovieClip();
			var labels:Array = imageCont[index].currentLabels;		
			var found:Boolean;
			
			for (var i:uint = 0; i < labels.length; i++) {
				var label:FrameLabel = labels[i];
				//trace("frame " + label.frame + ": " + label.name );				
				if ( label.name == id ) {
					found = true;
					break;
				}
			}
			
			if( found ){
				imageCont[index].gotoAndStop(id);
				if (currentCategory == 5 || currentCategory == 7 ) {
					//swifer
					_isoObjectData = GlobalData.instance.extactData( null, id  );
					var effDesc:Array = _isoObjectData.eff.split( "_" );
					//var total:uint = _isoObjectData.eff;
					//var total:uint = GlobalData.OFFICESTATE_DIMENSION;
					if ( imageCont[index].expText != null ) {
						//imageCont[index].expText.defaultTextFormat = _fontManager.getTxtFormat( "Eras Bold ITC", 14, 0 );
						//imageCont[index].expText.embedFonts = true;
						//imageCont[index].expText.antiAliasType = AntiAliasType.ADVANCED;
						imageCont[index].expText.text = effDesc[ 0 ] + "x" + effDesc[ 0 ];
					}					
				}
				
				TweenLite.to(imageCont[index], .3, {alpha:1, ease:Quint.easeInOut})
				trace("GI: " + index + "ID:" + id);
			}else {
				imageCont[index].gotoAndStop( 0 );
			}
		}
		
		//MEbuyMenu
		private function buyMenu(evt:MouseEvent):void {
			var curFrame:int = evt.currentTarget.parent.currentFrame;
			var typenum:int = evt.currentTarget.parent.itemPos.text 
		
			var enough:Boolean = false;
			var coinPrice:uint;
			var starPrice:uint;

			//var objID:String = GlobalData.instance.officeStoreDataArray[currentCategory][objPos-1][GlobalData.OFFICESTORE_ID];
			var objID:String = evt.currentTarget.parent.itemID.text;
			
			loadPlayerStat(_isOnline);
			trace("Frame:" + curFrame);
			trace("ObjPos:" + objPos); 
			switch (curFrame) 
			{
				case 1:
					coinPrice =  evt.currentTarget.parent.itemPrice.text;
					if(globalCoin >= coinPrice){
					trace("C:" + coinPrice);
					enough = true;
					}
				break;
				
				case 2:
					starPrice =  evt.currentTarget.parent.itemOther.text
						if(globalStar >= starPrice){
						trace("S:" + starPrice);
						enough = true;
					}
				break;
				
				case 3:
					coinPrice =  evt.currentTarget.parent.itemPrice.text;
					starPrice =  evt.currentTarget.parent.itemOther.text;

					if(globalCoin >= coinPrice && globalStar >= starPrice){
						trace("C:" + coinPrice);
						trace("S:" + starPrice);
						enough = true;
					}
				break;
				
				case 4:
					
				break;
				
				default:
					trace("Error in Buying");
					enough = false;
				break; 
			}
			
			//hack
			//enough = true;
			if (enough == true) {
				trace("BM: Bought [" + objID + "]");				
				switch(currentCategory) {
					case 0 :
							objCat = "staff";
							objPos = objID;
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
							trace( "[OfficeShopUI]: objCat", objCat );
							trigerTutorial();														
							break;
					case 1 : 
							objCat = "training";
							objPos = objID;
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
							break;
					case 2 :
							objCat = "machine";
							objPos = objID;
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
							break;
					case 3 :
							objCat = "deco";
							objPos = objID;
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
							break;
					case 4 :
							trace("WHAT TYPE:"+GlobalData.instance.officeStoreDataArray[currentCategory][typenum-1][GlobalData.OFFICESTORE_TYPE])
							objCat = "tile";
							objPos = objID;
							var _type:String = GlobalData.instance.officeStoreDataArray[currentCategory][typenum - 1][GlobalData.OFFICESTORE_TYPE];
							if (_type == 'tile') 
							{
								_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_TILE_BUY );
								_sdc.buyTile( objID );
							} else if (_type == 'wall') 
							{
								_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_WALL_BUY );
								_sdc.buyWall( objID );
							}
							break;
					case 5: 
							trace( "expansion  clickers id ===================>>", objID );
							objPos = objID;
							objCat = "expansion";
							globalExpansion +=1;
							trace("Expansion Updated: " + globalExpansion);
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_EXPANSION_BUY );
							//do it
					break;
					case 6:
							objPos = objID;
							objCat = "power";
							_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
					break;
					case 7:
							objPos = objID;
							_isoObjectData = GlobalData.instance.extactData( null, objID  );								
							objCat = _isoObjectData.type.toLowerCase();
							
							trace( "[OfficeShop category]:======================>>>> ", objCat , "objid", objPos );
							
							if( objCat =="deco"||  objCat =="training"||  objCat =="machine" || objCat == "power" || objCat =="staff" ){
								_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
								if ( objCat == "staff" ) {
									trace( "[OfficeShopUI]: objCat", objCat );
									trigerTutorial();
								}									
							}else if (objCat == 'tile') {
								objCat = "tile";								
								_type = gAllItems[typenum - 1][GlobalData.OFFICESTORE_TYPE];
								if (_type == 'tile'){
									_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_TILE_BUY );
									_sdc.buyTile( objID );
								}else if (_type == 'wall'){
									_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_WALL_BUY );
									_sdc.buyWall( objID );
								}
							} else if (objCat == "expansion"){
								_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_EXPANSION_BUY );
							}
					break;
						
					default:
						objPos = "1";
						objCat = GlobalData.instance.officeStoreDataArray[currentCategory][objPos][GlobalData.OFFICESTORE_TYPE];
						_ofcShopUIEvent = new OfficeShopUIEvent( OfficeShopUIEvent.ON_OBJECT_BUY );
						trace( "[OfficeShop category]:DEfault!!!!!!!!!! buy shit!! ==========================>>>> ", objCat , "objid", objPos );
					break;
				}
					
				trace( "buy moment!!!!!!!!!!!!!!!" );
				_itemData = new Object();					
				_itemData.cat = objCat; //cat					
				_itemData.currentPage = currentPage;					
				_itemData.id = objPos; //id					
				
				_itemObj = new Object();
				_itemObj.cat = objCat; //cat					
				_itemObj.currentPage = currentPage;					
				_itemObj.id = objPos; //id
				
				trace( "check bought item data", "objCat", objCat, "objPos", objPos, "currentPage", currentPage, "id", evt.currentTarget.parent.itemID.text, "shopUIEvent", _ofcShopUIEvent  );					
				
				_es.removeEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_COMPLETE, onCheckOwnItemComplete );					
				_es.removeEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED, onCheckOwnItemFailed );
				
				if( _itemData.cat == "staff" ){
					_sdc.checkIfOwnItem( _itemObj.id );
					_es.addEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_COMPLETE, onCheckOwnItemComplete );					
					_es.addEventListener( ServerDataControllerEvent.ON_CHECK_OWN_ITEM_FAILED, onCheckOwnItemFailed );
				}else{
					buy();
				}
				
			}else {
				trace("BM: Not Enough in buying this item [" + objPos+"]");
				EventSatellite.getInstance().dispatchEvent(new SSEvent (SSEvent.COIN_POPUP));
			}
			
			loadPlayerStat(_isOnline);
		}	
		
		private function trigerTutorial():void 
		{
			if ( !_gd.isTutorialDone ) {
				var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_BUY_BTN );								
				_es.dispatchESEvent( tutEvent );
				trace( "[OfficeShopUI]: trigerTutorial================================>>>>" );
			}
		}
		
		private function buy():void 
		{
			if ( _itemData.cat == "power" ){				
				_sdc.buyConsumableItem( _itemData.id );
			}else {
				_isoObjectData = GlobalData.instance.extactData( null, _itemData.id  );
			
				if( _itemData.cat != "expansion" ){
					if ( _isoObjectData != null ){
						_es.dispatchESEvent( _ofcShopUIEvent , _isoObjectData );
						_popUpUiManager.removeWindow( WindowPopUpConfig.BUILD_SHOP_POPUP );
					}
				}else{
					if ( _isoObjectData != null ){
						_es.dispatchESEvent( _ofcShopUIEvent, _isoObjectData );
						_popUpUiManager.removeWindow( WindowPopUpConfig.BUILD_SHOP_POPUP );
					}
					trace( "[ officeShop ]: buying expansion eff", _isoObjectData.eff );
				}
			}
		}
		
		/*----------------------------------------------------------------EventHandler-------------------------------------------------------------------------------*/
		
		// MECategory
		private function catClick(evt:MouseEvent):void {
			var _tempStr:String = evt.currentTarget.name;
			var _y:int = _tempStr.indexOf("_", 0);
			var num:int = parseInt(_tempStr.slice(_y + 1));
			//trace(num);
			updateCategory(num);
			currentCategory = num;
			currentPage = 0;
			populate(currentCategory, 0);
		}
		
		private function catHover(evt:MouseEvent):void {
			var _tempStr:String = evt.currentTarget.name;
			var _y:int = _tempStr.indexOf("_", 0);
			var num:int = parseInt(_tempStr.slice(_y + 1));
			//trace(num);
			TweenLite.to(categoryTab[num], .3, { y:80 } );
		}
		
		private function catOut(evt:MouseEvent):void {
			var _tempStr:String = evt.currentTarget.name;
			var _y:int = _tempStr.indexOf("_", 0);
			var num:int = parseInt(_tempStr.slice(_y + 1));
			//trace(num);
			TweenLite.to(categoryTab[num], .3, {y:90});
		}
		
		//MEArrows
		private function nextPage(evt:MouseEvent):void {
			if( currentCategory != 7){
				if(( GlobalData.instance.officeStoreDataArray[currentCategory].length/ 8)-currentPage >1){
					currentPage += 1;
				}
			}else {
				if(( itemNum/ 8)-currentPage >1){
					currentPage += 1;
				}
			}
			populate(currentCategory, currentPage);
		}
		private function prevPage(evt:MouseEvent):void {
			if ( currentCategory != 7) {
				if(currentPage != 0){
					currentPage -= 1;
				}
			}else {
				if(currentPage != 0){
					currentPage -= 1;
				}
			}
			
			populate(currentCategory, currentPage);
		}
		private function arrowHover(evt:MouseEvent):void {
			evt.target.gotoAndStop(2);
		}
		
		//MEGlower
		private function mouseOver(evt:MouseEvent):void {
			var glow:GlowFilter = new GlowFilter();
			glow.inner = false;
			glow.color = 0xFFE743;
			glow.blurX = 8;
			glow.blurY = 8;
			glow.strength = 600;
			evt.currentTarget.filters = [glow];
			pop.visible = true;
			pop.x = evt.currentTarget.x;
			pop.y = evt.currentTarget.y;
			
			//pop.descTitle.defaultTextFormat = _fontManager.getTxtFormat( "Eras Bold ITC", 15, 0 );
			//pop.descTitle.embedFonts = true;
			//pop.descTitle..antiAliasType = AntiAliasType.ADVANCED;
			pop.descTitle.text = evt.currentTarget.itemName.text;
			
			//pop.descOthers.defaultTextFormat = _fontManager.getTxtFormat( "Eras Bold ITC", 10, 0 );
			//pop.descOthers.embedFonts = true;
			//pop.descOthers.antiAliasType = AntiAliasType.ADVANCED;
			trace( "[OfficeShopUI]: show description when hover", evt.currentTarget.itemDesc.text );
			pop.descOthers.text = evt.currentTarget.itemDesc.text;	
		}
		
		private function mouseOut(evt:MouseEvent):void {
			evt.currentTarget.filters = []
			pop.visible = false;
		}	
		
		private function onBuyFailed(e:ServerDataControllerEvent):void 
		{
			trace( "[OfficeShopUI]: on Buy Failed.................................................... " );
		}
		
		private function onCheckOwnItemFailed(e:ServerDataControllerEvent):void 
		{
			buy();
		}
		
		private function onCheckOwnItemComplete(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.CANT_BUY_ALREADY_HAVE_THIS_ITEM;
			_es.dispatchESEvent( popUpUIEvent );
			trace( "[OfficeShopUI]: you already own item can't buy!!!!!!.............................. " );
		}
	}
}