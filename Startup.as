package 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import net.hires.debug.Stats;
	import screens.InGame;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#1a3956")]
	public class Startup extends Sprite 
	{
		private var _starling:Starling;
		private var _stats:Stats;
		
		public function Startup()
		{
			_starling = new Starling(Game, stage);
			_starling.start();
			_starling.antiAliasing = 1;
			
			_stats = new Stats();
			this.addChild(_stats);
		}
	}
}
