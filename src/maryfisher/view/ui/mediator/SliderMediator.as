package maryfisher.view.ui.mediator {
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import maryfisher.view.ui.interfaces.ISlider;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SliderMediator {
		
		protected var _thumb:IViewListener;
		protected var _updateSignal:Signal;
		protected var _isVertical:Boolean;
		protected var _maxPos:int;
		protected var _minPos:int;
		//protected var stage:Stage;
		protected var _currentPos:int;
		protected var _startPos:int;
		protected var _offset:Number;
		private var _lastUpdate:Number = 0;
		private var _doTween:Boolean;
		private var _downChange:Boolean;
		protected var _isDown:Boolean;
		private var _downSignal:Signal;
		
		public function SliderMediator(doTween:Boolean = true) {
			_doTween = doTween;
			init();
		}
		
		protected function init():void {
			_updateSignal = new Signal(Number);
			_downSignal = new Signal(Number);
		}
		
		public function setMinMax(min:int, max:int):void {
			_minPos = min;
			_maxPos = max;
		}
		
		/* TODO
		 * zu IButton machen?
		 */
		public function assignThumb(thumb:IViewListener, minPos:int, maxPos:int, isVertical:Boolean = true):void {
			_minPos = minPos;
			_maxPos = maxPos;
			_isVertical = isVertical;
			_thumb = thumb;
			_isDown = false;
			_startPos = _currentPos = _isVertical ? thumb.y : thumb.x;
			if(_thumb.hasStage){
				onThumbAdded();
			}else {
				_thumb.addListener(Event.ADDED_TO_STAGE, onThumbAdded);
			}
		}
		
		private function onThumbAdded(e:Event = null):void {
			_thumb.removeListener(Event.ADDED_TO_STAGE, onThumbAdded);
			//stage = _thumb.stage;
			assignListeners();
		}
		
		private function assignListeners():void {
			
			CONFIG::mouse {
				_thumb.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_thumb.addStageListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch{
				_thumb.addListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				_thumb.addStageListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		public function setPercent(volume:Number):void {
			//trace("[SliderMediator] setPercent", (_maxPos - _minPos) * volume);
			assignDiff(_minPos + (_maxPos - _minPos) * volume);
		}
		
		CONFIG::touch
		protected function onTouchBegin(e:TouchEvent):void {
			_thumb.addStageListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_isDown = true;
			calculateOffset();
		}
		CONFIG::touch
		protected function onTouchEnd(e:TouchEvent):void { 
			if (!_isDown) return;
			_thumb.removeStageListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			_isDown = false;
			dispatchUpdate();
		}
		CONFIG::mouse
		protected function onMouseDown(ev:MouseEvent):void {
			_thumb.addStageListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isDown = true;
			calculateOffset();
		}
		CONFIG::mouse
		protected function onMouseUp(ev:MouseEvent):void { 
			if (!_isDown) return;
			_thumb.removeStageListener(MouseEvent.MOUSE_MOVE, onMouseMove);
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
			var sp:Number = (_currentPos - _minPos) / (_maxPos - _minPos);
			//if (sp == _lastUpdate) return;
			if (!_isDown) {
				_updateSignal.dispatch(sp);
			}else {
				_downSignal.dispatch(sp);
			}
			_lastUpdate = sp;
		}
		
		public function getPercent():Number {
			//trace("[SliderMediator] getPercent _maxPos", _maxPos, "_minPos", _minPos, "_currentPos", _currenPos);
			return (_currentPos - _minPos) / (_maxPos - _minPos);
		}
		
		public function destroy():void {
			CONFIG::touch {
				_thumb.removeListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				_thumb.removeStageListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
			CONFIG::mouse {
				_thumb.removeListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_thumb.removeStageListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			_thumb = null;
		}
		
		protected function assignDiff(diff:Number):void {
			_currentPos = _isVertical ? _thumb.y : _thumb.x;
			//_currenPos += diff;
			var newPos:int = Math.min(Math.max(diff, _minPos), _maxPos);
			//trace("[SliderMediator] assignDiff", newPos, _currenPos);
			if (newPos != _currentPos) {
				_currentPos = newPos;
				tweenThumb();
			}
		}
		
		protected function calculateOffset():void {
			_offset = _isVertical ? (_thumb.stageMouseY - _thumb.y) : (_thumb.stageMouseX - _thumb.x);
		}
		
		protected function calculatePosition():void {
			assignDiff((_isVertical ? _thumb.stageMouseY  : _thumb.stageMouseX) - _offset);
		}
		
		protected function tweenThumb():void {
			if(_doTween){
				var tween:Object = _isVertical ? { y: _currentPos } : { x: _currentPos };
				tween.onComplete = onComplete;
				TweenLite.to(_thumb, 0.3, tween);
			}else {
				_isVertical ? _thumb.y = _currentPos : _thumb.x = _currentPos;
				onComplete();
			}
			//if (_downChange) _updateSignal.dispatch();
			if(_downChange) dispatchUpdate();
		}
		
		protected function onComplete():void {
			
		}
		
		/**
		 * 
		 * @param	listener Function.<Number>
		 */
		public function addUpdateListener(listener:Function, downChange:Boolean):void {
			_downChange = _downChange || downChange;
			if (downChange) {
				_downSignal.add(listener);
			}else {
				_updateSignal.add(listener);
			}
		}
		
		public function setPos(pos:int):void {
			_currentPos = pos;
			tweenThumb();
		}
		
		/* INTERFACE maryfisher.ui.interfaces.IScrollTrack */
		
		//public function get updateSignal():Signal {
			//return _updateSignal;
		//}
	}
}