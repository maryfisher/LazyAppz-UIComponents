package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.view.ui.button.SimpleButton;
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
		
		public function RectTextButton(id:String, w:int, h:int, bgColorScheme:ButtonColorScheme = null, lineColorScheme:ButtonColorScheme = null, textfield:FormatText = null, padding:int = 0, alpha:Number = 1, lineThickness:int = 1, centerButton:Boolean = true, overwrite:Boolean = true) {
			_lineThickness = lineThickness;
			_alpha = alpha;
			_padding = padding;
			_h = h;
			_w = w;
			_lineColorScheme = lineColorScheme;
			_bgColorScheme = bgColorScheme;
			
			super(id, lineColorScheme, textfield, centerButton, overwrite);
			_defaultState = getState(_bgColorScheme.upColor, _lineColorScheme.upColor);
			setStates(	_defaultState, 
						getState(_bgColorScheme.overColor, _lineColorScheme.overColor), 
						getState(_bgColorScheme.downColor, _lineColorScheme.downColor), 
						getState(_bgColorScheme.disabledColor, _lineColorScheme.disabledColor));
			_selectedState = getState(_bgColorScheme.downColor, _lineColorScheme.downColor);
		}
		
		protected function getState(color:uint, lineColor:uint):Bitmap {
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(_lineThickness, lineColor);
			shape.graphics.beginFill(color, _alpha);
			shape.graphics.drawRect(-_padding, -_padding, _w + _padding * 2, _h + _padding * 2);
			shape.graphics.endFill();
			
			var matrix:Matrix = new Matrix();
			matrix.translate(_lineThickness - 1, _lineThickness - 1);
			var bitmapData:BitmapData = new BitmapData(shape.width, shape.height, true, 0);
			bitmapData.draw(shape, matrix);
			return new Bitmap(bitmapData);
		}
		
	}

}