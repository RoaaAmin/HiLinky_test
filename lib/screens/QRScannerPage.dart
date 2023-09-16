import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs= [];
  bool myCardFetched = false;





  getMyCards(data) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Cards')
          .where('cardId', isEqualTo: data)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            cardsDocs = value.docs.toList();
            myCardFetched = true;
          });
          cardsDocs.sort((a, b) => b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget curent = Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text('Scan a QR code'),
          ),
        ),
      ],
    );
    if (cardsDocs != null) {
      if (cardsDocs.length != 0) {
        curent = ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 75),
            itemCount: cardsDocs.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()async{
                  //  showUserBottomSheet(postsDocs[i]);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 110,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFF495592),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(image: NetworkImage(cardsDocs[i].data()!['ImageURL']), fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFF495592).withOpacity(0.9),
                        ),
                        Text(
                          'name:',
                          style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        Text(
                          cardsDocs[i].data()!['FirstName'],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        Divider(
                          color: Color(0xFF495592).withOpacity(0.9),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Position: ',
                                  style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  cardsDocs[i].data()!['Position'],
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
                                ),
                                // postsDocs[i].data()!['TimeStamp'],
                              ],

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: curent
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null && scanData.code != null) {
        /// Handle the scanned data here.
        getMyCards(scanData.code);
        print(scanData.code);
      }
    });
  }

}
