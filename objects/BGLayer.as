package objects {
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	import flash.events.Event;
	
	public class BGLayer extends Sprite {
		
		private var image1:Image;
		private var image2:Image;
		
		private var _layer:int;
		private var _parallax:Number;

		public function BGLayer(layer:int) {
			super();
			this._layer = layer;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(_layer == 0)
			{
				image1 = new Image(Assets.getTexture("BgLayer" + _layer));
				image2 = new Image(Assets.getTexture("BgLayer" + _layer));
			}
			else
			{
				image1 = new Image(Assets.getAtlas().getTexture("BgLayer" + _layer));
				image2 = new Image(Assets.getAtlas().getTexture("BgLayer" + _layer));
			}
			
			image1.x = 0;
			image1.y = stage.stageHeight - image1.height;
			
			image2.x = image2.width;
			image2.y = image1.y;
			
			this.addChild(image1);
			this.addChild(image2);
		}
		
		public function get parallax():Number
		{
			return _parallax;
		}
		
		public function set parallax(value:Number)
		{
			_parallax = value;
		}

	}
	
}
