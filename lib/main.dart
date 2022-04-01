import 'dart:convert';
import 'package:demo/InfoModel.dart';
import 'package:demo/TestUtil.dart';
import 'package:demo/advisorHomePage.dart';
import 'package:demo/advisor_model.dart';
import 'package:demo/network.dart';
import 'package:demo/settingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo/HiveUtil.dart';
import 'package:demo/JsonUtil.dart';
import 'package:demo/TabBarPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtil.install();
  await HiveUtil.getInstance();
  await JsonUtil.initInstance();
  TestUtil.getInstance();
  await Network.getNetwork();
  runApp(const TabBarPage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AdvisorModel> dataList = [];
  List<int> favoriteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList = HiveUtil.instance?.getAdvisors() ?? [];
    JsonUtil.instance!.infoChangeNotifier!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //加载数据
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Container(
      width: kWidth,
      height: kHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/bg.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth)),
      child: Scaffold(
          //背景色设置透明
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            //AppBar的背景设置透明
            backgroundColor: Colors.transparent,
            //不设置此值时，AppBar的位置会有像阴影一样的东西（不完全透明）
            elevation: 0,
            title: const Text(
              'Advisors',
              style: TextStyle(
                  fontFamily: "TimesNewRoman",
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  color: Colors.black),
            ),
            //AppBar的Title不居中，位于AppBar的左下角
            centerTitle: false
          ),
          body: FutureBuilder(
            future: Network.network?.getAdvisorList(),
            builder: (context, snapshot) {
                if (snapshot.hasData == true) {
                  //final response = json.decode(snapshot.data.toString());
                  //print('advisor response ================= $response');
                  dataList = snapshot.data as List<AdvisorModel>;
                  HiveUtil.instance?.saveAdvisor(dataList);
                }
                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16, top: 8, right: 0, bottom: 0),
                      child: Row(
                        children: const [
                          Image(image: AssetImage('images/smallSquare.png')),
                          Text(
                            'Trending',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepOrange,
                            ),
                          )
                        ],
                      ),
                    ),
                    buildGrid(kWidth, favoriteList),
                  ],
                );
            },
          ),
      ),
    );
  }

  List<Container> _buildGridTileList(List<int> favorites) {
    List<Container> list = [];
    for (var i = 0; i < dataList.length; i++) {
      AdvisorModel model = dataList[i];
      list.add(
        Container(
          width: 200,
          height: 350,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 1.0),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                  bottomLeft: Radius.circular(0))),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 140,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: 200,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(28)),
                          image: DecorationImage(
                            image: NetworkImage(model.advisorAvatar ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      top: 0,
                      left: 0,
                    ),
                    //收藏按钮、显示状态
                    Positioned(
                      child: GestureDetector(
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                              //根据index判断该卡片是不是_favoriteList中，是显示已收藏状态图片，否则显示未收藏状态图片
                              favoriteList.contains(i)
                                  ? "images/shoucanged.png"
                                  : "images/shoucang.png"),
                        ),
                        //点击事件，根据index判断，已经在_favoriteList中了，再次点击时将其挪出，否则，添加进_favoriteList
                        onTap: () {
                          if (favoriteList.contains(i)) {
                            favoriteList.remove(i);
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
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            favoriteList.add(i);
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
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                      right: 8,
                      bottom: 8,
                    )
                  ],
                ),
              ),
              Container(
                width: 200,
                height: 32,
                margin: const EdgeInsets.only(
                    left: 16, top: 8, right: 0.0, bottom: 0.0),
                child: Text(
                  model.advisorName ?? '',
                  style: TextStyle(
                      fontSize: 28,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                                colors: [Colors.yellow, Colors.red])
                            .createShader(const Rect.fromLTWH(0, 0, 150, 0))),
                ),
              ),
              Container(
                width: 200,
                height: 20,
                margin: const EdgeInsets.only(
                    left: 16, top: 4, right: 8, bottom: 0),
                child: Text(
                  model.advisorDesc ?? '',
                  //文字超出无法显示部分以"..."显示
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Container(
                width: 120,
                height: 48,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    left: 0, top: 12, right: 0, bottom: 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    gradient: LinearGradient(
                        colors: [Colors.amber, Colors.orangeAccent])),
                child: TextButton(
                  child: const Text(
                    "Consult Now",
                    style: TextStyle(color: Colors.white),
                  ),
                  //传递index，接收AdvisorHomePage中的收藏状态来判断是否将此顾问加入_favoriteList
                  onPressed: ()
                      //async标明函数是一个异步函数，返回值为Future类型
                      async {
                    //判断收藏数组中是否包含此index
                    bool hasFavorite = favoriteList.contains(i);
                    //await用来等待耗时操作的返回结果，这个操作会阻塞到后面的代码。favorite接收返回结果
                    final favorite = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AdvisorHomePage(favorite: hasFavorite, model: model);
                      }),
                    );
                    //判断favorite及hasFavorite，将卡片添加进_favoriteList
                    //favorite为true：顾问详情页为收藏状态，
                    if (favorite == true) {
                      if (!hasFavorite) {
                        favoriteList.add(i);
                      }
                    } else {
                      if (hasFavorite) {
                        favoriteList.remove(i);
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }

  Widget buildGrid(double screenWidth, List<int> favorites) {
    final cardWidth = (screenWidth - 48.0) / 2.0;
    return GridView.extent(
      maxCrossAxisExtent: cardWidth,
      childAspectRatio: cardWidth / 280.0,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      //ListView嵌套GridView二者都不显示了，解决问题如下：
      shrinkWrap: true,
      //显示了但是二者都无法滚动，解决问题如下：
      physics: const NeverScrollableScrollPhysics(),
      children: _buildGridTileList(favorites),
    );
  }
}
