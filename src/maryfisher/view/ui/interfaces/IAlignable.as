package maryfisher.view.ui.interfaces {
	import maryfisher.view.ui.mediator.AlignMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IAlignable {
		//function set alignMediator(value:AlignMediator):void;
		function alignOnX(nextTo:IDisplayObject):void;
		function alignOnY(nextTo:IDisplayObject):void;
		function alignNextTo(nextTo:IDisplayObject, dist:int = 0):void;
		function alignBelow(nextTo:IDisplayObject, dist:int = 0):void
	}
	
}