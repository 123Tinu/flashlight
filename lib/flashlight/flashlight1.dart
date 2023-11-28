import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class TorchController1 extends StatefulWidget {
  const TorchController1({super.key});

  @override
  State<TorchController1> createState() => _TorchController1State();
}

class _TorchController1State extends State<TorchController1> {
  @override
  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      _showMessage(
        'Could not check if the device has an available torch',
        context,
      );
      rethrow;
    }
  }

  Future<void> _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  Future<void> _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Torch Light Example App"),
        ),
        body: FutureBuilder<bool>(
            future: _isTorchAvailable(context),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  _enableTorch(context);
                                },
                                child: Text("Enable Torch")))),
                    Expanded(
                        child: Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  _disableTorch(context);
                                },
                                child: Text("Disable Torch")))),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
