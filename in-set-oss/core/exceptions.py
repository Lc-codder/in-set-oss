from rest_framework.views import exception_handler


def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)

    if response is not None:
        response.data = {
            'erro': True,
            'mensagem': _extrair_mensagem(response.data),
            'status': response.status_code,
        }

    return response


def _extrair_mensagem(data):
    if isinstance(data, dict):
        for key, value in data.items():
            if key == 'detail':
                return str(value)
            if isinstance(value, list) and value:
                return f"{key}: {value[0]}"
        return str(data)
    if isinstance(data, list) and data:
        return str(data[0])
    return str(data)