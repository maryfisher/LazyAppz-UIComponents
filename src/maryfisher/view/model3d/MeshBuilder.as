package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MeshBuilder extends Sprite implements IAssetBuilder {
		
		private var _meshes:Dictionary;
		private var _isWaiting:Dictionary;
		private var _waitingForGeometry:Dictionary;
		protected var _cloneGeometry:Boolean = false;
		
		public function MeshBuilder() {
			super();
			_waitingForGeometry = new Dictionary();
			_meshes = new Dictionary();
			_isWaiting = new Dictionary();
		}
		
		/* INTERFACE maryfisher.framework.view.IAssetBuilder */
		
		public function getViewComponent(id:String):IViewComponent {
			return null;
		}
		
		protected function getMesh(entity:ISharedMeshEntity, id:String):ISharedMeshEntity {
			entity.isWaiting = _isWaiting[id];
			if (!_meshes[id]) {
				if (_isWaiting[id]) {
					if (!_waitingForGeometry[id]) {
						_waitingForGeometry[id] = new Vector.<ISharedMeshEntity>();
					}
					_waitingForGeometry[id].push(entity);
					return entity;
				}
				_isWaiting[id] = true;
				entity.meshId = id;
				entity.meshSignal.add(onMeshFinished);
			}else {
				if (!_cloneGeometry) {
					entity.mesh = _meshes[id].clone() as Mesh;
					
				}else {
					var m:Mesh = _meshes[id].clone() as Mesh;
					m.geometry = m.geometry.clone();
					entity.mesh = m;
				}
			}
			
			return entity;
		}
		
		private function onMeshFinished(mesh:Mesh, id:String):void {
			if (!_cloneGeometry) {
				_meshes[id] = mesh;
			}else {
				var m:Mesh = mesh.clone() as Mesh;
				m.geometry = m.geometry.clone();
				_meshes[id] = m;
			}
			
			_isWaiting[id] = false;
			//for (var i:int = 0; i < _waitingForGeometry[id].length; i++ ) {
			if (!_waitingForGeometry[id]) {
				return;
			}
			for each(var entity:SharedMeshEntity in _waitingForGeometry[id]) {
				if (!_cloneGeometry) {
					entity.mesh = mesh.clone() as Mesh;
				}else {
					var m2:Mesh = mesh.clone() as Mesh;
					m2.geometry = m2.geometry.clone();
					entity.mesh = m2;
				}
			}
		}
	}

}