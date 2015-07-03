package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITooltipButton extends IButton{
		function attachTooltip(t:ITooltip):void;
		function get tooltip():ITooltip;
	}
	
}