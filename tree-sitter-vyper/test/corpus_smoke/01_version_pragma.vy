# @version ^0.3.7
# A minimal contract with a version pragma

greeting: public(String[64])

@external
def set_greeting(new_greeting: String[64]):
    self.greeting = new_greeting
