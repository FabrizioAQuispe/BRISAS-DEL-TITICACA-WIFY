import 'package:brisasdeltiticaca/screens/eventos-screen.dart';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class RegisterPerson extends StatefulWidget {
  final String ssid;
  final String password;

  const RegisterPerson({
    required this.ssid,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPerson> createState() => _RegisterPersonState();
}

class _RegisterPersonState extends State<RegisterPerson> {
  late TextEditingController _ssidController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores recibidos
    _ssidController = TextEditingController(text: widget.ssid);
    _passwordController = TextEditingController(text: widget.password);
  }

  //Función para guardar los datos de la persona

  //Función para conectar al wifi
  Future<void> _connectToWifi() async {
    String ssid = _ssidController.text.trim();
    String password = _passwordController.text.trim();

    if (ssid.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, ingrese SSID y contraseña")),
      );
      return;
    }

    try {
      bool isConnected = await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
        joinOnce: false, // Desconecta después de salir de la app
        security: NetworkSecurity
            .WPA, // WPA es el estándar para la mayoría de redes WiFi
      );

      if (isConnected) {
        await WiFiForIoTPlugin.registerWifiNetwork(
          ssid,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Conexión exitosa")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al conectar a la red")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conexión WiFi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(),
            TextField(
              controller: _ssidController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Nombre de la red (SSID)",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Contraseña",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await _connectToWifi();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EventosScreen()));
              },
              //          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventosScreen()))
              child: const Text("Conectar a WiFi"),
            ),
          ],
        ),
      ),
    );
  }
}
