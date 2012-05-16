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
	public class HoverCamera extends BaseCameraController {
		
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastStageX:Number;
		private var _lastStageY:Number;
		private var _move:Boolean;
		
		public function HoverCamera(targetObject:Entity = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000) {
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
		
		CONFIG::mouse
		private function onMouseUp(e:MouseEvent):void {
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void {
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::mouse
		private function onMouseDown(e:MouseEvent):void {
			_lastPanAngle = _currentPanAngle;
			_lastTiltAngle = _currentTiltAngle;
			_lastStageX = _stage.mouseX;
			_lastStageY = _stage.mouseY;
			_move = true;
			_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		CONFIG::touch
		private function onTouchBegin(e:TouchEvent):void {
			_lastPanAngle = _currentPanAngle;
			_lastTiltAngle = _currentTiltAngle;
			_lastStageX = _stage.mouseX;
			_lastStageY = _stage.mouseY;
			_move = true;
			_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		CONFIG::touch
		private function onTouchEnd(e:TouchEvent):void {
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		override protected function onEnterFrame(e:Event):void {
			if (_move) {
				panAngle = 0.3 * (_stage.mouseX - _lastStageX) + _lastPanAngle;
				tiltAngle = 0.3 * (_stage.mouseY - _lastStageY) + _lastTiltAngle;
			}
			super.onEnterFrame(e);
			
		}
	}

}