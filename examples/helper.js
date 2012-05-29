sc = function(x){return x+1}
funToInt = function(n){return n(sc)(0)}
funToBool = function(b){return b(true)(false)}

curry2 = function(f){return function(x){return function (y){return f(x,y)}}}
curry3 = function(f){return function(x){return function (y){return function(z){f(x,y,z)}}}}
curry4 = function(f){return function(w){return function(x){return function(y){return function(z){return f(w,x,y,z)}}}}}
uncurry2 = function(f){return function(x,y){return f(x)(y)}}
uncurry3 = function(f){return function(x,y,z){return f(x)(y)(z)}}
uncurry4 = function(f){return function(w,x,y,z){return f(w)(x)(y)(z)}}
