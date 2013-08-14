package maryfisher.view.model3d.camera {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import maryfisher.framework.config.KeyboardConfig;
	import maryfisher.framework.core.IKeyListener;
	import maryfisher.framework.core.KeyController;
	import maryfisher.framework.data.KeyComboData;
	import maryfisher.framework.view.ICameraObject;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ScrollCameraBehavior extends AbstractCameraBehavior implements IKeyListener{
		
		static public const TOP:String = "top";
		static public const RIGHT:String = "right";
		static public const LEFT:String = "left";
		static public const BOTTOM:String = "bottom";
		
		private var _moveVector:Vector3D;
		private var _isMoving:Boolean = false;
		private var _scrollPanels:Vector.<ICameraScrollObject>;
		private var _moveDistance:int = 50;
		
		public function ScrollCameraBehavior(cameraController:BaseCameraController, scrollPanels:Vector.<ICameraScrollObject>) {
			super(cameraController);
			_scrollPanels = scrollPanels;
			
			_moveVector = new Vector3D();
		}
		
		override public function start(stage:Stage):void {
			super.start(stage);
			
			for each (var panel:ICameraScrollObject in _scrollPanels) {
				panel.addListener(MouseEvent.MOUSE_OVER, onPanelOver);
				panel.addListener(MouseEvent.MOUSE_OUT, onPanelOut);
			}
			
			KeyController.getInstance().registerForKeyDown(this, 
				Vector.<int>([Keyboard.RIGHT, Keyboard.LEFT, Keyboard.UP, Keyboard.DOWN]));
		}
		
		override public function stop():void {
			for each (var panel:ICameraScrollObject in _scrollPanels) {
				panel.removeListener(MouseEvent.MOUSE_OVER, onPanelOver);
				panel.removeListener(MouseEvent.MOUSE_OUT, onPanelOut);
			}
			
			KeyController.getInstance().unregisterForKeyDown(this, 
				Vector.<int>([Keyboard.RIGHT, Keyboard.LEFT, Keyboard.UP, Keyboard.DOWN]));
		}
		
		private function onPanelOver(e:MouseEvent):void {
			_isMoving = true;
			
			
		}
		
		private function onPanelOut(e:MouseEvent):void {
			_isMoving = false;
		}
		
		override public function onEnterFrame(e:Event):void {
			super.onEnterFrame(e);
			if (_isMoving) {
				var x:int, z:int;
				switch ((e.target as ICameraScrollObject).panelId) {
					case TOP:
						z = -_moveDistance;
					break;
					case BOTTOM:
						z = _moveDistance;
					break;
					case LEFT:
						x = -_moveDistance;
					break;
					case RIGHT:
						x = _moveDistance;
					break;
					default:
				}
				
				_moveVector.x = x;
				_moveVector.z = z;
				_cameraController.moveLookAtObject(_moveVector);
				
			}
		}
		
		/* INTERFACE maryfisher.framework.core.IKeyListener */
		
		public function handleKeyDownOnce(key:int):void {
			
		}
		
		public function handleKeyDown(key:int):void {
			
			_cameraController.lookAtObject.rotationY = _cameraController.targetObject.rotationY;
			switch (key) {
				case Keyboard.DOWN:
					_cameraController.lookAtObject.moveBackward(_moveDistance);
				break;
				case Keyboard.RIGHT:
					_cameraController.lookAtObject.moveRight(_moveDistance);
				break;
				case Keyboard.LEFT:
					_cameraController.lookAtObject.moveLeft(_moveDistance);
				break;
				case Keyboard.UP:
					_cameraController.lookAtObject.moveForward(_moveDistance);
				break;
				default:
			}
			_cameraController.updateLookAtObject();
		}
		
		public function handleKeyUp(key:int):void {
			
		}
		
		public function handleKeyCombo(keyComboData:KeyComboData):void {
			
		}
		
		public function set moveDistance(value:int):void {
			_moveDistance = value;
		}
	}

}