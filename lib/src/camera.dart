import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warnakaltim/src/homeDriver.dart';

class ActivCamera extends StatefulWidget {
  final String nik;
  final String namaIbuKandung;
  final String tempatLahir;
  final String tglLahir;
  final String jenisKelamin;
  final String agama;
  final String pekerjaan;
  final String statusPerkawinan;
  final String tglBerakhir;
  final String alamatJalan;
  final String alamatRt;
  final String alamatRw;
  final String alamatKelurahan;
  final String alamatKecamatan;
  final String alamatKabupaten;
  final String alamatProvinsi;
  final String alamatKodepos;
  final String tujuanPenggunaanDana;
  final String sumberDana;
  final String penghasilanUtama;
  final String alamatEmail;

  const ActivCamera(
      {Key key,
      this.nik,
      this.namaIbuKandung,
      this.tempatLahir,
      this.tglLahir,
      this.jenisKelamin,
      this.agama,
      this.pekerjaan,
      this.statusPerkawinan,
      this.tglBerakhir,
      this.alamatJalan,
      this.alamatRt,
      this.alamatRw,
      this.alamatKelurahan,
      this.alamatKecamatan,
      this.alamatKabupaten,
      this.alamatProvinsi,
      this.alamatKodepos,
      this.tujuanPenggunaanDana,
      this.sumberDana,
      this.penghasilanUtama,
      this.alamatEmail})
      : super(key: key);
  @override
  _ActivCameraState createState() => _ActivCameraState();
}

class _ActivCameraState extends State<ActivCamera> {
  CameraController controller;

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<XFile> takePicture() async {
    // Directory root = await getTemporaryDirectory();
    // String directoryPath = '${root.path}/camera';
    // await Directory(directoryPath).create(recursive: true);
    // String filepath = '$directoryPath/${DateTime.now()}.jpg';
    try {
      return await controller.takePicture();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivasi Rekening Reguler'),
        // color: Colors.grey[900],
        // colorTitle: Colors.white
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (_, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 30,
                          // ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'Atur posisi kartu identitas anda sesuai garis bantu yang disediakan',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: 300,
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.width /
                              //     controller.value.aspectRatio,
                              child: CameraPreview(controller),
                            ),
                          ),
                          Container(
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: BorderSide(
                                        color: Colors.purple[700], width: 7),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(40.0)),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                child: Container(),
                                onPressed: () async {
                                  if (!controller.value.isTakingPicture) {
                                    XFile result = await takePicture();
                                    print('hasill' + result.path);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DriverHomeDetail(result: result,)));
                                    // Navigator.pop(context, result);
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    // ActivKtpPreview(
                                    //     imageFile: result,
                                    //     nik: widget.nik,
                                    //     namaIbuKandung:
                                    //         widget.namaIbuKandung,
                                    //     tempatLahir: widget.tempatLahir,
                                    //     tglLahir: widget.tglLahir,
                                    //     jenisKelamin:
                                    //         widget.jenisKelamin,
                                    //     agama: widget.agama,
                                    //     pekerjaan: widget.pekerjaan,
                                    //     statusPerkawinan:
                                    //         widget.statusPerkawinan,
                                    //     tglBerakhir: widget.tglBerakhir,
                                    //     alamatJalan: widget.alamatJalan,
                                    //     alamatRt: widget.alamatRt,
                                    //     alamatRw: widget.alamatRw,
                                    //     alamatKelurahan:
                                    //         widget.alamatKelurahan,
                                    //     alamatKecamatan:
                                    //         widget.alamatKecamatan,
                                    //     alamatKabupaten:
                                    //         widget.alamatKabupaten,
                                    //     alamatProvinsi:
                                    //         widget.alamatProvinsi,
                                    //     alamatKodepos:
                                    //         widget.alamatKodepos,
                                    //     tujuanPenggunaanDana:
                                    //         widget.tujuanPenggunaanDana,
                                    //     sumberDana: widget.sumberDana,
                                    //     penghasilanUtama:
                                    //         widget.penghasilanUtama,
                                    //     alamatEmail:
                                    //         widget.alamatEmail)));

                                    // Navigation.replaceWithSlideTransition(() => ActivKtpPreview(imageFile: result,) );
                                  }
                                },
                              )),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
      ),
    );
  }
}
