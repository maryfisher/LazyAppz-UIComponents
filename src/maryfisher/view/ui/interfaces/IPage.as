package maryfisher.view.ui.interfaces {
    import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.mediator.ListMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IPage {
		//function hasRoom(content:IDisplayObject):Boolean;
		function addContent(content:IDisplayObject):void;
		function hide():void;
		function show():void;
		function get listMediator():ListMediator;
	}
	
}