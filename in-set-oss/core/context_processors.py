def token_processor(request):
    return {
        'token': request.session.get('access_token', '')
    }