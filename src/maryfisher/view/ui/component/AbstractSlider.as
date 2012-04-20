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
	public class AbstractSlider implements ISlider {
		
		protected var _thumb:DisplayObject;
		protected var _updateSignal:Signal;
		protected var _isVertical:Boolean;
		protected var _maxPos:int;
		protected var _minPos:int;
		protected var stage:Stage;
		protected var _currenPos:int;
		protected var _offset:Number;
		
		public function AbstractSlider() {
			init();
		}
		
		/* TODO
		 * zu IButton machen?
		 */
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
			
			CONFIG::mouse {
				_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch{
				_thumb.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		protected function init():void {
			_updateSignal = new Signal(Number);
		}
		
		CONFIG::touch
		protected function onTouchBegin(e:TouchEvent):void {
			calculateOffset();
		}
		CONFIG::touch
		protected function onTouchEnd(e:TouchEvent):void { }
		CONFIG::mouse
		protected function onMouseDown(ev:MouseEvent):void {
			calculateOffset();
		}
		CONFIG::mouse
		protected function onMouseUp(ev:MouseEvent):void { }
		
		public function destroy():void {
			CONFIG::touch {
				_thumb.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage && stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
			CONFIG::mouse {
				_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage && stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			_thumb = null;
		}
		
		protected function assignDiff(diff:Number):void {
			_currenPos = _isVertical ? _thumb.y : _thumb.x;
			_currenPos += diff;
			var newPos:int = Math.min(Math.max(diff, _minPos), _maxPos);
			if (newPos != _currenPos) {
				_currenPos = newPos
				tweenThumb();
			}
		}
		
		protected function calculateOffset():void {
			_offset = _isVertical ? (stage.mouseY - _thumb.y) : (stage.mouseX - _thumb.x);
		}
		
		protected function calculatePosition():void {
			assignDiff((_isVertical ? stage.mouseY  : stage.mouseX) - _offset);
		}
		
		protected function tweenThumb():void {
			var base:Object = { time:0.3 };
			var tween:Object = _isVertical ? { y: _currenPos, base: base } : { x: _currenPos, base: base };
			Tweener.addTween(_thumb, tween);
		}
		
		/* INTERFACE maryfisher.ui.interfaces.IScrollTrack */
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
	}
}