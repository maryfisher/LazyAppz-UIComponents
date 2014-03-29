package maryfisher.view.ui.mediator {
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ISlider;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SliderMediator {
		
		protected var _thumb:IDisplayObject;
		protected var _updateSignal:Signal;
		protected var _isVertical:Boolean;
		protected var _maxPos:int;
		protected var _minPos:int;
		protected var stage:Stage;
		protected var _currenPos:int;
		protected var _offset:Number;
		private var _lastUpdate:Number = 0;
		private var _doTween:Boolean;
		private var _downChange:Boolean;
		private var _isDown:Boolean;
		
		public function SliderMediator(doTween:Boolean = true) {
			_doTween = doTween;
			init();
		}
		
		protected function init():void {
			_updateSignal = new Signal(Number);
		}
		
		public function setMinMax(min:int, max:int):void {
			_minPos = min;
			_maxPos = max;
		}
		
		/* TODO
		 * zu IButton machen?
		 */
		public function assignThumb(thumb:IDisplayObject, minPos:int, maxPos:int, isVertical:Boolean = true):void {
			_minPos = minPos;
			_maxPos = maxPos;
			_isVertical = isVertical;
			_thumb = thumb;
			_isDown = false;
			if(_thumb.stage){
				onThumbAdded();
			}else {
				_thumb.addListener(Event.ADDED_TO_STAGE, onThumbAdded);
			}
		}
		
		private function onThumbAdded(e:Event = null):void {
			_thumb.removeListener(Event.ADDED_TO_STAGE, onThumbAdded);
			stage = _thumb.stage;
			assignListeners();
		}
		
		private function assignListeners():void {
			
			CONFIG::mouse {
				_thumb.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch{
				_thumb.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		public function setPercent(volume:Number):void {
			assignDiff((_maxPos - _minPos) * volume);
		}
		
		CONFIG::touch
		protected function onTouchBegin(e:TouchEvent):void {
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_isDown = true;
			calculateOffset();
		}
		CONFIG::touch
		protected function onTouchEnd(e:TouchEvent):void { 
			if (!_isDown) return;
			stage && stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_isDown = false;
			dispatchUpdate();
		}
		CONFIG::mouse
		protected function onMouseDown(ev:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isDown = true;
			calculateOffset();
		}
		CONFIG::mouse
		protected function onMouseUp(ev:MouseEvent):void { 
			if (!_isDown) return;
			stage && stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isDown = false;
			dispatchUpdate();
		}
		
		CONFIG::mouse
		public function mouseWheel(delta:Number):void {
			var pos:Number = (_isVertical ? _thumb.y : _thumb.x) - delta * 10;
			assignDiff(pos);
		}
		
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void {
			calculatePosition();
		}
		CONFIG::mouse
		private function onMouseMove(ev:MouseEvent):void {
			calculatePosition();
		}
		
		private function dispatchUpdate():void {
			var sp:Number = _currenPos / _maxPos;
			if (sp == _lastUpdate) return;
			_updateSignal.dispatch(sp);
			_lastUpdate = sp;
		}
		
		public function getPercent():Number {
			return _currenPos / (_maxPos - _minPos);
		}
		
		public function destroy():void {
			CONFIG::touch {
				_thumb.removeListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage && stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
			CONFIG::mouse {
				_thumb.removeListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage && stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			_thumb = null;
		}
		
		protected function assignDiff(diff:Number):void {
			_currenPos = _isVertical ? _thumb.y : _thumb.x;
			//_currenPos += diff;
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
			if(_doTween){1
				var tween:Object = _isVertical ? { y: _currenPos } : { x: _currenPos };
				TweenLite.to(_thumb, 0.3, tween);
			}else {
				_isVertical ? _thumb.y = _currenPos : _thumb.x = _currenPos;
			}
			//if (_downChange) _updateSignal.dispatch();
			if(_downChange) dispatchUpdate();
		}
		
		/**
		 * 
		 * @param	listener Function.<Number>
		 */
		public function addUpdateListener(listener:Function, downChange:Boolean):void {
			_downChange = downChange;
			_updateSignal.add(listener);
		}
		
		public function setPos(pos:int):void {
			_currenPos = pos;
			tweenThumb();
		}
		
		/* INTERFACE maryfisher.ui.interfaces.IScrollTrack */
		
		//public function get updateSignal():Signal {
			//return _updateSignal;
		//}
	}
}