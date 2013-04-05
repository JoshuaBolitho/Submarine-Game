package  
{
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import starling.textures.TextureAtlas;
	
	public class Assets 
	{
		[Embed(source="assets/images/BgLayer1.png")]
		public static const BgLayer1:Class;
		[Embed(source="assets/images/fish01.png")]
		public static const Obstacle1:Class;
		[Embed(source="assets/images/fish02.png")]
		public static const Obstacle2:Class;
		[Embed(source="assets/images/fish03.png")]
		public static const Obstacle3:Class;
		[Embed(source="assets/images/mine.png")]
		public static const Obstacle4:Class;
		[Embed(source="assets/images/play_Btn.png")]
		public static const startBtn:Class;
		[Embed(source="assets/sprite_sheets/game.png")]
		public static const AtlasTextureGame:Class;
		[Embed(source="assets/sprite_sheets/game.xml", mimeType="application/octet-stream")]
		public static const AtlasXMLGame:Class;
		
		public static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXMLGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(namer:String):Texture
		{
			
			if(gameTextures[namer] == undefined){
				var bitmap:Bitmap = new Assets[namer]();
				gameTextures[namer] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[namer];
		}
		
	}
	
}
