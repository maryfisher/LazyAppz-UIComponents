package maryfisher.view.ui.mediator {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DragScroller extends BaseScroller {
		
		private var _lastPos:Number;
		private var _offset:Number;
		private var _dragMilage:int;
		
		public function DragScroller() {
			
		}
		
		override public function assignContent(content:DisplayObject):void {
			super.assignContent(content);
			
			CONFIG::mouse {
				_content.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			CONFIG::touch{
				_content.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			}
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			_content.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_content.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_dragMilage = 0;
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
			//calculateOffset();
		}
		
		CONFIG::touch
		private function onTouchBegin (e:TouchEvent):void {
			_content.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_content.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
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
			_content.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
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
			_end -= (_lastPos - c);
			_dragMilage += Math.abs(_lastPos - c);
			_lastPos = c;
			
			
			
			scrollContent();
		}
		
		public function get wasDragging():Boolean {
			if (_dragMilage > 10) {
				//_dragMilage = 0;
				return true;
			}
			
			return false;
		}
	}
}