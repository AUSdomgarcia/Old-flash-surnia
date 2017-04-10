
package com.surnia.socialStar.sceneHandler  {
	import com.surnia.socialStar.sceneHandler.component.MessageSeparator;
    import flash.display.Sprite;
	
    public class testMain extends Sprite { 		
		
		private var _messageSeparator:MessageSeparator;
		
        public function testMain() {
			var str:String = "Sarah Kerrigan was an extremely powerful terran psychic. At a young age she fried her mother's brain accidentally with psionic powers[9] and demonstrated telekinetic abilities. This means she possessed a PI of 8 or higher.[105] Indeed, her powers were so strong it forced a readjustment of the psionic measurement scale.[3] Her powers were reduced by both ghost conditioning[27] and a neuro-adjuster[9] but after the device's removal, she was powerful enough to throw Major Rumm around with telekinesis and fry his brain.[4]Kerrigan was uniquely suited to controlling zerg even before she was infested. In experiments conducted with captured zerg specimens, the Confederacy terminated the other ghosts involved in the project because only Kerrigan could get the results they wanted.[4] In addition, Kerrigan has a gene pattern that enabled her to retain her intelligence upon infestation.[9]";
			
			initialization();
			display();
			_messageSeparator.messageNPC(str, 2);
        }     
		
		private function initialization():void {
			_messageSeparator = new MessageSeparator;
		}
		
		private function display():void {
			addChild(_messageSeparator);
		}
    }
}