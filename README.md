Welcome to lambda2js
====================

First thing to mention is, that lambda2js is meant mainly as fun project.
So if you are not in mood, simply leave as this is nothing for you.

As you can guess just by looking at name, lambda2js is compiler
that takes simple syntactically sugared Untyped lambda calculus and produces
JavaScript code. Though this project is meant as fun, it actually works.

Project is open source (licensed under GPL-3) and patches are welcome.

Motivation
----------

Have you ever found yourselves writing JavaScript code and thinking like:
"Oh my... How nice it would be to have this function with flipped arguments.
And now I have to write wrapper function, or at least some anonymous function
that will do what I need. In functional programming, I would simply use
flip and that would be it!" Well, now is your time, as this project
was brought to light of general public.

Example
-------

In examples you can find [simple though nice example](examples/example.ulc),
that will get compiled into

~~~ { .javascript }
K = function(x){return function(y){return x}}
S = function(f){return function(g){return function(x){return f(x)(g(x))}}}
I = S(K)(K)
Dot = function(f){return function(g){return function(x){return f(g(x))}}}
Flip = function(f){return function(x){return function(y){return f(y)(x)}}}
True = K
Not = Flip
False = Not(True)
If = I
Zero = function(s){return function(z){return z}}
Succ = function(n){return function(s){return function(z){return n(s)(s(z))}}}
IsZero = function(n){return n(K(False))(True)}
Add = function(m){return function(n){return function(s){return function(z){return m(s)(n(s)(z))}}}}
Mul = function(m){return function(n){return function(s){return function(z){return m(n(s))(z)}}}}
Pow = function(m){return function(n){return function(s){return function(z){return n(m)(s)(z)}}}}
One = Succ(Zero)
Two = Succ(One)
Three = Succ(Two)
Tup = function(x){return function(y){return function(p){return p(x)(y)}}}
Fst = function(t){return t(K)}
Snd = function(t){return t(Flip(K))}
Fac = function(n){return Snd(n(function(t){return t(function(x){return function(y){return Tup(Succ(x))(Mul(x)(y))}})})(Tup(One)(One)))}
~~~~

which actually works. You can play with thing. For example, combined
with small [helper library for seamless integration](examples/helper.js),
you can try computing `(2+3)!`.

~~~ { .javascript }
alert( funToInt ( Fac(Add(Three)(Two)) ) )
~~~

Flipping arguments can be as simple as

~~~ { .javascript }
alert ( uncurry2(Flip(curry2(Math.pow)))(2,3) )
~~~

...and much more.

Origin
------

I was playing with JavaScript the other day, pondering higher functions.
Trying the usual stuff like [Church numerals](http://en.wikipedia.org/wiki/Church_encoding)
and things like that. And I found myself under avalanche of JavaScript
boilerplate. Just compare `function(x){return x}` and `\ x . x`.

And then it occurred to me: this can be easily automated! I can
write code I like and get code I need. And I sat down to my console
and in just couple of moments I came with 10 commandm\^W\^Wthis little
project. And here it is for everyone to enjoy.