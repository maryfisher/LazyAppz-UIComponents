package maryfisher.view.ui.button.starling {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import maryfisher.view.starling.BaseStarlingSprite;
	import maryfisher.view.ui.component.starling.BaseStarling;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.ui.mediator.button.StarlingButtonMediator;
	import maryfisher.view.util.ColorUtil;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingButton extends BaseStarling implements IButtonContainer {
		
		protected var _button:StarlingButtonMediator;
		
		public function BaseStarlingButton(id:String){
			_button = new StarlingButtonMediator(this, id);
		}
		
		
		/* INTERFACE maryfisher.view.ui.interfaces.IButtonContainer */
		
		public function set selected(value:Boolean):void {
			_button.selected = value;
		}
		
		public function set enabled(value:Boolean):void {
			_button.enabled = value;
		}
		
		public function get button():IButton {
			return _button;
		}
	}
}