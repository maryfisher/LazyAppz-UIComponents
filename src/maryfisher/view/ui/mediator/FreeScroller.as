package maryfisher.view.ui.mediator {
	import com.greensock.easing.Sine;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class FreeScroller {
		
		static public const RIGHT_MOUSE:String = "rightMouse";
		static public const MIDDLE_MOUSE:String = "middleMouse";
		
		private var _isDragging:Boolean;
		private var _lastPos:Point;
		private var _end:Point;
		private var _startPos:Point;
		private var _content:IViewListener;
		private var _scrollWidth:int;
		private var _scrollHeight:int;
		private var _update:Signal;
		private var _dragType:String;
		private var _dragTypeDown:String;
		private var _dragTypeUp:String;
		private var _dragCount:int;
		private var _maxDragging:int = 10;
		
		public function FreeScroller(dragType:String = MIDDLE_MOUSE) {
			_dragType = dragType;
			_dragTypeDown = _dragType + "Down";
			_dragTypeUp = _dragType + "Up";
			_startPos = new Point();
			_lastPos = new Point();
			_end = new Point();
			_update = new Signal();
		}
		
		public function defineScrollArea(scrollWidth:int, scrollHeight:int):void {
			_scrollHeight = scrollHeight;
			_scrollWidth = scrollWidth;
			if (_content) {
				createMask();
				addListener();
			}
		}
		
		private function createMask():void {
			_content.clipRect = new Rectangle(_content.x, _content.y, _scrollWidth, _scrollHeight);
		}
		
		
		public function assignContent(content:IViewListener):void {
			_content = content;
			_startPos.x = _content.x;
			_startPos.y = _content.y;
		}
		
		public function addListener():void {
			//if(!_content.hasListener(MouseEvent.MIDDLE_MOUSE_DOWN)){
				//_content.addListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleDown);
			//}
			if(!_content.hasListener(_dragTypeDown)){
				_content.addListener(_dragTypeDown, onMouseDown);
			}
		}
		
		public function removeListener():void {
			
			//_content.removeListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleDown);
			_content.removeListener(_dragTypeDown, onMouseDown);
		}
		
		public function scrollTo(posx:int, posy:int, instantScroll:Boolean):void {
			_end.x = posx;
			_end.y = posy;
			scrollContent(instantScroll);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			_isDragging = true;
			_dragCount = 0;
			/** TODO
			 * 
			 */
			//_content.addListener(MouseEvent.MIDDLE_MOUSE_UP, onMouseUp);
			//_content.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMouseUp);
			_content.addListener(_dragTypeUp, onMouseUp);
			_content.addStageListener(_dragTypeUp, onMouseUp);
			_content.addListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			_lastPos.x = e.stageX;
			_lastPos.y = e.stageY;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			_isDragging = false;
			/** TODO
			 * 
			 */
			//_content.removeListener(MouseEvent.MIDDLE_MOUSE_UP, onMouseUp);
			//_content.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.removeListener(_dragTypeUp, onMouseUp);
			_content.removeStageListener(_dragTypeUp, onMouseUp);
			_content.removeListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void {
			if (_isDragging) {
				_dragCount++;
				_end.x -= (_lastPos.x - _content.stageMouseX);
				_end.y -= (_lastPos.y - _content.stageMouseY);
				_lastPos.x = _content.stageMouseX; 
				_lastPos.y = _content.stageMouseY;
				
				scrollContent(false);
			}
		}
		
		private function scrollContent(instantScroll:Boolean):void {
			_end.x = Math.min(Math.max(_end.x, _startPos.x - (_content.width - _scrollWidth)), _startPos.x);
			_end.y = Math.min(Math.max(_end.y, _startPos.y - (_content.height - _scrollHeight)), _startPos.y);
			if (_content.x == _end.x && _content.y == _end.y) {
				return;
			}
			if(!instantScroll){
				TweenLite.killTweensOf(_content);
				TweenLite.to(_content, 0.3, { y: _end.y, x:_end.x, ease:Sine.easeOut, onComplete: scrollingFinished } );
			}else {
				_content.y = _end.y;
				_content.x = _end.x;
			}
			//TweenLite.to(_content, 0.3, { x: _end.x, ease:Sine.easeOut } );
		}
		
		public function addFinishedListener(listener:Function):void {
			_update.add(listener);
		}
		
		private function scrollingFinished():void {
			_update.dispatch();
		}
		
		public function get wasDragging():Boolean {
			return _dragCount > _maxDragging;
		}
		
		public function set maxDragging(value:int):void {
			_maxDragging = value;
		}
	}

}