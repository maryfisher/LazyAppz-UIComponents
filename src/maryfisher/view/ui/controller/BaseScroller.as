package maryfisher.view.ui.controller {
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.interfaces.IButton;
	
	/**
	 *
	 * @author mary_fisher
	 */
	public class BaseScroller {
		protected var _mask:Bitmap;
		
		protected var _scrollSideways:Boolean;
		protected var _content:DisplayObject;
		protected var _scrollWidth:int;
		protected var _scrollHeight:int;
		protected var _startPos:int;
		//protected var _currentPage:int;
		//protected var _maxPages:int;
		protected var _scrollRows:int;
		protected var _end:int;
		protected var _scrollMax:int;
		
		public function BaseScroller() {
			
		}
		
		/**
		 *
		 * @param	scrollWidth
		 * @param	scrollHeight
		 * @param	isHorizontal defines scroll direction
		 * @param	scrollRows defines how much should be scrolled each time (if not set, default length is length of the mask)
		 * @return mask object
		 */
		public function defineScrollArea(scrollWidth:int, scrollHeight:int, isHorizontal:Boolean = false, scrollRows:int = 0):DisplayObject {
			
			_scrollHeight = scrollHeight;
			_scrollWidth = scrollWidth;
			_scrollSideways = isHorizontal;
			//_scrollMax = _scrollSideways ? _scrollWidth : _scrollHeight;
			_startPos = _scrollSideways ? _content.x : _content.y;
			
			if (scrollRows == 0) {
				_scrollRows = _scrollSideways ? _scrollWidth : _scrollHeight;
			}else {
				//trace(_scrollRows, _scrollWidth / scrollRows)
				_scrollRows = _scrollSideways ? _scrollWidth / scrollRows : _scrollHeight / scrollRows;
			}
			
			if (_content) {
				return createMask();
			}
			
			return null;
		}
		
		public function assignContent(content:DisplayObject):void {
			_content = content;
		}
		
		public function updateContent():void {
			_scrollMax = _scrollSideways ? _content.width : _content.height;
			//trace("_scrollMax", _scrollMax);
		}
		
		public function scrollContent():void {
			
			_end = Math.min(Math.max(_end, (_startPos - _scrollMax + (_scrollSideways ? _mask.width : _mask.height))), _startPos);
			
			if ((_scrollSideways ? _content.x : _content.y) == _end) {
				return;
			}
			
			Tweener.removeTweens(_content);
			//var tween:Object = { time:_scrollRows / 400, transition:"easeOutSine", delay:0.1 };
			//var time:Number = Math.abs(_end - (_scrollSideways ? _content.x : _content.y)) / 300;
			var tween:Object = { time: 0.3, transition:"easeOutSine" };
			var tweenDelay:Object = _scrollSideways ? { base:tween, x:_end } : { base:tween, y:_end };
			Tweener.addTween(_content, tweenDelay );
		}
		
		private function createMask():DisplayObject {
			_mask = new Bitmap(new BitmapData(_scrollWidth, _scrollHeight, false, 0));
			_mask.x = _content.x;
			_mask.y = _content.y;
			_content.mask = _mask;
			return _mask;
		}
		
		public function dispose():void {
			
		}
		
	}

}