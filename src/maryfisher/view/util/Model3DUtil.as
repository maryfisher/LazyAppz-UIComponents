package maryfisher.view.util {
	import away3d.entities.Mesh;
	import away3d.entities.Sprite3D;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Model3DUtil {
		
		public function Model3DUtil() {
			
		}
		
		//static public function getMappedSprite3D(bm:BitmapData):Mesh {
			//var bm2:BitmapData = BitmapUtil.getPowerOf2Bitmap(bm, false);
			//var plane:Sprite3D = new Sprite3D(new TextureMaterial(new BitmapTexture((bm2))), 
				//bm.width * 10, bm.height * 10);
			//var uVData:Vector.<Number> = (plane as Sprite3D).geometry.subGeometries[0].UVData;
			//var scX:Number = bm.width / bm2.width;
			//var scY:Number = bm.height / bm2.height;
			//uVData[1] = scY;
			//uVData[2] = scX;
			//uVData[3] = scY;
			//uVData[6] = scX;
			//(plane as Mesh).geometry.subGeometries[0].updateUVData(uVData);
			//
			//return plane;
		//}
		
		static public function getMappedPlane3D(bm:BitmapData):Mesh {
			var bm2:BitmapData = BitmapUtil.getPowerOf2Bitmap(bm, false);
			var plane:Mesh = new Mesh(new PlaneGeometry(bm.width * 10, bm.height * 10, 1, 1, false), 
										new TextureMaterial(new BitmapTexture((bm2))));
			var uVData:Vector.<Number> = (plane as Mesh).geometry.subGeometries[0].UVData;
			var scX:Number = bm.width / bm2.width;
			var scY:Number = bm.height / bm2.height;
			uVData[1] = scY;
			uVData[2] = scX;
			uVData[3] = scY;
			uVData[6] = scX;
			(plane as Mesh).geometry.subGeometries[0].updateUVData(uVData);
			
			return plane;
		}
	}

}