package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import maryfisher.framework.view.IAssetBuilder;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MeshBuilder extends Sprite implements IAssetBuilder {
		
		/** TODO
		 * 
		 */
		
		protected var _geometries:Dictionary;
		protected var _materials:Dictionary;
		private var _waitingForGeometry:Dictionary;
		private var _modelLoader:Dictionary;
		protected var _cloneGeometry:Boolean = false;
		
		public function MeshBuilder(cloneGeometry:Boolean = false) {
			super();
			_cloneGeometry = cloneGeometry;
			_waitingForGeometry = new Dictionary();
			_geometries = new Dictionary();
			_materials = new Dictionary();
			_modelLoader = new Dictionary();
		}
		
		protected function addLoader(id:String):Model3DLoader {
			var model3DLoader:Model3DLoader = new Model3DLoader(id);
			model3DLoader.addOnFinished(onLoaderFinished);
			
			_modelLoader[id] = model3DLoader;
			return model3DLoader;
		}
		
		protected function onLoaderFinished(id:String):void {
			var model3DLoader:Model3DLoader = _modelLoader[id];
			//_meshes[id] = model3DLoader.mesh;
			delete _modelLoader[id];
			onMeshFinished(model3DLoader.mesh, id);
		}
		
		/* INTERFACE maryfisher.framework.view.IAssetBuilder */
		
		public function getViewComponent(id:String):IViewComponent {
			return null;
		}
		
		protected function getMesh(entity:Mesh, id:String):Mesh {
			
			if (!_geometries[id]) {
				
				//_isWaiting[id] = true;
				//entity.isWaiting = _isWaiting[id];
				if (!_waitingForGeometry[id]) {
					_waitingForGeometry[id] = new Vector.<Mesh>();
				}
				_waitingForGeometry[id].push(entity);
				return entity;
				
				//entity.meshId = id;
				//entity.meshSignal.add(onMeshFinished);
			}else {
				//entity.isWaiting = false;
				if (!_cloneGeometry) {
					entity.geometry = _geometries[id].clone();
					//entity.material
				}else {
					entity.geometry = _geometries[id]
					//var m:Mesh = _geometries[id].clone() as Mesh;
					//m.geometry = m.geometry.clone();
					//entity.mesh = m;
				}
			}
			
			return entity;
		}
		
		private function onMeshFinished(mesh:Mesh, id:String):void {
			//if (!_cloneGeometry) {
				_geometries[id] = mesh.geometry;
				_materials[id] = mesh.material;
			//}else {
				//var m:Mesh = mesh.clone() as Mesh;
				//m.geometry = m.geometry.clone();
				//_meshes[id] = m;
			//}
			
			//_isWaiting[id] = false;
			//for (var i:int = 0; i < _waitingForGeometry[id].length; i++ ) {
			if (!_waitingForGeometry[id]) {
				return;
			}
			for each(var entity:Mesh in _waitingForGeometry[id]) {
				if (!_cloneGeometry) {
					entity.geometry = _geometries[id].clone();
					//entity.material
				}else {
					entity.geometry = _geometries[id]
					//var m:Mesh = _geometries[id].clone() as Mesh;
					//m.geometry = m.geometry.clone();
					//entity.mesh = m;
				}
			}
		}
	}

}