package maryfisher.view.ui.button.starling {
	import flash.display.BitmapData;
	import maryfisher.view.ui.component.starling.BaseImage;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ImageStarlingButton extends SimpleStarlingButton {
		
		public function ImageStarlingButton(id:String, upState:BitmapData, overState:BitmapData, downState:BitmapData, disabledState:BitmapData=null) {
			super(id, getImage(upState), getImage(overState), getImage(downState), getImage(disabledState));
			
		}
		
		private function getImage(bm:BitmapData):BaseImage {
			return new BaseImage(Texture.fromBitmapData(bm))
		}
		
		//public function setStates(upState:BitmapData, overState:BitmapData, downState:BitmapData):void {
			//_defaultState.texture = Texture.fromBitmapData(upState);
			//_overState.texture = Texture.fromBitmapData(overState);
			//_downState.texture = Texture.fromBitmapData(downState);
		//}
	}

}