package com.surnia.socialStar.ui.popUI.views.characterPanel.components.charStatPanel 
{
	//import com.surnia.socialStar.minigames.MovieGame.MovieGameController;
	import com.surnia.socialStar.controllers.fontManager.FontManager;
	import fl.text.TLFTextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author DF
	 */
	public class CharStatPanel  extends MovieClip
	{
		public static const POPULAR:int	 = 0;
		public static const STRESS:int	 = 1;
		public static const HEALTH:int	 = 2;
		public static const SING:int	 = 3;
		public static const INTELLIGENCE:int = 4;
		public static const ACTING:int 		= 5;
		public static const ATTRACTION:int = 6;
		
		
		private var _lvl:int;
		private var _popular:int;
		private var _stress:int;
		private var _health:int;
		private var _sing:int;
		private var _intelligence:int;
		private var _acting:int;
		private var _attraction:int;
		
		private var _progressBar:Array = [];
		private var _gauge:GaugeBarMC;
		private var _charStat:CharStatMC;	
		private var _mask:GaugeBarMC;
		
		private var _name:String;
		private var _level1:int;
		private	var _popular1:int;
		private	var _stress1:int;
		private	var _health1:int;
		private	var _sing1:int;
		private	var _intelligence1:int;
		private	var _acting1:int;
		private	var _attraction1:int;
		
		private var _level2:int;
		private	var _popular2:int;
		private	var _stress2:int;
		private	var _health2:int;
		private	var _sing2:int;
		private	var _intelligence2:int;
		private	var _acting2:int;
		private	var _attraction2:int;
		
		private var _tf:TextFormat;	
		
		private var _fontManager:FontManager;
		public function CharStatPanel() 
		{
			initialization();	
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void {
			trace("CLEAN :", this);
			if (_charStat != null) {
				if (this.contains(_charStat)) {
					removeChild(_charStat);
					_charStat = null;
				}
			}
			
			if (_tf != null) {
				_tf = null
			}
		}
		
		private function initialization():void {
			_fontManager = FontManager.getInstance();
			_charStat = new CharStatMC;	
			_tf = new TextFormat;
		}
		
		public function display():void {			
			addChild(_charStat);			
		}	
		
		public function remove():void {
			if (_charStat != null) {
				if (this.contains(_charStat)) {
					removeChild(_charStat);
				}
			}
		}
		
		public function setStat(name:String = "Name", level:int = 1, popular:int = 0, stress:int = 0, health:int = 0, sing:int = 0, intelligence:int = 0, acting:int = 0, attraction:int = 0):void {			
			_name = name;
			_level1 = level;
			_popular1 = popular;
			_stress1 = stress;
			_health1 = health;
			_sing1 = sing;
			_intelligence1 = intelligence;
			_acting1 = acting;
			_attraction1 = attraction;		
			
			
			setFontManager(_charStat.txtName, 12);
			_charStat.txtName.text = _name;	
			
			setFontManager(_charStat.txtLevel, 14, 0xFFCC33);
			_charStat.txtLevel.text = String(level);
			
			setFontManager(_charStat.txtPopular);
			_charStat.txtPopular.text = String(popular);
			
			setFontManager(_charStat.txtStress);
			_charStat.txtStress.text = String(stress); 
			
			setFontManager(_charStat.txtHealth);
			_charStat.txtHealth.text = String(health);
			
			setFontManager(_charStat.txtSing);
			_charStat.txtSing.text = String(sing);
			
			setFontManager(_charStat.txtIntelligence);
			_charStat.txtIntelligence.text = String(intelligence);
			
			setFontManager(_charStat.txtActing);
			_charStat.txtActing.text = String(acting);
			
			setFontManager(_charStat.txtAttraction);
			_charStat.txtAttraction.text = String(attraction);		
			
			compareStat();
			remove();
			display();		
		}		
		
		private function setFontManager(txtField:TLFTextField, fontSize:int = 8, fontColor:int = 0, fontFamily:String = "Eras Demi ITC"):void 
		{
			txtField.defaultTextFormat = _fontManager.getTxtFormat(fontFamily , fontSize, fontColor );			
			txtField.embedFonts = true;
			txtField.antiAliasType = AntiAliasType.ADVANCED;			
		}
		
		public function setCompareStat(level:int = 1, popular:int = 0, stress:int = 0, health:int = 0, sing:int = 0, intelligence:int = 0, acting:int = 0, attraction:int = 0):void {
			_level2 = level;
			_popular2 = popular;
			_stress2 = stress;
			_health2 = health;
			_sing2 = sing;
			_intelligence2 = intelligence;
			_acting2 = acting;
			_attraction2 = attraction;			
		}
		
		private function compareStat():void {
				
			//_tf.font = "Arial Bold";
			//_tf.bold = true;
			//_tf.size = 10;				
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY POPULAR TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/					
		
			//if MORE than RIVAL
			if (_popular1 > _popular2) {				
				_tf.color = 0x09900;	
				_charStat.txtPopular.setTextFormat(_tf);
			}
			if (_popular1  > _popular2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtPopular.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_popular1 < _popular2) {
				_tf.color = 0xFF6600;	
				_charStat.txtPopular.setTextFormat(_tf);
			}
			if (_popular1 + 20 < _popular2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtPopular.setTextFormat(_tf);
			}
			if (_popular1 == _popular2 ) {
				_tf.color = 0x000000;	
				_charStat.txtPopular.setTextFormat(_tf);
			}	
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY STRESS TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_stress1 > _stress2) {				
				_tf.color = 0x09900;	
				_charStat.txtStress.setTextFormat(_tf);
			}
			if (_stress1  > _stress2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtStress.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_stress1 < _stress2) {
				_tf.color = 0xFF6600;	
				_charStat.txtStress.setTextFormat(_tf);
			}
			if (_stress1 + 20 < _stress2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtStress.setTextFormat(_tf);
			}
			if (_stress1 == _stress2 ) {
				_tf.color = 0x000000;	
				_charStat.txtStress.setTextFormat(_tf);
			}
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY HEALTH TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_health1 > _health2) {				
				_tf.color = 0x09900;	
				_charStat.txtHealth.setTextFormat(_tf);
			}
			if (_health1  > _health2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtHealth.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_health1 < _health2) {
				_tf.color = 0xFF6600;	
				_charStat.txtHealth.setTextFormat(_tf);
			}
			if (_health1 + 20 < _health2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtHealth.setTextFormat(_tf);
			}
			
			if (_health1 == _health2 ) {
				_tf.color = 0x000000;	
				_charStat.txtHealth.setTextFormat(_tf);
			}
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY SING TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_sing1 > _sing2) {				
				_tf.color = 0x09900;	
				_charStat.txtSing.setTextFormat(_tf);
			}
			if (_sing1  > _sing2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtSing.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_sing1 < _sing2) {
				_tf.color = 0xFF6600;	
				_charStat.txtSing.setTextFormat(_tf);
			}
			if (_sing1 + 20 < _sing2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtSing.setTextFormat(_tf);
			}		
			if (_sing1 == _sing2 ) {
				_tf.color = 0x000000;	
				_charStat.txtSing.setTextFormat(_tf);
			}
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY INTELLIGENCE TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_intelligence1 > _intelligence2) {				
				_tf.color = 0x09900;	
				_charStat.txtIntelligence.setTextFormat(_tf);
			}
			if (_intelligence1  > _intelligence2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtIntelligence.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_intelligence1 < _intelligence2) {
				_tf.color = 0xFF6600;	
				_charStat.txtIntelligence.setTextFormat(_tf);
			}
			if (_intelligence1 + 20 < _intelligence2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtIntelligence.setTextFormat(_tf);
			}
			if (_intelligence1 == _intelligence2 ) {
				_tf.color = 0x000000;	
				_charStat.txtIntelligence.setTextFormat(_tf);
			}
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY ACTING TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_acting1 > _acting2) {				
				_tf.color = 0x09900;	
				_charStat.txtActing.setTextFormat(_tf);
			}
			if (_acting1  > _acting2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtActing.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_acting1 < _acting2) {
				_tf.color = 0xFF6600;	
				_charStat.txtActing.setTextFormat(_tf);
			}
			if (_acting1 + 20 < _acting2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtActing.setTextFormat(_tf);
			}
			if (_acting1 == _acting2 ) {
				_tf.color = 0x000000;	
				_charStat.txtActing.setTextFormat(_tf);
			}
			
			/*------------------------------------------------------------------------------------------------------------
			 *												DISPLAY ATTRACTION TEXT COLOR
			 * ----------------------------------------------------------------------------------------------------------*/			
			//if MORE than RIVAL
			if (_attraction1 > _attraction2) {				
				_tf.color = 0x09900;	
				_charStat.txtAttraction.setTextFormat(_tf);
			}
			if (_attraction1  > _attraction2 + 20) {
				_tf.color = 0x0066FF;	
				_charStat.txtAttraction.setTextFormat(_tf);
			}
			//if LESS than RIVAL
			if (_attraction1 < _attraction2) {
				_tf.color = 0xFF6600;	
				_charStat.txtAttraction.setTextFormat(_tf);
			}
			if (_attraction1 + 20 < _attraction2 ) {
				_tf.color = 0xCC0000;	
				_charStat.txtAttraction.setTextFormat(_tf);
			}
			if (_attraction1 == _attraction2 ) {
				_tf.color = 0x000000;	
				_charStat.txtAttraction.setTextFormat(_tf);
			}
		}
	}

}