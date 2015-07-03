package maryfisher.view.ui.interfaces {
	import maryfisher.framework.sound.ISound;
	import maryfisher.framework.sound.ISoundPlayer;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	
	public interface IButton extends IIDItem{
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		function addClickedListener(listener:Function):void;
		function addDownListener(listener:Function, onStayDown:Boolean):void;
		
		function destroy():void;
		function set sound(value:ISoundPlayer):void;
	}
	
}