package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.ParserBase;
	import away3d.materials.TextureMaterial;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import maryfisher.framework.command.view.SequenceProgress;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Model3DLoader {
		
		private var _mesh:Mesh;
		private var _material:TextureMaterial;
		private var _id:String;
		
		protected var _finishedSignal:Signal;
		//protected var _loader:Loader3D;
		
		protected var _sequenceProgress:SequenceProgress;
		
		public function Model3DLoader(id:String) {
			_id = id;
			_finishedSignal = new Signal(String);
			//_assetLoader = new AssetLoader();
			
			//_loader = new Loader3D(false);
			//_loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			//_loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function addOnFinished(listener:Function):void {
			_finishedSignal.addOnce(listener);
		}
		
		private function onAssetComplete(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				_mesh = (e.asset as Mesh);
			} else if (e.asset.assetType == AssetType.MATERIAL) {
				_material = (e.asset as TextureMaterial);
			//}else if (e.asset.assetType == AssetType.ANIMATION_STATE) {
				//parseAnimation(e.asset as SkeletonAnimationState);
			//}else if (e.asset.assetType == AssetType.ANIMATOR) {
				//parseAnimator(e.asset as VertexAnimator);
			//}else if (e.asset.assetType == AssetType.ANIMATION_SET) {
				//parseAnimationSet(e.asset as SkeletonAnimationSet);
			//}else if (e.asset.assetType == AssetType.SKELETON) {
				//parseSkeleton(e.asset as Skeleton);
			}
		}
		
		protected function parseData(data : * , context : AssetLoaderContext = null, parser : ParserBase = null):void {
			//_loader.loadData(data, context, null, parser);
			var assetLoader:AssetLoader = new AssetLoader();
			var token:AssetLoaderToken = assetLoader.loadData(data, "", context, null, parser);
			token.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			token.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			token.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.ANIMATION_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.ANIMATOR_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.BITMAP_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.CONTAINER_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.GEOMETRY_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.MATERIAL_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.MESH_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.ENTITY_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.SKELETON_COMPLETE, onAssetComplete);
			//token.addEventListener(AssetEvent.SKELETON_POSE_COMPLETE, onAssetComplete);
		}
		
		private function onLoadError(ev : LoaderEvent) : void {
			removeListeners(EventDispatcher(ev.currentTarget));
			
			//throw new Error(ev.message);
		}

		private function removeListeners(dispatcher : EventDispatcher) : void {
			dispatcher.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			dispatcher.removeEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			dispatcher.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.ANIMATION_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.ANIMATOR_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.TEXTURE_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.CONTAINER_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.GEOMETRY_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.MATERIAL_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.MESH_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.ENTITY_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.SKELETON_COMPLETE, onAssetComplete);
			//dispatcher.removeEventListener(AssetEvent.SKELETON_POSE_COMPLETE, onAssetComplete);
		}
		
		private function onResourceComplete(ev : Event) : void {
			removeListeners(EventDispatcher(ev.currentTarget));
			
			onResourceFinished();
		}
		
		protected function onResourceFinished():void {
			_finishedSignal.dispatch(_id);
		}
		
		public function get mesh():Mesh {
			return _mesh;
		}
		
		public function get material():TextureMaterial {
			return _material;
		}
		
		//public function get id():String {
			//return _id;
		//}
	}

}