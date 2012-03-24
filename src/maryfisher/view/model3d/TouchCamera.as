package maryfisher.view.model3d {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TouchCamera extends BaseCameraController {
		
		private var _rotate:Boolean = false;
		private var _drag:Boolean = false;
		
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastStageX:Number;
		private var _lastStageY:Number;
		private var _lastPositionX:Number;
		private var _lastPositionZ:Number;
		
		public function TouchCamera(targetObject:Entity = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000) {
			super(targetObject, new Mesh(new CubeGeometry()), panAngle, tiltAngle, distance);
		}
		
		override public function start(stage:Stage = null):void {
			super.start(stage);
			CONFIG::debug{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
		}
		
		private function onMouseUp(e:MouseEvent):void {
			_drag = false;
		}
		
		private function onMouseDown(e:MouseEvent):void {
			_lastPositionX = _lookAtObject.x;
			_lastPositionZ = _lookAtObject.z;
			_lastStageX = e.stageX;
			_lastStageY = e.stageY;
			_drag = true;
		}
		
		private function onTouchBegin(event:TouchEvent):void {
			_lastPositionX = _lookAtObject.x;
			_lastPositionZ = _lookAtObject.z;
			_lastStageX = event.stageX;
			_lastStageY = event.stageY;
			_drag = true;
		}
		
		override protected function onEnterFrame(e:Event):void {
			super.onEnterFrame(e);
			if (!_drag) {
				return;
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
		
		private function onTouchEnd(e:TouchEvent):void {
			_drag = false;
		}
	}

}