package maryfisher.view.ui.interfaces {
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDisplayObjectContainer extends IDisplayObject, IViewListener {
		function addContent(child:IDisplayObject):void;
		function addContentAt(child:IDisplayObject, index:int):void;
		function removeContent(child:IDisplayObject):void;
		function removeAllContent():void;	
		
		function containsContent(child:IDisplayObject):Boolean;
		
		function getContentIndex(child:IDisplayObject):int;
		
		
		//function addDisplayChild(child:IDisplayObject):void;
		//function removeDisplayChild(child:IDisplayObject):void;
		//function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void;
	}
	
}