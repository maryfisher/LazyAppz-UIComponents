package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITooltip {
		function switchVisibility():void;
		function show():void;
		function hide():void;
		function set defaultFace(value:int):void;
		function destroy():void;
		function set paddingX(value:int):void;
		function set paddingY(value:int):void;
	}
	
}