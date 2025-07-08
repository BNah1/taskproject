import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/constant/routes.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/model/user_model.dart';

class InfoUserChatView extends StatefulWidget {
  const InfoUserChatView({super.key, required this.userId});

  final String userId;


  @override
  State<InfoUserChatView> createState() => _InfoUserChatViewState();
}

class _InfoUserChatViewState extends State<InfoUserChatView> {
  @override
  Widget build(BuildContext context) {
    final user = getUser(widget.userId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            _userInfo(user),
            _listIconBottom(user)
          ],
        ),
      ),
    );
  }

  Widget _listIconBottom(UserModel user){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _itemTile(Icons.facebook, 'Home Page'),
        _itemTile(Icons.notifications, 'Turn off notification'),
        InkWell(
            onTap: (){
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(AppRoutes.searchChat, arguments: user);
            },
            child: _itemTile(Icons.search, 'Search')),
      ],
    );
  }

  Widget _userInfo(UserModel user){
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: AssetImage(user.pathImage),
        ),
        const SizedBox(height: 5,),
        Text(user.userName,style: AppTextStyle.dashboardTitle,),
        Text('Active some times ago',style: AppTextStyle.textBodyTile(color: Colors.grey,fontWeight: FontWeight.normal, size: 20) ),
        const SizedBox(height: 10,),
      ],
    );
  }


  Widget _itemTile(IconData icon, String title){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSize.paddingMenu),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(icon, size: 35,)),
        Text(title)
      ],
    );
  }
}
