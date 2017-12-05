//
//  MDCDrawDragons.swift
//  MDCDragons
//
//  Created by Yarden Eitan on 12/5/17.
//  Copyright © 2017 Google. All rights reserved.
//

import Foundation
import UIKit

class MDCDrawDragons {
  static func image(with path: UIBezierPath, size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
//    path.lineWidth = 2
//    path.stroke()
    path.fill()
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  static func drawFun() ->UIBezierPath {
    let logoDarkGroup = CGRect(x: 0, y: 0, width: 30, height: 30)
    let square = UIBezierPath()
    square.move(to: CGPoint(x: logoDarkGroup.minX + 0.00000 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.66667 * logoDarkGroup.size.height))
    square.addLine(to: CGPoint(x: logoDarkGroup.minX + 0.33333 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.66667 * logoDarkGroup.size.height))
    square.addLine(to: CGPoint(x: logoDarkGroup.minX + 0.66667 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.33333 * logoDarkGroup.size.height))
    square.addLine(to: CGPoint(x: logoDarkGroup.minX + 0.66667 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.00000 * logoDarkGroup.size.height))
    square.addLine(to: CGPoint(x: logoDarkGroup.minX + 0.00000 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.00000 * logoDarkGroup.size.height))
    square.addLine(to: CGPoint(x: logoDarkGroup.minX + 0.00000 * logoDarkGroup.size.width, y: logoDarkGroup.minY + 0.66667 * logoDarkGroup.size.height))
    square.close()
    UIColor.white.setFill()
    return square
  }
  
  static func drawDragon() -> UIBezierPath {
    let fillColor = UIColor(red: 0.212, green: 0.188, blue: 0.184, alpha: 1.000)
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 1749.8, y: 1157.18))
    bezierPath.addCurve(to: CGPoint(x: 1668.39, y: 1041.28), controlPoint1: CGPoint(x: 1739.9, y: 1106.86), controlPoint2: CGPoint(x: 1708.64, y: 1067.53))
    bezierPath.addCurve(to: CGPoint(x: 1328.81, y: 1641.62), controlPoint1: CGPoint(x: 1612.05, y: 1327.32), controlPoint2: CGPoint(x: 1483.75, y: 1518.63))
    bezierPath.addCurve(to: CGPoint(x: 465.46, y: 1782.51), controlPoint1: CGPoint(x: 1033.01, y: 1876.42), controlPoint2: CGPoint(x: 640.12, y: 1862.16))
    bezierPath.addCurve(to: CGPoint(x: 97.72, y: 1409.89), controlPoint1: CGPoint(x: 351.67, y: 1730.62), controlPoint2: CGPoint(x: 195.66, y: 1592.91))
    bezierPath.addCurve(to: CGPoint(x: 51.48, y: 771.12), controlPoint1: CGPoint(x: -0.22, y: 1226.87), controlPoint2: CGPoint(x: -40.09, y: 998.53))
    bezierPath.addCurve(to: CGPoint(x: 550.29, y: 1607.19), controlPoint1: CGPoint(x: 92.21, y: 1361.38), controlPoint2: CGPoint(x: 372.92, y: 1541.08))
    bezierPath.addCurve(to: CGPoint(x: 870.77, y: 1606.26), controlPoint1: CGPoint(x: 633.91, y: 1638.37), controlPoint2: CGPoint(x: 754.3, y: 1643.05))
    bezierPath.addCurve(to: CGPoint(x: 1232.84, y: 1074.45), controlPoint1: CGPoint(x: 1052.46, y: 1548.87), controlPoint2: CGPoint(x: 1224.63, y: 1390.55))
    bezierPath.addCurve(to: CGPoint(x: 1024.5, y: 1185.32), controlPoint1: CGPoint(x: 1164.96, y: 1146), controlPoint2: CGPoint(x: 1095.67, y: 1186.36))
    bezierPath.addCurve(to: CGPoint(x: 1189.81, y: 924.1), controlPoint1: CGPoint(x: 1117.04, y: 1121.76), controlPoint2: CGPoint(x: 1171.48, y: 997.01))
    bezierPath.addCurve(to: CGPoint(x: 1168.04, y: 684.2), controlPoint1: CGPoint(x: 1209.76, y: 844.72), controlPoint2: CGPoint(x: 1211.49, y: 740.42))
    bezierPath.addCurve(to: CGPoint(x: 1007.96, y: 641.92), controlPoint1: CGPoint(x: 1128.48, y: 633.01), controlPoint2: CGPoint(x: 1046.26, y: 625.28))
    bezierPath.addCurve(to: CGPoint(x: 921.63, y: 721.13), controlPoint1: CGPoint(x: 985.07, y: 651.86), controlPoint2: CGPoint(x: 944.05, y: 676.17))
    bezierPath.addCurve(to: CGPoint(x: 919.9, y: 872.4), controlPoint1: CGPoint(x: 901.02, y: 762.46), controlPoint2: CGPoint(x: 895.63, y: 831.48))
    bezierPath.addCurve(to: CGPoint(x: 942.25, y: 907.98), controlPoint1: CGPoint(x: 927.32, y: 884.91), controlPoint2: CGPoint(x: 937.45, y: 895.83))
    bezierPath.addCurve(to: CGPoint(x: 941.37, y: 942.52), controlPoint1: CGPoint(x: 947.04, y: 920.15), controlPoint2: CGPoint(x: 943.49, y: 932.28))
    bezierPath.addCurve(to: CGPoint(x: 904.14, y: 1087.97), controlPoint1: CGPoint(x: 934.98, y: 973.38), controlPoint2: CGPoint(x: 917.45, y: 1033.5))
    bezierPath.addCurve(to: CGPoint(x: 929.24, y: 1220.53), controlPoint1: CGPoint(x: 885.91, y: 1162.61), controlPoint2: CGPoint(x: 877.09, y: 1229.38))
    bezierPath.addCurve(to: CGPoint(x: 840.68, y: 1286.6), controlPoint1: CGPoint(x: 875.02, y: 1300.87), controlPoint2: CGPoint(x: 852.44, y: 1288.27))
    bezierPath.addCurve(to: CGPoint(x: 824.34, y: 1264.67), controlPoint1: CGPoint(x: 825.55, y: 1284.46), controlPoint2: CGPoint(x: 818.11, y: 1286.66))
    bezierPath.addCurve(to: CGPoint(x: 824.76, y: 1260.53), controlPoint1: CGPoint(x: 824.48, y: 1263.29), controlPoint2: CGPoint(x: 824.63, y: 1261.91))
    bezierPath.addCurve(to: CGPoint(x: 721.09, y: 1239.29), controlPoint1: CGPoint(x: 783.8, y: 1275.03), controlPoint2: CGPoint(x: 747.72, y: 1273.06))
    bezierPath.addCurve(to: CGPoint(x: 827.88, y: 1201.22), controlPoint1: CGPoint(x: 755.01, y: 1240.01), controlPoint2: CGPoint(x: 790.61, y: 1227.32))
    bezierPath.addCurve(to: CGPoint(x: 827.89, y: 1197.96), controlPoint1: CGPoint(x: 827.89, y: 1200.13), controlPoint2: CGPoint(x: 827.89, y: 1199.04))
    bezierPath.addCurve(to: CGPoint(x: 753.87, y: 1189.55), controlPoint1: CGPoint(x: 799.85, y: 1206.34), controlPoint2: CGPoint(x: 775.17, y: 1203.54))
    bezierPath.addCurve(to: CGPoint(x: 827.17, y: 1166.16), controlPoint1: CGPoint(x: 779.77, y: 1189.33), controlPoint2: CGPoint(x: 804.37, y: 1182.4))
    bezierPath.addCurve(to: CGPoint(x: 826.8, y: 1158.91), controlPoint1: CGPoint(x: 827.06, y: 1163.74), controlPoint2: CGPoint(x: 826.94, y: 1161.32))
    bezierPath.addCurve(to: CGPoint(x: 758.81, y: 1132.94), controlPoint1: CGPoint(x: 800.72, y: 1163.76), controlPoint2: CGPoint(x: 777.29, y: 1158.15))
    bezierPath.addCurve(to: CGPoint(x: 822.19, y: 1108.82), controlPoint1: CGPoint(x: 784.87, y: 1136.85), controlPoint2: CGPoint(x: 805.52, y: 1127.66))
    bezierPath.addCurve(to: CGPoint(x: 821.28, y: 1101.88), controlPoint1: CGPoint(x: 821.89, y: 1106.5), controlPoint2: CGPoint(x: 821.59, y: 1104.19))
    bezierPath.addCurve(to: CGPoint(x: 764.69, y: 1103.78), controlPoint1: CGPoint(x: 799.01, y: 1112.08), controlPoint2: CGPoint(x: 780.15, y: 1112.71))
    bezierPath.addCurve(to: CGPoint(x: 817.1, y: 1074.56), controlPoint1: CGPoint(x: 784.92, y: 1100.84), controlPoint2: CGPoint(x: 802.39, y: 1091.1))
    bezierPath.addCurve(to: CGPoint(x: 801.61, y: 1001.42), controlPoint1: CGPoint(x: 812.91, y: 1049.93), controlPoint2: CGPoint(x: 807.66, y: 1025.57))
    bezierPath.addCurve(to: CGPoint(x: 799.42, y: 997.66), controlPoint1: CGPoint(x: 800.88, y: 1000.14), controlPoint2: CGPoint(x: 800.15, y: 998.89))
    bezierPath.addCurve(to: CGPoint(x: 727.46, y: 1121.85), controlPoint1: CGPoint(x: 771.37, y: 1035.48), controlPoint2: CGPoint(x: 747.86, y: 1077.3))
    bezierPath.addCurve(to: CGPoint(x: 777.08, y: 1429.24), controlPoint1: CGPoint(x: 693.34, y: 1222.87), controlPoint2: CGPoint(x: 714.33, y: 1325.46))
    bezierPath.addCurve(to: CGPoint(x: 705.85, y: 1320.09), controlPoint1: CGPoint(x: 745.65, y: 1393.22), controlPoint2: CGPoint(x: 722.11, y: 1356.82))
    bezierPath.addCurve(to: CGPoint(x: 616.75, y: 1463.13), controlPoint1: CGPoint(x: 703.14, y: 1363.36), controlPoint2: CGPoint(x: 684.78, y: 1409.75))
    bezierPath.addCurve(to: CGPoint(x: 683.88, y: 1124.77), controlPoint1: CGPoint(x: 739.27, y: 1333.31), controlPoint2: CGPoint(x: 650.89, y: 1229.64))
    bezierPath.addLine(to: CGPoint(x: 685.19, y: 1120.64))
    bezierPath.addCurve(to: CGPoint(x: 760.84, y: 949.23), controlPoint1: CGPoint(x: 697.04, y: 1064.13), controlPoint2: CGPoint(x: 722.88, y: 1006.97))
    bezierPath.addCurve(to: CGPoint(x: 676.06, y: 951.79), controlPoint1: CGPoint(x: 732.44, y: 925.76), controlPoint2: CGPoint(x: 704.19, y: 928.57))
    bezierPath.addCurve(to: CGPoint(x: 660.17, y: 967.59), controlPoint1: CGPoint(x: 671.02, y: 955.94), controlPoint2: CGPoint(x: 665.71, y: 961.27))
    bezierPath.addCurve(to: CGPoint(x: 714.7, y: 987.65), controlPoint1: CGPoint(x: 672.34, y: 978.73), controlPoint2: CGPoint(x: 688.86, y: 986.64))
    bezierPath.addCurve(to: CGPoint(x: 635.71, y: 999.46), controlPoint1: CGPoint(x: 684.18, y: 1005.63), controlPoint2: CGPoint(x: 656.91, y: 1009.59))
    bezierPath.addCurve(to: CGPoint(x: 628.49, y: 1010.11), controlPoint1: CGPoint(x: 633.32, y: 1002.9), controlPoint2: CGPoint(x: 630.91, y: 1006.45))
    bezierPath.addCurve(to: CGPoint(x: 680.07, y: 1073.98), controlPoint1: CGPoint(x: 638.65, y: 1043.24), controlPoint2: CGPoint(x: 654.27, y: 1067.17))
    bezierPath.addCurve(to: CGPoint(x: 595.7, y: 1063.37), controlPoint1: CGPoint(x: 648.37, y: 1084.58), controlPoint2: CGPoint(x: 620.98, y: 1078.17))
    bezierPath.addCurve(to: CGPoint(x: 592.44, y: 1069), controlPoint1: CGPoint(x: 594.61, y: 1065.24), controlPoint2: CGPoint(x: 593.53, y: 1067.11))
    bezierPath.addCurve(to: CGPoint(x: 648.16, y: 1149.58), controlPoint1: CGPoint(x: 603.87, y: 1109.78), controlPoint2: CGPoint(x: 620.61, y: 1140.21))
    bezierPath.addCurve(to: CGPoint(x: 554.18, y: 1138.45), controlPoint1: CGPoint(x: 607.95, y: 1166.58), controlPoint2: CGPoint(x: 578.36, y: 1158.83))
    bezierPath.addLine(to: CGPoint(x: 552.12, y: 1142.32))
    bezierPath.addCurve(to: CGPoint(x: 641.99, y: 1211.06), controlPoint1: CGPoint(x: 574.3, y: 1181.46), controlPoint2: CGPoint(x: 603.32, y: 1206.31))
    bezierPath.addCurve(to: CGPoint(x: 524.81, y: 1197.98), controlPoint1: CGPoint(x: 600.83, y: 1220.64), controlPoint2: CGPoint(x: 560.83, y: 1222.54))
    bezierPath.addCurve(to: CGPoint(x: 523.12, y: 1201.9), controlPoint1: CGPoint(x: 524.24, y: 1199.29), controlPoint2: CGPoint(x: 523.68, y: 1200.59))
    bezierPath.addCurve(to: CGPoint(x: 623.93, y: 1264.99), controlPoint1: CGPoint(x: 544.41, y: 1242.71), controlPoint2: CGPoint(x: 579.39, y: 1261.52))
    bezierPath.addCurve(to: CGPoint(x: 500.78, y: 1279.56), controlPoint1: CGPoint(x: 583.79, y: 1291.35), controlPoint2: CGPoint(x: 542.86, y: 1298.81))
    bezierPath.addCurve(to: CGPoint(x: 500.8, y: 1311.42), controlPoint1: CGPoint(x: 499.64, y: 1290.39), controlPoint2: CGPoint(x: 499.56, y: 1301.03))
    bezierPath.addCurve(to: CGPoint(x: 419.27, y: 1219.95), controlPoint1: CGPoint(x: 456.73, y: 1296.5), controlPoint2: CGPoint(x: 431.22, y: 1264.48))
    bezierPath.addCurve(to: CGPoint(x: 418.51, y: 1121.51), controlPoint1: CGPoint(x: 412.1, y: 1193.26), controlPoint2: CGPoint(x: 417.86, y: 1157.54))
    bezierPath.addCurve(to: CGPoint(x: 429.99, y: 968.69), controlPoint1: CGPoint(x: 419.35, y: 1075.19), controlPoint2: CGPoint(x: 417.54, y: 1025.91))
    bezierPath.addCurve(to: CGPoint(x: 467.49, y: 1031.86), controlPoint1: CGPoint(x: 440.11, y: 994.29), controlPoint2: CGPoint(x: 452.29, y: 1015.95))
    bezierPath.addCurve(to: CGPoint(x: 477.51, y: 987.78), controlPoint1: CGPoint(x: 472.84, y: 1015.88), controlPoint2: CGPoint(x: 474.28, y: 1000.75))
    bezierPath.addCurve(to: CGPoint(x: 489.59, y: 919.68), controlPoint1: CGPoint(x: 484.62, y: 959.23), controlPoint2: CGPoint(x: 489.81, y: 938.05))
    bezierPath.addCurve(to: CGPoint(x: 475.91, y: 864.6), controlPoint1: CGPoint(x: 489.33, y: 897.54), controlPoint2: CGPoint(x: 480.31, y: 881.56))
    bezierPath.addCurve(to: CGPoint(x: 470.94, y: 815.06), controlPoint1: CGPoint(x: 472.03, y: 849.63), controlPoint2: CGPoint(x: 472.83, y: 833.68))
    bezierPath.addCurve(to: CGPoint(x: 390.28, y: 541.63), controlPoint1: CGPoint(x: 460.19, y: 709.32), controlPoint2: CGPoint(x: 430.63, y: 620.59))
    bezierPath.addCurve(to: CGPoint(x: 515.54, y: 666.08), controlPoint1: CGPoint(x: 453.51, y: 569.97), controlPoint2: CGPoint(x: 492.73, y: 613))
    bezierPath.addCurve(to: CGPoint(x: 397.88, y: 324.29), controlPoint1: CGPoint(x: 561.31, y: 535.15), controlPoint2: CGPoint(x: 533.43, y: 418.95))
    bezierPath.addCurve(to: CGPoint(x: 597.11, y: 487.53), controlPoint1: CGPoint(x: 492.26, y: 336.03), controlPoint2: CGPoint(x: 560.48, y: 387.68))
    bezierPath.addCurve(to: CGPoint(x: 566.29, y: 145.33), controlPoint1: CGPoint(x: 686.88, y: 364.96), controlPoint2: CGPoint(x: 676.61, y: 250.89))
    bezierPath.addCurve(to: CGPoint(x: 735.44, y: 341.82), controlPoint1: CGPoint(x: 659.44, y: 164.51), controlPoint2: CGPoint(x: 713.6, y: 232.81))
    bezierPath.addCurve(to: CGPoint(x: 856.62, y: 10.42), controlPoint1: CGPoint(x: 880.21, y: 257.1), controlPoint2: CGPoint(x: 934.51, y: 150.06))
    bezierPath.addCurve(to: CGPoint(x: 959.44, y: 239.29), controlPoint1: CGPoint(x: 940.88, y: 49.13), controlPoint2: CGPoint(x: 985.5, y: 117.64))
    bezierPath.addCurve(to: CGPoint(x: 1213.09, y: -0.12), controlPoint1: CGPoint(x: 1114.49, y: 228.13), controlPoint2: CGPoint(x: 1203.58, y: 152.75))
    bezierPath.addCurve(to: CGPoint(x: 1220.56, y: 249.21), controlPoint1: CGPoint(x: 1262.13, y: 65.62), controlPoint2: CGPoint(x: 1281.85, y: 142.3))
    bezierPath.addCurve(to: CGPoint(x: 1490.84, y: 111.74), controlPoint1: CGPoint(x: 1344.82, y: 281.39), controlPoint2: CGPoint(x: 1434.92, y: 235.57))
    bezierPath.addCurve(to: CGPoint(x: 1468.79, y: 308.26), controlPoint1: CGPoint(x: 1504.06, y: 173.62), controlPoint2: CGPoint(x: 1500.97, y: 238.37))
    bezierPath.addCurve(to: CGPoint(x: 1682.73, y: 294.32), controlPoint1: CGPoint(x: 1547.23, y: 357.64), controlPoint2: CGPoint(x: 1618.07, y: 346.41))
    bezierPath.addCurve(to: CGPoint(x: 1575.87, y: 494.95), controlPoint1: CGPoint(x: 1664.69, y: 372.07), controlPoint2: CGPoint(x: 1631.41, y: 440.4))
    bezierPath.addCurve(to: CGPoint(x: 1809.16, y: 695.05), controlPoint1: CGPoint(x: 1723.58, y: 515.21), controlPoint2: CGPoint(x: 1789.35, y: 589.87))
    bezierPath.addCurve(to: CGPoint(x: 1649.67, y: 690.49), controlPoint1: CGPoint(x: 1762.8, y: 671.8), controlPoint2: CGPoint(x: 1709.63, y: 670.28))
    bezierPath.addCurve(to: CGPoint(x: 1749.81, y: 1157.17), controlPoint1: CGPoint(x: 1750.29, y: 833.88), controlPoint2: CGPoint(x: 1805.43, y: 988.47))
    bezierPath.addLine(to: CGPoint(x: 1749.8, y: 1157.18))
    bezierPath.close()
    bezierPath.move(to: CGPoint(x: 581.4, y: 690.05))
    bezierPath.addCurve(to: CGPoint(x: 556.66, y: 881.61), controlPoint1: CGPoint(x: 589.17, y: 770.48), controlPoint2: CGPoint(x: 508.66, y: 825.83))
    bezierPath.addCurve(to: CGPoint(x: 581.4, y: 690.05), controlPoint1: CGPoint(x: 613.56, y: 830.02), controlPoint2: CGPoint(x: 611, y: 763.44))
    bezierPath.close()
    bezierPath.usesEvenOddFillRule = true
    fillColor.setFill()
    return bezierPath
  }

}
