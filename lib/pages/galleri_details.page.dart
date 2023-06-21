import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleriDetailsPage extends StatefulWidget {
  String keyWord = "";

  GalleriDetailsPage(this.keyWord);

  @override
  State<GalleriDetailsPage> createState() => _GalleriDetailsPageState();
}

class _GalleriDetailsPageState extends State<GalleriDetailsPage> {
  var GalleriData;
  int nbpage =1 ;
  int totalPages=10;

  ScrollController _controller = ScrollController();
  String message = "";
  @override
  void initState() {
    super.initState();
    getGalleriData(widget.keyWord);
    _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    _controller.addListener(_onScrollEvent);
  }
  void _onScrollEvent() {
    if (_controller.position.pixels==_controller.position.maxScrollExtent){
      if (nbpage<totalPages){
        nbpage++;
        getGalleriData(widget.keyWord);
      }
    }
  }

  /*_scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }*/
  List<dynamic>hits=[];
  void getGalleriData(String keyWord) {
    print("Dalleri de la keyWord de" + keyWord);
    String url =
        "https://pixabay.com/api/?key=19081875-6eebdaaf29471b2b6194e564b&q=${keyWord}&page=${nbpage}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        // this.GalleriData = json.decode(resp.body);
        //  print(this.GalleriData);
        this.GalleriData=json.decode(resp.body);
        hits.addAll(GalleriData['hits']);
        print(hits);

      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(title: Text(" ${widget.keyWord} : Page ${nbpage}/${totalPages}")),
        body: GalleriData ==null
            ? Center(
          child: CircularProgressIndicator(),
        ):
        ListView.builder(
            controller: _controller,
            itemCount:  (GalleriData == null ? 0: hits.length),
            itemBuilder: (context, index) {
              return             Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Card(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue,Colors.transparent]
                              )
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //ce widget sera developpé dans la question 9
                                        Text(
                                          hits[index]['tags'] ,
                                          style: TextStyle(
                                            fontSize: 22, fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //ce widget sera developpé dans la question 10

                                      ],
                                    ),
                                  )

                                ],
                              ),

                            ],
                          ),

                        )

                    ),

                    Image.network( hits[index]['userImageURL']),
                  ],
                ),
              );

            }));
  }
}
