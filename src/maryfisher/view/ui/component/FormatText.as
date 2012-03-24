package maryfisher.view.ui.component {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class FormatText extends TextField {
		
		private var _format:TextFormat;
		
		public function FormatText(x:int, y:int, width:int = 100, height:int = 30) {
			super();
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			_format = new TextFormat();
		}
		
		public function setTextBlock(autoSize:String = TextFieldAutoSize.LEFT):void {
			wordWrap = true;
			this.autoSize = autoSize;
		}
		
		public function setFormatting(font:String, color:int, size:int, bold:Boolean = false, align:String = "left", italic:Boolean = false):void {
			_format.font = font;
			_format.color = color;
			_format.bold = bold;
			_format.size = size;
			_format.align = align;
			_format.italic = italic;
			applyFormat();
		}
		
		public function set format(value:TextFormat):void {
			_format = value;
			applyFormat();
		}
		
		protected function applyFormat():void{
			this.setTextFormat(_format);
			this.defaultTextFormat = _format;
		}
		
		override public function set borderColor(color:uint):void {
			super.borderColor = color;
			border = true;
		}
		
		public function set font(font:String):void{
			_format.font = font;
			applyFormat();
		}
		
		//public function setColor(color:int):void{
			//pformat.color = color;
			//applyFormat();
		//}
		
		public function set size(size:int):void{
			_format.size = size;
			applyFormat();
		}
		
		public function set bold(bold:Boolean):void{
			_format.bold = bold;
			applyFormat();
		}
		
		public function set align(align:String):void{
			_format.align = align;
			applyFormat();
		}
		
		public function set leading(leading:int):void {
			_format.leading = leading;
			applyFormat();
		}
		
	}

}