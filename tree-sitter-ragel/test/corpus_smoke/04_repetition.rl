machine repetition;

star = digit*;
longest = digit**;
maybe = sign?;
some = alpha+;
exactly = digit{4};
at_most = digit{,6};
at_least = digit{2,};
between = digit{2,4};
main := star . maybe . some;
