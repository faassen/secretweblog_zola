## Refactoring

Refactoring with or without LLM agents requires you understand the code well
enough to actually express what refactoring you want. Detailed human
understanding is helpful.

Now "vibe refactoring" does exist; you can express a vague discomfort and a
desire for regularity to an LLM and the LLM will come up with some refactoring.
Whether that refactoring is in the right direction however still requires human
judgement. The LLM coding agent allows fast refactoring; whether you go forward
quickly or spin around in circles is up to you.

## Porting code

You do need extensive tests for the new code. You often want to test not just
the final outcome but the layers against the original implementation. In my
play I've ported Python to Rust, and C to Rust, and even Fortran to Rust.

I guess the "rewrite it to Rust" meme is part of my play behavior.

## Doing things more quickly

I'm not interested in the grind/productivity discussion here. But just like you
can refactorings more quickly, you can write new code more quickly too. If
that's code you already know how to write, then that can be pretty neat,
especially when creating something new.
