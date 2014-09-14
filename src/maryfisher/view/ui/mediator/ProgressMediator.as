package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IProgressBar;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ProgressMediator {
		
		private var _progress:IProgressBar;
		
		public function ProgressMediator(progress:IProgressBar) {
			_progress = progress;
			
		}
		
		public function changePercent(percent:Number):void {
			_progress.maskWidth = percent * _progress.totalWidth;
		}
		
		public function get progress():IProgressBar {
			return _progress;
		}
	}

}