package maryfisher.view.ui.component {
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.interfaces.ISlider;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSlider implements ISlider {
		
		private var _offset:Number;
		private var _thumb:DisplayObject;
		private var _updateSignal:Signal;
		private var _isTouch:Boolean;
		private var _isVertical:Boolean;
		private var _maxPos:int;
		private var _minPos:int;
		private var stage:Stage;
		
		public function BaseSlider(isTouch:Boolean = false) {
			_isTouch = isTouch;
			_updateSignal = new Signal(Number);
		}
		
		public function assignThumb(thumb:DisplayObject, minPos:int, maxPos:int, isVertical:Boolean = true):void {
			_minPos = minPos;
			_maxPos = maxPos;
			_isVertical = isVertical;
			_thumb = thumb;
			if(_thumb.stage){
				onThumbAdded();
			}else {
				_thumb.addEventListener(Event.ADDED_TO_STAGE, onThumbAdded);
			}
		}
		
		private function onThumbAdded(e:Event = null):void {
			_thumb.removeEventListener(Event.ADDED_TO_STAGE, onThumbAdded);
			stage = _thumb.stage;
			assignListeners();
		}
		
		private function assignListeners():void {
			CONFIG::debug {
				if (_isTouch) {
					_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
					stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
				}
			}
			
			if (!_isTouch) {
				_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			}else if(_isTouch){
				_thumb.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, touchEnd);
			}
		}
		
		private function touchEnd(e:TouchEvent):void {
			stage && stage.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
		}
		
		private function thumbUp(ev:MouseEvent):void {
			stage && stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		private function touchBegin(e:TouchEvent):void {
			stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			calculateOffset();
		}
		
		private function thumbDown(ev:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			calculateOffset()
		}
		
		public function mouseWheel(delta:Number):void {
			var pos:Number = (_isVertical ? _thumb.y : _thumb.x) - delta * 10;
			assignDiff(pos);
		}
		
		private function touchMove(e:TouchEvent):void {
			calculatePosition();
		}
		
		private function thumbMove(ev:MouseEvent):void {
			calculatePosition();
		}
		
		private function assignDiff(diff:Number):void {
			var currenPos:int = _isVertical ? _thumb.y : _thumb.x;
			currenPos += diff;
			currenPos = Math.min(Math.max(diff, _minPos), _maxPos);
			
			var sp:Number = currenPos / _maxPos;
			_updateSignal.dispatch(sp);
			var base:Object = { time:0.3 };
			var tween:Object = _isVertical ? { y: currenPos, base: base } : { x: currenPos, base: base };
			Tweener.addTween(_thumb, tween);
		}
		
		private function calculateOffset():void {
			_offset = _isVertical ? (stage.mouseY - _thumb.y) : (stage.mouseX - _thumb.x);
		}
		
		private function calculatePosition():void {
			assignDiff((_isVertical ? stage.mouseY  : stage.mouseX) - _offset);
		}
		
		public function destroy():void {
			if (_isTouch) {
				_thumb.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				stage && stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
			}else{
				_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
				stage && stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
			}
			_thumb = null;
		}
		
		/* INTERFACE maryfisher.ui.interfaces.IScrollTrack */
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
	}
}