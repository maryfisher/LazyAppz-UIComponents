package maryfisher.view.ui.controller {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TouchScroller extends BaseScroller {
		
		private var _lastPos:Number;
		private var _offset:Number;
		
		public function TouchScroller() {
			
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
			
			_lastPos = _scrollSideways ? e.stageX : e.stageY;
			//calculateOffset();
		}
		
		CONFIG::touch
		private function onTouchBegin (e:TouchEvent):void {
			_content.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_content.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_content.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			//_lastPos = _scrollSideways ? e.stageX : e.stageY;
			calculateOffset();
		}
		
		CONFIG::mouse
		private function onMouseMove(e:MouseEvent):void {
			//var pos:Number = _scrollSideways ? e.stageX : e.stageY;
			//calculateMove(pos);
			trace("onScrollMouseMove");
			calculateMove();
		}
		
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void	{
			//var pos:Number = _scrollSideways ? e.stageX : e.stageY;
			//calculateMove(pos);
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
		
		private function calculateOffset():void {
			_lastPos = (_scrollSideways ? _content.stage.mouseX : _content.stage.mouseY);
			_end = (_scrollSideways ? _content.x : _content.y);
			//_offset = !_scrollSideways ? (_content.stage.mouseY - _content.y) : (_content.stage.mouseX - _content.x);
			//_offset = !_scrollSideways ? (_content.stage.mouseY) : (_content.stage.mouseX);
			//trace("start:", _content.stage.mouseX, "_conten.x", _content.x);
		}
		
		private function calculateMove():void {
		//private function calculateMove(pos:Number):void {
			var c:Number = (_scrollSideways ? _content.stage.mouseX : _content.stage.mouseY);
			_end -= (_lastPos - c);
			_lastPos = c;
			//var diff:Number = (!_scrollSideways ? _content.stage.mouseY  : _content.stage.mouseX) - _offset;
			//trace("_content.stage.mouseX", _content.stage.mouseX, "content.x", _content.x, "_offset", _offset);
			//trace("diff", diff);
			//_end = (!_scrollSideways ? _content.y : _content.x) + diff;
			//trace("end", _end);
			//trace("scrollPos", _end, "start (max)", _startPos, "end (min)", (_startPos - _scrollMax + _mask.width))
			//_end = Math.min(Math.max(_end, (_startPos - _scrollMax + _mask.width)), _startPos);
			//calculateOffset();
			//trace("scrollPos for real", _end)
			//Beschleunigung
			//var dist:Number = -(_lastPos - pos);// / ( _scrollSideways ? _content.width : _content.height);
			
			/**
				dist -29 currentPos 150
				currentPos + dist * 10 -140
				_startPos - _scrollMax + _mask.width 110
				_startPos 0
				dist -197 currentPos 149.75
				currentPos + dist * 10 -1820.25
				_startPos - _scrollMax + _mask.width 110
				_startPos 110
			 */
			//var currentPos:Number = _scrollSideways ? _content.x : _content.y;
			//trace("dist", dist, "currentPos", currentPos);
			//trace("currentPos + dist * 10", currentPos + dist * 10);
			//trace("_scrollMax, _mask.width", _scrollMax, _mask.width)
			//trace("_startPos - _scrollMax + _mask.width", _startPos - _scrollMax + _mask.width)
			//trace("_startPos", _startPos)
			//_end = Math.max((_startPos - _scrollMax + _mask.width), currentPos + dist);
			//_end = Math.min(_startPos, _end);
			
			scrollContent();
			//_lastPos = pos;
		}
	}
}