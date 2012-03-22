package maryfisher.view.ui.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorPicker extends Sprite {
		private var _img:BitmapData;
		
		public function ColorPicker() {
			
		}
		
		public function addColorImage(img:BitmapData):void {
			_img = img;
			graphics.beginBitmapFill(img);
			graphics.drawRect(0, 0, img.width, img.height);
			graphics.endFill();
			
			//addChild(new Bitmap(img));
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, true);
		}
		
		private function onMouseUp(e:MouseEvent):void {
			var posX:Number = e.localX;
			var posY:Number = e.localY;
			var pixelColor:uint = _img.getPixel(posX, posY);
		}
	}

}