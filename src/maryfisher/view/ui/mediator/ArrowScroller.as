package maryfisher.view.ui.mediator {
	import flash.display.DisplayObject;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IScrollContainer;
	/**
	 * ...
	 *
	 */
	public class ArrowScroller extends BaseScroller {
		
		static public const NEXT:String = "next";
		static public const PREV:String = "prev";
		
		private var _nextButton:IButton;
		private var _prevButton:IButton;
		
		private var _lastButton:IButton;
		private var _firstButton:IButton;
		private var _downDirection:int = 1;
		
		protected var _currentPage:int;
		protected var _maxPages:int;
		
		public function ArrowScroller() {
			
		}
		
		public function assignScrollButtons(prevButton:IButton, nextButton:IButton, onDown:Boolean = false, lastButton:IButton = null, firstButton:IButton = null):void {
			_firstButton = firstButton;
			_lastButton = lastButton;
			_prevButton = prevButton;
			_nextButton = nextButton;
			
			if(!onDown){
				_prevButton.addClickedListener(onPrevButtonClicked);
				_nextButton.addClickedListener(onNextButtonClicked);
			}else {
				_prevButton.addDownListener(onButtonDown, false);
				_prevButton.addClickedListener(onButtonUp);
				_nextButton.addDownListener(onButtonDown, false);
				_nextButton.addClickedListener(onButtonUp);
			}
			
			if (!_firstButton) {
				return;
			}
			
			_firstButton.addClickedListener(onFirstButtonClicked);
			_lastButton.addClickedListener(onLastButtonClicked);
		}
		
		private function onButtonUp(button:IButton):void {
			var pos:Number = (_startPos - _end) / _scrollRows;
			_currentPage = _downDirection == 1 ? Math.ceil(pos) : Math.floor(pos);
			calculateMove();
		}
		
		private function onButtonDown(button:IButton):void {
			
			_downDirection = button == _nextButton ? 1 : -1;
			_end = _end - (_scrollWidth / 5 * _downDirection);
			scrollContent();
		}
		
		private function onLastButtonClicked(button:IButton):void {
			_currentPage = _maxPages - 1;
			calculateMove();
		}
		
		private function onFirstButtonClicked(button:IButton):void {
			_currentPage = 0;
			calculateMove();
		}
		
		private function onNextButtonClicked(button:IButton):void {
			setCurrentPage(1);
		}
		
		private function onPrevButtonClicked(button:IButton):void {
			setCurrentPage(-1);
		}
		
		private function enableButtons():void {
			_prevButton.enabled = (_currentPage > 0);
			_nextButton.enabled = (_currentPage < _maxPages - 1);
		}
		
		override public function scrollTo(pos:int):void {
			_currentPage = Math.ceil(-( -pos - _startPos) / _scrollRows);
			super.scrollTo(pos);
		}
		
		private function calculateMove():void {
			_end = -((_scrollRows) * _currentPage) + _startPos;
			//trace("calculateMove", _end, _currentPage, _startPos);
			scrollContent();
		}
		
		override public function assignContent(content:IDisplayObject):void {
			super.assignContent(content);
			
			_currentPage = 0;
		}
		
		override public function scrollContent():void {
			super.scrollContent();
			enableButtons();
		}
		
		override public function updateContent():void {
			super.updateContent();
			if (_scrollSideways) {
				_maxPages = Math.ceil((_content.width - (_scrollWidth - _scrollRows)) / _scrollRows);
			}else {
				_maxPages = Math.ceil((_content.height - (_scrollHeight - _scrollRows)) / _scrollRows);
			}
			enableButtons();
		}
		
		/**
		 * for descret scrolling
		 */
		protected function setCurrentPage(direction:int):void {
			var index:int = _currentPage + direction;
			//trace(_currentPage, _maxPages, direction);
			if (index >= _maxPages || index < 0) {
				return;
			}
			
			_currentPage = index;
			
			/* TODO
			 * maybe on tween finish
			 */
			//if (_content is IScrollContainer) {
				//(_content as IScrollContainer).scrolledContent(_currentPage);
			//}
			
			//enableButtons();
			
			calculateMove();
		}
		
		public function get currentPage():int {
			return _currentPage;
		}
	}

}