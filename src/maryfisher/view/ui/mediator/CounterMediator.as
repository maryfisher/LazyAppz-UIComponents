package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ITextField;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class CounterMediator {
		
		private var _amount:int;
		private var _plusCounter:IButton;
		private var _minusCounter:IButton;
		private var _textCounter:ITextField;
		private var _max:int;
		private var _min:int;
		private var _steps:int = 1;
		private var _updateSignal:Signal;
		private var _lastDirection:String;
		
		public function CounterMediator() {
			_updateSignal = new Signal();
		}
		
		public function setSteps(steps:int):void {
			_steps = steps;
		}
		
		public function setMaxMin(max:int = 0, min:int = 0):void {
			_min = min;
			_max = max;
		}
		
		/**
		 * 
		 * @param	listener Function.<>
		 */
		public function addAmountChangedListener(listener:Function):void {
			_updateSignal.add(listener);
		}
		
		public function assignCounterButtons(plusCounter:IButton, minusCounter:IButton, textCounter:ITextField = null, amount:int = 0):void {
			_amount = amount;
			_minusCounter = minusCounter;
			_plusCounter = plusCounter;
			_textCounter = textCounter;
			_textCounter && (_textCounter.text = amount.toString());
			_minusCounter.addClickedListener(onMinus);
			_plusCounter.addClickedListener(onPlus);
			setEnabled();
		}
		
		private function onMinus(button:IButton):void {
			if (_amount - _steps >= _min) {
				_lastDirection = button.id;
				changeAmount(-1);
			}
		}
		
		private function onPlus(button:IButton):void {
			if (_amount + _steps <= _max) {
				_lastDirection = button.id;
				changeAmount(1);
			}
			
		}
		
		private function changeAmount(dir:int):void {
			_amount += _steps * dir;
			_textCounter && (_textCounter.text = _amount.toString());
			_updateSignal.dispatch();
			setEnabled();
		}
		
		private function setEnabled():void {
			_plusCounter.enabled = _amount + _steps <= _max;
			_minusCounter.enabled = _amount - _steps >= _min;
		}
		
		public function destroy():void {
			_minusCounter.destroy();
			_plusCounter.destroy();
			_updateSignal.removeAll();
			_updateSignal = null;
			_minusCounter = null;
			_plusCounter = null;
		}
		
		public function get amount():int {
			return _amount;
		}
		
		public function set amount(value:int):void {
			_amount = value;
			_textCounter && (_textCounter.text = _amount.toString());
			setEnabled();
		}
		
		public function get lastDirection():String {
			return _lastDirection;
		}
	}

}