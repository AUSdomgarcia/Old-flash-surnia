package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import com.surnia.socialStar.controllers.imageLoader.events.ImageLoaderEvent;	
	import com.surnia.socialStar.controllers.imageLoader.ImageLoaders;
	import com.surnia.socialStar.controllers.serverDataController.events.ServerDataControllerEvent;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.data.GameDialogueConfig;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.quest.events.QuestEvent;
	import com.surnia.socialStar.quest.Model.QuestData;
	import com.surnia.socialStar.quest.Model.RewardListData;
	import com.surnia.socialStar.quest.Model.TermListData;
	import com.surnia.socialStar.ui.popUI.components.*;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.events.PopUIEvent;
	import com.surnia.socialStar.utils.buttonManager.ButtonManager;
	import com.surnia.socialStar.utils.buttonManager.events.ButtonEvent;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class QuestPopUpWindow extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _mc:QuestWindowMC;
		private var _popUpUIManager:PopUpUIManager;
		private var _bm:ButtonManager;
		private var _es:EventSatellite;
		private var _imageLoader:ImageLoaders;	
		private var _loadedIcon1:Boolean = false;
		
		private var _iconId:String;
		private var _iconId2:String;
		private var _gd:GlobalData;
		private var _sdc:ServerDataController;
		private var _fontManager:FontManager;		
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function QuestPopUpWindow( windowName:String, windowSkin:MovieClip ) 
		{			
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{			
			_gd = GlobalData.instance;
			_imageLoader = ImageLoaders.getInstance();
			_es = EventSatellite.getInstance();
			_sdc = ServerDataController.getInstance();
			_fontManager = FontManager.getInstance();			
			
			_es.addEventListener( ServerDataControllerEvent.ON_ACCEPT_QUEST_COMPLETE, onAcceptQuestComplete );
			_es.addEventListener( ServerDataControllerEvent.ON_ACCEPT_QUEST_FAILED, onAcceptQuestFailed );
			
			_popUpUIManager = PopUpUIManager.getInstance();
			super.initWindow();
			setDisplay();
		}			
		
		override public function clearWindow():void 
		{
			super.clearWindow();
			removeDisplay();
		}		
		
		
		private function  setDisplay():void 
		{
			_mc = new QuestWindowMC();
			addChild( _mc );
			
			_iconId = null;
			_iconId2 = null;
			
			_mc.qicon.visible = false;
			_mc.qicon2.visible = false;
			
			//_mc.name = "closeBtn";
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.closeBtn );
			_bm.addBtnListener( _mc.acceptBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );			
			
			update( _gd.currentSelectedQuestData  );
		}		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){			
				_bm.removeBtnListener( _mc.closeBtn );
				_bm.removeBtnListener( _mc.acceptBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function update( data:QuestData ):void 
		{				 
			trace( "data .......update quest window...........................", data );
			
			if ( data == null ) {
				var data:QuestData = new QuestData();
				data.title = "test title";
				data.npcscript = "this is a test quest script!!!.";
				data.rewardcoin = "1000";
				data.rewardexp = "500";
				data.qtcommand = "finish any quest if you have?";
				data.qtamounthave = "0";
				data.qtamountreq = "99";
				data.npcimage = "qnpc014";			
				data.questicon = "0";			
			}
			
			
			var qlen:uint = data.termlist.length;
			
			if ( qlen > 1 ){
				_mc.gotoAndStop( 2 );
				_mc.icon.visible = false;
				_mc.icon2.visible = false;
			}else {
				_mc.gotoAndStop( 1 );
				_mc.icon.visible = false;
			}
			
			for (var j:int = 0; j < qlen; j++) 
			{
				var term:TermListData = data.termlist[ j ];
				
				if ( j == 0 ) {
					_mc.qicon.visible = true;					
					
					//_mc.txtQuestTerm.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 18, 0 );
					//_mc.txtQuestTerm.embedFonts = true;
					//_mc.txtQuestTerm.antiAliasType = AntiAliasType.ADVANCED;					
					_mc.txtQuestTerm.text = term.conditiontext;
					
					//_mc.txtAmountQuest.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 18, 0 );
					//_mc.txtAmountQuest.embedFonts = true;
					//_mc.txtAmountQuest.antiAliasType = AntiAliasType.ADVANCED;
					_mc.txtAmountQuest.text = term.amounthave + " / " + term.amountreq;
					
					if ( int( term.amounthave ) == int( term.amountreq ) ) {
						_mc.icon.visible = true;						
					}else {
						_mc.icon.visible = false;						
					}
					
					_iconId = term.objectimage;
					_imageLoader.extractXmlByid( _iconId );
					_imageLoader.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onImageQIcon );					
				}
				
				if ( j == 1 ){
					_mc.qicon2.visible = true;
					
					//_mc.txtQuestTerm2.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 18, 0 );
					//_mc.txtQuestTerm2.embedFonts = true;
					//_mc.txtQuestTerm2.antiAliasType = AntiAliasType.ADVANCED;					
					_mc.txtQuestTerm2.text = term.conditiontext;
					
					//_mc.txtAmountQuest2.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 18, 0 );
					//_mc.txtAmountQuest2.embedFonts = true;
					//_mc.txtAmountQuest2.antiAliasType = AntiAliasType.ADVANCED;
					_mc.txtAmountQuest2.text = term.amounthave + " / " + term.amountreq;
					
					//_mc.txtQuestTerm2.text = term.conditiontext;
					//_mc.txtAmountQuest2.text = term.amounthave + " / " + term.amountreq;
					
					if ( int( term.amounthave ) == int( term.amountreq ) ) {
						_mc.icon2.visible = true;						
					}else {
						_mc.icon2.visible = false;						
					}
					
					_iconId2 = term.objectimage;
					_imageLoader.extractXmlByid( _iconId2 );
					_imageLoader.addEventListener( ImageLoaderEvent.IMAGE_LOADED, onImageQIcon2 );
				}								
			}		
			
			trace( "[QuestPopUpWindow]: ", data.npcimage  );
			if( data.npcimage != null ){
				var found:Boolean = searchForId( data.npcimage, _mc.npc );
				if ( found ) {
					_mc.npc.gotoAndStop( data.npcimage );
				}else {
					_mc.npc.gotoAndStop( "qnpc001" );
				}
			}else {
				_mc.npc.gotoAndStop( "qnpc001" );
			}			
			trace( "[QuestPopUpWindow]: ", data.npcimage  );			
			
			
			//_mc.txtTitle.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 40, 0xffd414 );			
			//_mc.txtTitle.embedFonts = true;
			//_mc.txtTitle.antiAliasType = AntiAliasType.ADVANCED;	
			_mc.txtTitle.text = data.title;			
			
			if ( data.npcscript != null ){				
				//_mc.txtScript.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 20, 0 );
				//_mc.txtScript.embedFonts = true;
				//_mc.txtScript.antiAliasType = AntiAliasType.ADVANCED;
				_mc.txtScript.text = data.npcscript;
			}else{				
				//_mc.txtScript.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 20, 0 );
				//_mc.txtScript.embedFonts = true;
				//_mc.txtScript.antiAliasType = AntiAliasType.ADVANCED;
				_mc.txtScript.text = data.hintscript;
			}
			
			var len:uint = data.rewardlist.length;
			var coin:String = null;
			var exp:String = null;
			
			for (var i:int = 0; i < len ; i++) 
			{
				var reward:RewardListData = data.rewardlist[ i ];
				if ( reward.type=="coin" ) {
					coin =  reward.amount;
				}
				
				if ( reward.type == "pexp" ) {
					exp =  reward.amount;
				}
			}		
			
			if ( exp != null ) {				
				//_mc.txtExp.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 12, 0 );
				//_mc.txtExp.embedFonts = true;
				//_mc.txtExp.antiAliasType = AntiAliasType.ADVANCED;
				_mc.txtExp.text = exp;
			}
			
			if ( coin != null ) {				
				//_mc.txtCoin.defaultTextFormat = _fontManager.getTxtFormat( "Eras Demi ITC", 12, 0 );
				//_mc.txtCoin.embedFonts = true;
				//_mc.txtCoin.antiAliasType = AntiAliasType.ADVANCED;
				_mc.txtCoin.text = coin;
			}
			
			if ( data.isAccepted == "1" ) {
				_mc.acceptBtn.visible = false;
			}else {
				_mc.acceptBtn.visible = true;
			}
		}			
		
		
		private function searchForId( itemId:String , mc:MovieClip ):Boolean 
		{			
			var labels:Array = mc.currentLabels;
			var found:Boolean = false;
			
			for (var i:uint = 0; i < labels.length; i++) {
				var label:FrameLabel = labels[i];	
				//for checking obj.id
				if ( label.name == itemId ) {
					found = true;
					break;
				}
			}			
			return found;
		}		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/				
		private function onClickBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "closeBtn":
					_popUpUIManager.removeWindow( WindowPopUpConfig.QUEST_WINDOW );
					//_popUpUIManager.removeSubWindowByName( WindowPopUpConfig.QUEST_WINDOW );
				break;
				
				case "acceptBtn":
					_sdc.acceptQuest( _gd.currentSelectedQuestData.id );					
				break;
				
				default:
					
				break;
			}		
		}
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "closeBtn":									
					_mc.closeBtn.gotoAndStop( 1 );					
				break;			
				
				case "acceptBtn":
					_mc.acceptBtn.gotoAndStop( 1 );					
				break;
				
				default:
					
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "closeBtn":				
					_mc.closeBtn.gotoAndStop( 2 );
				break;			
				
				case "acceptBtn":
					_mc.acceptBtn.gotoAndStop( 2 );
				break;
				
				default:					
				break;
			}
		}		
		
		private function onImageQIcon(e:ImageLoaderEvent):void 
		{
			if( _iconId == e.obj.id ){
				trace( "[ QuestPopupWindow ]: on show image qicon on quest window" );
				var img:Bitmap;			
				trace( "[QuestPopUpWindow] image icon1 loaded id", e.obj.id );
				img = _imageLoader.getImage( _iconId );
				trace( "[QuestPopUpWindow] image icon1 loaded id", img );
				
				if( img != null && _mc != null ){
					_mc.qicon.addChild( img );
					_mc.qicon.txtQicon.visible = false;					
				}
			}			
		}		
		
		private function onImageQIcon2(e:ImageLoaderEvent):void 
		{
			if( _iconId2 == e.obj.id ){
				trace( "[QuestPopUpWindow] image icon2 loaded id", e.obj.id );
				var img:Bitmap = _imageLoader.getImage( _iconId2 );
				trace( "[QuestPopUpWindow] image icon2 loaded id", img );
				_mc.qicon2.addChild( img );
				_mc.qicon2.txtQicon.visible = false;
			}
		}
		
		private function onAcceptQuestFailed(e:ServerDataControllerEvent):void 
		{
			var popUpUIEvent:PopUIEvent = new PopUIEvent( PopUIEvent.ON_SHOW_MESSAGE );
			popUpUIEvent.obj.msg = GameDialogueConfig.SERVER_SYNC_ERROR;
			_es.dispatchESEvent( popUpUIEvent );			
		}
		
		private function onAcceptQuestComplete(e:ServerDataControllerEvent):void 
		{
			_sdc.updateQuestXML( true );
			_popUpUIManager.removeWindow( WindowPopUpConfig.QUEST_WINDOW );
		}
	}

}