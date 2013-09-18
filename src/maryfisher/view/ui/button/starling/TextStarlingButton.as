package maryfisher.view.ui.button.starling {
	import maryfisher.austengames.view.components.ButtonColorScheme;
	import starling.text.TextField;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextStarlingButton extends BaseStarlingButton {
		
		protected var _colorScheme:ButtonColorScheme;
		
		protected var _label:TextField;
		
		public function TextStarlingButton(id:String, colorScheme:ButtonColorScheme, textfield:TextField = null) {
			super(id);
			_colorScheme = colorScheme;
			_label = textfield || new TextField(100, 30, "");
			_label.touchable = false;
			//_label.wordWrap = false;
			//_label.autoScale = TextFieldAutoSize.CENTER;
			_label.hAlign = "center";
			_label.color = _colorScheme.upColor;
			addChild(_label);
		}
		
		override protected function onOver():void {
			super.onOver();
			_label.color = _colorScheme.overColor;
			
		}
		
		override protected function onDown():void {
			super.onDown();
			_label.color = _colorScheme.downColor;
		}
		
		override protected function showUpState():void {
			super.showUpState();
			_label.color = _colorScheme.upColor;
		}
		
		override protected function onUp():void {
			super.onUp();
			_label.color = _colorScheme.upColor;
		}
		
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			if (_enabled) {
				_label.color = _colorScheme.upColor;
			}else {
				_label.color = _colorScheme.downColor;
			}
		}
	}

}