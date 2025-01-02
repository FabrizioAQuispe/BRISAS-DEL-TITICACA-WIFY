import 'package:flutter/material.dart';

class EventosScreen extends StatelessWidget {
  const EventosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de eventos
    final List<Map<String, String>> eventos = [
      {
        'titulo': 'Concierto de Música Andina',
        'descripcion': 'Disfruta de una noche mágica con los mejores intérpretes.',
        'fecha': '12/01/2025',
        'hora': '7:00 PM',
      },
      {
        'titulo': 'Feria Gastronómica',
        'descripcion': 'Saborea los platos típicos de nuestra región.',
        'fecha': '15/01/2025',
        'hora': '10:00 AM',
      },
      {
        'titulo': 'Danza de los Caporales',
        'descripcion': 'Una presentación cultural inolvidable.',
        'fecha': '18/01/2025',
        'hora': '6:00 PM',
      },
      {
        'titulo': 'Exposición de Arte',
        'descripcion': 'Obras de artistas locales en un ambiente único.',
        'fecha': '20/01/2025',
        'hora': '4:00 PM',
      },
      {
        'titulo': 'Taller de Cerámica',
        'descripcion': 'Aprende a crear tus propias piezas de arte.',
        'fecha': '22/01/2025',
        'hora': '2:00 PM',
      },
      {
        'titulo': 'Conferencia de Historia',
        'descripcion': 'Explora las raíces de nuestra cultura.',
        'fecha': '25/01/2025',
        'hora': '5:00 PM',
      },
      {
        'titulo': 'Festival de Cometas',
        'descripcion': 'Un evento familiar lleno de color y diversión.',
        'fecha': '28/01/2025',
        'hora': '3:00 PM',
      },
      {
        'titulo': 'Noche de Poesía',
        'descripcion': 'Recitales de los mejores poetas de la región.',
        'fecha': '30/01/2025',
        'hora': '8:00 PM',
      },
      {
        'titulo': 'Cine al Aire Libre',
        'descripcion': 'Películas clásicas bajo las estrellas.',
        'fecha': '01/02/2025',
        'hora': '7:30 PM',
      },
      {
        'titulo': 'Maratón 10K',
        'descripcion': 'Participa en esta emocionante carrera.',
        'fecha': '03/02/2025',
        'hora': '7:00 AM',
      },
    ];

    return MaterialApp(
      title: 'Eventos',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Eventos de Brisas del Titicaca'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Stack(
          children: [
            // Fondo de imagen genérico
            Container(
              decoration: const BoxDecoration(

              ),
            ),
            // ListView de eventos
            ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Imagen del evento
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              evento['titulo']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              evento['descripcion']!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '📅 ${evento['fecha']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '🕒 ${evento['hora']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción al presionar el botón
                          },
                          child: const Text('Ver detalles'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
