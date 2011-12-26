package maryfisher.ui.sprite.container {
	//import caurina.transitions.Tweener;
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import matchmaker.component.button.ArrowButton;
	import matchmaker.component.button.AbstractButton;
	import matchmaker.event.ButtonEvent;
	//import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ArrowScrollContainerOLD extends Sprite {
		private var _scrollRows:int;
		
		protected var _scrollSideways:Boolean;
		protected var _scrollWidth:int;
		protected var _scrollHeight:int;
		protected var _maxPages:int;
		protected var _currentPage:int;
		protected var _mask:Bitmap;
		protected var _content:Sprite;
		protected var _scrollMax:int;
		protected var _prevArrow:ArrowButton;
		protected var _nextArrow:ArrowButton;
		protected var _end:int;
		protected var _startY:Number;
		//private var _updateSignal:Signal;
		
		public function ArrowScrollContainer() { 
		}
		
		public function assignClass(arrowClass:Class):void {
			
			_nextArrow = new arrowClass(true);
			addChild(_nextArrow);
			
			_prevArrow = new arrowClass(false);
			addChild(_prevArrow);
			
			addEventListener(ButtonEvent.BUTTON_CLICKED, handleScrollContent, true, 0, true);
		}
		
		public function assignRect(scrollWidth:int, scrollHeight:int, scrollSideways:Boolean, scrollRows:int = 0):void {
			
			_scrollHeight = scrollHeight;
			_scrollWidth = scrollWidth;
			_scrollSideways = scrollSideways;
			_scrollMax = _scrollSideways ? _scrollWidth : _scrollHeight;
			if (scrollRows == 0) {
				_scrollRows = _scrollMax;
			}else {
				_scrollRows = _scrollSideways ? _scrollWidth / scrollRows : _scrollHeight / scrollRows;
			}
			
			if (_scrollSideways) {
				_nextArrow.rotation = 270;
				_prevArrow.rotation = 270;
				_nextArrow.x = _scrollWidth - _nextArrow.width;
				
				var ypos:int = (scrollHeight + _nextArrow.height) / 2;
				_prevArrow.y = ypos;
				_nextArrow.y = ypos;
			}else {
				_prevArrow.y = /*-_prevArrow.height */- 10;
				_nextArrow.y = _scrollHeight - _nextArrow.height + 20;
				var xpos:int = (scrollWidth - _nextArrow.width) / 2;
				_prevArrow.x = xpos;
				_nextArrow.x = xpos;
			}
			
			_mask = new Bitmap(new BitmapData(_scrollWidth, _scrollHeight, false, 0));
			addChildAt(_mask, 0);
		}
		
		public function assignContent(content:Sprite):void {
			_content = content;
			content.mask = _mask;
			addChild(content);
			_startY = _content.y;
			
			_currentPage = 0;
			
			updateContent();
		}
		
		public function updateContent():void {
			if (_scrollSideways) {
				//_maxPages = _content.width / _scrollMax;
				_maxPages = (_content.width - (_scrollWidth - _scrollRows)) / _scrollRows;
			}else {
				//_maxPages = _content.height / _scrollMax;
				//trace('updateContent', _content.height, 'scrollHeight', _scrollHeight, 'scrollRows', _scrollRows);
				_maxPages = (_content.height - (_scrollHeight - _scrollRows)) / _scrollRows;
			}
			//trace('maxPages', _maxPages, _content.height, _scrollMax);
			enableButtons();
		}
		
		
		private function handleScrollContent(e:ButtonEvent):void {
			//trace('buttonevent??');
			if(e.target is ArrowButton){
				var direction:int = (e.target as AbstractButton).id == 'next' ? 1 : -1;
				scrollContent(direction);
			}
		}
		
		public function scrollContent(direction:int):void {
			//trace('warum scroll Content??');
			var index:int = _currentPage + direction;
			if (index >= 0 && index <= _maxPages) {
				_currentPage = index;
			}
			
			enableButtons();
			
			//_end = -((_scrollMax - _startY/2) * _currentPage) + _startY;
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
		
		private function enableButtons():void {
			_prevArrow.enabled = (_currentPage > 0);
			_nextArrow.enabled = (_currentPage < _maxPages);
		}
	}
}