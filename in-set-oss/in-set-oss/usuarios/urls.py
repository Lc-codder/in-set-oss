from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from .views import LoginView, UsuarioListCreateView, UsuarioDetailView

urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('usuarios/', UsuarioListCreateView.as_view(), name='usuarios'),
    path('usuarios/<int:pk>/', UsuarioDetailView.as_view(), name='usuario_detail'),
]