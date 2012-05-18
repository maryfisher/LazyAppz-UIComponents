package maryfisher.view.model3d {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Vector3D;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DragCamera extends BaseCameraController {
		
		private var _rotate:Boolean = false;
		private var _drag:Boolean = false;
		
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastStageX:Number;
		private var _lastStageY:Number;
		private var _lastPositionX:Number;
		private var _lastPositionZ:Number;
		private var _touchPoints:int;
		private var _seconds:int;
		
		public function DragCamera(targetObject:Entity = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000) {
			super(targetObject, new Mesh(new CubeGeometry()), panAngle, tiltAngle, distance);
		}
		
		override public function start(stage:Stage = null):void {
			super.start(stage);
			CONFIG::mouse{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			CONFIG::touch{
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
			
		}
		
		//private function onStageMouseLeave(e:Event):void {
			//_drag = false;
			//_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		//}
		
		CONFIG::mouse
		private function onMouseUp(e:MouseEvent):void {
			_drag = false;
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			beginDrag(e.stageX, e.stageY);
		}
		CONFIG::touch
		private function onTouchBegin(e:TouchEvent):void {
			_touchPoints++;
			if (_touchPoints == 2) {
				beginDrag(e.stageX, e.stageY);
			}
		}
		
		private function beginDrag(stageX:Number, stageY:Number):void {
			if (stageX > _maxBoundsX || stageX < _minBoundsX) {
				return;
			}
			
			if (stageY > _maxBoundsY || stageY < _minBoundsY) {
				return;
			}
			
			_lastPositionX = _lookAtObject.x;
			_lastPositionZ = _lookAtObject.z;
			_lastStageX = stageX;
			_lastStageY = stageY;
			_drag = true;
			CONFIG::touch {
				_seconds = 8;
			}
		}
		
		override protected function onEnterFrame(e:Event):void {
			super.onEnterFrame(e);
			if (!_drag) {
				return;
			}
			CONFIG::mouse {
				_seconds++;
			}
			_lookAtObject.rotationY = _targetObject.rotationY;
			var distX:int = (_stage.mouseX - _lastStageX);
			var distZ:int = (_stage.mouseY - _lastStageY);
			_lookAtObject.moveLeft(distX);
			_lookAtObject.moveForward(distZ);
			_positionX = _lookAtObject.x;
			_positionZ = _lookAtObject.z;
			_lastStageX = _stage.mouseX;
			_lastStageY = _stage.mouseY;
			//positionX = 0.3 * (_stage.mouseX - _lastStageX) + _lastPositionX;
			//positionZ = 0.3 * (_stage.mouseY - _lastStageY) + _lastPositionZ;
			//_lookAtObject.x = _positionX;
			//_lookAtObject.z = _positionZ;
			//lookAtObject.rotationY = targetObject.rotationY;
			//_lastStageX = _stage.mouseX;
			//_lastStageX = _stage.mouseY;
			/* TODO
			 * with tween
			 */
			//notifyMoveUpdate();
		}
		CONFIG::touch
		private function onTouchEnd(e:TouchEvent):void {
			_drag = false;
			_touchPoints = 0;
		}
		
		public function get wasDragging():Boolean {
			//CONFIG::debug{
			//abhängig von der framerate!!!!
				var dragging:Boolean = _seconds > 7;
				_seconds = 0;
				return dragging;
			//}
			//_touchPoints = 0;
			//return _drag;
		}
	}

}