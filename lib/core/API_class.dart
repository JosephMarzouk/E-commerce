import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://asbxvyaxvraxpevngyjy.supabase.co/rest/v1/', 

      headers: {
        'apikey':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFzYnh2eWF4dnJheHBldm5neWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4NjMzMDQsImV4cCI6MjA1OTQzOTMwNH0.Z4LXgVoUqucTJ_Ggu-VYeNcB7HVveGIYoA1cPMRI1jE",
      },
    ),

   
  );

     Future<Response> getData(String path) async {
        return await _dio.get(path);

      }


  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(
      path,
      data: data,
    );
  }
  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(
      path,
      data: data,
    );
  }

  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
