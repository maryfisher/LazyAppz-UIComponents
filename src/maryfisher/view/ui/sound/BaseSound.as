package maryfisher.view.ui.sound {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import maryfisher.view.ui.interfaces.ISound;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSound implements ISound {
		private var _channel:SoundChannel;
		
		protected var _sound:Sound;
		
		public function BaseSound(sound:Sound) {
			_sound = sound;
			//_channel = new SoundChannel();
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ISound */
		
		public function play():void {
			_sound.play();
		}
		
		public function stop():void {
			//_sound.
		}
		
	}

}