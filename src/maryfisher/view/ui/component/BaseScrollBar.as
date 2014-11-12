package maryfisher.view.ui.component {
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import maryfisher.view.ui.interfaces.IScrollBar;
	import maryfisher.view.ui.mediator.BarScroller;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseScrollBar extends Sprite implements IScrollBar {
		
		protected var _track:DisplayObject;
		protected var _thumb:DisplayObject;
		private var _scrollMax:int;
		private var _scrollHeight:int;
		private var _isInvisible:Boolean;
		private var _fadeOutSpeed:Number = 0.7;
		private var _fadeInSpeed:Number = 0.3;
		private var _scroller:BarScroller;
		private var _lastPos:int;
		
		public function BaseScrollBar(isInvisible:Boolean) {
			_isInvisible = isInvisible;
			if(_isInvisible) alpha = 0;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function setScrollDims(scrollMax:int, scrollHeight:int):void {
			reset();
			_scrollHeight = scrollHeight;
			_scrollMax = scrollMax;
			
			if (_scrollHeight >= _scrollMax) return;
			
			createTrack(_scrollHeight);
			createThumb((_scrollHeight / _scrollMax) * _scrollHeight);
			
			if (!_isInvisible) {
				CONFIG::mouse {
					if (!_thumb.hasEventListener(MouseEvent.MOUSE_DOWN)) {
						_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					}
				}
			}
		}
		
		CONFIG::mouse
		private function onMouseUp(e:MouseEvent):void {
			trace("remove");
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			trace("add");
			_lastPos = e.stageY;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		CONFIG::mouse
		private function onMouseMove(e:MouseEvent):void {
			calculateMove();
		}
		
		private function calculateMove():void {
			var endY:int = stage.mouseY - _lastPos;
			
			//var diffY:int = - _lastPos + stage.mouseY;
			//var endY:int = _thumb.y + diffY;
			//if (endY > (_scrollHeight - _thumb.height)) {
				//endY = _scrollHeight - _thumb.height - 1;
			//}else if (endY < 1) {
				//endY = 1;
			//}
			
			var scrollEnd:int = endY * (_scrollMax - _scrollHeight) / (_scrollHeight - _thumb.height);
			//TweenMax.killTweensOf(_thumb);
			//TweenMax.to(_thumb, _fadeInSpeed, { y: endY } );
			//trace("[BaseScrollBar] calculateMove scrollEnd", scrollEnd);
			_scroller.scrollTo(scrollEnd);
		}
		
		protected function reset():void {
			removeChildren();
			if (_thumb && _thumb.hasEventListener(MouseEvent.MOUSE_DOWN)) {
				_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
		}
		
		public function startScrolling(scrollEnd:int):void {
			//fade in
			if (!_thumb) return;
			var perc:Number = scrollEnd / (_scrollMax - _scrollHeight);
			var px:int = scrollEnd > _thumb.y ? -1 : 1;
			var pos:int = (_scrollHeight - _thumb.height) * perc + px;
			
			TweenMax.killTweensOf(_thumb);
			TweenMax.to(_thumb, _fadeInSpeed, { y: pos } );
			
			if (!_isInvisible) return;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, _fadeInSpeed, { alpha: 1 } );
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function finishedScrolling():void {
			if (!_isInvisible) return;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, _fadeOutSpeed, { alpha: 0 } );
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function set scroller(value:BarScroller):void {
			_scroller = value;
		}
		
		protected function createTrack(trackHeight:int):void {	}
		
		protected function createThumb(thumbHeight:int):void {	}
		
		public function set fadeOutSpeed(value:Number):void {
			_fadeOutSpeed = value;
		}
		
		public function set fadeInSpeed(value:Number):void {
			_fadeInSpeed = value;
		}
		
	}

}