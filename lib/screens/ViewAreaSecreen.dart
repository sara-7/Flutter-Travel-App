import 'package:flutter/material.dart';
import 'package:travel_now_app/screens/CategorieSecreen.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';

class ViewAreaSecreen extends StatefulWidget {
  const ViewAreaSecreen({Key? key, this.notes}) : super(key: key);
  final notes;

  @override
  State<ViewAreaSecreen> createState() => _ViewAreaSecreenState();
}

class _ViewAreaSecreenState extends State<ViewAreaSecreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'التفاصيل',
        backgroundColor: Colors.transparent,
        loading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.brown,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            }),
      ),

      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.brown,
            ),
            Positioned(
              bottom: 22.0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.white.withOpacity(0.3), size: 11.0),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.white.withOpacity(0.5), size: 12.0),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.white.withOpacity(0.7), size: 13.0),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.white.withOpacity(0.9), size: 14.0),
                        RotatedBox(
                            child:
                                Icon(Icons.local_airport, color: Colors.white),
                            quarterTurns: 1),
                      ],
                    ),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 65.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0)),
                  color: Colors.white),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 310.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0)),
                  image: DecorationImage(
                      image: NetworkImage("${widget.notes['image']}"),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 350.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 35.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      size: 12.0, color: Colors.grey),
                                  Text(
                                    "${widget.notes['site']}",
                                    style: TextStyle(
                                        fontFamily: 'Opensans',
                                        fontSize: 12.0,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              Text("${widget.notes['name']}",
                                  style: TextStyle(
                                      fontFamily: 'Opensans',
                                      fontSize: 27.0,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                          Container(
                            height: 60.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.favorite_border,
                                    color: Colors.black, size: 20.0),
                                SizedBox(height: 7.0)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Container(
                        width: 500.0,
                        child: Text("${widget.notes['description']}",
                            style: TextStyle(
                                color: Color(0xFF6A6A6A),
                                fontFamily: 'Opensans',
                                fontWeight: FontWeight.w300)),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 15.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Icon(Icons.arrow_back_ios, color: Colors.white, size: 15.0),
                        InkWell(
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 15.0),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategorieSecreen()));
                          },
                        ),
                        SizedBox(width: 20.0),
                        Container(
                            height: 40.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black.withOpacity(0.2)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.star,
                                      color: Colors.white, size: 12.0),
                                  SizedBox(width: 5.0),
                                  Text(
                                    "${widget.notes['rate']}",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                    //Icon(Icons.file_upload, color: Colors.white)
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // body: Container(
      //   child: Stack(children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height,
      //       color: Colors.brown,
      //     ),
      //     Positioned(
      //       bottom: 22.0,
      //       child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           child: Center(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 Icon(Icons.arrow_forward_ios,
      //                     color: Colors.white.withOpacity(0.3), size: 11.0),
      //                 Icon(Icons.arrow_forward_ios,
      //                     color: Colors.white.withOpacity(0.5), size: 12.0),
      //                 Icon(Icons.arrow_forward_ios,
      //                     color: Colors.white.withOpacity(0.7), size: 13.0),
      //                 Icon(Icons.arrow_forward_ios,
      //                     color: Colors.white.withOpacity(0.9), size: 14.0),
      //                 RotatedBox(
      //                     child:
      //                         Icon(Icons.local_airport, color: Colors.white),
      //                     quarterTurns: 1),
      //               ],
      //             ),
      //           )),
      //     ),
      //     Container(
      //       height: MediaQuery.of(context).size.height - 65.0,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(35.0),
      //               bottomRight: Radius.circular(35.0)),
      //           color: Colors.white),
      //     ),
      //     Container(
      //       height: MediaQuery.of(context).size.height - 310.0,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.only(
      //             bottomLeft: Radius.circular(35.0),
      //             bottomRight: Radius.circular(35.0)),
      //         image: DecorationImage(
      //             //image: AssetImage('assets/fishing.jpg'), fit: BoxFit.cover)
      //             image: NetworkImage("${widget.notes['image']}"),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //     Positioned(
      //       top: 350.0,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.only(left: 15.0),
      //             child: Container(
      //               width: MediaQuery.of(context).size.width - 35.0,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       Row(
      //                         children: <Widget>[
      //                           Icon(Icons.location_on,
      //                               size: 12.0, color: Colors.grey),
      //                           Text(
      //                             "${widget.notes['site']}",
      //                             style: TextStyle(
      //                                 fontFamily: 'Opensans',
      //                                 fontSize: 12.0,
      //                                 color: Colors.grey),
      //                           )
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         height: 7.0,
      //                       ),
      //                       Text("${widget.notes['title']}",
      //                           style: TextStyle(
      //                               fontFamily: 'Opensans',
      //                               fontSize: 27.0,
      //                               fontWeight: FontWeight.w600))
      //                     ],
      //                   ),
      //                   Container(
      //                     height: 60.0,
      //                     width: 40.0,
      //                     decoration: BoxDecoration(
      //                         color: Colors.grey.withOpacity(0.1),
      //                         borderRadius: BorderRadius.circular(20.0)),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       children: <Widget>[
      //                         Icon(Icons.favorite_border,
      //                             color: Colors.black, size: 20.0),
      //                         SizedBox(height: 7.0)
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Padding(
      //               padding: EdgeInsets.only(top: 15.0, left: 15.0),
      //               child: Container(
      //                 width: 500.0,
      //                 child: Text("${widget.notes['description']}",
      //                     style: TextStyle(
      //                         color: Color(0xFF6A6A6A),
      //                         fontFamily: 'Opensans',
      //                         fontWeight: FontWeight.w300)),
      //               ))
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
      //       child: Container(
      //         width: MediaQuery.of(context).size.width - 15.0,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             Row(
      //               children: <Widget>[
      //                 // Icon(Icons.arrow_back_ios, color: Colors.white, size: 15.0),
      //                 InkWell(
      //                   child: Icon(Icons.arrow_back_ios,
      //                       color: Colors.white, size: 15.0),
      //                   onTap: () {
      //                     Navigator.of(context).push(MaterialPageRoute(
      //                         builder: (context) => CategorieSecreen()));
      //                   },
      //                 ),
      //                 SizedBox(width: 20.0),
      //                 Container(
      //                     height: 40.0,
      //                     width: 60.0,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20.0),
      //                         color: Colors.black.withOpacity(0.2)),
      //                     child: Center(
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: <Widget>[
      //                           Icon(Icons.star,
      //                               color: Colors.white, size: 12.0),
      //                           SizedBox(width: 5.0),
      //                           Text(
      //                             '4.3',
      //                             style: TextStyle(color: Colors.white),
      //                           )
      //                         ],
      //                       ),
      //                     ))
      //               ],
      //             ),
      //             //Icon(Icons.file_upload, color: Colors.white)
      //           ],
      //         ),
      //       ),
      //     )
      //   ]),
      // )
    );
  }
}
