package maryfisher.view.ui.container {
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
			scrollContent(1);
		}
		
		private function onPrevButtonClicked(button:IButton):void {
			scrollContent(-1);
		}
		
		private function enableButtons():void {
			_prevButton.enabled = (_currentPage > 0);
			_nextButton.enabled = (_currentPage < _maxPages - 1);
		}
		
		override public function scrollContent(direction:int):void {
			super.scrollContent(direction);
			enableButtons();
		}
		
		override public function updateContent():void {
			super.updateContent();
			enableButtons();
		}
	}

}