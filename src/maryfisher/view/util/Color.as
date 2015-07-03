package maryfisher.view.util {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Color {
		
		
		public var a:Number;
		public var r:Number;
		public var g:Number;
		public var b:Number;
		
		//public var components:Array = ["r","g","b"];
		
		public function Color(a:Number, r:Number, g:Number, b:Number) {
			this.b = b;
			this.g = g;
			this.r = r;
			this.a = a;
			
		}
		
		public function get hex():uint {
			return ( (a << 24) | ( r << 16 ) | ( g << 8 ) | b ); 
		}
		
	}

}