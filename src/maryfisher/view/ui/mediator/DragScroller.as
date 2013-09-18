package maryfisher.view.ui.mediator {
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.IScrollBar;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DragScroller extends BaseScroller {
		
		private var _lastPos:Number;
		private var _offset:Number;
		private var _dragMilage:int;
		private var _scrollBar:IScrollBar;
		private var _dragMax:int = 10;
		
		public function DragScroller(dragMax:int = 10) {
			_dragMax = dragMax;
			
		}
		
		override public function assignContent(content:IDisplayObject):void {
			super.assignContent(content);
			
			CONFIG::mouse {
				if(!_content.hasListener(MouseEvent.MOUSE_DOWN)){
					_content.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					_content.addListener(MouseEvent.MOUSE_OVER, onMouseOver);
					_content.addListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
			}
			CONFIG::touch {
				if(!_content.hasListener(TouchEvent.TOUCH_BEGIN)){
					_content.addListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				}
			}
		}
		
		CONFIG::mouse
		private function onMouseOut(e:MouseEvent):void {
			_content.removeListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		CONFIG::mouse
		private function onMouseOver(e:MouseEvent):void {
			_content.addListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		CONFIG::mouse
		private function onMouseWheel(e:MouseEvent):void {
			_end += e.delta * 10;
			
			scrollContent();
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			_content.addListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_content.addListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_dragMilage = 0;
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
			//calculateOffset();
		}
		
		CONFIG::touch
		private function onTouchBegin (e:TouchEvent):void {
			_content.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_content.addListener(TouchEvent.TOUCH_END, onTouchEnd);
			_content.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			_dragMilage = 0;
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
			//calculateOffset();
		}
		
		//private function calculateOffset():void {
			//_lastPos = (_scrollSideways ? _content.stage.mouseX : _content.stage.mouseY);
			//_end = (_scrollSideways ? _content.x : _content.y);
		//}
		
		CONFIG::mouse
		private function onMouseMove(e:MouseEvent):void {
			calculateMove();
		}
		
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void	{
			calculateMove();
		}
		
		CONFIG::mouse
		private function onMouseUp(e:MouseEvent):void {
			_content.removeListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//_content.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		CONFIG::touch
		private function onTouchEnd(e:TouchEvent):void {
			_content.stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			//_content.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_content.stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function calculateMove():void {
			var c:Number = (_scrollSideways ? _content.stage.mouseX : _content.stage.mouseY);
			if(!_scrollStops){
				_end -= (_lastPos - c);
				_dragMilage += Math.abs(_lastPos - c);
				_lastPos = c;
			}else {
				nextScrollStop((_lastPos - c) > 0 ? 1 : -1);
			}
			
			scrollContent();
		}
		
		public function get wasDragging():Boolean {
			if (_dragMilage > _dragMax) {
				//_dragMilage = 0;
				return true;
			}
			
			return false;
		}
		
		public function set scrollBar(value:IScrollBar):void {
			_scrollBar = value;
		}
		
		public function set dragMax(value:int):void {
			_dragMax = value;
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