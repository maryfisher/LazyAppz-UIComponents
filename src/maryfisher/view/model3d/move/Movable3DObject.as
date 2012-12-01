package maryfisher.view.model3d.move {
	import away3d.entities.Mesh;
	import flash.geom.Vector3D;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.view.core.BaseContainer3DView;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Movable3DObject extends BaseContainer3DView implements IMovableObject, ITickedObject {
		
		
		private var _walkPath:Vector.<Vector3D>;
		private var _currentPathPosition:int;
		protected var _mesh:Mesh;
		
		public function Movable3DObject() {
			
		}
		
		public function pathTo(path:Vector.<Vector3D>):void {
			_walkPath = path;
			_currentPathPosition = _walkPath.length - 1;
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			var dist:Vector3D = _walkPath[_currentPathPosition].clone().subtract(position);
			
			var realLength:Number = Math.abs(dist.length);
			var walkDist:Number = 0.07 * interval;
			
			if (realLength <= walkDist) {
				_walkPath.pop();
				if (_walkPath.length == 0) {
					//playAnimation("idle");
					translate(dist, realLength);
					new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
					_finishedMovingSignal.dispatch();
					return;
				}
				_currentPathPosition--;
				dist = _walkPath[_currentPathPosition].clone().subtract(position);
			}
			dist.normalize();
			translate(dist, walkDist);
		}
		
		
		
		public function moveToPosition(move:Vector3D):void {
			lookTo(move);
			//var angle:Number = getAngle(move);
			//face(angle);
			pathTo(Vector.<Vector3D>([move]));
		}
		
	}

}