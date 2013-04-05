package objects
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	
	public class Hero extends Sprite
	{
		private var heroArt:MovieClip;

		public function Hero()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			createHeroArt();
		}
		
		private function createHeroArt():void
		{
			heroArt = new MovieClip(Assets.getAtlas().getTextures("ship"), 24);
			heroArt.x = Math.ceil(-heroArt.width * 0.5);
			heroArt.y = Math.ceil(-heroArt.height * 0.5);
			starling.core.Starling.juggler.add(heroArt);
			this.addChild(heroArt);
		}

	}
	
}
