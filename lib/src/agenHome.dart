import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/all_critic.dart';
import 'package:warnakaltim/src/all_event.dart';
import 'package:warnakaltim/src/all_hotPromo.dart';
import 'package:warnakaltim/src/all_news.dart';
import 'package:warnakaltim/src/all_promo.dart';
import 'package:warnakaltim/src/all_videos.dart';
import 'package:warnakaltim/src/company.dart';
import 'package:warnakaltim/src/detail_Promo.dart';
import 'package:warnakaltim/src/detail_event.dart';
import 'package:warnakaltim/src/detail_news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warnakaltim/main.dart';
import 'package:warnakaltim/src/doApproveAgen.dart';
import 'package:warnakaltim/src/login.dart';
import 'package:warnakaltim/src/model/HomeAgenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/src/profileAgen.dart';
import 'package:warnakaltim/src/salesOrder.dart';
import 'package:http/http.dart' as http;

class AgenHomeDetail extends StatefulWidget {
  // final email;
  // final token;
  // AgenHomeDetail({
  //   Key key,
  //   this.email,
  //   this.token,
  // }) : super(key: key);

  @override
  _AgenHomeState createState() => _AgenHomeState();
}

Future<void> _refreshData(BuildContext context) async {
  await Provider.of<AgenHomeModel>(context, listen: false).fetchDataAgenHome();
}

Future<http.Response> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.get('Token');

  http.Response hasil =
      await http.post(Uri.decodeFull(urls + "/api/logout"), body: {
    // "email": emailController.text,
    // "old_password": oldpasswordController.text,
    // "new_password": passwordController.text
  }, headers: {
    "Accept": "application/JSON",
    "Authorization": 'Bearer ' + token
  });
  print(hasil.statusCode);
  return Future.value(hasil);
}

class _AgenHomeState extends State<AgenHomeDetail> {
  var releaseTime = TimeOfDay.now(); // 3:00pm

  @override
  void initState() {
    super.initState();
    print("badges : ---- $badges");
    // _getToken();
    // WidgetsBinding.instance.addObserver(this);
  }

  final GlobalKey<ScaffoldState> _agenhomeKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('dapat' + email.toString());
    print('dapat' + token.toString());

    double b_width = MediaQuery.of(context).size.width * 0.5;
    double b_height = MediaQuery.of(context).size.width * 0.4;

    double a_width = MediaQuery.of(context).size.width * 0.6;
    double a_height = MediaQuery.of(context).size.width * 0.5;

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.3;

    double d_width = MediaQuery.of(context).size.width * 0.3;
    double d_height = MediaQuery.of(context).size.height * 0.3;

    double e_width = MediaQuery.of(context).size.width * 0.3;
    double e_height = MediaQuery.of(context).size.height / 8;

    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );

    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void _incrementCounter(int jum) {
      // setState(() {
      badges = badges + jum;
      // });
    }

    void _increment() {
      setState(() {
        badges--;
      });
    }

    return Scaffold(
      key: _agenhomeKey,
      backgroundColor: Colors.grey[850],
      // appBar: AppBar(title: Text('WARNA KALTIM')),
      body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: FutureBuilder(
              future: Provider.of<AgenHomeModel>(context, listen: false)
                  .fetchDataAgenHome(),
              builder: (ctx, snapshop) {
                if (snapshop.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshop.error != null) {
                    return Center(
                      child: Text("Error Loading Data"),
                    );
                  }
                  return Consumer<AgenHomeModel>(
                      builder: (ctx, _listNews, child) => Center(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                iconTheme: IconThemeData(
                                  color: Colors.white, //change your color here
                                ),
                                backgroundColor: Colors.black,
                                floating: false,
                                pinned: true,
                                expandedHeight:
                                    MediaQuery.of(context).size.width / 20,
                                leading: email == null
                                    ? null
                                    : new IconButton(
                                        icon: new Icon(Icons.menu, color: gold),
                                        onPressed: () {
                                          pdf = _listNews
                                              .listHomeDetail[0].company.profile
                                              .toString();

                                          _agenhomeKey.currentState
                                              .openDrawer();
                                        }),
                                flexibleSpace: FlexibleSpaceBar(
                                  // centerTitle: true,
                                  title: Row(
                                    crossAxisAlignment: email == null
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/patra.jpg',
                                            // Expanded(
                                            //     child: Container(
                                            //         // width: 100,
                                            //         child: Image.network(
                                            //   _listNews
                                            //       .listHomeDetail[0].company.,
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            // height: MediaQuery.of(context).size.height / 200,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10)),
                                      Expanded(
                                          child: email == null
                                              ? Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      InkWell(
                                                          onTap: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Login()));
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: gold,
                                                            size: 35,
                                                          ))
                                                    ],
                                                  ))
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                        _listNews
                                                            .listHomeDetail[0]
                                                            .user
                                                            .agen
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                    Text(
                                                        'Reward Point Management ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                  ],
                                                ))
                                    ],
                                  ),
                                  titlePadding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 8,
                                      0.0,
                                      MediaQuery.of(context).size.width / 100,
                                      MediaQuery.of(context).size.width / 100),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: gold,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    pdf = _listNews
                                        .listHomeDetail[0].company.profile
                                        .toString();
                                    print('pdfnya' + pdf);
                                    return email != null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black12,
                                            padding: EdgeInsets.all(10),
                                            // width: c_width,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height * 100,
                                            // 0.32,
                                            child: Card(
                                                // shape: RoundedRectangleBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(10),
                                                //   side: BorderSide(
                                                //     color: gold,
                                                //     width: 2.0,
                                                //   ),
                                                // ),
                                                color: Colors.black12,
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                10.0,
                                                                0.0,
                                                                20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5)),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    "Good Evening",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                                Text("Guest",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15)),
                                                              ],
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            150,
                                                                        right:
                                                                            10)),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: <
                                                                    Widget>[
                                                                  Text(''),
                                                                  Text("Login",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15)),
                                                                ]),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: <Widget>[
                                                                  Text(''),
                                                                  Icon(
                                                                      Icons
                                                                          .input,
                                                                      color:
                                                                          gold,
                                                                      size: 30)
                                                                ])
                                                          ],
                                                        )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20)),
                                                    new Expanded(
                                                        child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: _listNews
                                                          .listHomeDetail[0]
                                                          .event
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                            // width: 400,
                                                            // height: 300,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DetailPromo(id: _listNews.listHomeDetail[0].hot[index].id.toString()),
                                                                      ));
                                                                },
                                                                child: Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                      side:
                                                                          BorderSide(
                                                                        color:
                                                                            gold,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      _listNews
                                                                          .listHomeDetail[
                                                                              0]
                                                                          .event[
                                                                              index]
                                                                          .image,
                                                                      //   fit: BoxFit
                                                                      //       .cover,
                                                                      // )
                                                                      //   Image
                                                                      //       .asset(
                                                                      // 'assets/iklan-pertamina.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ))));
                                                      },
                                                    )
                                                        //         new Swiper(
                                                        //   itemBuilder:
                                                        //       (BuildContext context,
                                                        //           int index) {
                                                        //     return new Image.asset(
                                                        //       'assets/iklan-pertamina.png',
                                                        //       fit: BoxFit.fill,
                                                        //     );
                                                        //   },
                                                        //   itemCount: 10,
                                                        //   viewportFraction: 0.8,
                                                        //   scale: 0.9,
                                                        // )
                                                        ),
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return email == null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black,
                                            padding: EdgeInsets.all(10),
                                            width: c_width,
                                            height: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15)),
                                                Container(
                                                  // padding: EdgeInsets.all(),
                                                  child: Marquee(
                                                      direction:
                                                          Axis.horizontal,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      animationDuration:
                                                          Duration(seconds: 3),
                                                      backDuration: Duration(
                                                          milliseconds: 3000),
                                                      pauseDuration: Duration(
                                                          milliseconds: 100),
                                                      // directionMarguee:
                                                      //     DirectionMarguee.oneDirection,
                                                      child: Text(
                                                        _listNews
                                                                    .listHomeDetail[
                                                                        0]
                                                                    .company
                                                                    .description ==
                                                                null
                                                            ? "Welcome to PT Pertamina Patra Niaga Loyalty Card"
                                                            : _listNews
                                                                .listHomeDetail[
                                                                    0]
                                                                .company
                                                                .description,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: gold,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10)),
                                                new Expanded(
                                                    child: Container(
                                                        // height: 200,
                                                        // width: 200,
                                                        child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                        width: 400,
                                                        height: 400,
                                                        // MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .height *
                                                        //     50,
                                                        child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => DetailEvent(
                                                                        url: _listNews
                                                                            .listHomeDetail[0]
                                                                            .event[index]
                                                                            .url
                                                                            .toString()),
                                                                  ));
                                                            },
                                                            child:
                                                                Image.network(
                                                              _listNews
                                                                  .listHomeDetail[
                                                                      0]
                                                                  .event[index]
                                                                  .image,
                                                              fit: BoxFit.cover,
                                                            )));
                                                  },
                                                ))),
                                              ],
                                            ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    // if (badges == 0) {

                                    badges = 0;
                                    _incrementCounter(_listNews
                                        .listHomeDetail[0].totalNotifDo);

                                    // }
                                    // badges = _listNews
                                    //     .listHomeDetail[0].totalNotifDo;
                                    return email == null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black12,
                                            padding: EdgeInsets.all(10),
                                            // width: c_width,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.42,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                    color: gold,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                color: Colors.black12,
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                10.0,
                                                                0.0,
                                                                20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                                child: Image
                                                                    .network(
                                                                  _listNews
                                                                      .listHomeDetail[
                                                                          0]
                                                                      .user
                                                                      .agen
                                                                      .logo,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 50,
                                                                  height: 50,
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5)),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    releaseTime.hour.toInt() <=
                                                                            12
                                                                        ? "Good Morning"
                                                                        : releaseTime.hour.toInt() <=
                                                                                18
                                                                            ? 'Good Afternoon'
                                                                            : "Good Evening",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                                Text(
                                                                    _listNews
                                                                        .listHomeDetail[
                                                                            0]
                                                                        .user
                                                                        .agen
                                                                        .name,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12)),
                                                                Text(
                                                                    _listNews
                                                                        .listHomeDetail[
                                                                            0]
                                                                        .user
                                                                        .agen
                                                                        .member,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                              ],
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5)),
                                                            // Padding(
                                                            //     padding: EdgeInsets
                                                            //         .only(
                                                            //             left:
                                                            //                 50,
                                                            //             right:
                                                            //                 10)),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DoApproveAgen(),
                                                                      ));
                                                                },
                                                                child: badges ==
                                                                        0
                                                                    ? Icon(
                                                                        Icons
                                                                            .notifications_active,
                                                                        size:
                                                                            30,
                                                                        color:
                                                                            gold,
                                                                      )
                                                                    : Badge(
                                                                        badgeContent:
                                                                            Text(
                                                                          '$badges',
                                                                          // style: TextStyle(
                                                                          //     color:
                                                                          //         Colors.white,
                                                                          //     fontSize: 12),
                                                                        ),
                                                                        badgeColor:
                                                                            Colors.red[
                                                                                900],
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .notifications_active,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              gold,
                                                                        )),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      thickness: 5,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10)),
                                                    Image.network(
                                                      _listNews
                                                          .listHomeDetail[0]
                                                          .user
                                                          .agen
                                                          .cardImage,
                                                      // Image.asset(
                                                      //   'assets/pertamina-loyalty-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Special Offers',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  // _increment();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllHotPromo(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: a_width,
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    // _listNews.listHomeDetail[0].hot.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          padding: EdgeInsets.all(10),
                                          width: a_width,
                                          height: a_height,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPromo(
                                                              id: _listNews
                                                                  .listHomeDetail[
                                                                      0]
                                                                  .hot[index]
                                                                  .id
                                                                  .toString()),
                                                    ));
                                              },
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    side: BorderSide(
                                                      color: gold,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    _listNews.listHomeDetail[0]
                                                        .hot[index].image,
                                                    //   fit: BoxFit.cover,
                                                    // )
                                                    //   Image.asset(
                                                    // 'assets/promo2.jpg',
                                                    fit: BoxFit.cover,
                                                  ))));
                                    },
                                  ),
                                ),
                              ),

                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Videos',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllVideos(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: a_width,
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _listNews.listHomeDetail[0]
                                                .videos.length <
                                            4
                                        ? _listNews
                                            .listHomeDetail[0].videos.length
                                        : 4,
                                    // _listNews.listHomeDetail[0].hot.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        width: a_width,
                                        height: a_height,
                                        child: Stack(
                                            alignment: Alignment.topLeft,
                                            children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    _launchURL(_listNews
                                                        .listHomeDetail[0]
                                                        .videos[index]
                                                        .url
                                                        .toString());
                                                  },
                                                  child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        side: BorderSide(
                                                          color: gold,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Image.network(
                                                        _listNews
                                                            .listHomeDetail[0]
                                                            .videos[index]
                                                            .image,
                                                        //   fit: BoxFit.cover,
                                                        // )
                                                        //   Image.asset(
                                                        // 'assets/promo2.jpg',
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      ))),
                                              Center(
                                                  // top: 60.0,
                                                  // left: 75.0,
                                                  child: InkWell(
                                                      onTap: () {
                                                        _launchURL(_listNews
                                                            .listHomeDetail[0]
                                                            .videos[index]
                                                            .url
                                                            .toString());
                                                      },
                                                      child: Container(
                                                          color: Colors.yellow
                                                              .withOpacity(0.5),
                                                          child: Padding(
                                                              padding: EdgeInsets.all(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      150),
                                                              child: Icon(
                                                                Icons
                                                                    .play_circle_outline,
                                                                size: 50,
                                                              ))))),
                                            ]),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Informasi Terbaru",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllNews(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailNews(
                                                        url: _listNews
                                                            .listHomeDetail[0]
                                                            .news[index]
                                                            .url
                                                            .toString())));
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: b_width,
                                          height: 150,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              side: BorderSide(
                                                color: gold,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Stack(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    children: <Widget>[
                                                      Image.network(
                                                          _listNews
                                                              .listHomeDetail[0]
                                                              .news[index]
                                                              .image
                                                              .toString(),
                                                          // Image.asset(
                                                          //     'assets/news.jpg',
                                                          width: d_width,
                                                          height: c_height,
                                                          fit: BoxFit.cover),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5)),
                                                      Positioned(
                                                          top: 2.0,
                                                          left: 2.0,
                                                          child: Container(
                                                              color: Colors
                                                                  .yellow
                                                                  .withOpacity(
                                                                      0.5),
                                                              child: Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        150),
                                                                child: Text(
                                                                    _listNews
                                                                        .listHomeDetail[
                                                                            0]
                                                                        .news[
                                                                            index]
                                                                        .category[
                                                                            0]
                                                                        .name
                                                                        .toString(),
                                                                    // 'Bencana',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black)),
                                                              ))),
                                                    ]),
                                                Padding(
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            100)),
                                                Flexible(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                        _listNews
                                                            .listHomeDetail[0]
                                                            .news[index]
                                                            .title
                                                            .toString(),
                                                        // 'Produksi Anjlok karena Virus Corona, Iphone Bisa Langka di Pasaran ???',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            // textBaseline: TextBaseline.alphabetic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10)),

                                                    // Text(
                                                    //     _listNews
                                                    //         .listHomeDetail[0]
                                                    //         .news[index]
                                                    //         .createdAt
                                                    //         .toString(),
                                                    //     // '18 February 2020',
                                                    //     overflow: TextOverflow
                                                    //         .ellipsis,
                                                    //     maxLines: 5,
                                                    //     style: TextStyle(
                                                    //       color: Colors.black54,
                                                    //       fontSize: 15,
                                                    //       fontStyle:
                                                    //           FontStyle.italic,
                                                    //       textBaseline:
                                                    //           TextBaseline
                                                    //               .alphabetic,
                                                    //     )),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          )));
                                }, childCount: 4
                                    // _listNews.listHomeDetail[0].news.length
                                    // _listNews.listHomeDetail[0].news.length,
                                    ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Tukar Poin, yuk!",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllPromo(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              // SliverToBoxAdapter(
                              //   child: Container(
                              //     padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 30.0),
                              //     width: 300,
                              //     height: 500,
                              // child:
                              SliverGrid(
                                // gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                //     maxCrossAxisExtent: 200, childAspectRatio: 1),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.5),
                                ),
                                //     SliverGridDelegateWithMaxCrossAxisExtent(
                                //   maxCrossAxisExtent: 250.0,
                                //   mainAxisSpacing: 50.0,
                                //   crossAxisSpacing: 10.0,
                                //   // childAspectRatio: 4.0,
                                // ),
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      width: e_width,
                                      height: e_height,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPromo(
                                                          id: _listNews
                                                              .listHomeDetail[0]
                                                              .normal[index]
                                                              .id
                                                              .toString()),
                                                ));
                                          },
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: gold,
                                                  width: 2.0,
                                                ),
                                              ),
                                              color: Colors.black12,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                    _listNews.listHomeDetail[0]
                                                        .normal[index].image
                                                        .toString(),
                                                    // Image.asset(
                                                    //   'assets/iklan-max.jpg',
                                                    fit: BoxFit.cover,
                                                    // width: e_width,
                                                    // height: e_height,
                                                  )))));
                                }, childCount: 4
                                    // _listNews.listHomeDetail[0].normal.length,
                                    // ),
                                    ),
                              ),
                            ],
                          )));
                }
              })),
      drawer: email == null
          ? null
          : Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[
                    850], //This will change the drawer background to blue.
                //other styles
              ),
              child: email == null
                  ? Text('')
                  : Drawer(
                      elevation: 12,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          DrawerHeader(
                            child:
                                // Text("data"),
                                Image.asset(
                              'assets/patra.jpg',
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.perm_identity, color: gold),
                                title: Text('Company Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyDetail(url: pdf)));
                                },
                              )),
                          // Container(
                          //     padding: EdgeInsets.only(top: 2),
                          //     decoration: new BoxDecoration(
                          //         color: Colors.black12,
                          //         border: new Border(
                          //             bottom: new BorderSide(
                          //                 color: Colors.grey[850]))),
                          //     child: ListTile(
                          //       leading: Icon(Icons.phone, color: gold),

                          //       title: Text('Contact Distributor',
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.bold)),
                          //       // isThreeLine: true,
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     DistributorProfile()));
                          //       },
                          //     )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.phone_android, color: gold),

                                title: Text('Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AgenDetail()));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.new_releases, color: gold),

                                title: Text('Event',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllEvent()));
                                },
                              )),
                          // Container(
                          //     padding: EdgeInsets.only(top: 2),
                          //     decoration: new BoxDecoration(
                          //         color: Colors.black12,
                          //         border: new Border(
                          //             bottom: new BorderSide(
                          //                 color: Colors.grey[850]))),
                          //     child: ListTile(
                          //       leading:
                          //           Icon(Icons.local_car_wash, color: gold),

                          //       title: Text('Driver Arrival Input',
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.bold)),
                          //       // isThreeLine: true,
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     DriverHistory()));
                          //       },
                          //     )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.history, color: gold),

                                title: Text('Sales Order ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SalesOrderDetail()));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.star, color: gold),

                                title: Text('Rate ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Allcritic()));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(
                                    email == null ? Icons.input : Icons.input,
                                    color: gold),
                                title: email == null
                                    ? Text('Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                    : Text('Logout',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),

                                // isThreeLine: true,
                                onTap: email == null
                                    ? () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    : () async {
                                        await logout();
                                        // setState(() async{
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove('Email');
                                        prefs.remove('Token');
                                        login = false;
                                        email = null;
                                        token = null;
                                        // });

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      },
                              )),
                          Padding(padding: EdgeInsets.only(top: 300)),
                          // Container(
                          //     height: 100,
                          //     padding: EdgeInsets.only(top: 10),
                          //     decoration: new BoxDecoration(
                          //         color: Colors.black12,
                          //         border: new Border(
                          //             bottom: new BorderSide(
                          //                 color: Colors.grey[850]))),
                          //     child: Center(
                          //         child: ListTile(
                          //       // leading: Icon(Icons.assessment, color: gold),
                          //       title: Text('Build by Topq',
                          //           style: TextStyle(
                          //               color: gold,
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.bold)),
                          //       subtitle: Text('Topq@gmail.com',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             // fontSize: 15,
                          //             // fontWeight: FontWeight.bold
                          //           )),
                          //       // isThreeLine: true,
                          //       onTap: () {
                          //         Navigator.of(context).pushNamed(
                          //           '/mangas',
                          //         );
                          //       },
                          //     ))),
                        ],
                      ),
                    )),
    );
    //   }
    // })),

    // floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.mood_bad,)),
    // );
  }
}
