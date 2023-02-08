import 'dart:convert';

import 'package:danvery/model/login_info.dart';
import 'package:danvery/model/post_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../palette/palette.dart';

class Home extends StatefulWidget{
  final LoginInfo loginInfo;

  const Home({super.key, required this.loginInfo});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }

}

class _Home extends State<Home>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: FutureBuilder<Map<String,List<PostInfo>?>>(
        future: getHome(),
        builder: (context, AsyncSnapshot<Map<String,List<PostInfo>?>> snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15)
                ),
              ),
            );
          }else if(snapshot.hasData == false){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          }else{
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Color(0xff0D6EFA).withOpacity(0.9),
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16, top: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("버스 정보",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Row(
                                    children: [
                                      Text("더보기",style: TextStyle(fontSize: 14),),
                                      Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      dense: true,
                                      title: Text("720-3"),
                                      subtitle: Text("단국대학교 곰상 승차"),
                                      leading: Icon(Icons.directions_bus),
                                      trailing: Text("17분 후 도착"),
                                    );
                                  }
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16, top: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("실시간 인기글",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Row(
                                    children: [
                                      Text("더보기",style: TextStyle(fontSize: 14),),
                                      Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data!["popularBoard"]!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      dense: true,
                                      title: Text(snapshot.data!["popularBoard"]![index].title),
                                      subtitle: Text("익명"),
                                    );
                                  }
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16,top: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("자유 게시판",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Row(
                                    children: [
                                      Text("게시글 더보기",style: TextStyle(fontSize: 14),),
                                      Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data!["freeBoard"]!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      dense: true,
                                      title: Text(snapshot.data!["freeBoard"]![index].title),
                                      subtitle: Text("익명"),
                                    );
                                  }
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
        }
      ),
    );
  }

  Future<Map<String,List<PostInfo>?>> getHome() async{

    Map<String,List<PostInfo>?> postList = {
      "freeBoard": await getFreeBoard(),
      "popularBoard": await getPopularBoard()
    };

    return postList;
  }

  Future<List<PostInfo>?> getFreeBoard() async {
    http.Response postInfoResponse = await http.get(
      Uri.parse('$apiHost/api/suggestion?page=0&size=3&sort=createDate,desc'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": widget.loginInfo.accessToken
      },
    );

    print(postInfoResponse.statusCode);
    if(postInfoResponse.statusCode == 200){
      final List<PostInfo> response = json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]
          .map<PostInfo>((json) => PostInfo.fromJson(json)).toList();
      return response;
    }
    return null;
  }

  Future<List<PostInfo>?> getPopularBoard() async {
    http.Response postInfoResponse = await http.get(
      Uri.parse('$apiHost/api/suggestion?page=0&size=3&sort=hitCount,desc'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": widget.loginInfo.accessToken
      },
    );

    print(postInfoResponse.statusCode);
    if(postInfoResponse.statusCode == 200){
      //print(json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]);
      final List<PostInfo> response = json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]
          .map<PostInfo>((json) => PostInfo.fromJson(json)).toList();
      return response;
    }
    return null;
  }

}
