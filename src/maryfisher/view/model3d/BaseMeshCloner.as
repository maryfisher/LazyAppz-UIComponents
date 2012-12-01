package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import flash.display.Sprite;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseMeshCloner extends Sprite implements IClonableViewComponent {
		private var _loader3D:Loader3D;
		protected var _onViewFinished:Function;
		
		public function BaseMeshCloner() {
			
		}
		
		/* INTERFACE maryfisher.framework.view.IClonableViewComponent */
		
		public function clone():IViewComponent {
			return null;
		}
		
		public function addOnFinished(onViewFinished:Function):void {
			_onViewFinished = onViewFinished;
			
		}
		
		protected function loadModel(model:Class):void {
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext(false);
			_loader3D = new Loader3D(false);
			_loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader3D.loadData(new model(), assetLoaderContext);
		}
		
		protected function onAssetComplete(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				_loader3D.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
				assignMesh(e.asset as Mesh);
				_loader3D.dispose();
			}
		}
		
		protected function assignMesh(mesh:Mesh):void {
			
		}
		
	}

}