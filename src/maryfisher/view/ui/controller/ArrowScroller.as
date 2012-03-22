package maryfisher.view.ui.controller {
	import flash.display.DisplayObject;
	import maryfisher.view.ui.interfaces.IButton;
	/**
	 * ...
	 *
	 */
	public class ArrowScroller extends BaseScroller {
		
		private var _nextButton:IButton;
		private var _prevButton:IButton;
		
		private var _lastButton:IButton;
		private var _firstButton:IButton;
		
		protected var _currentPage:int;
		protected var _maxPages:int;
		
		public function ArrowScroller() {
			
		}
		
		public function assignScrollButtons(prevButton:IButton, nextButton:IButton, lastButton:IButton = null, firstButton:IButton = null):void {
			_firstButton = firstButton;
			_lastButton = lastButton;
			_prevButton = prevButton;
			_nextButton = nextButton;
			
			//_prevButton.addEventListener(ButtonEvent.BUTTON_CLICKED, handleButtonClicked, false, 0, true);
			_prevButton.addClickedListener(onPrevButtonClicked);
			_nextButton.addClickedListener(onNextButtonClicked);
			//_nextButton.addEventListener(ButtonEvent.BUTTON_CLICKED, handleButtonClicked, false, 0, true);
			
			if (!_firstButton) {
				return;
			}
			
			_firstButton.addClickedListener(onFirstButtonClicked);
			_lastButton.addClickedListener(onLastButtonClicked);
		}
		
		private function onLastButtonClicked(button:IButton):void {
			
		}
		
		private function onFirstButtonClicked(button:IButton):void {
			
		}
		
		//private function handleButtonClicked(event:ButtonEvent):void {
			//var direction:int = event.buttonId == 'next' ? 1 : -1;
			//scrollContent(direction);
		//}
		
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
		
		override public function assignContent(content:DisplayObject):void {
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
				_maxPages = (_content.width - (_scrollWidth - _scrollRows)) / _scrollRows;
			}else {
				_maxPages = (_content.height - (_scrollHeight - _scrollRows)) / _scrollRows;
			}
			enableButtons();
		}
		
		/**
		 * for descret scrolling
		 */
		protected function setCurrentPage(direction:int):void {
			var index:int = _currentPage + direction;
			if (index >= _maxPages) {
				_currentPage = _maxPages;
			}else if (index < 0) {
				_currentPage = 0;
			}else {
				_currentPage = index;
			}
			
			/* TODO
			 * maybe on tween finish
			 */
			if (_content is IScrollContainer) {
				(_content as IScrollContainer).scrolledContent(_currentPage);
			}
			
			//enableButtons();
			
			_end = -((_scrollRows) * _currentPage) + _startPos;
			
			scrollContent();
		}
		
		public function get currentPage():int {
			return _currentPage;
		}
	}

}