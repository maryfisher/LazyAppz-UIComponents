package maryfisher.view.ui.data {
	import maryfisher.framework.view.IDisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AlignData {
		
		static public const NEXT_TO:String = "next_to";
		static public const ON_LINE:String = "on_line";
		
		public var alignment:String;
		public var target:IDisplayObject;
		public var nextTo:IDisplayObject;
		public var dist:int;
		//the higher the index, the later they are aligned
		public var index:int; 
		
		public function AlignData(target:IDisplayObject, nextTo:IDisplayObject, alignment:String, index:int, dist:int) {
			this.dist = dist;
			this.alignment = alignment;
			this.nextTo = nextTo;
			this.target = target;
			
		}
		
	}

}