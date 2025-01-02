import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifyConnects extends StatefulWidget {
  const WifyConnects({super.key});

  @override
  State<WifyConnects> createState() => _WifyConnectsState();
}

class _WifyConnectsState extends State<WifyConnects> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Método para conectar a una red WiFi

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
      password: password.isNotEmpty ? password : null,
      security: password.isNotEmpty ? NetworkSecurity.WPA : NetworkSecurity.NONE,
      withInternet: true,
      joinOnce: false
      );

      if (isConnected) {
        await WiFiForIoTPlugin.registerWifiNetwork(ssid, password: password);
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
            TextField(
              controller: _ssidController,
              decoration: const InputDecoration(
                labelText: "Nombre de la red (SSID)",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Contraseña",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _connectToWifi,
              child: const Text("Conectar a WiFi"),
            ),
          ],
        ),
      ),
    );
  }
}
