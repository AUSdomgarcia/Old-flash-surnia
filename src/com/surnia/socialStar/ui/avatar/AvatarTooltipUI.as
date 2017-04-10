package com.surnia.socialStar.ui.avatar 
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.tutorial.events.TutorialEvent;
	import com.surnia.socialStar.ui.popUI.config.WindowPopUpConfig;
	import com.surnia.socialStar.ui.popUI.views.PopUpUIManager;
	import com.surnia.socialStar.ui.popUI.views.crew.event.CrewEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Windz
	 */
	
	public class AvatarTooltipUI extends MovieClip
	{
		private var _avatarTooltip:AvatarTooltip;
		private var _es:EventSatellite;
		private var _avaToolEvent:AvatarTooltipUIEvent;
		private var _popUpUIManager:PopUpUIManager;
		private var _charID:String;
		private var _gd:GlobalData = GlobalData.instance;
		
		public function AvatarTooltipUI(charID:String)
		{
			_charID = charID;
			_popUpUIManager = PopUpUIManager.getInstance();
			_es = EventSatellite.getInstance();
			_avatarTooltip = new AvatarTooltip();
			addChild(_avatarTooltip);
			initButtons();
			initValues();
		}
		
		private function initValues():void{
			if (_gd.friendView){
				charData = GlobalData.instance.getFriendCharDataOnCharID(_charID);
				_avatarTooltip.txtPop.text = charData[GlobalData.FRIENDCHARLIST_POPULAR];
				_avatarTooltip.txtLevel.text = charData[GlobalData.FRIENDCHARLIST_LEVEL];
				_avatarTooltip.txtName.text = charData[GlobalData.FRIENDCHARLIST_NAME];
				
				// text values
				_avatarTooltip.txtStress.text = charData[GlobalData.FRIENDCHARLIST_STRESS] + "";
				_avatarTooltip.txtHealth.text = Math.floor(charData[GlobalData.FRIENDCHARLIST_HEALTH] * .01) + "";
				_avatarTooltip.txtSing.text = Math.floor(charData[GlobalData.FRIENDCHARLIST_SING] * .01) + "";
				_avatarTooltip.txtActing.text = Math.floor(charData[GlobalData.FRIENDCHARLIST_ACTING] * .01) + "";
				_avatarTooltip.txtAttraction.text = Math.floor(charData[GlobalData.FRIENDCHARLIST_ATTRACTION] * .01) + "";
				_avatarTooltip.txtInt.text = Math.floor(charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] * .01) + "";
				
				// bar scales based on attr values
				_avatarTooltip.popBar.scaleX = charData[GlobalData.FRIENDCHARLIST_POPULAR] * .01;
				_avatarTooltip.stressBar.scaleX = charData[GlobalData.FRIENDCHARLIST_STRESS] * .01;
				_avatarTooltip.healthBar.scaleX = (charData[GlobalData.FRIENDCHARLIST_HEALTH] * .01) - Math.floor(charData[GlobalData.FRIENDCHARLIST_HEALTH] * .01);
				_avatarTooltip.singBar.scaleX = (charData[GlobalData.FRIENDCHARLIST_SING] * .01) - Math.floor(charData[GlobalData.FRIENDCHARLIST_SING] * .01);
				_avatarTooltip.actBar.scaleX = (charData[GlobalData.FRIENDCHARLIST_ACTING] * .01) - Math.floor(charData[GlobalData.FRIENDCHARLIST_ACTING] * .01);
				_avatarTooltip.attrBar.scaleX = (charData[GlobalData.FRIENDCHARLIST_ATTRACTION] * .01) - Math.floor(charData[GlobalData.FRIENDCHARLIST_ATTRACTION] * .01);
				_avatarTooltip.intBar.scaleX = (charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] * .01) - Math.floor(charData[GlobalData.FRIENDCHARLIST_INTELLIGENCE] * .01);
			} else {
				var charData:Array = GlobalData.instance.getCharDataOnCharID(_charID);
				
				_avatarTooltip.txtPop.text = charData[GlobalData.CHARLIST_POPULAR];
				_avatarTooltip.txtLevel.text = charData[GlobalData.CHARLIST_LEVEL];
				_avatarTooltip.txtName.text = charData[GlobalData.CHARLIST_NAME];
				
				_avatarTooltip.txtStress.text = charData[GlobalData.CHARLIST_STRESS] + "";
				_avatarTooltip.txtHealth.text = Math.floor(charData[GlobalData.CHARLIST_HEALTH] * .01) + "";
				_avatarTooltip.txtSing.text = Math.floor(charData[GlobalData.CHARLIST_SING] * .01) + "";
				_avatarTooltip.txtActing.text = Math.floor(charData[GlobalData.CHARLIST_ACTING] * .01) + "";
				_avatarTooltip.txtAttraction.text = Math.floor(charData[GlobalData.CHARLIST_ATTRACTION] * .01) + "";
				_avatarTooltip.txtInt.text = Math.floor(charData[GlobalData.CHARLIST_INTELLIGENCE] * .01) + "";
			
				_avatarTooltip.popBar.scaleX = charData[GlobalData.CHARLIST_POPULAR] * .01;
				_avatarTooltip.stressBar.scaleX = charData[GlobalData.CHARLIST_STRESS] * .01;
				_avatarTooltip.healthBar.scaleX = (charData[GlobalData.CHARLIST_HEALTH] * .01) - Math.floor(charData[GlobalData.CHARLIST_HEALTH] * .01);
				_avatarTooltip.singBar.scaleX = (charData[GlobalData.CHARLIST_SING] * .01) - Math.floor(charData[GlobalData.CHARLIST_SING] * .01);
				_avatarTooltip.actBar.scaleX = (charData[GlobalData.CHARLIST_ACTING] * .01) - Math.floor(charData[GlobalData.CHARLIST_ACTING] * .01);
				_avatarTooltip.attrBar.scaleX = (charData[GlobalData.CHARLIST_ATTRACTION] * .01) - Math.floor(charData[GlobalData.CHARLIST_ATTRACTION] * .01);
				_avatarTooltip.intBar.scaleX = (charData[GlobalData.CHARLIST_INTELLIGENCE] * .01) - Math.floor(charData[GlobalData.CHARLIST_INTELLIGENCE] * .01);	
				
				// trace values
				trace ("character health " + charData[GlobalData.CHARLIST_HEALTH]);
				trace ("character sing " + charData[GlobalData.CHARLIST_SING]);
				trace ("character acting " + charData[GlobalData.CHARLIST_ACTING]);
				trace ("character attraction " + charData[GlobalData.CHARLIST_ATTRACTION]);
				trace ("character intelligence " + charData[GlobalData.CHARLIST_INTELLIGENCE]);
			
				// trace scales for each values
				trace ("character health scale " + _avatarTooltip.healthBar.scaleX);
				trace ("character sing scale " + _avatarTooltip.singBar.scaleX);
				trace ("character acting scale " + _avatarTooltip.actBar.scaleX);
				trace ("character attraction scale " + _avatarTooltip.attrBar.scaleX);
				trace ("character intelligence scale " + _avatarTooltip.intBar.scaleX);
				
			}
		}
		
		private function initButtons():void {
			//_avatarTooltip.trainingBtn.gotoAndStop(1);
			_avatarTooltip.shopBtn.gotoAndStop(1);
			_avatarTooltip.staffBtn.gotoAndStop(1);
			_avatarTooltip.closeBtn.gotoAndStop(1);
			
			//_avatarTooltip.trainingBtn.buttonMode = true;
			_avatarTooltip.shopBtn.buttonMode = true;
			_avatarTooltip.staffBtn.buttonMode = true;
			_avatarTooltip.closeBtn.buttonMode = true;
			
			//_avatarTooltip.trainingBtn.addEventListener(MouseEvent.ROLL_OVER, _onAvatarTooltipBtnOver);
			_avatarTooltip.shopBtn.addEventListener(MouseEvent.ROLL_OVER, _onAvatarTooltipBtnOver);
			_avatarTooltip.staffBtn.addEventListener(MouseEvent.ROLL_OVER, _onAvatarTooltipBtnOver);
			_avatarTooltip.closeBtn.addEventListener(MouseEvent.ROLL_OVER, _onAvatarTooltipBtnOver);
			
			//_avatarTooltip.trainingBtn.addEventListener(MouseEvent.ROLL_OUT, _onAvatarTooltipBtnOut);
			_avatarTooltip.shopBtn.addEventListener(MouseEvent.ROLL_OUT, _onAvatarTooltipBtnOut);
			_avatarTooltip.staffBtn.addEventListener(MouseEvent.ROLL_OUT, _onAvatarTooltipBtnOut);
			_avatarTooltip.closeBtn.addEventListener(MouseEvent.ROLL_OUT, _onAvatarTooltipBtnOut);
			
			//_avatarTooltip.trainingBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAvatarTooltipBtnPress);
			_avatarTooltip.shopBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAvatarTooltipBtnPress);
			_avatarTooltip.staffBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAvatarTooltipBtnPress);
			_avatarTooltip.closeBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onAvatarTooltipBtnPress);
			
		}
		
		private function _onAvatarTooltipBtnOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
		}
		
		private function _onAvatarTooltipBtnOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		private function _onAvatarTooltipBtnPress(e:MouseEvent):void
		{
			trace('Avatar Tooltip UI Button Clicked : ' + e.currentTarget.name);		
			
			switch (e.currentTarget.name) {
				
				//case 'trainingBtn':
					//_avaToolEvent = new AvatarTooltipUIEvent ( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_TRAINING_BUTTON_SELECT );
					//_es.dispatchESEvent( _avaToolEvent );
				//break;
				
				case 'shopBtn':
					_popUpUIManager.loadWindow(WindowPopUpConfig.CHARSHOP_WINDOW);
					_avaToolEvent = new AvatarTooltipUIEvent ( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_SHOP_BUTTON_SELECT );
					_es.dispatchESEvent( _avaToolEvent );
				break;
				
				case 'staffBtn':
					// commented because it will be removed in the design.
					/*_popUpUIManager.loadWindow( WindowPopUpConfig.CREW_WINDOW );
					_es.dispatchEvent(new CrewEvent(CrewEvent.UPDATE_CHARDATA, {charID:_charID}));
					_avaToolEvent = new AvatarTooltipUIEvent ( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_STAFF_BUTTON_SELECT );
					_es.dispatchESEvent( _avaToolEvent );
					
					var tutEvent:TutorialEvent = new TutorialEvent( TutorialEvent.CLICK_STAFF_BTN );
					_es.dispatchESEvent( tutEvent );*/
				break;
				
				case 'closeBtn':
					//_avaToolEvent = new AvatarTooltipUIEvent ( AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT );
					//_es.dispatchESEvent( _avaToolEvent );
					
					var event:AvatarTooltipUIEvent = new AvatarTooltipUIEvent(AvatarTooltipUIEvent.ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT);
					event.obj.charID = _charID;
					_es.dispatchEvent(event);
					
					_popUpUIManager.removeWindow(WindowPopUpConfig.AVATAR_TOOL_WINDOW );
				break;
			}
		}		
	}
}