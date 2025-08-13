import 'package:flutter/material.dart';
import 'package:my_homework_app/src/pages/popups.dart';

class CardNotification extends StatelessWidget {
  final String texto1;
  final String texto2;
  final bool showButton;

  const CardNotification({
    super.key,
    required this.texto1,
    required this.texto2,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(texto1, style: TextStyle(fontSize: 15)),
                  Text(texto2, style: TextStyle(fontSize: 15)),
                ],
              ),
              if (showButton)
                IconButton(
                  onPressed: () {
                    MostrarPopup.mostrar(context);
                  },
                  icon: Icon(
                    Icons.add_task_outlined,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
