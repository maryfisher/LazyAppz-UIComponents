package maryfisher.view.ui.button {
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.ui.mediator.button.SpriteButtonMediator;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseSpriteButton extends BaseSprite implements IButtonContainer {
		
		protected var _button:SpriteButtonMediator;
		
		public function BaseSpriteButton(id:String) {
			_button = new SpriteButtonMediator(this, id);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IButtonContainer */
		
		public function set selected(value:Boolean):void {
			_button.selected = value;
		}
		
		public function set enabled(value:Boolean):void {
			_button.enabled = value;
		}
		
		public function get id():String{
			return _button.id;
		}
		
		public function attachTooltip(t:ITooltip):void{
			_button.attachTooltip(t);
		}
		
		public function destroy():void{
			_button.destroy();
		}
		
		public function setButtonStates(defaultS:IDisplayObject, overS:IDisplayObject, downS:IDisplayObject, disabledS:IDisplayObject = null, selectedS:IDisplayObject = null):void {
			_button.defaultState = defaultS;
			_button.overState = overS;
			_button.downState = downS;
			disabledS && (_button.disabledState = disabledS);
			selectedS && (_button.selectedState = selectedS);
		}
		
		public function get button():IButton {
			return _button;
		}
	}
}