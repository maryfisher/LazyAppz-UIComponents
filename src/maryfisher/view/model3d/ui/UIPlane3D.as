package maryfisher.view.model3d.ui {
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import maryfisher.austengames.config.ViewConstants;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ICameraObject;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class UIPlane3D extends Mesh implements IViewComponent, ICameraObject {
		
		protected var _origData:BitmapData;
		protected var _bitmapData:BitmapData;
		protected var _bitmapTexture:BitmapTexture;
		
		public function UIPlane3D(width:int, height:int, bitmapData:BitmapData) {
			_bitmapData = bitmapData;
			_origData = bitmapData.clone();
			_bitmapTexture = new BitmapTexture(_bitmapData);
			super(new PlaneGeometry(width, height, 1, 1, false), new TextureMaterial(_bitmapTexture));
		}
		
		/* INTERFACE maryfisher.austengames.view.interfaces.party.IGuestOverviewMenu */
		
		public function get componentType():String {
			return ViewConstants.MODEL3D_VIEW;
		}
		
		protected function initView():void {
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
		}
		
		protected function exitView():void {
			new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
		}
		
		public function destroy():void {
			exitView();
		}
		
		public function addOnFinished(listener:Function):void {
			listener();
		}
		
		/* INTERFACE maryfisher.framework.view.ICameraObject */
		
		public function set cameraTilt(value:Number):void {
			rotationX = value;
		}
		
		public function set cameraPan(value:Number):void {
			rotationY = value + 180;
		}
	}

}