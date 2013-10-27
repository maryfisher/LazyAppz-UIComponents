package maryfisher.view.ui.text {
	import flash.text.Font;
	import flash.text.TextFormat;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TrajanText extends FormatText {
		
		[Embed(source="../../../../assets/fonts/TrajanPro-Regular.otf", embedAsCFF = 'false', fontName = "TrajanFont", mimeType = "application/x-font-opentype")]
		private static var austenFont:Class;
		
		public function TrajanText(x:int = 0, y:int = 0, width:int = 100, height:int = 30) {
			super(x, y, width, height);
			
			//Font.registerFont(austenFont);
			//applyFormat();
			embedFonts = true;
			font = "TrajanFont";
		}
		
		override public function setFormatting(font:String, color:int, size:int, bold:Boolean = false, align:String = "left", italic:Boolean = false):void {
			super.setFormatting("TrajanFont", color, size, bold, align, italic);
		}
		
		override public function set format(value:TextFormat):void {
			value.font = "TrajanFont";
			super.format = value;
		}
		
	}

}