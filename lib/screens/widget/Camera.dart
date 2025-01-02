import 'package:brisasdeltiticaca/screens/register-screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScanner extends StatefulWidget {
  const CameraScanner({super.key});

  @override
  State<CameraScanner> createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal, returnImage: true),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            //Recorremos el codigo de barras
            for (final barcode in barcodes) {
              final ssid = extractSsid(barcode.rawValue!);
              final password = extractPassword(barcode.rawValue!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPerson(
                            ssid: ssid ?? "",
                            password: password ?? "",
                          )));
            }
          },
        ),
        Center(
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: SquarePainter(),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo_camera_back,
                    color: Colors.white,
                    size: 40,
                  )),
            ],
          ),
        )
      ],
    );
  }
}

/*Widgets Customizados*/
class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the paint properties for the square
    final Paint paint = Paint()
      ..color = Colors.white // Color of the square
      ..strokeWidth = 3 // Border thickness
      ..style = PaintingStyle.stroke; // Only draw the border

    // Define the square dimensions
    final double squareSize = 200.0; // Adjust the size of the square
    final double left = (size.width - squareSize) / 2;
    final double top = (size.height - squareSize) / 2;

    // Draw the square
    final Rect rect = Rect.fromLTWH(left, top, squareSize, squareSize);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless explicitly required
  }
}

/*MÉTODOS PARA EXTRAER EL SSID Y PASSWORD PARA PASAR AL CONTROLADOR DEL TEXTO*/
String? extractSsid(String barcode) {
  final wifiRegex = RegExp(r"S:(?<ssid>[^;]+);");
  final match = wifiRegex.firstMatch(barcode);
  return match?.namedGroup('ssid');
}

String? extractPassword(String barcode) {
  final wifiRegex = RegExp(r"P:(?<password>[^;]+);");
  final match = wifiRegex.firstMatch(barcode);
  return match?.namedGroup('password');
}

/*MÉTODO PARA EXTRAER EL DETALLE DEL WIFI*/
void extractWifiDetails(String barcode) {
  final wifiRegex =
      RegExp(r"WIFI:T:(?<type>[^;]+);S:(?<ssid>[^;]+);P:(?<password>[^;]+);;");
  final match = wifiRegex.firstMatch(barcode);

  if (match != null) {
    final ssid = match.namedGroup("ssid");
    final password = match.namedGroup("password");

    print("SSID: $ssid");
    print("Password: $password");

    final wifiDetails = {"ssid": ssid, "password": password};

    print('Wifi Details: $wifiDetails');
  }
}
