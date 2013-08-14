package maryfisher.view.ui.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.util.BitmapUtil;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ExtendableTooltip extends BaseSpriteTooltip {
		
		static protected const TOP:String = "top";
		static protected const CENTER:String = "center";
		static protected const BOTTOM:String = "bottom";
		static protected const _LEFT:String = "_left";
		static protected const _RIGHT:String = "_right";
		static protected const _CENTER:String = "_center";
		
		static protected const TILES_9:String = "tiles9";
		static protected const TILES_3:String = "tiles3";
		static protected const TILES_NONE:String = "tilesNone";
		
		private var _bg:Bitmap;
		
		protected var _contentY:int;
		protected var _startY:int;
		protected var _startX:int;
		protected var _endY:int;
		protected var _endX:int;
		private var _bgDatas:Dictionary;
		private var _tiles:String;
		//protected var _top:BitmapData;
		//protected var _middle:BitmapData;
		//protected var _bottom:BitmapData;
		
		public function ExtendableTooltip(owner:DisplayObject, tiles:String = TILES_3) {
			super(owner);
			_tiles = tiles;
			_contentY = _startY;
			_bgDatas = new Dictionary();
		}
		
		protected function addBGTile(bgTile:Bitmap, pos:String):void {
			_bgDatas[pos] = bgTile.bitmapData;
		}
		
		public function addContent(content:DisplayObject, distance:int):void {
			
			content.x = _startX
			content.y = _contentY + distance;
			addChild(content);
			_contentY += content.height + distance;
			
			buildBackground();
		}
		
		public function resetContent():void {
			removeChildren();
			_contentY = _startY;
		}
		
		//protected function buildBackground(top:BitmapData, middle:BitmapData, bottom:BitmapData, height:int):void {
		/** TODO
		 * auslagern ins BitmapUtil
		 */
		protected function buildBackground():void {
			if (_bg && contains(_bg)) removeChild(_bg);
			if (_tiles == TILES_3) {
				_bg = new Bitmap(BitmapUtil.build3TileBackground(
					_bgDatas[TOP], _bgDatas[CENTER], _bgDatas[BOTTOM], height));
			}else if(_tiles == TILES_9) {
				_bg = new Bitmap(BitmapUtil.build9TileBackground(
					_bgDatas[TOP + _LEFT], _bgDatas[TOP + _CENTER], _bgDatas[TOP + _RIGHT],
					_bgDatas[CENTER + _LEFT], _bgDatas[CENTER + _CENTER], _bgDatas[CENTER + _RIGHT],
					_bgDatas[BOTTOM + _LEFT], _bgDatas[BOTTOM + _CENTER], _bgDatas[BOTTOM + _RIGHT], width + _endX, _contentY + _endY));
					
			}
			addChildAt(_bg, 0);
			//var topPlusBottom:int = _top.height + _bottom.height;
			//var bg:BitmapData;
			//var point:Point = new Point();
			//
			//if (topPlusBottom >= height) {
				//bg = new BitmapData(_top.width, topPlusBottom, true, 0);
				//bg.copyPixels(_top, _top.rect, point);
				//bg.copyPixels(_bottom, _bottom.rect, new Point(0, _top.height));
			//}else {
				//var missingHeight:int = _contentY - topPlusBottom;
				//var repeat:int = Math.ceil(missingHeight / _middle.height);
				//
				//bg = new BitmapData(_top.width, topPlusBottom + repeat * _middle.height, true, 0);
				//bg.copyPixels(_top, _top.rect, point);
				//
				//for (var i:int = 0; i < repeat; i++) {
					//point.y = _top.height + i * _middle.height;
					//bg.copyPixels(_middle, _middle.rect, point);
				//}
				//
				//bg.copyPixels(_bottom, _bottom.rect, new Point(0, _top.height + repeat * _middle.height));
			//}
			//
			//_bg = new Bitmap(bg);
			//addChildAt(_bg, 0);
		}
	}

}