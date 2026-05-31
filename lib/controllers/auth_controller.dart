import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/views/auth/login_view.dart';
import 'package:techworld_assignment/views/home_navigation_view.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Rxn<User> user = Rxn<User>();
  RxBool isInitialCheckDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges()); 
    ever(user, (_) {
      isInitialCheckDone.value = true;
    });
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => const HomeNavigationView());
      Get.snackbar('Success', 'Logged in successfully', snackPosition: SnackPosition.TOP, backgroundColor: AppColors.price);
    } catch (e) {
      Get.snackbar('Login Failed', e.toString(), isDismissible: true, backgroundColor: AppColors.like); 
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
    Get.offAll(() =>  LoginView());
    Get.snackbar('Success', 'Account created successfully! Please login.', snackPosition: SnackPosition.TOP, backgroundColor: AppColors.price.withValues(alpha: 0.9),);
    return true; 
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP, backgroundColor: AppColors.like.withValues(alpha: 0.9),);
    return false;
  }
}

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      
      Get.offAll(() => LoginView());
      
      Get.snackbar('Success', 'Logged out successfully!', snackPosition: SnackPosition.TOP,backgroundColor: AppColors.price);
    } catch (e) {
      Get.snackbar('Error', 'Failed to log out safely.', snackPosition: SnackPosition.TOP, backgroundColor: AppColors.like);
    }
  }
}