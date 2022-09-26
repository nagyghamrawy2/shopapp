import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/shared/Network/local/cache_helper.dart';
import 'package:shopapp/shared/component/components.dart';
import 'package:shopapp/shared/component/constants.dart';



class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
  listener: (context, state) {
    if(state is ShopRegisterSuccessState){
      if(state.loginModel.status){
        print(state.loginModel.message);
        print(state.loginModel.data?.token);
        CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
          token = state.loginModel.data!.token;
          navigateAndFinish(context, ShopLayout());
        });
        showToast(text: state.loginModel.message!, state: ToastStates.SUCCESS);
      }else{
        print(state.loginModel.message);
        showToast(text: state.loginModel.message!, state: ToastStates.ERROR);
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.drive_file_rename_outline,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email address must not be empty';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: ShopRegisterCubit.get(context).isPassword,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(ShopRegisterCubit.get(context).isPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          ShopRegisterCubit.get(context).changeRegisterPasswordVisibality();
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ConditionalBuilder(
                    condition: state is! ShopRegisterLoadingState,
                    builder: (context) => TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopRegisterCubit.get(context).userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
