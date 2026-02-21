from rest_framework.serializers import ModelSerializer
from backend.flash_cards.models import User, StackOfFlashCards, FlashCard


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class StackOfFlashCardsSerializer(ModelSerializer):
    class Meta:
        model = StackOfFlashCards
        fields = '__all__'
    
class FlashCardSerializer(ModelSerializer):
    class Meta:
        model = FlashCard
        fields = '__all__'