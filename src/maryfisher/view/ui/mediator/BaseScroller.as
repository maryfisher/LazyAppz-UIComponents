package maryfisher.view.ui.mediator {
	import com.greensock.easing.Sine;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	
	/**
	 *
	 * @author mary_fisher
	 */
	public class BaseScroller {
		//protected var _mask:Bitmap;
		
		protected var _scrollStops:Vector.<int>;
		protected var _scrollSideways:Boolean;
		protected var _content:IDisplayObject;
		protected var _scrollWidth:int;
		protected var _scrollHeight:int;
		protected var _startPos:int;
		protected var _scrollRows:int;
		protected var _end:int;
		protected var _scrollMax:int;
		
		public function BaseScroller() {
			
		}
		
		public function setScrollStops(stops:Vector.<int>):void {
			_scrollStops = stops;
		}
		
		/**
		 *
		 * @param	scrollWidth
		 * @param	scrollHeight
		 * @param	isHorizontal defines scroll direction
		 * @param	scrollRows defines how much should be scrolled each time (if not set, default length is length of the mask)
		 * @return mask object
		 */
		//public function defineScrollArea(scrollWidth:int, scrollHeight:int, isHorizontal:Boolean = false, scrollRows:int = 0):DisplayObject {
		public function defineScrollArea(scrollWidth:int, scrollHeight:int, isHorizontal:Boolean = false, scrollRows:int = 0):void {
			
			_scrollHeight = scrollHeight;
			_scrollWidth = scrollWidth;
			_scrollSideways = isHorizontal;
			//_scrollMax = _scrollSideways ? _scrollWidth : _scrollHeight;
			_startPos = _scrollSideways ? _content.x : _content.y;
			
			if (scrollRows == 0) {
				_scrollRows = _scrollSideways ? _scrollWidth : _scrollHeight;
			}else {
				_scrollRows = _scrollSideways ? _scrollWidth / scrollRows : _scrollHeight / scrollRows;
			}
			
			if (_content) {
				//return createMask();
				createMask();
			}
			
			//return null;
		}
		
		public function assignContent(content:IDisplayObject):void {
			_content = content;
			_startPos = _scrollSideways ? _content.x : _content.y;
			updateContent();
		}
		
		public function updateContent():void {
			_scrollMax = _scrollSideways ? _content.width : _content.height;
		}
		
		protected function nextScrollStop(dir:int):void {
			
			if(_scrollStops){
				var i:int = _scrollStops.indexOf((_scrollSideways ? _content.x : _content.y)) + dir;
				if (i < 0 || i >= _scrollStops.length) return;
				_end = _scrollStops[i];
			}
		}
		
		public function scrollContent():void {
			
			//make sure the end is within the bounds of start and max of the scrolling area
			//_end = Math.min(Math.max(_end, (_startPos - _scrollMax + (_scrollSideways ? _mask.width : _mask.height))), _startPos);
			_end = Math.min(Math.max(_end, (_startPos - _scrollMax + (_scrollSideways ? _scrollWidth : _scrollHeight))), _startPos);
			
			if ((_scrollSideways ? _content.x : _content.y) == _end) {
				return;
			}
			
			startScrolling();
		}
		
		//private function createMask():DisplayObject {
		private function createMask():void {
			//_mask = new Bitmap(new BitmapData(_scrollWidth, _scrollHeight, false, 0));
			//_mask.x = _content.x;
			//_mask.y = _content.y;
			//_content.mask = _mask;
			//return _mask;
			
			_content.clipRect = new Rectangle(_content.x, _content.y, _scrollWidth, _scrollHeight);
		}
		
		protected function startScrolling():void {
			TweenLite.killTweensOf(_content);
			_scrollSideways ? 	TweenLite.to(_content, 0.3, { x:_end, ease:Sine.easeOut, onComplete: scrollingFinished } )
							:	TweenLite.to(_content, 0.3, { y:_end, ease:Sine.easeOut, onComplete: scrollingFinished } );
		}
		
		protected function scrollingFinished():void {
			
		}
		
		public function dispose():void {
			
		}
		
		public function reset():void {
			_end = _startPos;
			if (_scrollSideways) {
				_content.x = _end;
			}else {
				_content.y = _end;
			}
		}
		
	}

}