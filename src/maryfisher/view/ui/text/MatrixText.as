package maryfisher.view.ui.text {
	import flash.text.TextFormat;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MatrixText extends FormatText {
		
		[Embed(source="../../../../assets/fonts/Matrix.ttf", embedAsCFF = 'false', fontName = "MatrixFont", mimeType = "application/x-font-truetype")]
		private static var matrixFont:Class;
		
		public function MatrixText(x:int = 0, y:int = 0, width:int = 100, height:int = 30) {
			super(x, y, width, height);
			
			embedFonts = true;
			font = "MatrixFont";
		}
		
		override public function setFormatting(font:String, color:int, size:int, bold:Boolean = false, align:String = "left", italic:Boolean = false):void {
			super.setFormatting("MatrixFont", color, size, bold, align, italic);
		}
		
		override public function set format(value:TextFormat):void {
			value.font = "MatrixFont";
			super.format = value;
		}
		
	}

}