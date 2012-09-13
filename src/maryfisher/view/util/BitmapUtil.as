package maryfisher.view.util {
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BitmapUtil {
		
		public function BitmapUtil() {
			
		}
		
		static public function build3TileBackground(top:BitmapData, middle:BitmapData, bottom:BitmapData, height:int):BitmapData {
			var topPlusBottom:int = top.height + bottom.height;
			var bg:BitmapData;
			var point:Point = new Point();
			
			if (topPlusBottom >= height) {
				bg = new BitmapData(top.width, topPlusBottom, true, 0);
				bg.copyPixels(top, top.rect, point);
				bg.copyPixels(bottom, bottom.rect, new Point(0, top.height));
			}else {
				var missingHeight:int = height - topPlusBottom;
				var repeat:int = Math.ceil(missingHeight / middle.height);
				
				bg = new BitmapData(top.width, topPlusBottom + repeat * middle.height, true, 0);
				bg.copyPixels(top, top.rect, point);
				
				for (var i:int = 0; i < repeat; i++) {
					point.y = top.height + i * middle.height;
					bg.copyPixels(middle, middle.rect, point);
				}
				
				bg.copyPixels(bottom, bottom.rect, new Point(0, top.height + repeat * middle.height));
			}
			
			return bg;
		}
		
		static public function getPowerOf2(width:int):int {
			var origWidth:int = width;
			var i:int = 64;
			while (width == origWidth) {
				width = Math.max(width, i);
				i = i * 2;
			}
			
			return width;
		}
		
		static public function getPowerOf2Bitmap(b:BitmapData):BitmapData {
			var b2:BitmapData = new BitmapData(getPowerOf2(b.width), getPowerOf2(b.height), true, 0);
			b2.copyPixels(b, b.rect, new Point(), b, new Point(), true);
			return b2;
		}
	}

}