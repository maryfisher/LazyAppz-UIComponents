package maryfisher.view.ui.data {
	import maryfisher.framework.view.IDisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AlignIntData {
		
		static public const ALIGN_X:String = "alignX";
		static public const ALIGN_Y:String = "alignY";
		
		public var alignment:String;
		public var pos:int;
		public var target:IDisplayObject;
		
		public function AlignIntData(target:IDisplayObject, pos:int, alignment:String) {
			this.alignment = alignment;
			this.pos = pos;
			this.target = target;
			
		}
		
	}

}