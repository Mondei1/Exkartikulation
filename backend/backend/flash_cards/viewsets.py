from drf_spectacular.utils import extend_schema
from rest_framework.viewsets import ModelViewSet
from backend.flash_cards.models import User, FlashCard, StackOfFlashCards
from backend.flash_cards.serializers import UserSerializer, FlashCardSerializer, StackOfFlashCardsSerializer

@extend_schema(
    tags=["User"]
)
class UserViewSet(ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

@extend_schema(
    tags=["Stack"]
)
class StackOfFlashCardsViewSet(ModelViewSet):
    serializer_class = StackOfFlashCardsSerializer

    def get_queryset(self):
        return StackOfFlashCards.objects.filter(user=self.kwargs["user_pk"])
    
    def get_serializer(self, *args, **kwargs):
        if "data" in kwargs:
            data = kwargs["data"].copy()
            data["user_id"] = self.kwargs.get("user_pk")
            kwargs["data"] = data
        return super().get_serializer(*args, **kwargs)

@extend_schema(
    tags=["Flashcard"]
)
class FlashCardViewSet(ModelViewSet):
    serializer_class = FlashCardSerializer

    def get_queryset(self):
        return FlashCard.objects.filter(stack=self.kwargs["stack_pk"], stack__user=self.kwargs["user_pk"])
    
    def get_serializer(self, *args, **kwargs):
        if "data" in kwargs:
            data = kwargs["data"].copy()
            data["stack"] = self.kwargs.get("stack_pk")
            kwargs["data"] = data
        return super().get_serializer(*args, **kwargs)