package maryfisher.view.model3d.ui {
	import away3d.containers.ObjectContainer3D;
	import away3d.events.MouseEvent3D;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Base3DUI extends ObjectContainer3D {
		
		protected var _origData:BitmapData;
		protected var _bitmapData:BitmapData;
		protected var _bitmapTexture:BitmapTexture;
		protected var _pigData:BitmapData;
		protected var _buttonLookup:Dictionary;
		protected var _selectedButton:Plane3DButton;
		protected var _currentOverColor:uint;
		protected var _lastIndex:int;
		
		
		public function Base3DUI(bitmapData:BitmapData) {
			super();
			_bitmapData = bitmapData;
			_bitmapTexture = new BitmapTexture(_bitmapData);
			_origData = bitmapData.clone();
			_buttonLookup = new Dictionary();
			
			_pigData = new BitmapData(_bitmapData.width, _bitmapData.height, false, 0);
		}
		
		protected function onClick(e:MouseEvent3D):void {
			var pixel:uint = _pigData.getPixel(e.uv.x * _pigData.width, e.uv.y * _pigData.height);
			_selectedButton = _buttonLookup[pixel];
		}
		
		protected function onMove(e:MouseEvent3D):void {
			var pixel:uint = _pigData.getPixel(e.uv.x * _pigData.height, e.uv.y * _pigData.width);
			if (pixel == _currentOverColor) {
				return;
			}
			var button:Plane3DButton = _buttonLookup[_currentOverColor];
			if (button) {
				//_bitmapData.copyPixels(_origData, button.upData.rect, button.position);
				_bitmapData.copyPixels(button.upData, button.upData.rect, button.position);
			}
			
			_currentOverColor = pixel;
			
			button = _buttonLookup[_currentOverColor];
			if (button) {
				//_bitmapData.copyPixels(_origData, button.overData.rect, button.position);
				_bitmapData.copyPixels(button.overData, button.overData.rect, button.position);
				/** TODO
				 * mouse - buttonMode
				 */
			}
			
			_bitmapTexture.invalidateContent();
		}
		
		protected function addButton(b:Plane3DButton):void {
			//b.position = position;
			_bitmapData.copyPixels(b.upData, b.upData.rect, b.position);
			_pigData.copyPixels(b.pigData, b.pigData.rect, b.position);
		}
		
		public function clear():void {
			for (var i:Object in _buttonLookup) {
				delete _buttonLookup[i];
			}
			_bitmapData = _origData.clone();
			_pigData = new BitmapData(_bitmapData.width, _bitmapData.height, false, 0);
			_bitmapTexture.bitmapData = _bitmapData;
			_lastIndex = 0;
		}
		
	}

}