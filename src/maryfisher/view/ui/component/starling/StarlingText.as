package maryfisher.view.ui.component.starling {
	import maryfisher.framework.core.LocaleController;
	import maryfisher.framework.data.LocaleContextData;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingText extends TextField {
		
		public function StarlingText(x:int, y:int, width:int, height:int, fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0x0, bold:Boolean = false) {
			this.x = x;
			this.y = y;
			super(width, height, "", fontName, fontSize, color, bold);
			
		}
		
		//public function attachTooltip(tooltip:ITooltip):void {
			//mouseEnabled = true;
			//
			//_tooltip = tooltip;
			//addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		//}
		//
		//private function onMouseOut(e:MouseEvent):void {
			//_tooltip.hide();
		//}
		//
		//private function onMouseOver(e:MouseEvent):void {
			//_tooltip.show();
		//}
		
		public function setLocaleById(context:String, id:String, addText:Boolean = false, ... pars):void {
			setLocaleText(new LocaleContextData(context, id));
		}
		
		public function setLocaleText(contextData:LocaleContextData, addText:Boolean = false, ... pars):void {
			var t:String = LocaleController.getText(contextData).getText().text;
			text = addText ? text + t : t;
		}
	}

}