package maryfisher.view.ui.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import maryfisher.framework.core.LocaleController;
	import maryfisher.framework.data.LocaleContextData;
	import maryfisher.view.ui.interfaces.ITextField;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class FormatText extends TextField implements ITextField{
		
		private var _format:TextFormat;
		private var _tooltip:ITooltip;
		
		public function FormatText(x:int = 0, y:int = 0, width:int = 100, height:int = 30) {
			super();
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			mouseEnabled = false;
			selectable = false;
			
			_format = new TextFormat();
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
		}
		
		public function hasListener(type:String):Boolean {
			return hasEventListener(type);
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
		
		//public function attachSimpleTooltip(tooltipClass:Class, contextData:LocaleContextData):void {
			//var t:ITooltip = new tooltipClass(this);
			//t
		//}
		
		public function attachTooltip(tooltip:ITooltip):void {
			mouseEnabled = true;
			
			_tooltip = tooltip;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			_tooltip.hide();
		}
		
		private function onMouseOver(e:MouseEvent):void {
			_tooltip.show();
		}
		
		public function setLocaleById(context:String, id:String, addText:Boolean = false, ... pars):void {
			setLocaleText(new LocaleContextData(context, id));
		}
		
		public function setLocaleText(contextData:LocaleContextData, addText:Boolean = false, ... pars):void {
			var t:String = LocaleController.getText(contextData).getText().text;
			text = addText ? text + t : t;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITextField */
		
		public function set clipRect(value:Rectangle):void {
			mask = new Bitmap(new BitmapData(value.width, value.height, false, 0));
			mask.x = value.x;
			mask.y = value.y;
		}
	}

}