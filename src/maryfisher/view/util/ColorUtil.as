package maryfisher.view.util {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorUtil {
		
		public function ColorUtil() {
			
		}
		
		static public function desaturate(d:DisplayObject):void {
			d.filters = [new ColorMatrixFilter(
				[0.2126, 0.7152, 0.0722, 0, 0,
				 0.2126, 0.7152, 0.0722, 0, 0,
				 0.2126, 0.7152, 0.0722, 0, 0,
				 0, 0, 0, 1, 0])];
		}
		
		static public function setTransparency(data:BitmapData, alpha:Number = 1):BitmapData {
			var matrix:Array = [
				1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				alpha, alpha, alpha, alpha, 0];
			var cl:BitmapData = data.clone();
			applyFilter(cl, new ColorMatrixFilter(matrix));
			
			return cl;
		}
		
		public static function desaturateBitmapData(data:BitmapData, alpha:Number = 1):BitmapData{
			var matrix:Array = [
				0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				alpha, alpha, alpha, alpha, 0];
			var cl:BitmapData = data.clone();
			applyFilter(cl, new ColorMatrixFilter(matrix));
			
			return cl;
		}
		
		public static function applyFilter(data:BitmapData, filter:BitmapFilter):void {
			data.applyFilter(data, data.rect, new Point(), filter)
		}
	}

}