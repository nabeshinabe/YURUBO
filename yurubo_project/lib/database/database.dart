import 'package:supabase/supabase.dart';

// Database API 接続用
final supabase = SupabaseClient(
  'SUPABASE_URL', // SupabaseのURLを指定
  'SUPABASE_KEY', // SupabaseのAPIキーを指定
);