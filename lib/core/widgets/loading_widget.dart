import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 30,
          width: MediaQuery.of(context).size.width / 15,
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
