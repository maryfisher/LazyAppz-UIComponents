package maryfisher.view.ui.controller {
	import maryfisher.view.ui.interfaces.IProgress;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ProgressController {
		
		private var _progress:IProgress;
		
		public function ProgressController(progress:IProgress) {
			_progress = progress;
			
		}
		
		public function changePercent(percent:Number):void {
			_progress.maskWidth = percent * _progress.totalWidth;
		}
	}

}