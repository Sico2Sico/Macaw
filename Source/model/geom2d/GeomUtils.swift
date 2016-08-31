
import Foundation

public class GeomUtils {
	public class func concat(t1 t1: Transform, t2: Transform) -> Transform {
		let nm11 = t2.m11 * t1.m11 + t2.m12 * t1.m21
		let nm21 = t2.m21 * t1.m11 + t2.m22 * t1.m21
		let ndx = t2.dx * t1.m11 + t2.dy * t1.m21 + t1.dx
		let nm12 = t2.m11 * t1.m12 + t2.m12 * t1.m22
		let nm22 = t2.m21 * t1.m12 + t2.m22 * t1.m22
		let ndy = t2.dx * t1.m12 + t2.dy * t1.m22 + t1.dy
		return Transform(m11: nm11, m12: nm12, m21: nm21, m22: nm22, dx: ndx, dy: ndy)
	}

	public class func centerRotation(node node: Node, angle: Double) -> Transform {
		guard let bounds = node.bounds() else {
			return Transform()
		}

		let center = Point(x: bounds.w / 2.0, y: bounds.h / 2.0)
		let t1 = Transform.move(dx: -1.0 * center.x, dy: -1.0 * center.y)
		let t2 = Transform.move(dx: center.x, dy: center.y)
		let r = Transform().rotate(angle: angle)

		let moveAndRotate = GeomUtils.concat(t1: t1, t2: r)

		return GeomUtils.concat(t1: moveAndRotate, t2: t2)

	}
}

