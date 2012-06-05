package maryfisher.view.model3d.ui {
	import away3d.core.base.Geometry;
	import away3d.core.raycast.MouseHitMethod;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import maryfisher.austengames.config.ViewConstants;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ICameraObject;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class InteractivePlane3D extends Mesh implements IViewComponent, ICameraObject{
		
		protected var _pigData:BitmapData;
		protected var _origData:BitmapData;
		protected var _bitmapData:BitmapData;
		protected var _bitmapTexture:BitmapTexture;
		protected var _buttonLookup:Dictionary;
		protected var _updateSignal:Signal;
		protected var _selectedButton:Plane3DButton;
		protected var _currentOverColor:uint;
		
		public function InteractivePlane3D() {
			
			_buttonLookup = new Dictionary();
			
			_bitmapData = new BitmapData(512, 512, true, 0xff);
			_bitmapTexture = new BitmapTexture(_bitmapData);
			super(new PlaneGeometry(150, 150, 1, 1, false), new TextureMaterial(_bitmapTexture));
			
			mouseEnabled = true;
			mouseHitMethod = MouseHitMethod.MESH_CLOSEST_HIT;
		}
		
		protected function onClick(e:MouseEvent3D):void {
			var pixel:uint = _pigData.getPixel(e.uv.x * _pigData.width, e.uv.y * _pigData.height);
			_selectedButton = _buttonLookup[pixel];
		}
		
		protected function onMove(e:MouseEvent3D):void {
			var pixel:uint = _pigData.getPixel(e.uv.x * _pigData.width, e.uv.y * _pigData.height);
			if (pixel == _currentOverColor) {
				return;
			}
			
			var button:Plane3DButton = _buttonLookup[_currentOverColor];
			if(button){
				_bitmapData.copyPixels(button.upData, button.upData.rect, button.position);
			}
			
			_currentOverColor = pixel;
			
			button = _buttonLookup[_currentOverColor];
			if(button){
				_bitmapData.copyPixels(button.overData, button.overData.rect, button.position);
				/** TODO
				 * mouse - buttonMode
				 */
			}
			
			_bitmapTexture.invalidateContent();
		}
		
		protected function addButton(b:Plane3DButton, position:Point):void {
			b.position = position;
			_bitmapData.copyPixels(b.upData, b.upData.rect, b.position);
			_pigData.copyPixels(b.pigData, b.pigData.rect, position);
		}
		
		protected function initView():void {
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
			addEventListener(MouseEvent3D.MOUSE_MOVE, onMove);
			addEventListener(MouseEvent3D.CLICK, onClick);
		}
		
		protected function exitView():void {
			new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
			removeEventListener(MouseEvent3D.MOUSE_MOVE, onMove);
			removeEventListener(MouseEvent3D.CLICK, onClick);
		}
		
		public function clear():void {
			exitView();
			for (var i:Object in _buttonLookup) {
				delete _buttonLookup[i];
			}
		}
		
		/* INTERFACE maryfisher.austengames.view.interfaces.party.IGuestOverviewMenu */
		
		public function get componentType():String {
			return ViewConstants.MODEL3D_VIEW;
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
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
	}

}