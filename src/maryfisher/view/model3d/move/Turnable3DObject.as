package maryfisher.view.model3d.move {
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Turnable3DObject extends Movable3DObject implements ITurnableObject{
		
		public function Turnable3DObject() {
			
		}
		
		public function face(angle:Number):void {
			trace("face:", angle, _mesh.rotationY, "diff", angle - _mesh.rotationY);
			var a:Number = Math.abs(angle-_mesh.rotationY);
			if (a > 180) {
				if (Math.abs((angle - 360) - _mesh.rotationY) < 180) {
					angle -= 360;
				}else {
					angle += 360;
				}
				trace("after adjustment:", angle, _mesh.rotationY, "diff", angle - _mesh.rotationY);
			}
			var time:Number = Math.abs(angle - _mesh.rotationY)/ 100;
			TweenLite.killTweensOf(this);
			TweenLite.to(_mesh, time, { rotationY: angle} );
		}
		
		public function lookTo(position:Vector3D):void {
			face(getAngle(position));
		}
		
		public function turn(value:int):void {
			face(rotationY + value);
		}
		
		private function getAngle(position:Vector3D):Number {
			var xd:Number = position.x - this.x, zd:Number =  position.z - this.z;
			var direction:Point = new Point(xd, zd);
			
			var r:Number = Math.sqrt(Math.pow(direction.x, 2) + Math.pow(direction.y, 2));
			var angle:Number = (direction.y < 0 ? Math.acos(direction.x / r) : Math.acos( -direction.x / r) - Math.PI) * 180 / Math.PI;
			return angle;
		}
	}

}