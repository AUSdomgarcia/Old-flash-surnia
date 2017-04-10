package com.surnia.socialStar.minigames.runningMan.view 
{
	import com.surnia.socialStar.minigames.runningMan.model.PlayerModel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author domz
	 */
	public class PlayerModelManager extends Sprite
	{
		private var spt:Sprite;
		private var pModel:PlayerModel;
		public function PlayerModelManager() 
		{
			pModel = new PlayerModel( "11111111111111111111111111111111111111111020034050607" );
			//pModel.setPname = "ab";
			trace( pModel.getpCurrentActionPoint );
		}
		
	}

}