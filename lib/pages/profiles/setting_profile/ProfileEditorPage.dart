part of '../../profiles.dart';
class EditorProfile extends StatelessWidget {
/*  @override
  _EditorProfileState createState() => _EditorProfileState();
}

class _EditorProfileState extends State<EditorProfile> with SingleTickerProviderStateMixin{*/



  final TextStyle _textStyle = TextStyle(color: Colors.black45);
  final TextEditingController _inputController = TextEditingController();
  final FirebaseManager _firebaseManager = FirebaseManager();

  //late AnimationController _animationController;
  AnimateIconController _animateIconController = AnimateIconController();

  /*@override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this,  duration: Duration(milliseconds: 450, ),);
    _animateIconController = AnimateIconController();
  }*/

  /*@override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }*/

  refresh(context,user) async {
     //User userUploaded = await _firebaseManager.getUserInCloud(userId: user.id);
     //context.read<AuthenticationBloc>().updateUser(userUploaded);
     //BlocProvider.of<AuthenticationBloc>(context).updateUser(userUploaded);
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Container(
                  height: 400,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(state.user.photoMail!)
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                                  title: Text(state.user.name ?? "unknown",
                                      style: _textStyle.copyWith(fontWeight: FontWeight.bold)
                                  ),
                                  subtitle: Text(state.user.email ?? "user.@mail.com"),
                                )),
                            Container(
                              child: AnimateIcons(
                                startIcon: FontAwesomeIcons.sync,
                                endIcon: FontAwesomeIcons.sync,
                                size: 28.0,
                                controller: _animateIconController,
                                startTooltip: 'Icons.add_circle',
                                endTooltip: 'Icons.add_circle_outline',
                                onStartIconPress: () {
                                  print("Clicked on Add Icon");
                                  refresh(context,state. user);
                                  return true;
                                },
                                onEndIconPress: () {
                                  print("Clicked on Close Icon");
                                  return true;
                                },
                                duration: Duration(milliseconds: 500),
                                startIconColor: Theme.of(context).primaryColorDark,
                                endIconColor: Theme.of(context).primaryColorDark,
                                clockwise: false,
                              ),
                              /*IconButton(
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.rep,
                                  progress: _animationController,
                                  semanticLabel: 'Show menu',
                                ),
                                //Icon(FontAwesomeIcons.sync, color: Theme.of(context).primaryColorDark,),
                                onPressed: () async {
                                  User userUploaded = await _firebaseManager.getUserInCloud(userId: state.user.id);
                                  context.read<AuthenticationBloc>().updateUser(userUploaded);
                                },
                              ),*/
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(state.user.name ?? "unknown"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () => changeValueDialog(context,
                                title: "name",
                                user: state.user,
                                value: state.user.name ?? '',
                                mapKey: 'name'
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.email_outlined),
                              title: Text(state.user.email ?? "unknown"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () => changeValueDialog(context,
                                title: "email",
                                user: state.user,
                                value: state.user.email ?? ''
                                //mapKey: 'email',
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text((state.user.phoneNumber != null)
                                  ? (state.user.phoneNumber!.length < 4)
                                    ? "invalid phone number"
                                    : state.user.phoneNumber.toString()
                                  : "unknown phone number" ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () => changeValueDialog(context,
                                title: "phone number",
                                user: state.user,
                                value: state.user.phoneNumber?.toString() ?? '',
                                mapKey: 'phone_number',
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.lock_outline_rounded),
                              title: Text("Password"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () => changeValueDialog(context,
                                title: "password",
                                isPassword: true,
                                value: '',
                                user: state.user,
                                //mapKey: '',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });


  }

  Future<void> changeValueDialog(context,{
    required String title,
    required User user,
    required String value,
    bool isPassword = false,
    String? mapKey,
  }){
    if(mapKey == null) return Future.error("mapKey might not be null");
    var pwdInputWidget = [
      TextField(
        focusNode: FocusNode()..requestFocus(),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: 'Enter old password '
        ),
      ),
      SizedBox(height: 16.0,),
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: 'Enter new password'
        ),
      ),
      SizedBox(height: 4.0,),
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            hintText: 'Enter new password'
        ),
      ),
    ];

    return showDialog<void>(
        context: context,
        builder: (ctx){
          _inputController.text =  value;
          return AlertDialog(
            title: Text("Change your " + title, style: Theme.of(context).textTheme.bodyText2,),
            content: Container(
              height: isPassword ? 200 :65,
              child: Column(
                children: [
                  if(!isPassword)
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: _inputController,
                      //showCursor: true,
                      focusNode: FocusNode()..requestFocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),


                          //labelText: value,

                          //hintText: 'Enter '+title
                      ),
                    ),
                  if(isPassword)
                    ...pwdInputWidget

                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: Navigator.of(context).pop,
              ),
              TextButton(
                  child: Text("Change"),
                  onPressed: () {
                    _firebaseManager.updateUserInformation(
                        userId: user.id!,
                        key: mapKey,
                        value: _inputController.text
                    );

                    Navigator.of(context).pop();
                  }
              ),
            ],
            //child: ,
          );
        }
    );

  }
}