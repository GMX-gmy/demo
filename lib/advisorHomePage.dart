import 'package:demo/InfoModel.dart';
import 'package:demo/advisor_model.dart';
import 'package:demo/counselingPage.dart';
import 'package:demo/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Stateful组件
class AdvisorHomePage extends StatefulWidget {
  //默认状态下为未收藏状态
  const AdvisorHomePage({Key? key, this.favorite = false, this.model}) : super(key: key);
  final bool favorite;
  final AdvisorModel? model;
  //bool favorite = false;
  //AdvisorHomePage(this.favorite);
  @override
  _AdvisorHomePageState createState() => _AdvisorHomePageState();
}

//Stateful组件的State类
class _AdvisorHomePageState extends State<AdvisorHomePage> {

  bool _favorite = false;

  @override
  initState() {
    super.initState();

    _favorite = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kwidth = size.width;
    final kheight = size.height;

    return Column(
        children: [
          Expanded (
          child: Container(
            width: kwidth,
            height: kheight,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                children: [
                  Container(
                      width: kwidth,
                      height: 400,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('images/bg3.png'),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth)),
                      child: Stack(
                        children: [
                          Positioned(
                            child: GestureDetector(
                              child: Image.asset(
                                "images/back.png",
                                width: 32,
                                height: 32,
                              ),
                              //通过pop将_favorite（收藏状态）传递到main.dart
                              onTap: () {
                                Navigator.of(context).pop(_favorite);
                              },
                            ),
                            top: 52,
                            left: 16,
                          ),
                          Positioned(
                            child: info(kwidth),
                            top: 160,
                            left: 16,
                          ),
                          Positioned(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.model?.advisorAvatar ?? 'images/defaultAvatar.png'),
                                      fit: BoxFit.cover)),
                            ),
                            top: 120,
                            left: 32,
                          ),
                          Positioned(
                            child: GestureDetector(
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  //判断_favorite状态，bool类型，ture为收藏状态，false为未收藏
                                  _favorite
                                      ? "images/shoucanged.png"
                                      : "images/shoucang.png",
                                ),
                              ),
                              //收藏状态下，点击变为未收藏状态；未收藏状态下，点击为收藏状态
                              onTap: () {
                                //若为收藏状态，则是取消收藏状态，此时弹出取消收藏成功提示框。
                                if (_favorite == true){
                                  _favorite = !_favorite;
                                  setState(() {});
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('提示'),
                                          content: const Text('取消收藏成功'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('确认'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                });
                                              },
                                            )
                                          ],
                                        );
                                      });
                                } else {
                                  _favorite = !_favorite;
                                  setState(() {});
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('提示'),
                                          content: const Text('收藏成功'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('确认'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                });
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }

                                //setState（）更新UI展示，
                              },
                            ),
                            top: 176,
                            right: 32,
                          ),
                        ],
                      )),
                  Container(
                    width: kwidth,
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: about(),
                  )
                ],
              ))
            )
          )
      )]
    );
  }

  Widget info(double screenWidth) {
    return Container(
      width: screenWidth - 32,
      height: 240,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8)],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            margin: const EdgeInsets.only(top: 64),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.model?.advisorName ?? '',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 28,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: const Text(
              'Fast-paced and full of jsijc jdj',
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          //第三行
          Container(
            //height: 64,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromRGBO(248, 242, 238, 1)),
            //第三行的内容
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(widget.model?.services?[0].serviceName ?? 'Default Text Reading',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 4, bottom: 8),
                      child: Text(
                        widget.model?.services?[0].serviceDesc ?? 'Default Delivered within 24h',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                //Row的右边按钮部分
                GestureDetector(
                  //按钮框
                  child: Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    padding: const EdgeInsets.only(
                        left: 32, top: 4, right: 32, bottom: 4),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(67, 115, 139, 1),
                        borderRadius: BorderRadius.circular(20)),
                    //金币、数值
                    child: Row(
                      children: [
                        Image.asset('images/coin.png'),
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '${widget.model?.services?[0].servicePrice}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CounselingPage(model: widget.model);
                    }));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget about() {
    return Column(
      children: [
        Container(
          //padding: const EdgeInsets.only(),
          alignment: Alignment.centerLeft,
          child: const Text(
            'About Me',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: const Text(
            'Anti Tracks is a complete solution to protect your privacy and enhance your PC performance. With a simple click Anti Tracks securely erase your internet tracks, computer activities and programs history information stored in many hidden files on your computer.Anti Tracks support Internet Explorer, AOL, Netscape/Mozilla and Opera browsers. It also include more than 85 free plug-ins to extend erasing features to support popular programs such as ACDSee, Acrobat Reader, KaZaA, PowerDVD, WinZip, iMesh, Winamp and much more. Also you can easily schedule erasing tasks at specific time intervals or at Windows stat-up/ shutdown.To ensure maximum privacy protection Anti Tracks implements the US Department of Defense DOD 5220.22-M, Gutmann and NSA secure erasing methods, making any erased files unrecoverable even when using advanced recovery tools.making any erased files unrecoverable even when using advanced recovery tools.Anti Tracks is a complete solution to protect your privacy and enhance your PC performance. With a simple click Anti Tracks securely erase your internet tracks, computer activities and programs history information stored in many hidden files on your computer.Anti Tracks support Internet Explorer, AOL, Netscape/Mozilla and Opera browsers. It also include more than 85 free plug-ins to extend erasing features to support popular programs such as ACDSee, Acrobat Reader, KaZaA, PowerDVD, WinZip, iMesh, Winamp and much more. Also you can easily schedule erasing tasks at specific time intervals or at Windows stat-up/ shutdown.To ensure maximum privacy protection Anti Tracks implements the US Department of Defense DOD 5220.22-M, Gutmann and NSA secure erasing methods, making any erased files unrecoverable even when using advanced recovery tools.making any erased files unrecoverable even when using advanced recovery tools.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
