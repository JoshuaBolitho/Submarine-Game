package screens 
{
	import starling.display.Sprite;
	import objects.Hero;
	import starling.events.Event;
	import objects.GameBackground;
	import flash.utils.getTimer;
	import starling.display.Button;
	import objects.Obstacle;
	import flash.geom.Rectangle;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.utils.deg2rad;
	import starling.events.TouchPhase;
	import starling.display.Stage;

	
	public class InGame extends Sprite
	{
		private var startButton:Button;
		private var hero:Hero;
		private var bg:GameBackground;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var gameState:String;
		
		private var playerSpeed:Number;
		private var hitObstacle:Number = 0;
		private const MIN_SPEED = 250;
		
		private var scoreDistance:int;
		private var obstacleGapCount:int;
		
		private var gameArea:Rectangle;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		private var touchPhase:TouchPhase;
		
		private var obstaclesToAnimate:Vector.<Obstacle>;
		
		
		public function InGame() 
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		//add visual elements to display
		private function drawGame():void
		{
			bg = new GameBackground();
			bg.speed = 2;
			this.addChild(bg);
			
			hero = new Hero();
			this.addChild(hero);
			
			startButton = new Button(Assets.getTexture("startBtn"));
			startButton.x = stage.stageWidth - (startButton.width + 10);
			this.addChild(startButton);
			
			gameArea = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight - 105);
		}
		
		//initializes the level setup
		public function initialize():void{
			this.visible = true;
		
			this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			hero.x = -stage.stageWidth;
			hero.y = stage.stageHeight * 0.5;
			
			gameState = "idle";
			
			playerSpeed = 0;
			hitObstacle = 0;
			
			//bg.speed = 0;
			scoreDistance = 0;
			obstacleGapCount = 0;
			
			obstaclesToAnimate = new Vector.<Obstacle>();
			
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
		}
		
		
		//start level
		private function onStartButtonClick(e:Event):void
		{
				startButton.visible = false;
				startButton.removeEventListener(Event.TRIGGERED, onStartButtonClick);
				
				launchHero();
		}
		
		//starts level animation from idle state
		private function launchHero():void
		{
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		private function onTouch(e:TouchEvent):void{
			touch = e.getTouch(stage);
			
			if(touch && touch.phase != TouchPhase.HOVER){
 				touchX = touch.globalX;
				touchY = touch.globalY;
				trace(touchY);
			}
		}
		
		//manages state animations 
		private function onGameTick(e:Event):void
		{
			switch(gameState)
			{
				case "idle":
					if(hero.x < stage.stageWidth * 0.25)
					{
						//ease from from left to on screen
						hero.x += ((stage.stageWidth * 0.25 + 10) - hero.x) * 0.05;
						hero.y = stage.stageHeight * 0.25;
						
						playerSpeed += (MIN_SPEED - playerSpeed) * 0.05;
						
						//compensates movement/time for when EnterFrame isn't precise
						bg.speed = playerSpeed * elapsed;
					}
					else
					{
						gameState = "flying";
					}
					break;
				case "flying":
				
					if(hitObstacle <= 0)
					{
						//10% of the distance between hero position and touch position, for easing
						hero.y -= (hero.y - touchY) * 0.1;
						
						//rotate hero max 150 to -150 degrees from touchY position
						if(-(hero.y - touchY) < 150 && -(hero.y - touchY) > -150)
						{
							hero.rotation = deg2rad(-(hero.y - touchY) * 0.15);
						}
						
						if(hero.y > gameArea.bottom - hero.height * 0.5)
						{
							hero.y = gameArea.bottom - hero.height * 0.5;
							hero.rotation = deg2rad(0);
						}
						
						if(hero.y < gameArea.top + hero.height * 0.5)
						{
							hero.y = gameArea.top + hero.height * 0.5;
							hero.rotation = deg2rad(0);
						}
					}
					
					playerSpeed -= (playerSpeed - MIN_SPEED) * 0.01;
					bg.speed = playerSpeed * elapsed;
					
					scoreDistance += (playerSpeed * elapsed) * 0.01;
					
					initObstacle();
					animateObstacles();
					
					break;
				case "over":
				
					break;
			}
		}
		
		private function animateObstacles():void
		{
			var obstacleToTrack:Obstacle;
			
			for(var i:uint = 0; i < obstaclesToAnimate.length; i++){
				
				obstacleToTrack = obstaclesToAnimate[i];
				
				if(obstacleToTrack.distance > 0)
				{
					obstacleToTrack.distance -= playerSpeed * elapsed;
				}
				else
				{
					if(obstacleToTrack.watchOut)
					{
						obstacleToTrack.watchOut = false;
					}
					obstacleToTrack.x -= (playerSpeed + obstacleToTrack.speed) * elapsed * 0.15;
				}
				if(obstacleToTrack.x < -obstacleToTrack.width || gameState == "over")
				{
					obstaclesToAnimate.splice(i, 1);
					this.removeChild(obstacleToTrack);
				}
			}
		}
		
		private function initObstacle():void
		{
			if(obstacleGapCount < 1200)
			{
				obstacleGapCount += playerSpeed * elapsed;
			}
			else if(obstacleGapCount != 0)
			{
				obstacleGapCount = 25;
				createObstacle(Math.ceil(Math.random() * 4), Math.random() * 1000 + 1000);
			}
		}
		
		private function createObstacle(type:Number, distance:Number):void
		{
			var obstacle:Obstacle = new Obstacle(type, distance, true, 300);
			obstacle.x = stage.stageWidth;
			this.addChild(obstacle);
			
			if(type <= 3)
			{
				if(Math.random() > 0.5)
				{
					obstacle.y = gameArea.top;
					obstacle.position = "top";
				}
				else
				{
					obstacle.y = gameArea.bottom - obstacle.height;
					obstacle.position = "bottom";
				}
			}
			else
			{
				obstacle.y = int(Math.random() * (gameArea.bottom - obstacle.height - gameArea.top)) + gameArea.top;;
				obstacle.position = "middle";
			}
			
			obstaclesToAnimate.push(obstacle);
		}
		
		//gets the amount of time between frames
		private function checkElapsed(e:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.005;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}

	}
	
}
