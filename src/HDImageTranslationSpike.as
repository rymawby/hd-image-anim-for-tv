package
{
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class HDImageTranslationSpike extends Sprite
	{
		[Embed(source="assets/img/image_1.jpg")]
		private static const image1:Class;
		
		[Embed(source="assets/img/image_2.jpg")]
		private static const image2:Class;
		
		[Embed(source="assets/img/image_3.jpg")]
		private static const image3:Class;
		
		[Embed(source="assets/img/image_4.jpg")]
		private static const image4:Class;
		
		private var _currentIndex:int = 0;
		private var _currentImage:Bitmap;
		private var _assetList:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		private var _cycleInterval:int = 5000;
		private var _imageHolder:Sprite;
		private var _imageToBeRemoved:Bitmap;
		private var _imageSpacing:int = 1280;
		private var _transitionTimeSeconds:Number = 1;
		
		[SWF(frameRate='25', width='1280', height='720')]
		public function HDImageTranslationSpike()
		{
			initialise();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
		}
		
		protected function initialise() : void
		{
			
			_assetList.push(new image1() as Bitmap);
			_assetList.push(new image2() as Bitmap);
			_assetList.push(new image3() as Bitmap);
			_assetList.push(new image4() as Bitmap);
			
			_imageHolder = new Sprite();
			addChild(_imageHolder);
			
			var t:Timer = new Timer(_cycleInterval);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
			
			if(! _currentImage)
			{
				addNextImage();
			}
			else
			{
				next();
			}
		}
		
		private function onTimer(event:TimerEvent) : void
		{
			next();
		}
		
		public function next() : void
		{
			_currentIndex = (_currentIndex == _assetList.length - 1) ? 0 : _currentIndex + 1;
			
			if(_imageToBeRemoved) _imageHolder.removeChild(_imageToBeRemoved);
			
			_imageToBeRemoved = _currentImage;
			addNextImage();
			
			var tweenLiteVars:TweenLiteVars = new TweenLiteVars();
			tweenLiteVars.move(-(_imageSpacing * _currentIndex), _imageHolder.y);
			TweenLite.to(_imageHolder, _transitionTimeSeconds, tweenLiteVars);
		}
		
		protected function addNextImage() : void
		{
			_currentImage = _assetList[_currentIndex];
			_currentImage.x = _imageSpacing * _currentIndex;
			_imageHolder.addChild(_currentImage);
			_imageHolder.cacheAsBitmap = true;
		}
	}
}