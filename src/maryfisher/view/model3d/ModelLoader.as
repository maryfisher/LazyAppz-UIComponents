package maryfisher.view.model3d {
	import away3d.animators.data.SkeletonAnimationSequence;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.TextureMaterial;
	import maryfisher.austengames.society.config.ViewConstants;
	import maryfisher.austengames.society.proxy.ViewProxy;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ModelLoader extends ObjectContainer3D implements IViewComponent {
		
		protected var _viewProxy:ViewProxy;
		protected var _finishedSignal:Signal;
		protected var _loader:Loader3D;
		
		public function ModelLoader() {
			_viewProxy = new ViewProxy();
			_finishedSignal = new Signal();
			_loader = new Loader3D(false);
			_loader.addEventListener(AssetEvent.ASSET_COMPLETE, handleAssetComplete);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return ViewConstants.MODEL3D_VIEW;
		}
		
		public function destroy():void {
			
		}
		
		public function get finishedSignal():Signal {
			return _finishedSignal;
		}
		
		private function handleAssetComplete(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				parseMesh(e.asset as Mesh);
			} else if (e.asset.assetType == AssetType.MATERIAL) {
				parseMaterial(e.asset as TextureMaterial);
			}else if (e.asset.assetType == AssetType.ANIMATION) {
				parseAnimation(e.asset as SkeletonAnimationSequence);
			}
		}
		
		protected function parseAnimation(anim:SkeletonAnimationSequence):void {
			
		}
		
		protected function parseMaterial(bitmapMaterial:TextureMaterial):void {
			
		}
		
		protected function parseMesh(mesh:Mesh):void {
			
		}
	}

}