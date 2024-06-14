abstract class ClientIHttp {
  
  //Criar
  Future<dynamic> post({
    required String path,
    required Map body,
  });

  //Atualizar Completamente
  Future<dynamic> put({
    required String path,
    required Map body,
    required Map<String, dynamic>? queryHeaders,
  });

  //Atualizar Parcialmente
  Future<dynamic> patch({
    required String path,
    required Map body,
    required Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> delete({
    required String path,
  });
}
