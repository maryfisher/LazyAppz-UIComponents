package maryfisher.view.ui.text {
	import flash.text.Font;
	import flash.text.TextFormat;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class PapyrusText extends FormatText {
		
		[Embed(source="../../../assets/fonts/PAPYRUS.TTF", embedAsCFF = 'false', fontName = "PapyrusFont", mimeType = "application/x-font-truetype")]
		private static var austenFont2:Class;
		
		public function PapyrusText(x:int = 0, y:int = 0, width:int = 100, height:int = 30) {
			super(x, y, width, height);
			
			//Font.registerFont(austenFont);
			//applyFormat();
			embedFonts = true;
			font = "PapyrusFont";
		}
		
		override public function setFormatting(font:String, color:int, size:int, bold:Boolean = false, align:String = "left", italic:Boolean = false):void {
			super.setFormatting("PapyrusFont", color, size, bold, align, italic);
		}
		
		override public function set format(value:TextFormat):void {
			value.font = "PapyrusFont";
			super.format = value;
		}
		
	}

}