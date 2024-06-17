import 'dart:typed_data';

import 'package:app_asistencia/config/theme/paletaColors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Center(
            child: Text(
              'DOCENTECHECK',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontSize: 23),
            ),
          ),
        ), 
      body: Container(
        color: backgroundColor2,
        child: Column(
          children: [
            
            const Text(
              'QR Scaner',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontSize: 35
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: 
                MobileScanner(

                  controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),

                  onDetect: (capture) {
                  
                    print('capture: $capture');
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    for(final barcode in barcodes){
                      print('Barcode found: ${barcode.rawValue}');
                    }
                    if(image != null){
                      showDialog(context: context,builder: (context) {
                          return AlertDialog(
                            title: Text('QR escaneado correctamente ${barcodes.first.rawValue}' , style: const TextStyle(fontSize: 15),),
                            content: Image(image: MemoryImage(image),),
                            actions: [
                              ElevatedButton.icon(
                                // style: ElevatedButton.styleFrom(
                                //   minimumSize: Size(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height * 0.001),
                                //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Espaciado interno
                                //   textStyle: const TextStyle(fontSize: 14),   
                                // ),
                                onPressed: (){
                                  print(capture);
                                  context.pop();
                                }, 
                                icon: const Icon(Icons.qr_code_2, size: 14,), 
                                label: const Text('Ver QR')
                              ),
                            ],
                          );
                        }, 
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}