package maryfisher.ui.sprite.container {
	import flash.display.Sprite;
	import matchmaker.component.icon.AbstractIcon;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AlignContainer extends Sprite {
		
		static public const ALIGN_VERTICAL:String = "alignVertical";
		static public const ALIGN_HORIZONTAL:String = "alignHorizontal";
		
		private var _align:String;
		
		public function AlignContainer(align:String) {
			_align = align;
			
		}
		
		public function addContainer(icon:AbstractIcon, vbc:ValueButtonContainer):void {
			addChild(icon);
			addChild(vbc);
			
			if (_align == ALIGN_HORIZONTAL) {
				vbc.x = icon.width + 20;
				if (icon.height > vbc.height) {
					
				}else {
					
				}
			}else {
				vbc.y = icon.height + 20;
			}
		}
	}

}