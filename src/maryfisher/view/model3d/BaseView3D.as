package maryfisher.view.model3d {
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import maryfisher.austengames.config.ViewConstants;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseView3D extends View3D implements IView3D{
		
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		
		private var _cameraController:ICameraController;
		private var _cube:Mesh;
		
		public function BaseView3D(x:int, y:int, width:int, height:int) {
			_camera = new Camera3D();
			_scene = new Scene3D();
			super(_scene, _camera);
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
			
			//_cube = new Mesh(new CubeGeometry());
			
			//_camera.lens.far = 5000;
			//_cameraController = new CameraController()
			//_cameraController.init(_camera, _cube, 1000);
			//_cameraController.panAngle
			
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return ViewConstants.MODEL3D_VIEW;
		}
		
		public function get cameraController():ICameraController {
			return _cameraController;
		}
		
		public function set cameraController(value:ICameraController):void {
			_cameraController = value;
			_cameraController.assignBounds(x, x + width, y, y + width);
		}
		
		public function destroy():void {
			
		}
		
		public function addOnFinished(listener:Function):void {
			
		}
		
	}

}