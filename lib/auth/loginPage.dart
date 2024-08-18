import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/auth/registerPage.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/homePagev.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/auth/registerPage.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/homePagev.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var icon = Icons.visibility;
  var formKey = GlobalKey<FormState>();
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePageSaraWidget()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("lib/assets/Login.jpg"),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 40,
                      color: ColorManager.primaryColor8,
                    ),
                  ),
                  const Text(
                    "Login to access your account below",
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorManager.primaryColor8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: emailController,
                    label: "Email",
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter your email";
                      if (!value.contains("@")) return "Invalid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: passwordController,
                    label: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter your password";
                      if (value.length < 8)
                        return "Password must be at least 8 characters";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: ColorManager.primaryColor8,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            ColorManager.primaryColor,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff9D4EDD),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: ColorManager.primaryColor8,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Create account ->",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      obscureText: isPassword && isSecure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        labelText: label,
        labelStyle: const TextStyle(color: ColorManager.primaryColor8),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 208, 53, 236)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.primaryColor8),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword
            ? IconButton(
                color: Colors.white,
                icon: Icon(icon),
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                    icon = isSecure ? Icons.visibility_off : Icons.visibility;
                  });
                },
              )
            : null,
      ),
    );
  }
}

















// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var icon = Icons.visibility;
//   var formKey = GlobalKey<FormState>();
//   bool isSecure = true;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is LoginSuccessState) {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => HomePageSaraWidget()),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage("lib/assets/Login.jpg"),
//               ),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 80),
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(
//                       fontSize: 40,
//                       color: ColorManager.primaryColor8,
//                     ),
//                   ),
//                   const Text(
//                     "Login to access your account below",
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: ColorManager.primaryColor8,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   buildTextField(
//                     controller: emailController,
//                     label: "Email",
//                     validator: (value) {
//                       if (value!.isEmpty) return "Please enter your email";
//                       if (!value.contains("@")) return "Invalid email";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   buildTextField(
//                     controller: passwordController,
//                     label: "Password",
//                     isPassword: true,
//                     validator: (value) {
//                       if (value!.isEmpty) return "Please enter your password";
//                       if (value.length < 8)
//                         return "Password must be at least 8 characters";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Forgot password?",
//                         style: TextStyle(
//                           color: ColorManager.primaryColor8,
//                           fontSize: 20,
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                             ColorManager.primaryColor,
//                           ),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             AuthCubit().get(context).login(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                 );
//                           }
//                         },
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 35),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: const Color(0xff9D4EDD),
//                         ),
//                         child: MaterialButton(
//                           onPressed: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => RegisterScreen()),
//                             );
//                           },
//                           child: const Row(
//                             children: [
//                               Text(
//                                 "Don't have an account?",
//                                 style: TextStyle(
//                                   color: ColorManager.primaryColor8,
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               SizedBox(width: 20),
//                               Text(
//                                 "Create account ->",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget buildTextField({
//     required TextEditingController controller,
//     required String label,
//     bool isPassword = false,
//     required String? Function(String?) validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       style: const TextStyle(color: Colors.white),
//       validator: validator,
//       obscureText: isPassword && isSecure,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(16),
//         labelText: label,
//         labelStyle: const TextStyle(color: ColorManager.primaryColor8),
//         border: const OutlineInputBorder(),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Color.fromARGB(255, 208, 53, 236)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: ColorManager.primaryColor8),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         suffixIcon: isPassword
//             ? IconButton(
//                 color: Colors.white,
//                 icon: Icon(icon),
//                 onPressed: () {
//                   setState(() {
//                     isSecure = !isSecure;
//                     icon = isSecure ? Icons.visibility_off : Icons.visibility;
//                   });
//                 },
//               )
//             : null,
//       ),
//     );
//   }
// }













































// class loginScreen extends StatefulWidget {
//   const loginScreen({super.key});

//   @override
//   State<loginScreen> createState() => _loginScreenState();
// }

// class _loginScreenState extends State<loginScreen> {
//   Color primaryColor = const Color(0xff3c096c);
//   Color secondlyColor = const Color(0xff7B2CBF);
//   Color thirdlyColor = const Color(0xff9D4EDD);
//   Color fourColor = const Color(0xffC77DFF);
//   Color fiveColor = const Color(0xffE0AAFF);
//   Color sixColor = const Color(0xff5A189A);
//   Color sevenColor = const Color(0xff240046);
//   Color eight = const Color(0xff10002B);
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var icon = Icons.visibility;
//   //GlobalKey<FormState> nnn = GlobalKey();
//   var nnn = GlobalKey<FormState>();
//   // var formKey = GlobalKey<FormState>();
//   bool isScure = true;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is LoginSuccesState) {
//           Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => HomePageSaraWidget()));
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Container(
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.fill, image: AssetImage("lib/assets/22.jpg"))),
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 70,
//                     ),
//                     const Text(
//                       "Welcom back",
//                       style: TextStyle(fontSize: 40, color: Colors.white),
//                     ),
//                     const Text("Login to acces your account below",
//                         style: TextStyle(fontSize: 20, color: Colors.white)),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: emailController,
//                       style: TextStyle(color: Colors.white),
//                       validator: (value) {
//                         if (value!.isEmpty) return "error";
//                         // if (value.contains("@")) return "error";
//                       },
//                       decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(16),
//                           labelText: "email",
//                           labelStyle: const TextStyle(color: Colors.white),
//                           border: const OutlineInputBorder(),
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 208, 53, 236))),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10))),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       style: TextStyle(color: Colors.white),
//                       validator: (value) {
//                         if (value!.isEmpty) return "error";
//                         if (value!.length > 8) return "error";
//                       },
//                       obscureText: isScure,
//                       decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(16),
//                           labelText: "password",
//                           suffixIcon: IconButton(
//                             color: Colors.white,
//                             icon: Icon(icon),
//                             onPressed: () {
//                               setState(() {
//                                 isScure = !isScure;
//                                 isScure
//                                     ? icon = Icons.visibility_off
//                                     : icon = Icons.visibility;
//                               });
//                             },
//                           ),
//                           labelStyle: const TextStyle(color: Colors.white),
//                           border: const OutlineInputBorder(),
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 182, 85, 200))),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10))),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           "forget password",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         const SizedBox(
//                           width: 80,
//                         ),
//                         ElevatedButton(
//                           style: ButtonStyle(
//                               backgroundColor:
//                                   (MaterialStateProperty.all<Color>(
//                                       thirdlyColor)),
//                               shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(25)))),
//                           onPressed: () {
//                             // if (nnn.currentState!.validate())
//                             {
//                               AuthCubit().get(context).login(
//                                   email: emailController.text,
//                                   password: passwordController.text);
//                             }
//                             ;
//                           },
//                           child: Container(
//                               width: 80,
//                               height: 30,
//                               child: const Text(" Login",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 20),
//                                   textAlign: TextAlign.center)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 40,
//                         ),
//                         Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: thirdlyColor),
//                             child: MaterialButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => RegisterScreen()));
//                               },
//                               child: const Row(
//                                 children: [
//                                   Text("Dont have account ?",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 16),
//                                       textAlign: TextAlign.center),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   Text("creat account->",
//                                       style: TextStyle(
//                                           color: Colors.black, fontSize: 16),
//                                       textAlign: TextAlign.center)
//                                 ],
//                               ),
//                             )),
//                       ],
//                     )
//                   ]),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
