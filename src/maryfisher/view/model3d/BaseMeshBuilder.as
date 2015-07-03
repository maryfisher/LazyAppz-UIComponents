package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.materials.TextureMaterial;
	import flash.display.Sprite;
	import maryfisher.framework.command.view.SequenceProgress;
	import maryfisher.view.model3d.BaseMeshCloner;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseMeshBuilder extends Sprite{
		
		protected var _loader:Loader3D;
		protected var _sequenceProgress:SequenceProgress;
		
		public function BaseMeshBuilder() {
			
			_loader = new Loader3D();
			_loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
		}
		
		protected function loadModel(model:Class):void {
			_loader3D.loadData(new model());
		}
		
		protected function onAssetComplete(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				parseMesh(e.asset as Mesh);
			} else if (e.asset.assetType == AssetType.MATERIAL) {
				parseMaterial(e.asset as TextureMaterial);
			}
		}
		
		protected function parseMaterial(textureMaterial:TextureMaterial):void {
			
		}
		
		protected function parseMesh(mesh:Mesh):void {
			
		}
		
		protected function onResourceFinished():void {
			
		}
		
		private function onResourceComplete(e:LoaderEvent):void {
			onResourceFinished();
		}
		
		protected function disposeLoader():void {
			_loader.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			_loader.dispose();
		}
	}

}