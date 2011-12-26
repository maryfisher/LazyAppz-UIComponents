package maryfisher.ui.sprite.container {
	import maryfisher.ui.interfaces.IScrollTrack;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TrackScrollContainer extends BaseScrollContainer {
		
		public static const POS_RIGHT:String = "posRight";
		
		private var _track:IScrollTrack;
		
		public function TrackScrollContainer() {
			
		}
		
		public function assignTrack(track:IScrollTrack, align:String = POS_RIGHT):void {
			_track = track;
			//_track.updateSignal.add()
			//_track.addEventListener()
		}
	}

}