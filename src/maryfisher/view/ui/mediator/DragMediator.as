package maryfisher.view.ui.mediator {
	import com.greensock.TweenLite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DragMediator {
		
		private var _offsetY:int;
		private var _offsetX:int;
		private var _currenPos:Point;
		private var _maxPos:Point;
		private var _minPos:Point;
		private var _dragObject:IViewListener;
		private var _isDown:Boolean;
		private var _updateSignal:Signal;
		private var _restrictToX:Boolean;
		private var _restrictToY:Boolean;
		//private var _stage:Stage;
		
		public function DragMediator() {
			_updateSignal = new Signal(int, int);
			_minPos = new Point();
			_maxPos = new Point();
		}
		
		/**
		 * 
		 * @param	listener Function.<int, int>
		 */
		public function addDraggedListener(listener:Function):void {
			_updateSignal.add(listener);
		}
		
		public function setMin(minX:int, minY:int):void {
			_minPos.x = minX;
			_minPos.y = minY;
		}
		
		public function setMax(maxX:int, maxY:int):void {
			_maxPos.x = maxX;
			_maxPos.y = maxY;
		}
		
		public function assignDragObject(dragObject:IViewListener):void {
			_dragObject = dragObject;
			_currenPos = new Point(_dragObject.x, _dragObject.y);
			
			
			if (!_dragObject.hasStage) {
				_dragObject.addListener(Event.ADDED_TO_STAGE, onAdded);
			}else {
				//_stage = _dragObject.stage;
				addListeners();
			}
		}
		
		private function onAdded(e:Event):void {
			_dragObject.removeListener(Event.ADDED_TO_STAGE, onAdded);
			//_stage = _dragObject.stage;
			addListeners();
		}
		
		public function destroy():void {
			removeListeners();
		}
		
		private function addListeners():void {
			CONFIG::mouse {
				_dragObject.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_dragObject.addStageListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch {
				if(!_dragObject.hasListener(TouchEvent.TOUCH_BEGIN)){
					_dragObject.addListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
					_dragObject.addListener(TouchEvent.TOUCH_END, onTouchEnd);
					_dragObject.addStageListener(TouchEvent.TOUCH_END, onTouchEnd);
				}
			}
		}
		
		private function removeListeners():void {
			CONFIG::mouse {
				_dragObject.removeListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_dragObject.removeStageListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch {
				_dragObject.addListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				_dragObject.removeListener(TouchEvent.TOUCH_END, onTouchEnd);
				_dragObject.removeStageListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		CONFIG::mouse
		private function onMouseUp(e:MouseEvent):void {
			onUp();
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			onDown();
		}
		
		CONFIG::touch
		private function onTouchBegin(e:TouchEvent):void {
			onDown();
		}
		
		CONFIG::touch
		private function onTouchEnd(e:TouchEvent):void {
			onUp();
		}
		
		public function onDown():void {
			_offsetY = _dragObject.stageMouseY - _dragObject.y;
			_offsetX = _dragObject.stageMouseX - _dragObject.x;
			_isDown = true;
			CONFIG::mouse {
				_dragObject.addStageListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			CONFIG::touch {
				_dragObject.addStageListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			}
		}
		
		public function onUp():void {
			if (!_isDown) return;
			_isDown = false;
			CONFIG::mouse {
				_dragObject.removeStageListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			CONFIG::touch {
				_dragObject.removeStageListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			}
		}
		
		CONFIG::mouse
		private function onMouseMove(e:MouseEvent):void {
			calculateMove();
		}
		
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void	{
			calculateMove();
		}
		
		private function calculateMove():void {
			assignDiff(_dragObject.stageMouseY - _offsetY, _dragObject.stageMouseX - _offsetX);
		}
		
		protected function assignDiff(diffY:Number, diffX:Number):void {
			_currenPos.x = _dragObject.x;
			_currenPos.y = _dragObject.y;
			
			var newPosX:int = Math.min(Math.max(diffX, _minPos.x), _maxPos.x);
			var newPosY:int = Math.min(Math.max(diffY, _minPos.y), _maxPos.y);
			if (newPosX != _currenPos.x && newPosY != _currenPos.y) {
				_currenPos.x = newPosX;
				_currenPos.y = newPosY;
				TweenLite.killTweensOf(_dragObject);
				if(!_restrictToX) TweenLite.to(_dragObject, 0.1, { x: newPosX });
				if(!_restrictToY) TweenLite.to(_dragObject, 0.1, { y: newPosY } );
				
				dispatch();
			}
		}
		
		private function dispatch():void {
			_updateSignal.dispatch(_currenPos.x, _currenPos.y);
		}
		
		public function set restrictToX(value:Boolean):void {
			_restrictToX = value;
		}
		
		public function set restrictToY(value:Boolean):void {
			_restrictToY = value;
		}
	}

}