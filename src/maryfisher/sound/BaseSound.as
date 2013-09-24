package maryfisher.sound {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import maryfisher.framework.core.SoundController;
	import maryfisher.framework.sound.ISound;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSound implements ISound {
		protected var _channel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _fader:Timer;
		private var _fadingStep:Number;
		private var _isPlaying:Boolean;
		
		protected var _sound:Sound;
		
		public function BaseSound(sound:Sound) {
			_sound = sound;
			//_channel = new SoundChannel();
			SoundController.registerSound(this);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ISound */
		
		public function play():void {
			if (_channel) {
				_channel.stop();
			}
			_channel = _sound.play();
			_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_soundTransform && (_channel.soundTransform = _soundTransform);
			_isPlaying = true;
		}
		
		private function onSoundComplete(e:Event):void {
			_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_channel = null;
			_isPlaying = false;
		}
		
		public function stop():void {
			_channel.stop();
			_channel = null;
			_isPlaying = false;
		}
		
		public function set soundTransform(value:SoundTransform):void {
			_soundTransform = value;
			_channel && _soundTransform && (_channel.soundTransform = _soundTransform);
		}

		public function fadeIn():void {
			volume = 0;
			_fadingStep = 0.1;
			initTimer();
		}

		public function fadeOut():void {
			_fadingStep = -0.1;
			initTimer();
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ISound */
		
		public function get soundType():String {
			throw Error("Function needs to be overridden!")
			return "";
		}

		public function set volume(volume:Number):void {
			_channel.soundTransform = new SoundTransform(volume);
		}

		public function get volume():Number {
			return _channel.soundTransform.volume;
		}
		
		public function set sound(value:Sound):void {
			if (_channel) {
				_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				_channel.stop();
				_channel = null;
			}
			_sound = value;
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}

		private function initTimer():void {
			_fader = null;
			_fader = new Timer(100);
			_fader.addEventListener(TimerEvent.TIMER, onTimer);
			_fader.start();
		}

		private function onTimer(event:TimerEvent):void {
			volume += _fadingStep;
			if (volume >= 1) {
				volume = 1;
				_fader.stop();
			} else if (volume <= 0) {
				volume = 0;
				_fader.stop();
			}
		}
		
	}

}