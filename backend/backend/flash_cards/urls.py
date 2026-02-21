from django.urls import path
from rest_framework.routers import SimpleRouter
from rest_framework_nested.routers import NestedSimpleRouter
from backend.flash_cards.viewsets import UserViewSet, StackOfFlashCardsViewSet, FlashCardViewSet


router = SimpleRouter()
router.register(r'users', UserViewSet, basename="users")

user_router = NestedSimpleRouter(router, r"users", lookup="user")
user_router.register(r'stacks', StackOfFlashCardsViewSet, basename="stack_of_flash_cards")

stack_router = NestedSimpleRouter(user_router, r"stacks", lookup="stack")
stack_router.register(r'flash-cards', FlashCardViewSet, basename="flash_cards")

# Combine the urls
urlpatterns = router.urls + user_router.urls + stack_router.urls