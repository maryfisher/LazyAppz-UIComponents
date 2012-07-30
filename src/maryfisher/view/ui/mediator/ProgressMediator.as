package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IProgress;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ProgressMediator {
		
		private var _progress:IProgress;
		
		public function ProgressMediator(progress:IProgress) {
			_progress = progress;
			
		}
		
		public function changePercent(percent:Number):void {
			_progress.maskWidth = percent * _progress.totalWidth;
		}
	}

}