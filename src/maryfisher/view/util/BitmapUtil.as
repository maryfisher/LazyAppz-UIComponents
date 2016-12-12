package maryfisher.view.util {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BitmapUtil {
		
		public function BitmapUtil() {
			
		}
		
		//static public function buildUniqueFrame():void {
			//
		//}
		
		static public function resizeBitmap(data:BitmapData, width:int, height:int):BitmapData {
			//var data:BitmapData = bm.bitmapData;
			var matrix:Matrix = new Matrix();
			matrix.scale(width / data.width, height / data.height);
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0);
			bitmapData.draw(data, matrix);
			//return new Bitmap(bitmapData);
			return bitmapData;
		}
		
		static public function build9Tile(base:BitmapData, leftW:int, centerW:int, rightW:int, topH:int, centerH:int, 
			bottomH:int, w:int, h:int):BitmapData {
			
			var leftPlusRight:int = leftW + rightW;
			var topPlusBottom:int = topH + bottomH;
			
			var actwidth:int;
			var repeatWidth:int = 0;
			var centerWidth:int = 0;
			if (leftPlusRight >= w) {
				actwidth = leftPlusRight;
			} else {
				repeatWidth = Math.ceil((w - leftPlusRight) / centerW);
				centerWidth = repeatWidth * centerW;
				actwidth = leftPlusRight + centerWidth;
			}
			
			var actheight:int;
			var repeatHeight:int;
			var centerHeight:int;
			if (topPlusBottom >= h) {
				actheight = topPlusBottom;
			}else {
				repeatHeight = Math.ceil((h - topPlusBottom) / centerH);
				centerHeight = repeatHeight * centerH;
				actheight = topPlusBottom + centerHeight;
			}
			
			var point:Point = new Point();
			var rect:Rectangle = new Rectangle();
			var tile:BitmapData = new BitmapData(actwidth, actheight, true, 0);
			//leftTop
			rect.width = leftW;
			rect.height = topH;
			tile.copyPixels(base, rect, point);
			//rightTop
			rect.width = rightW;
			rect.height = topH;
			rect.x = leftW + centerW;
			point.x = leftW + centerWidth;
			tile.copyPixels(base, rect, point);
			//bottomRight
			rect.width = rightW;
			rect.height = bottomH;
			rect.y = topH + centerH;
			point.y = topH + centerHeight;
			tile.copyPixels(base, rect, point);
			//bottomLeft
			rect.width = leftW;
			rect.height = bottomH;
			rect.x = point.x = 0;
			tile.copyPixels(base, rect, point);
			
			for (var i:int = 0; i < repeatWidth; i++) {
				//top center width
				rect.x = leftW;
				point.x = leftW + i * centerW;
				rect.y = point.y = 0;
				tile.copyPixels(base, rect, point);
				//center width / height
				for (var j:int = 0; j < repeatHeight; j++) {
					rect.y = topH;
					point.y = topH + j * centerH;
					tile.copyPixels(base, rect, point);
				}
				//bottom center width
				rect.y = topH + centerH;
				point.y = topH + centerHeight;
				tile.copyPixels(base, rect, point);
			}
			for (i = 0; i < repeatHeight; i++) {
				//center left height
				rect.y = topH;
				point.y = topH + i * centerH;
				rect.x = point.x = 0;
				tile.copyPixels(base, rect, point);
				//center right height
				rect.x = leftW + centerW;
				point.x = leftW + centerWidth;
				tile.copyPixels(base, rect, point);
			}
			
			return tile;
		}

		static public function build9TileBackground(topleft:BitmapData, topcenter:BitmapData, topright:BitmapData,
			centerleft:BitmapData, center:BitmapData, centerright:BitmapData, 
			bottomleft:BitmapData, bottomcenter:BitmapData, bottomright:BitmapData, width:int, height:int):BitmapData {
				
			
			var topPlusBottom:int = topleft.height + bottomleft.height; // + centerleft.height
			var leftPlusRight:int = topleft.width + topright.width; // + topcenter.width
			
			var bg:BitmapData;
			var point:Point = new Point();
			
			var actwidth:int;
			var repeatWidth:int = 0;
			var centerWidth:int = 0;
			if (leftPlusRight >= width) {
				actwidth = leftPlusRight;
			}else {
				repeatWidth = Math.ceil((width - leftPlusRight) / topcenter.width);
				centerWidth = repeatWidth * topcenter.width;
				actwidth = leftPlusRight + centerWidth;
			}
			
			var actheight:int;
			var repeatHeight:int;
			var centerHeight:int;
			if (topPlusBottom >= height) {
				actheight = topPlusBottom;
			}else {
				repeatHeight = Math.ceil((height - topPlusBottom) / centerleft.height);
				centerHeight = repeatHeight * centerleft.height;
				actheight = topPlusBottom + centerHeight;
			}
			
			bg = new BitmapData(actwidth, actheight, true, 0);
			bg.copyPixels(topleft, topleft.rect, point);
			point.x = topleft.width + repeatWidth * topcenter.width;
			bg.copyPixels(topright, topright.rect, point);
			point.y =  topleft.height + centerHeight;
			bg.copyPixels(bottomright, bottomright.rect, point);
			point.x = 0;
			bg.copyPixels(bottomleft, bottomleft.rect, point);
			
			for (var i:int = 0; i < repeatWidth; i++) {
				//top center width
				point.x = topleft.width + i * topcenter.width;
				point.y = 0;
				bg.copyPixels(topcenter, topcenter.rect, point);
				//center width / height
				for (var j:int = 0; j < repeatHeight; j++) {
					point.y = topleft.height + j * center.height;
					bg.copyPixels(center, center.rect, point);
				}
				//bottom center width
				point.y = topleft.height + centerHeight;
				bg.copyPixels(bottomcenter, bottomcenter.rect, point);
			}
			for (i = 0; i < repeatHeight; i++) {
				//center left height
				point.y = topleft.height + i * centerleft.height;
				point.x = 0;
				bg.copyPixels(centerleft, centerleft.rect, point);
				//center right height
				point.x = topleft.width + centerWidth;
				bg.copyPixels(centerright, centerright.rect, point);
			}
			
			return bg;
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
		
		static public function build3TileWBackground(left:BitmapData, middle:BitmapData, right:BitmapData, width:int):BitmapData {
			var leftPlusRight:int = left.width + right.width;
			var bg:BitmapData;
			var point:Point = new Point();
			
			if (leftPlusRight >= width) {
				bg = new BitmapData(leftPlusRight, left.height, true, 0);
				bg.copyPixels(left, left.rect, point);
				bg.copyPixels(right, right.rect, new Point(left.width, 0));
			}else {
				var missingWidth:int = width - leftPlusRight;
				var repeat:int = Math.ceil(missingWidth / middle.width);
				
				bg = new BitmapData(leftPlusRight + repeat * middle.width, left.height, true, 0);
				bg.copyPixels(left, left.rect, point);
				
				for (var i:int = 0; i < repeat; i++) {
					point.x = left.width + i * middle.width;
					bg.copyPixels(middle, middle.rect, point);
				}
				
				bg.copyPixels(right, right.rect, new Point(left.width + repeat * middle.width, 0));
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
		
		static public function getPowerOf2ScaledBitmap(b:BitmapData, center:Boolean = false):BitmapData {
			var b2:BitmapData = new BitmapData(getPowerOf2(b.width), getPowerOf2(b.height), true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(b2.width / b.width, b2.height / b.height);
			b2.draw(b, matrix);
			return b2;
		}
		
		static public function getPowerOf2Bitmap(b:BitmapData, center:Boolean = false):BitmapData {
			var b2:BitmapData = new BitmapData(getPowerOf2(b.width), getPowerOf2(b.height), true, 0);
			var offsetPoint:Point = center ? new Point((b2.width - b.width) / 2, (b2.height - b.height) / 2) : new Point();
			b2.copyPixels(b, b.rect, offsetPoint, b, offsetPoint, true);
			return b2;
		}
		
		static public function tileBitmap(tile:BitmapData, w:int, h:int):BitmapData {
			
			var tw:int = tile.width;
			var th:int = tile.height;
			var repeatW:int = Math.ceil(w / tw);
			var repeatH:int = Math.ceil(h / th);
			var point:Point = new Point();
			var tiled:BitmapData = new BitmapData(w, h, tile.transparent, 0);
			for (var i:int = 0; i < repeatW; i++) {
				for (var j:int = 0; j < repeatH; j++) {
					point.x = i * tw;
					point.y = j * th;
					tiled.copyPixels(tile, tile.rect, point);
				}
			}
			
			return tiled;
		}
		
		static public function getBitmapOverState(b:BitmapData, color:uint = 0x66FFFFFF):BitmapData {
			var bWhite:BitmapData = new BitmapData(b.width, b.height, true, color);
			var bOver:BitmapData = b.clone();
			var point:Point = new Point();
			bOver.copyPixels(bWhite, bWhite.rect, point, b, point, true);
			
			return bOver;
		}
	}

}