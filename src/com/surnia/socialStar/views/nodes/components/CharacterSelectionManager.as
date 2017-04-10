package com.surnia.socialStar.views.nodes.components
{
	import com.surnia.socialStar.data.GlobalData;

	public class CharacterSelectionManager
	{
		
		private var  _characterNodesArray:Array = []; 
			
		public function CharacterSelectionManager(characterNodesArray:Array)
		{
			_characterNodesArray = characterNodesArray;
		}
		
		public function updateCharacterNodeContainer(characterNodesArray:Array):void{
			_characterNodesArray = characterNodesArray;
		}
		
		/**
		 * Selects all characters in the array. 
		 * 
		 */		
		
		public function selectAll():void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				_characterNodesArray[i].selected = true;
			}
		}
		
		/**
		 * Selects characters from the array which has no status. 
		 * @param forStressDown - states if the selection is for stress down.
		 * 
		 */		
		
		public function selectAllWithoutStatus(forStressDown:Boolean = false):void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++) 
			{
				if (forStressDown && _characterNodesArray[i].stressLevel > 0){
					_characterNodesArray[i].selected = true;
				} else if (!forStressDown && _characterNodesArray[i].expression.length == 0 && _characterNodesArray[i].action != GlobalData.CHARACTER_ACTION_TRAINING && !_characterNodesArray[i].resting){
					_characterNodesArray[i].selected = true;
				}
			}
		}
		
		/**
		 * Deselects all characters in the array. 
		 * 
		 */		
		
		public function deselectAll():void{
			var len:int = _characterNodesArray.length;
			for (var i:int = 0; i < len; i++)
			{
				_characterNodesArray[i].selected = false;
			}
		}
	}
}