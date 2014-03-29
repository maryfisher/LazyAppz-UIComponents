package maryfisher.sound {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.framework.core.SoundController;
	import maryfisher.framework.sound.ISound;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSound implements ISound{
		protected var _channel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _fader:Timer;
		private var _fadingStep:Number;
		private var _isPlaying:Boolean;
		private var _soundType:String;
		private var _baseVolume:Number = 1;
		
		protected var _sound:Sound;
		
		public function BaseSound(soundType:String, sound:Sound = null) {
			_soundType = soundType;
			_sound = sound;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ISound */
		
		public function play():void {
			if (_channel) {
				_channel.stop();
				//new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, _channel);
				new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, this);
			}
			_channel = _sound.play();
			//new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, _channel);
			new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, this);
			_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			//_soundTransform && (_channel.soundTransform = _soundTransform);
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
			
		}
		
		public function set channelTransform(value:SoundTransform):void {
			_soundTransform = value;
			_channel && (_channel.soundTransform = new SoundTransform(_soundTransform.volume * _baseVolume));
		}

		public function set fadeIn(value:Boolean):void {
			volume = 0;
			_fadingStep = 0.1;
			initTimer();
		}

		public function set fadeOut(value:Boolean):void {
			_fadingStep = -0.1;
			initTimer();
		}

		public function set volume(vol:Number):void {
			_channel.soundTransform = new SoundTransform(vol * _baseVolume);
		}

		public function get volume():Number {
			return _channel.soundTransform.volume;
		}
		
		protected function set sound(value:Sound):void {
			//if (_channel) {
				//_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				//_channel.stop();
				//_channel = null;
			//}
			_sound = value;
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function set baseVolume(value:Number):void {
			_baseVolume = value;
			_channel && _soundTransform && (_channel.soundTransform = new SoundTransform(_soundTransform.volume * _baseVolume));
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