class ApiResponse<TData> {
  TData? data;
  Object? apiError;

  ApiResponse.success({required this.data});

  ApiResponse.error({required this.apiError});
}
