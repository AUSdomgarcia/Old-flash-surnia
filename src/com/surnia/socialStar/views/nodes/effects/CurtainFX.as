package com.surnia.socialStar.views.nodes.effects
{
	import com.surnia.socialStar.views.nodes.CharacterNode;
	
	import flash.display.MovieClip;

	public class CurtainFX extends MovieClip
	{
		
		private var _curtain:Curtain;
		private var _charNode:CharacterNode;
		private var _start:Boolean = true;
			
		public function CurtainFX()
		{
			init();
		}
		
		public function get start():Boolean
		{
			return _start;
		}

		public function set start(value:Boolean):void
		{
			_start = value;
		}

		public function get charNode():CharacterNode
		{
			return _charNode;
		}

		public function set charNode(value:CharacterNode):void
		{
			_charNode = value;
		}

		private  function init():void{
			_curtain = new Curtain();
			addChild(_curtain);
		}
		
		public function get instance():Curtain{
			return _curtain;
		}
		
		
	}
}