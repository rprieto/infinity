# infinity.js

Infinite sequences for Node.js

Supports typical array functions and more, all evaluated lazily.

# Contributors

Joint effort of [Andrew Jones](https://github.com/akjones), [Maxim Filimonov](https://github.com/Maxim-Filimonov), [Leonardo Borges](https://github.com/leonardoborges) and [Romain Prieto](https://github.com/rprieto), during a _ThoughtWorks_ Node.js hach night.

## Getting started

In your package.json, add the "infinity" module.
Then run
    
    >  npm install

And you're good to go, either in Javascript or CoffeeScript:
    
    infinite = require 'infinity'
    myStream = infinite.range 1

## Creating an infinite stream

    infinite = require 'infinity'

    infinite.range 9                        # naturals from 9 to infinity
    infinite.cycle [1, 2, 3]                # repeats 1, 2, 3 forever
    infinite.iteration 2, (i) -> i*2        # all powers of 2
    infinite.zip s1, s2, s3                 # a steam pairing all stream arguments 1 to 1

    infinite.fromArray [3, 6, 8]            # this one is actually finite, but still lazy


## Stream operations

    myStream = infinite.range 1

    myStream.filter (i) -> i%2 == 0       # a new stream with even numbers only
    myStream.map (i) -> i*2               # a new stream with all elements doubled
    myStream.skip 2                       # a new stream that starts 2 elements further
    myStream.take 5                       # get the first 5 elements as a javascript array

These can of course be chained.

## Custom streams

The basic generators (range, cycle) are not always enough.... but chances are you can express your stream as a *head* and a *tail*.

* The *head* is a function that returns a value.
* The *tail* is a stream itself

For example the following sequence outputs every second item it's given, lazily:

    skipper = (s) -> infinite.stream (-> s.first()), (-> skipper s.tail().skip(1))

    twentyAndAbove = infinite.range(1).skip 20
    console.log skipper(twentyAndAbove).take 10

This can be used to implement intersting algorithms.
For example, the following is an infinite sequence of prime numbers:

    prime = ->
        sieve = (s) ->
            h = s.head()
            infinite.stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
        sieve(infinite.range 2)

    console.log prime().take(50)
    console.log prime().filter( (i) -> i > 1000 ).take(5)

    
## More examples?

Check out the source for some typical algorithms implemented with *infinity*, for ex:

* a prime-number generator
* an infinite fibonacci sequence
* a "FizzBuzz" that doesn't use modulo or division

## Curious about the code?

Go to the folder you just cloned
    
    >  npm install
    >  npm install -g mocha
    >  mocha
    
All the tests should pass!
    
    > coffee src/main.coffee

This should output a lot of prime numbers

