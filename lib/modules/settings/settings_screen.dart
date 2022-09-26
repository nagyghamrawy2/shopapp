import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_layout_cubit.dart';
import 'package:shopapp/shared/component/components.dart';
import 'package:shopapp/shared/component/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
         builder:(context) =>  Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             children: [
               DefaultFormField(
                   controller: nameController,
                   type: TextInputType.name,
                   validate: (String value) {
                     if (value.isEmpty) {
                       return "name must not be empty";
                     } else {
                       return null;
                     }
                   },
                   label: 'Name',
                   prefix: Icons.person
               ),
               SizedBox(height: 20,),
               DefaultFormField(
                   controller: emailController,
                   type: TextInputType.emailAddress,
                   validate: (String value) {
                     if (value.isEmpty) {
                       return "email must not be empty";
                     } else {
                       return null;
                     }
                   },
                   label: 'Email Address',
                   prefix: Icons.email
               ),
               SizedBox(height: 20,),
               DefaultFormField(
                   controller: phoneController,
                   type: TextInputType.phone,
                   validate: (String value) {
                     if (value.isEmpty) {
                       return "phone must not be empty";
                     } else {
                       return null;
                     }
                   },
                   label: 'Phone',
                   prefix: Icons.phone
               ),
               SizedBox(height: 20,),
               DefaultButton(
                   function: (){
                     signout(context);
                   },
                   text: "Logout"
               ),
             ],
           ),
         ) ,
          fallback: (context) => Center(child: CircularProgressIndicator(),) ,
        );
      },
    );
  }
}
