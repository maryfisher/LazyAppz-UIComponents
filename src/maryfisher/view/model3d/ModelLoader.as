package maryfisher.view.model3d {
	import away3d.animators.data.Skeleton;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.VertexAnimator;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.MouseEvent3D;
	import away3d.library.assets.AssetType;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.ParserBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import maryfisher.framework.command.view.SequenceProgress;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ModelLoader extends ObjectContainer3D implements IViewComponent {
		protected var _lightPicker:StaticLightPicker;
		protected var _onFinishedListener:Function;
		
		//private var _assetLoader:AssetLoader;
		
		protected var _finishedSignal:Signal;
		//protected var _loader:Loader3D;
		
		protected var _sequenceProgress:SequenceProgress;
		
		public function ModelLoader() {
			_finishedSignal = new Signal();
			//_assetLoader = new AssetLoader();
			
			//_loader = new Loader3D(false);
			//_loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			//_loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
		}
		
		//protected function loadModel(model:Class, assetLoaderContext):void {
			//
		//}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return "";
		}
		
		public function destroy():void {
			
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function addOnFinished(listener:Function):void {
			_onFinishedListener = listener;
		}
		
		private function onAssetComplete(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				parseMesh(e.asset as Mesh);
			} else if (e.asset.assetType == AssetType.MATERIAL) {
				parseMaterial(e.asset as TextureMaterial);
			}else if (e.asset.assetType == AssetType.ANIMATION_STATE) {
				parseAnimation(e.asset as SkeletonAnimationState);
			//}else if (e.asset.assetType == AssetType.ANIMATOR) {
				//parseAnimator(e.asset as VertexAnimator);
			}else if (e.asset.assetType == AssetType.ANIMATION_SET) {
				parseAnimationSet(e.asset as SkeletonAnimationSet);
			}else if (e.asset.assetType == AssetType.SKELETON) {
				parseSkeleton(e.asset as Skeleton);
			}
		}
		
		protected function parseSkeleton(skeleton:Skeleton):void {
			
		}
		
		protected function parseAnimationSet(skeletonAnimationSet:SkeletonAnimationSet):void {
			
		}
		
		protected function parseAnimator(vertexAnimator:VertexAnimator):void {
			
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
			_onFinishedListener && _onFinishedListener();
		}
		
		protected function parseAnimation(anim:SkeletonAnimationState):void {
			
		}
		
		protected function parseMaterial(bitmapMaterial:TextureMaterial):void {
			
		}
		
		protected function parseMesh(mesh:Mesh):void {
			
		}
		
		public function addLight(lightPicker:StaticLightPicker):void {
			_lightPicker = lightPicker;
			//_mesh.material.lightPicker = lightPicker;
		}
		
		public function mouseEnableMesh(mesh:Mesh, enableOver:Boolean = false):void {
			mesh.mouseEnabled = true;
			if(enableOver){
				mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver);
				mesh.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut);
			}
			mesh.addEventListener(MouseEvent3D.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent3D):void {
			
		}
		
		public function onMouseOut(e:MouseEvent3D):void {
			
		}
		
		public function onMouseOver(e:MouseEvent3D):void {
			
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function dispatch(e:Event):void {
			dispatchEvent(e);
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function addView():void {
			new ViewCommand(this);
		}
		
		public function removeView():void {
			new ViewCommand(this, ViewCommand.REMOVE_VIEW);
		}
		
		public function pause():void {
			
		}
		
		public function show():void {
			visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
		}
	}

}