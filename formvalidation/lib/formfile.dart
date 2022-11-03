import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> with SingleTickerProviderStateMixin {
  TextEditingController _foremail = TextEditingController();
  TextEditingController _forpass = TextEditingController();
  GlobalKey<FormState> _keys = GlobalKey();
  bool _obsecuretext = false;

  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__480.jpg",
              height: double.infinity,
              //width: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(animation.value, 0),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Form(
                key: _keys,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _foremail,
                      decoration: InputDecoration(
                        hintText: "Enter Mail",
                        labelText: "Write mail",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Pass";
                        }
                        if (value.length > 8) {
                          return "Long Pass";
                        }
                        if (value.length < 3) {
                          return "Small Pass";
                        }
                      },
                      controller: _forpass,
                      obscureText: _obsecuretext,
                      decoration: InputDecoration(
                        hintText: "Enter Mail",
                        labelText: "Write mail",
                        suffixIcon: InkWell(
                          onTap: (() {
                            setState(() {
                              _obsecuretext = !_obsecuretext;
                            });
                          }),
                          child: Icon(_obsecuretext
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          if (_keys.currentState!.validate()) {
                            print("ok");
                          } else {
                            print("object");
                          }
                        });
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        color: Colors.blue,
                        child: Text("Submit"),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
