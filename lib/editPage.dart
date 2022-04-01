import 'dart:convert';
import 'package:demo/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo/HiveUtil.dart';
import 'package:demo/JsonUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);
  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  String _username = HiveUtil.instance?.getUsername() ?? '';
  String _bio = HiveUtil.instance?.getBio() ?? '';
  String _about = HiveUtil.instance?.getAbout() ?? '';
  final _nameCodeFocusNode =  FocusNode();
  final _bioCodeFocusNode =  FocusNode();
  final _aboutCodeFocusNode =  FocusNode();

  FToast? fToast;
  final _aboutGlobalKey = GlobalKey();

  @override
  initState() {
    super.initState();
    JsonUtil.instance?.infoChangeNotifier?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    fToast = FToast();
    fToast?.init(context);
  }

  showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  dispose(){
    super.dispose();
    JsonUtil.instance?.infoChangeNotifier?.removeListener(() {

    });
  }

  showNoteDialog(String note) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('提示'),
            content: Text(note),
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

  @override
  Widget build(BuildContext context) {

    //获取屏幕高度
    double kWidth = MediaQuery.of(context).size.width;
    //渐变Text设置shader
    Gradient gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(128, 56, 153, 1),
        Color.fromRGBO(107, 74, 186, 1)
      ],
    );
    Shader shader = gradient.createShader(const Rect.fromLTWH(50, 100, 150, 50));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(76, 26, 141, 1),
        ),
        title: Text('Profile Edit',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = shader)),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              // width: 30,
              // height: 24,
              padding: const EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 20, foreground: Paint()..shader = shader),
              ),
            ),
            //点击事件
            onTap: () async {
              if (_username.isEmpty) {
                //_toast();
                FocusScope.of(context).requestFocus(_nameCodeFocusNode);
                showToast("Name can't be empty");
                //var toast = Toast.toast(context,msg: "中间显示的 ",position: ToastPostion.center);
               // showNoteDialog("name can't be empty");
                return;
              }
              if (_bio.isEmpty) {
                FocusScope.of(context).requestFocus(_bioCodeFocusNode);
                showToast("Bio can't be empty");
                //showNoteDialog("bio can't be empty");
                return;
              }
              if(HiveUtil.instance!.getBirth().isEmpty) {
                showToast("Birthday can't be empty");
                //showNoteDialog("birthday can't be empty");
                return;
              }
              if(_about.isEmpty) {
                FocusScope.of(context).requestFocus(_aboutCodeFocusNode);
                showToast("About can't be empty");
                //showNoteDialog("about can't be empty");
                return;
              }
              EasyLoading.show(status: 'Saving...');
              Response? response = await Network.network?.updateUserMe(_username, _bio, _about);
              EasyLoading.dismiss();
              JsonUtil.instance!.infoChangeNotifier!
                  .updateUsername(_username);
              HiveUtil.instance!.updateBio(_bio);
              HiveUtil.instance!.updateAbout(_about);
              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
            children: [
              ProfileAvatar(),
              const SizedBox(
                height: 58,
              ),
              //Name栏
              sameWidget('Name', 'Enter your name', kWidth),
              //Bio栏
              sameWidget('Bio', 'Enter your bio', kWidth),
              //Gender栏
              SingleChoose(),
              //Birth Date栏
              Container(
                width: kWidth,
                padding: const EdgeInsets.only(left: 16, right: 16),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              HiveUtil.instance!.getBirth().isEmpty
                                  ? 'Enter your the date of birth'
                                  : HiveUtil.instance!.getBirth(),
                              style: TextStyle(
                                  color: HiveUtil.instance!.getBirth().isEmpty
                                      ? Colors.grey
                                      : Colors.black),
                              textAlign: TextAlign.left,
                              //InputDecoration(hintText: 'Enter your the date of birth'),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 280,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(onPressed:() {
                                          Navigator.of(context).pop();
                                        }, child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500
                                          ),
                                        )),
                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: const Text(
                                          'Done',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ))
                                      ],
                                    ),
                                    Container(
                                      height: 220,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode
                                            .date, // 展示模式, 默认为 dateAndTime
                                        initialDateTime:
                                        DateTime(2000, 3, 8), // 默认选中日期
                                        minimumDate: DateTime(1900, 1, 1), // 最小可选日期
                                        maximumDate: DateTime.now(), // 最大可选日期
                                        backgroundColor: Colors.white, // 背景色
                                        onDateTimeChanged: (dayTime) {
                                          String dateString =
                                          dayTime.toString().split(' ')[0];
                                          JsonUtil.instance?.infoChangeNotifier
                                              ?.updateBirth(dateString);
                                          debugPrint("onDateTimeChanged $dateString");
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ),
              //About me栏
              aboutMe()
            ],
          ),
        )
    );
  }

  sameWidget(String name, String hintText, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          TextField(
            focusNode: name == 'Name' ? _nameCodeFocusNode : _bioCodeFocusNode,
            controller: TextEditingController.fromValue(TextEditingValue(
                text: name == 'Name' ? _username : _bio,  //判断keyword是否为空
                // 保持光标在最后
                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: (name == 'Name' ? _username : _bio).length)))
          ),
            decoration: InputDecoration(
              hintText: hintText,
            ),
            onChanged: (text) {
              //var finalText = text;
              if (name == 'Name') {
                if(text.length > 20) {
                  text = text.substring(0, 20);
                  _username = text;
                  setState(() {

                  });
                } else {
                  _username = text;
                }
              } else if (name == 'Bio') {
                if(text.length > 50) {
                  text = text.substring(0, 50);
                  _bio = text;
                  setState(() {

                  });
                } else {
                  _bio = text;
                }
              }
            },
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

  aboutMe() {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(
              width: 16,
            ),
            Text(
              'About Me',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          key: _aboutGlobalKey,
          height: 150,
          margin: const EdgeInsets.only(left: 12, right: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(222, 222, 222, 1)),
          child: TextField(
            scrollPadding: EdgeInsets.only(bottom: 150),
            maxLines: 10,
            focusNode: _aboutCodeFocusNode,
            controller: TextEditingController.fromValue(TextEditingValue(
    text: _about,  //判断keyword是否为空
    // 保持光标在最后
    selection: TextSelection.fromPosition(TextPosition(
    affinity: TextAffinity.downstream,
    offset: _about.length)))
    ),
            decoration:
                const InputDecoration.collapsed(hintText: "Enter the text......"),
            onChanged: (text){
              _about = text;
            },
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}

class SingleChoose extends StatefulWidget {
  const SingleChoose({Key? key}) : super(key: key);

  @override
  SingleChooseState createState() => SingleChooseState();
}

class SingleChooseState extends State<SingleChoose> {
  @override
  initState() {
    super.initState();
    JsonUtil.instance?.infoChangeNotifier?.addListener(() {
      if(mounted) {
        setState(() {});
      }
    });
  }

  @override
  dispose(){
    super.dispose();
    JsonUtil.instance?.infoChangeNotifier?.removeListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(
              width: 16,
            ),
            Text(
              'Gender',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: genderButton(
                  HiveUtil.instance?.getGender() == 0
                      ? 'images/male_2.png'
                      : 'images/male_1.png',
                  'Male',
                  0),
            ),
            Expanded(
              child: genderButton(
                  HiveUtil.instance?.getGender() == 1
                      ? 'images/female_2.png'
                      : 'images/female_1.png',
                  'Female',
                  1),
            ),
            Expanded(
              child: genderButton(
                  HiveUtil.instance?.getGender() == 2
                      ? 'images/not_specified_2.png'
                      : 'images/not_specified_1.png',
                  'Not Specified',
                  2),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  genderButton(String imageName, String genderName, int genderType) {
    return GestureDetector(
      child: Column(
        children: [
          Image(
            image: AssetImage(imageName),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            genderName,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        ],
      ),
      onTap: () {
        JsonUtil.instance?.infoChangeNotifier?.updateGender(genderType);
      },
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  ProfileAvatarState createState() => ProfileAvatarState();
}

class ProfileAvatarState extends State<ProfileAvatar> {
  @override
  initState() {
    super.initState();
    JsonUtil.instance?.infoChangeNotifier?.addListener(() {
      if(mounted) {
        setState(() {});
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    JsonUtil.instance?.infoChangeNotifier?.removeListener(() {

    });
  }

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double kWidth = MediaQuery.of(context).size.width;
    return Container(
        width: kWidth,
        height: 210,
        child: Stack(
          children: [
            Positioned(
              width: kWidth,
              height: 160,
              child: const DecoratedBox(
                  decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/bg.jpeg',
                    ),
                    fit: BoxFit.fitWidth),
              )),
              top: 0,
              left: 0,
            ),
            Positioned(
              width: 100,
              height: 100,
              child: GestureDetector(
                  child: ClipOval(
                    child: HiveUtil.instance?.infoBox?.get('avatar') != null
                        ? Image.memory(
                      base64.decode(HiveUtil.instance!.infoBox!
                          .get('avatar')
                          .split(',')[1]),
                      fit: BoxFit.fill,
                      gaplessPlayback: true,
                    )
                        : Image.asset(
                      'images/image1.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  onTap: () {
                    _getPhoto();
                  }),
              top: 110,
              left: (kWidth - 100) / 2,
            ),
            Positioned(
              child: SizedBox(
                width: 24,
                height: 24,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(HiveUtil.instance?.getGender() == 0
                              ? 'images/male_2.png'
                              : (HiveUtil.instance?.getGender() == 1
                                  ? 'images/female_2.png'
                                  : 'images/not_specified_2.png')),
                          fit: BoxFit.fill)),
                ),
              ),
              top: 186,
              left: (kWidth - 100) / 2 + 76,
            )
          ],
        ));
  }

  Future _getPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      debugPrint('No image selected.');
      return;
    }
    List<int> bytes = await pickedFile.readAsBytes();
    String base64 = base64Encode(bytes);
    String base64Image = "data:image/png;base64," + base64;
    debugPrint("base64Image ==================== $base64Image");
    setState(() {
      HiveUtil.instance?.infoBox?.put('avatar', base64Image);
      JsonUtil.instance!.infoChangeNotifier!.updateAvatar(base64Image);
    });
  }
}
