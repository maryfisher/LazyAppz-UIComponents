package maryfisher.view.ui.mediator {
	import flash.geom.Point;
	import maryfisher.austengames.view.ui.preparation.invitation.TraitPage;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.IPage;
	import maryfisher.view.ui.interfaces.IPageBar;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class PageMediator {
		
		static public const NEXT_PAGE:String = ">";
		static public const LAST_PAGE:String = ">>";
		static public const PREV_PAGE:String = "<";
		static public const FIRST_PAGE:String = "<<";
		
		private var _maxPageHeight:int;
		private var _pages:Vector.<IPage>;
		private var _currentPageNum:int;
		private var _pageBar:IPageBar;
		private var _pageType:Class;
		private var _isHorizontal:Boolean;
		private var _nextButton:IButton;
		private var _prevButton:IButton;
		private var _lastButton:IButton;
		private var _firstButton:IButton;
		private var _distances:Point;
		//private var _numberButtons:Vector.<IButton>;
		
		public function PageMediator() {
			_pages = new Vector.<IPage>();
			//_numberButtons = new Vector.<IButton>();
		}
		
		public function setDimensions(maxPageHeight:int, isHorizontal:Boolean = false):void {
			_isHorizontal = isHorizontal;
			_maxPageHeight = maxPageHeight;
		}
		
		public function listMediatorSettings(dist:Point):void {
			_distances = dist;
		}
		
		public function addContent(content:IDisplayObject):IPage {
			if (!_pageType) {
				throw new Error("PageMediator Error: Please set a page type first!");
			}
			if (!_pageBar) {
				throw new Error("PageMediator Error: Please assign a page bar first!");
			}
			var l:int = _pages.length;
			if (l == 0 || !hasRoom(content, _pages[l - 1])) {
				var page:IPage = new _pageType();
				page.listMediator.setDistances(_distances);
				page.addContent(content);
				addPage(page);
				//_pages.push(page);
				//if (l == 0) {
					//page.show();
				//}else {
					//page.hide();
				//}
				//
				//var b:IButton = _pageBar.addPage((l + 1).toString());
				//if (b) {
					//_numberButtons.push(b);
					//b.addClickedListener(onNumberButtonSelected);
				//}
				
				return page;
			}
			
			return null;
		}
		
		public function addPage(page:IPage):void {
			var l:int = _pages.length;
			_pages.push(page);
			if (l == 0) {
				page.show();
			}else {
				page.hide();
			}
			
			var b:IButton = _pageBar.addPage((l + 1).toString());
			if (b) {
				//_numberButtons.push(b);
				b.addClickedListener(onNumberButtonSelected);
			}
		}
		
		public function reset():void {
			_currentPageNum = 0;
			_pageBar.reset();
			_pages = new Vector.<IPage>();
		}
		
		public function hasRoom(content:IDisplayObject, page:IPage):Boolean {
			//wir könnten den ListMediator auch noch in einen vector packen und die IPage zu einem simplen
			//IDisplayObject machen
			var childPos:Point = page.listMediator.getNextChildPos();
			var max:int = _isHorizontal ? childPos.x + content.width : childPos.y + content.height;
			if (max <= _maxPageHeight) {
				page.addContent(content);
				return true;
			}
			return false;
		}
		
		public function set pageType(value:Class):void {
			_pageType = value;
		}
		
		public function set pageBar(value:IPageBar):void {
			_pageBar = value;
			_pageBar.pageMediator = this;
		}
		
		private function onNumberButtonSelected(b:IButton):void {
			assignNewPage(parseInt(b.id) - 1);
		}
		
		public function onButtonSelected(b:IButton):void {
			var newpage:int;
			switch (b.id) {
				case NEXT_PAGE:
					if (_currentPageNum == _pages.length - 1) return;
					newpage = _currentPageNum + 1;
					break;
				case PREV_PAGE:
					if (_currentPageNum == 0) return;
					newpage = _currentPageNum - 1;
					break;
				case FIRST_PAGE:
					newpage = 0;
					break;
				case LAST_PAGE:
					newpage = _pages.length - 1;
					break;
				default:
			}
			
			assignNewPage(newpage);
		}
		
		private function assignNewPage(newpage:int):void {
			
			if (newpage == _currentPageNum) return;
			
			_pages[_currentPageNum].hide();
			_currentPageNum = newpage;
			_pages[_currentPageNum].show();
			
			enableButtons();
			
		}
		
		public function enableButtons():void {
			_firstButton.enabled = _currentPageNum != 0;
			_prevButton.enabled = _currentPageNum != 0
			_lastButton.enabled = _currentPageNum != _pages.length - 1;
			_nextButton.enabled = _currentPageNum != _pages.length - 1;
		}
		
		public function addButtons(nextButton:IButton = null, prevButton:IButton = null, lastButton:IButton = null,
					firstButton:IButton = null):void {
			if (nextButton) {
				_nextButton = nextButton;
				_nextButton.addClickedListener(onButtonSelected); //id checken?
			}
			if (prevButton) {
				_prevButton = prevButton;
				prevButton.addClickedListener(onButtonSelected); //id checken?
			}
			if (lastButton) {
				_lastButton = lastButton;
				lastButton.addClickedListener(onButtonSelected); //id checken?
			}
			if (firstButton) {
				_firstButton = firstButton;
				firstButton.addClickedListener(onButtonSelected); //id checken?
			}
		}
		
		public function destory():void {
			_pageBar.destroy();
			_firstButton.destroy();
			_prevButton.destroy();
			_nextButton.destroy();
			_lastButton.destroy();
		}
		
		public function get currentPage():IPage {
			return _pages[_currentPageNum];
		}
	}
}