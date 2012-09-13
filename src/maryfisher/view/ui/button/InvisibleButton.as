package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class InvisibleButton extends SimpleButton {
		
		public function InvisibleButton(id:String, width:int, height:int) {
			var bitmap:Bitmap = new Bitmap(new BitmapData(width, height, true, 0));
			super(id, bitmap, null, null);
			
		}
		
	}

}