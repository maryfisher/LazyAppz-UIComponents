package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ImageButton extends SimpleButton {
		
		public function ImageButton(id:String, upState:BitmapData, overState:BitmapData, downState:BitmapData, disabledState:BitmapData=null) {
			super(id, new Bitmap(upState), new Bitmap(overState), new Bitmap(downState), new Bitmap(disabledState));
			
		}
		
		public function setStates(upState:BitmapData, overState:BitmapData, downState:BitmapData):void {
			(_defaultState as Bitmap).bitmapData = upState;
			(_overState as Bitmap).bitmapData = overState;
			(_downState as Bitmap).bitmapData = downState;
		}
	}

}