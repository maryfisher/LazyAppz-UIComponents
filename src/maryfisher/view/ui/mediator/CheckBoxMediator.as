package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class CheckBoxMediator {
		
		private var _check:IDisplayObject;
		private var _button:IButton;
		private var _listener:Function;
		
		public function CheckBoxMediator() {
			
		}
		
		public function addContent(check:IDisplayObject, button:IButton, isChecked:Boolean):void {
			_button = button;
			_check = check;
			_button.addClickedListener(onChecked);
			this.isChecked = isChecked;
		}
		
		/**
		 * 
		 * @param	listener Function.<Boolean>
		 */
		public function addCheckedListener(listener:Function):void {
			_listener = listener;
			
		}
		
		private function onChecked(b:IButton):void {
			isChecked = !isChecked;
			_listener && _listener(isChecked);
		}
		
		public function get isChecked():Boolean {
			return _check.visible;
		}
		
		public function set isChecked(value:Boolean):void {
			_check.visible = value;
		}
	}

}