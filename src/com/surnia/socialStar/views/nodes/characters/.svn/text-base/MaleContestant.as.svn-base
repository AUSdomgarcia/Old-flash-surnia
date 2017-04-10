package com.surnia.socialStar.views.nodes.characters
{
	import com.surnia.socialStar.interfaces.ICharacter;

	public class MaleContestant extends AvatarMale implements ICharacter
	{
		
		public var LEFT:String = "LEFT";
		public var RIGHT:String = "RIGHT";		
		
		public function MaleContestant()
		{
			
		}
		
		public function setDefinition(definition:String):void{
			setType = definition;
		}
		
		public function setAnimation(action:String, duration:Number):void{
			runAnimation(action, duration);
		}
		
		public function getFacing():int{
			// LEFT = left
			// RIGHT = right
			var state:String = getState;
			if (state == LEFT){
				return 0;
			} else {
				return 1;
			}
		}
		
	}
}