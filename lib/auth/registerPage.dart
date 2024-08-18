// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/auth/loginPage.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/global/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/auth/loginPage.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/global/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var icon = Icons.visibility;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("lib/assets/Register.jpg"),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('lib/assets/InsaventLogo.png'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Insta",
                          style: TextStyle(
                            fontSize: 42,
                            color: ColorManager.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "vent",
                          style: TextStyle(
                            fontSize: 42,
                            color: ColorManager.primaryColor8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 35,
                        color: ColorManager.primaryColor8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Create a new account below.",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorManager.primaryColor8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      controller: fullNameController,
                      label: "Full Name",
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter your name";
                        return null;
                      },
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
                    buildTextField(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Please confirm your password";
                        if (value != passwordController.text)
                          return "Passwords do not match";
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorManager.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                );
                          }
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(
                                color: ColorManager.primaryColor8,
                                fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                                color: ColorManager.primaryColor6,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: const Text(
                                " Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      style: const TextStyle(color: ColorManager.primaryColor8),
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
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: isPassword
            ? IconButton(
                color: ColorManager.primaryColor8,
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


































// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   var fullNameController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var confirmPasswordController = TextEditingController();
//   var icon = Icons.visibility;
//   GlobalKey<FormState> formKey = GlobalKey();
//   bool isSecure = true;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is RegisterSuccessState) {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => LoginScreen()));
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage("lib/assets/Register.jpg"),
//                 ),
//               ),
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 190,
//                           height: 190,
//                           // clipBehavior: Clip.hardEdge,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage('lib/assets/InsaventLogo.png'),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         const Text(
//                           "Insta",
//                           style: TextStyle(
//                             fontSize: 42,
//                             color: ColorManager.primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Text(
//                           "vent",
//                           style: TextStyle(
//                             fontSize: 42,
//                             color: ColorManager.primaryColor8,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Text(
//                       "Get Started",
//                       style: TextStyle(
//                         fontSize: 35,
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Create a new account below.",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: ColorManager.primaryColor8,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     buildTextField(
//                       controller: fullNameController,
//                       label: "Full Name",
//                       validator: (value) {
//                         if (value!.isEmpty) return "Please enter your name";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     buildTextField(
//                       controller: emailController,
//                       label: "Email",
//                       validator: (value) {
//                         if (value!.isEmpty) return "Please enter your email";
//                         if (!value.contains("@")) return "Invalid email";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     buildTextField(
//                       controller: passwordController,
//                       label: "Password",
//                       isPassword: true,
//                       validator: (value) {
//                         if (value!.isEmpty) return "Please enter your password";
//                         if (value.length < 8)
//                           return "Password must be at least 8 characters";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     buildTextField(
//                       controller: confirmPasswordController,
//                       label: "Confirm Password",
//                       isPassword: true,
//                       validator: (value) {
//                         if (value!.isEmpty)
//                           return "Please confirm your password";
//                         if (value != passwordController.text)
//                           return "Passwords do not match";
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 25),
//                     Center(
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               ColorManager.primaryColor),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             AuthCubit().get(context).register(
//                                   name: fullNameController.text,
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   confirmPassword:
//                                       confirmPasswordController.text,
//                                 );
//                           }
//                         },
//                         child: const Text(
//                           "Create Account",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Already have an account?',
//                             style: TextStyle(
//                                 color: ColorManager.primaryColor8,
//                                 fontSize: 15)),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             width: 80,
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 color: ColorManager.primaryColor6,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20))),
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) => LoginScreen()),
//                                 );
//                               },
//                               child: const Text(
//                                 " Log in",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
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
//       style: const TextStyle(color: ColorManager.primaryColor8),
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
//           borderRadius: BorderRadius.circular(15),
//         ),
//         suffixIcon: isPassword
//             ? IconButton(
//                 color: ColorManager.primaryColor8,
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









































// import 'package:flutterproject2/cubit/auth_cubit.dart';
// import 'package:flutterproject2/screens/homeScreen.dart';
// import 'package:flutterproject2/screens/loginScreen.dart';

// class rejesterScreen extends StatefulWidget {
//   const rejesterScreen({super.key});

//   @override
//   State<rejesterScreen> createState() => _rejesterScreenState();
// }

// class _rejesterScreenState extends State<rejesterScreen> {
//   // Color primaryColor = const Color(0xff3c096c);
//   // Color secondlyColor = const Color(0xff7B2CBF);
//   // Color thirdlyColor = const Color(0xff9D4EDD);
//   // Color fourColor = const Color(0xffC77DFF);
//   // Color fiveColor = const Color(0xffE0AAFF);
//   // Color sixColor = const Color(0xff5A189A);
//   // Color sevenColor = const Color(0xff240046);
//   // Color eight = const Color(0xff10002B);
//   var full_nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var confirm_passwoerdController = TextEditingController();
//   var icon = Icons.visibility;
//   GlobalKey<FormState> nnn = GlobalKey();
//   bool isScure = true;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is RejesterSuccesState) {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => loginScreen()));
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Container(
//               height: 1000,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.fill,
//                       image: AssetImage("lib/assets/22.jpg"))),
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: nnn,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 70,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(70),
//                                 color: Colors.white),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           const Text(
//                             "Event mangment",
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         "Get Started",
//                         style: TextStyle(
//                             fontSize: 35,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       const Text(
//                         "creat new account below.",
//                         style: TextStyle(
//                           fontSize: 25,
//                           color: Color.fromARGB(255, 179, 179, 179),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: full_nameController,
//                         validator: (value) {
//                           if (value!.isEmpty) return "error";
//                         },
//                         decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(16),
//                             labelText: "name",
//                             labelStyle: const TextStyle(color: Colors.white),
//                             border: const OutlineInputBorder(),
//                             focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 208, 53, 236)),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(10))),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: emailController,
//                         validator: (value) {
//                           if (value!.isEmpty) return "error";
//                           // if (value.contains("@")) return "error";
//                         },
//                         decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(16),
//                             labelText: "email",
//                             labelStyle: const TextStyle(color: Colors.white),
//                             border: const OutlineInputBorder(),
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 208, 53, 236))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(10))),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: passwordController,
//                         validator: (value) {
//                           if (value!.isEmpty) return "error";
//                           if (value!.length > 8) return "error";
//                         },
//                         obscureText: isScure,
//                         decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(16),
//                             labelText: "password",
//                             suffixIcon: IconButton(
//                               color: Colors.white,
//                               icon: Icon(icon),
//                               onPressed: () {
//                                 setState(() {
//                                   isScure = !isScure;
//                                   isScure
//                                       ? icon = Icons.visibility_off
//                                       : icon = Icons.visibility;
//                                 });
//                               },
//                             ),
//                             labelStyle: const TextStyle(color: Colors.white),
//                             border: const OutlineInputBorder(),
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 182, 85, 200))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(10))),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: confirm_passwoerdController,
//                         validator: (value) {
//                           if (value!.isEmpty) return "error";
//                           if (value!.length > 8) return "error";
//                         },
//                         obscureText: isScure,
//                         decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(16),
//                             labelText: "confirm password",
//                             suffixIcon: IconButton(
//                               color: Colors.white,
//                               icon: Icon(icon),
//                               onPressed: () {
//                                 setState(() {
//                                   isScure = !isScure;
//                                   isScure
//                                       ? icon = Icons.visibility_off
//                                       : icon = Icons.visibility;
//                                 });
//                               },
//                             ),
//                             labelStyle: const TextStyle(color: Colors.white),
//                             border: const OutlineInputBorder(),
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 208, 53, 236))),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(10))),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         children: [
//                           const SizedBox(
//                             width: 190,
//                           ),
//                           ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     (MaterialStateProperty.all<Color>(
//                                         ColorManager.primaryColor3)),
//                                 shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(25)))),
//                             onPressed: () {
//                               if (nnn.currentState!.validate()) {
//                                 AuthCubit().get(context).rejester(
//                                     name: full_nameController.text,
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                     confirm_password:
//                                         confirm_passwoerdController.text);
//                               }
//                             },
//                             child: Container(
//                                 width: 120,
//                                 height: 30,
//                                 child: const Text("creat account",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15),
//                                     textAlign: TextAlign.center)),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           const SizedBox(
//                             width: 40,
//                           ),
//                           Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   color: ColorManager.primaryColor3),
//                               child: MaterialButton(
//                                 onPressed: () {},
//                                 child: const Row(
//                                   children: [
//                                     Text("<- Log in",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15),
//                                         textAlign: TextAlign.center),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text("Already have an account?",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 15),
//                                         textAlign: TextAlign.center)
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       )
//                     ]),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
