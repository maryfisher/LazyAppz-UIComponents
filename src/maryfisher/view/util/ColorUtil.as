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
		
		static public function getHexNum(color:uint):String {
			return color.toString(16);
		}
		
		static public function getAlphaColor(alpha:uint, color:uint):uint {
			return (alpha << 24) | color;
		}
		
		static public function adjustSaturation(color:uint, s:Number):uint {
			var invs:Number = 1 - s;
			
			var irlum:Number = invs * 0.3;
			var iglum:Number = invs * 0.59;
			var iblum:Number = invs * 0.11;
			
			var r:Number = (((color >> 16) & 0xFF));
            var g:Number = (((color >> 8) & 0xFF));
            var b:Number = ((color & 0xFF));
			
			var newred:Number = r * (irlum + s) + g * iglum + b * iblum;
			var newgreen:Number = r * irlum + g * (iglum + s) + b * iblum;
			var newblue:Number = r * irlum + g * iglum + b * (iblum + s);
			
			var newColor:uint = (int(newred) << 16) | (int(newgreen) << 8) | int(newblue);
			return newColor;
			//var mat:Array = [
				//irlum + s, iglum    , iblum    , 0, 0,
				//irlum    , iglum + s, iblum    , 0, 0,
				//irlum    , iglum    , iblum + s, 0, 0,
				//0        , 0        , 0        , 1, 0 ];
			
		}
		
		//static public function desaturateColor(color:uint):uint {
			//var newColor:uint;
			//var r:Number = (((color >> 16) & 0xFF));
            //var g:Number = (((color >> 8) & 0xFF));
            //var b:Number = ((color & 0xFF));
			//
			//var newred:Number = r * 0.3 + g * 0.59 + b * 0.11;
			//var newgreen:Number = r * 0.3 + g * 0.59 + b * 0.11;
			//var newblue:Number = r * 0.3 + g * 0.59 + b * 0.11;
			//
			//newColor = (int(newred) << 16) | (int(newred) << 8) | int(newred);
			//return newColor;
		//}
		
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
		
		static public function colorBitmap(color:uint, data:BitmapData):BitmapData {
			
            var r:Number = (((color >> 16) & 0xFF) / 255);
            var g:Number = (((color >> 8) & 0xFF) / 255);
            var b:Number = ((color & 0xFF) / 255);
			var matrix:Array = [
				r * 0.3, r * 0.59, r * 0.11, 0, 0,
				g * 0.3, g * 0.59, g * 0.11, 0, 0,
				b * 0.3, b * 0.59, b * 0.11, 0, 0,
				0, 0, 0, 1, 0];
			var cl:BitmapData = data.clone();
			applyFilter(cl, new ColorMatrixFilter(matrix));
			
			return cl;
		}
		
		public static function applyFilter(data:BitmapData, filter:BitmapFilter):void {
			data.applyFilter(data, data.rect, new Point(), filter);
		}
	}

}