package maryfisher.view.ui.button {
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.view.ui.component.BaseBitmap;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class RectTextButton extends TextSpriteButton {
		
		protected var _bgColorScheme:ButtonColorScheme;
		protected var _lineColorScheme:ButtonColorScheme;
		private var _w:int;
		private var _h:int;
		private var _padding:int;
		private var _alpha:Number;
		protected var _lineThickness:int;
		
		public function RectTextButton(id:String, w:int, h:int, bgColorScheme:ButtonColorScheme = null, lineColorScheme:ButtonColorScheme = null, textfield:FormatText = null, padding:int = 0, alpha:Number = 1, lineThickness:int = 1, centerButton:Boolean = true, overwrite:Boolean = false) {
			_lineThickness = lineThickness;
			_alpha = alpha;
			_padding = padding;
			_h = h;
			_w = w;
			_lineColorScheme = lineColorScheme;
			_bgColorScheme = bgColorScheme;
			if(textfield){
				textfield.width = w;
				textfield.height = h;
			}
			
			super(id, lineColorScheme, textfield, centerButton, overwrite);
			setStates();
		}
		
		override public function get width():Number {
			return super.width + _lineThickness;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
		}
		
		protected function getState(color:uint, lineColor:uint, textColor:uint):BaseBitmap {
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(_lineThickness, lineColor);
			shape.graphics.beginFill(color, _alpha);
			shape.graphics.drawRect(-_padding, -_padding, _w + _padding * 2, _h + _padding * 2);
			shape.graphics.endFill();
			
			var matrix:Matrix = new Matrix();
			matrix.translate(_lineThickness - 1, _lineThickness - 1);
			var bitmapData:BitmapData = new BitmapData(shape.width, shape.height, true, 0);
			bitmapData.draw(shape, matrix);
			return new BaseBitmap(drawTextData(bitmapData, textColor));
		}
		
		override protected function setStates():void {
			setButtonStates(
				getState(_bgColorScheme.upColor, _lineColorScheme.upColor, _textScheme.upColor),
				getState(_bgColorScheme.overColor, _lineColorScheme.overColor, _textScheme.overColor),
				getState(_bgColorScheme.downColor, _lineColorScheme.downColor, _textScheme.downColor),
				getState(_bgColorScheme.disabledColor, _lineColorScheme.disabledColor, _textScheme.disabledColor),
				getState(_bgColorScheme.downColor, _lineColorScheme.downColor, _textScheme.downColor));
		}
		
		override public function set label(value:String):void {
			super.label = value;
			if (_textField.width + _textField.x * 2 > _w) {
				_w = _textField.width + _textField.x * 2;
				setStates();
			}
		}
		
		public function set bgColorScheme(value:ButtonColorScheme):void {
			_bgColorScheme = value;
			setStates();
		}
		
		public function get bgColorScheme():ButtonColorScheme {
			return _bgColorScheme;
		}
	}

}