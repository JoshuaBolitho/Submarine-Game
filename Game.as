package  {
	
	import screens.Welcome;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.text.TextField;
	import events.NavigationEvent;
	import screens.InGame;
	
	
	public class Game extends Sprite {
	
		private var screenWelcome:Welcome;
		private var screenInGame:InGame;
		
		public function Game() {
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event){
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenInGame = new InGame();
			//screenInGame.disposeTemporarily();
			this.addChild(screenInGame);
			screenInGame.initialize();
			
			//screenWelcome = new Welcome();
			//this.addChild(screenWelcome);
			//screenWelcome.initialize();
			
		}
		
		private function onChangeScreen(e:NavigationEvent):void
		{
			switch(e.params.id)
			{
				case "play":
					screenWelcome.disposeTemporarily();
					screenInGame.initialize();
				break;
			}
		}
		

	}
	
}
