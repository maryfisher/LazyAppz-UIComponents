package maryfisher.view.ui.button {
	import flash.display.BitmapData;
	import maryfisher.view.ui.interfaces.IButton;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ToggleImageButton extends ImageButton {
		
		private var _up:BitmapData;
		private var _over:BitmapData;
		private var _down:BitmapData;
		private var _upSelected:BitmapData;
		private var _overSelected:BitmapData;
		private var _downSelected:BitmapData;
		private var _isChecked:Boolean;
		
		public function ToggleImageButton(id:String, up:BitmapData, over:BitmapData, down:BitmapData, upSelected:BitmapData, overSelected:BitmapData, downSelected:BitmapData) {
			_downSelected = downSelected;
			_overSelected = overSelected;
			_upSelected = upSelected;
			_down = down;
			_over = over;
			_up = up;
			super(id, up, over, down);
			
			_button.addClickedListener(onToggle);
		}
		
		private function onToggle(b:IButton):void {
			isChecked = !_isChecked;
		}
		
		public function set isChecked(value:Boolean):void {
			if (_isChecked == value) return;
			_isChecked = value;
			if (_isChecked) {
				setStates(_upSelected, _overSelected, _downSelected);
			}else {
				setStates(_up, _over, _down);
			}
		}
		
		public function get isChecked():Boolean {
			return _isChecked;
		}
		
		
	}

}