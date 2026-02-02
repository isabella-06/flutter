import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hnjdbgbjzhjvtiweswsa.supabase.co',
    anonKey: 'sb_publishable_vAcP3-45BL0tbL0q1TaeXw_yzWE8_vS',
  );
  runApp(App());
}