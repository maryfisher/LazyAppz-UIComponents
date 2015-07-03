package maryfisher.view.ui.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseBitmap extends Bitmap implements IDisplayObject {
		
		public function BaseBitmap(bd:BitmapData, scale:Number = 1) {
			
			if (scale != 1) {
				var sbd:BitmapData = bd.clone();
				bd = new BitmapData(sbd.width * scale, sbd.height * scale, sbd.transparent, 0xff0000);
				var matrix:Matrix = new Matrix();
				matrix.scale(scale, scale);
				bd.draw(sbd, matrix);
			}
			super(bd);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObject */
		
		public function set clipRect(value:Rectangle):void {
			/** TODO
			 * 
			 */
			//mask
		}
		
		public function hasListener(type:String):Boolean {
			return true;
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			
		}
		
		public function dispatch(e:Event):void {
			
		}
		
	}

}