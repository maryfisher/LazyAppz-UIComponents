package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseCheckBox extends BaseSprite{
		
		private var _bubbleSignal:DeluxeSignal;
		private var _content:DisplayObject;
		private var _id:String;
		private var _isEnabled:Boolean = true;
		
		public function BaseCheckBox(id:String) {
			_id = id;
			buttonMode = true;
			_bubbleSignal = new DeluxeSignal(this);
			addEventListener(MouseEvent.CLICK, onChecked);
		}
		
		private function onChecked(e:MouseEvent):void {
			if (!_isEnabled) return;
			_content.visible = !_content.visible;
			_bubbleSignal.dispatch(new GenericEvent(true));
		}
		
		public function set content(value:DisplayObject):void {
			_content = value;
			_content.visible = false;
			addChild(_content);
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get isEnabled():Boolean {
			return _isEnabled;
		}
		
		public function set isEnabled(value:Boolean):void {
			_isEnabled = value;
		}
		
		public function get isChecked():Boolean {
			return _content.visible;
		}
		
		public function set isChecked(value:Boolean):void {
			_content.visible = value;
		}
	}

}