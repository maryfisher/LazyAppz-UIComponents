package maryfisher.ui.sprite.container {
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.ui.event.ButtonEvent;
	import maryfisher.ui.sprite.button.BaseButton;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseScrollContainer extends Sprite {
		
		private var _scrollSideways:Boolean;
		private var _nextButton:BaseButton;
		private var _prevButton:BaseButton;
		private var _content:DisplayObject;
		private var _scrollWidth:int;
		private var _scrollHeight:int;
		private var _startY:int;
		private var _currentPage:int;
		private var _maxPages:int;
		private var _scrollRows:int;
		private var _end:int;
		private var _scrollMax:int;
		
		public function BaseScrollContainer() {
			
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
			_scrollMax = _scrollSideways ? _scrollWidth : _scrollHeight;
			
			if (scrollRows == 0) {
				_scrollRows = _scrollMax;
			}else {
				_scrollRows = _scrollSideways ? _scrollWidth / scrollRows : _scrollHeight / scrollRows;
			}
			
			if (_content) {
				return createMask();
			}
			
			return null;
		}
		
		public function assignScrollButtons(prevButton:BaseButton, nextButton:BaseButton):void {
			_prevButton = prevButton;
			//_prevButton.id = "prev";
			_nextButton = nextButton;
			//_nextButton.id = "next";
			/* TODO
			 * Signals!
			 */
			_prevButton.addEventListener(ButtonEvent.BUTTON_CLICKED, handleButtonClicked, false, 0, true);
			_nextButton.addEventListener(ButtonEvent.BUTTON_CLICKED, handleButtonClicked, false, 0, true);
		}
		
		public function assignContent(content:DisplayObject):void {
			_content = content;
			_startY = _content.y;
			_currentPage = 0;
		}
		
		public function updateContent():void {
			if (_scrollSideways) {
				_maxPages = (_content.width - (_scrollWidth - _scrollRows)) / _scrollRows;
			}else {
				_maxPages = (_content.height - (_scrollHeight - _scrollRows)) / _scrollRows;
			}
			enableButtons();
		}
		
		public function scrollContent(direction:int):void {
			var index:int = _currentPage + direction;
			if (index >= 0 && index <= _maxPages) {
				_currentPage = index;
			}
			
			enableButtons();
			
			_end = -((_scrollRows) * _currentPage) + _startY;
			
			var tween:Object = { time:_scrollRows / 200, transition:"easeOutSine", delay:0.1 };
			var tweenDelay:Object;
			if (_scrollSideways) {
				tweenDelay = { base:tween, x:_end };
			}else {
				tweenDelay = { base:tween, y:_end };
			}
			
			//TweenLite.to(_content, 0.5, { } );
			Tweener.addTween(_content, tweenDelay );
		}
		
		private function handleButtonClicked(event:ButtonEvent):void {
			var direction:int = event.buttonId == 'next' ? 1 : -1;
			scrollContent(direction);
		}
		
		private function createMask():DisplayObject {
			var mask:Bitmap = new Bitmap(new BitmapData(_scrollWidth, _scrollHeight, false, 0));
			mask.x = _content.x;
			mask.y = _content.y;
			_content.mask = mask;
			return mask;
		}
		
		private function enableButtons():void {
			_prevButton.enabled = (_currentPage > 0);
			_nextButton.enabled = (_currentPage < _maxPages);
		}
		
		public function dispose():void {
			
		}
	}

}