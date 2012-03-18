package maryfisher.view.ui.container {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TouchScroller extends BaseScroller {
		
		private var _lastPos:Number;
		
		public function TouchScroller() {
			
		}
		
		override public function assignContent(content:DisplayObject):void {
			super.assignContent(content);
			
			CONFIG::debug {
				_content.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			
			_content.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		}
		
		CONFIG::debug
		private function onMouseDown(e:MouseEvent):void {
			_content.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_content.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
		}
		
		private function onTouchBegin (e:TouchEvent):void {
			_content.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_content.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_content.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
		}
		
		CONFIG::debug
		private function onMouseMove(e:MouseEvent):void {
			var pos:Number = _scrollSideways ? e.stageX : e.stageY;
			calculateMove(pos);
		}
		
		CONFIG::debug
		private function onMouseUp(e:MouseEvent):void {
			_content.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_content.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onTouchMove(e:TouchEvent):void	{
			var pos:Number = _scrollSideways ? e.stageX : e.stageY;
			
			calculateMove(pos);
		}
		
		private function onTouchEnd(e:TouchEvent):void {
			_content.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_content.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_content.stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function calculateMove(pos:Number):void {
			//Beschleunigung
			var dist:Number = -(_lastPos - pos);// / ( _scrollSideways ? _content.width : _content.height);
			
			
			var currentPos:Number = _scrollSideways ? _content.x : _content.y;
			
			_end = Math.max((_startPos - _scrollMax + _mask.width), currentPos + dist * 10);
			_end = Math.min(_startPos, _end);
			
			scrollContent();
			_lastPos = pos;
		}
	}
}