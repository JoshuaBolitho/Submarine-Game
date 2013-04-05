package screens 
{
	import starling.display.Sprite;
	import objects.Hero;
	import starling.events.Event;
	import objects.GameBackground;
	
	public class Welcome extends Sprite
	{
		private var hero:Hero;
		private var bg:GameBackground;
		
		public function Welcome() 
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			bg = new GameBackground();
			
			
			hero = new Hero();
			hero.x = stage.stageWidth / 2;
			hero.y = stage.stageHeight / 2;
			this.addChild(hero);
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}

	}
	
}
