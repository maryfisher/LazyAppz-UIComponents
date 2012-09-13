package maryfisher.view.model3d.ui {
	import away3d.containers.ObjectContainer3D;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ICameraObject;
	import maryfisher.framework.view.IViewComponent;
	import maryfisher.view.core.BaseContainer3DView;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSprite3DContainer extends BaseContainer3DView implements ICameraObject {
		
		public function BaseSprite3DContainer() {
			
		}
		
		override public function show():void {
			super.show();
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
		}
		
		override public function hide():void {
			super.hide();
			new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
		}
		
		override public function addView():void {
			super.addView();
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
		}
		
		override public function removeView():void {
			super.removeView();
			new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
		}
		
		/* INTERFACE maryfisher.framework.view.ICameraObject */
		
		public function set cameraTilt(value:Number):void {
			rotationX = value - 20;
			trace("rot",rotationX);
		}
		
		public function set cameraPan(value:Number):void {
			rotationY = value + 180;
		}
		
		public function setCameraPosition(cameraPos:Vector3D, lookAtPos:Vector3D):void {
			
		}
		
	}

}