package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SharedMeshEntity extends ModelLoader implements ISharedMeshEntity {
		private var _meshSignal:Signal;
		private var _meshId:String;
		protected var _isWaiting:Boolean;
		
		protected var _mesh:Mesh;
		
		public function SharedMeshEntity() {
			super();
			_meshSignal = new Signal(Mesh, String);
		}
		
		public function set mesh(value:Mesh):void {
			_mesh = value;
			_isWaiting = false;
		}
		
		override public function addOnFinished(listener:Function):void {
			if (!_isWaiting && _mesh) {
				listener();
				return;
			}
			super.addOnFinished(listener);
		}
		
		public function set isWaiting(value:Boolean):void {
			_isWaiting = value;
		}
		
		public function get meshSignal():Signal {
			return _meshSignal;
		}
		
		public function get meshId():String {
			return _meshId;
		}
		
		public function set meshId(value:String):void {
			_meshId = value;
		}
		
		public function get mesh():Mesh {
			return _mesh;
		}
		
		override protected function parseMesh(mesh:Mesh):void {
			_mesh = mesh;
			_meshSignal.dispatch(mesh, _meshId);
			_meshSignal.removeAll();
			_meshSignal = null;
		}
		
		//public function cloneMesh():Mesh {
			//var m:Mesh = new Mesh(_mesh.geometry.clone(), _mesh.material);
			//return m;
		//}
	}

}