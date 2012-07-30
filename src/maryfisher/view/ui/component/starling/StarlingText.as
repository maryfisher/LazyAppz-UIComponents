package maryfisher.view.ui.component.starling {
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingText extends TextField {
		
		public function StarlingText(x:int, y:int, width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0x0, bold:Boolean=false) {
			super(width, height, text, fontName, fontSize, color, bold);
			
		}
		
	}

}