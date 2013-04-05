package objects {
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackground extends Sprite
	{
		private var ground:BGLayer;
		private var dome:BGLayer;
		private var hills1:BGLayer;
		private var hills2:BGLayer;
		
		private var _speed:Number = 0;
		
		public function GameBackground() 
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			ground = new BGLayer(1);
			this.addChild(ground);
			
			dome = new BGLayer(2);
			dome.parallax = 0.1;
			dome.y = -105;
			this.addChild(dome);
			
			hills2 = new BGLayer(3);
			hills2.parallax = 0.2;
			hills2 .y = -105;
			this.addChild(hills2);
			
			hills1 = new BGLayer(4);
			hills1.parallax = 0.3;
			hills1 .y = -105;
			this.addChild(hills1);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			
			dome.x -= Math.ceil(_speed * dome.parallax);
			if(dome.x < -stage.stageWidth)
			{
				dome.x = 0;
			}
			
			hills1.x -= Math.ceil(_speed * hills1.parallax);
			if(hills1.x < -stage.stageWidth)
			{
				hills1.x = 0;
			}
			
			hills2.x -= Math.ceil(_speed * hills2.parallax);
			if(hills2.x < -stage.stageWidth)
			{
				hills2.x = 0;
			}
			
		}
		
		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number)
		{
			_speed = value;
		}

	}
	
}
