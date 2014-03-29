package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IScrollBar;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BarScroller extends MouseScroller {
		
		private var _scrollBar:IScrollBar;
		
		public function BarScroller() {
			
		}
		
		public function set scrollBar(value:IScrollBar):void {
			_scrollBar = value;
			_scrollBar.scroller = this;
		}
		
		override public function updateContent():void {
			super.updateContent();
			_scrollBar && (_scrollBar.setScrollDims(_scrollMax, _scrollHeight));
		}
		
		override protected function startScrolling():void {
			super.startScrolling();
			_scrollBar && (_scrollBar.startScrolling(_startPos - _end));
		}
		
		override protected function scrollingFinished():void {
			super.scrollingFinished();
			_scrollBar && (_scrollBar.finishedScrolling());
		}
		
	}

}