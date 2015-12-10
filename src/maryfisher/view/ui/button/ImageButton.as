package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.component.BaseBitmap;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ImageButton extends SimpleButton {
		
		public function ImageButton(id:String, upState:BitmapData, overState:BitmapData, downState:BitmapData, disabledState:BitmapData=null, selectedState:BitmapData = null) {
			super(id, new BaseBitmap(upState), new BaseBitmap(overState), new BaseBitmap(downState), new BaseBitmap(disabledState), new BaseBitmap(selectedState));
			
		}
		
		public function setStates(upState:BitmapData, overState:BitmapData, downState:BitmapData):void {
			setButtonStates(new BaseBitmap(upState), new BaseBitmap(overState), new BaseBitmap(downState));
			//(_defaultState as Bitmap).bitmapData = upState;
			//(_overState as Bitmap).bitmapData = overState;
			//(_downState as Bitmap).bitmapData = downState;
		}
	}

}