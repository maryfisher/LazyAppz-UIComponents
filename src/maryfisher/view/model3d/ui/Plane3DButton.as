package maryfisher.view.model3d.ui {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import maryfisher.austengames.config.ViewConstants;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ISound;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Plane3DButton {
		
		protected var _enabled:Boolean;
		protected var _pigColor:uint;
		protected var _selected:Boolean;
		protected var _sound:ISound;
		protected var _id:String;
		protected var _position:Point;
		protected var _upData:BitmapData;
		protected var _overData:BitmapData;
		protected var _pigData:BitmapData;
		
		public function Plane3DButton(id:String, color:uint) {
			_id = id;
			_pigColor = color;
			_pigData = new BitmapData(_upData.width, _upData.height, false, color);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IButton */
		
		public function get id():String { return _id; }
		
		public function set selected(value:Boolean):void { _selected = value; }
		public function get selected():Boolean { return _selected; }
		
		public function set enabled(value:Boolean):void { _enabled = value; }
		public function get enabled():Boolean { return _enabled; }
		
		public function set sound(value:ISound):void { _sound = value; }
		
		public function destroy():void {
			
		}
		
		public function get upData():BitmapData { return _upData; }
		public function get overData():BitmapData { return _overData; }
		public function get pigData():BitmapData { return _pigData; }
		public function get pigColor():uint { return _pigColor; }
		
		public function get position():Point { return _position; }
		public function set position(value:Point):void { _position = value;	}
		
		
		
		public function toString():String {
			return "[Plane3DButton id=" + _id + "]";
		}
	}

}