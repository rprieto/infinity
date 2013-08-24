# infinity.js

> Infinite sequences for Node.js

> Supports typical array functions and more, all evaluated lazily.

[![NPM version](https://badge.fury.io/js/infinity.png)](https://npmjs.org/package/infinity)

# Contributors

Joint effort of [Andrew Jones](https://github.com/akjones), [Maxim Filimonov](https://github.com/Maxim-Filimonov), [Leonardo Borges](https://github.com/leonardoborges) and [Romain Prieto](https://github.com/rprieto), during a _ThoughtWorks_ Node.js hack night.

## Creating a stream

```coffee
infinite = require 'infinity'

infinite.range 9                        # naturals from 9 to infinity
infinite.cycle [1, 2, 3]                # repeats 1, 2, 3 forever
infinite.iteration 2, (i) -> i*2        # all powers of 2
infinite.zip s1, s2, s3                 # a steam pairing all given streams 1 to 1
infinite.cons 99, 98, stream            # a new stream starting with the given fixed values
infinite.fromArray [3, 6, 8]            # this one is actually finite, but still lazy
infinite.primes()                       # sequence of prime numbers
infinite.fibonacci()                    # fibonacci sequence
```

## Stream operations

```coffee
myStream = infinite.range 1

myStream.filter (i) -> i%2 == 0       # a new stream with even numbers only
myStream.map (i) -> i*2               # a new stream with all elements doubled
myStream.skip 2                       # a new stream that starts 2 elements further
myStream.take 5                       # get the first 5 elements as a javascript array
```

These can of course be chained.

## Example

FizzBuzz that doesn't use loops or modulo:

```coffee
naturals = infinite.range 1
threes   = infinite.cycle ['', '', ' fizz']
fives    = infinite.cycle ['', '', '', '', ' buzz']
concat   = (arr) -> arr.join ''
infinite.zip(naturals, threes, fives).map(concat).take(20)
```

## Custom streams

The basic generators (range, cycle) are not always enough.... but chances are you can express your stream as a *head* and a *tail*.

* The *head* is a function that returns a value
* The *tail* is a function that returns a stream

For example the following sequence outputs every second item it's given, lazily:

```coffee
skipper = (s) -> infinite.stream (-> s.first()), (-> skipper s.tail().skip(1))

twentyAndAbove = infinite.range(1).skip 20
console.log skipper(twentyAndAbove).take 10
```

This can be used to implement intersting algorithms.
For example, here's the implementation of `infinite.primes()`:

```coffee
primes = ->
    sieve = (s) ->
        h = s.head()
        infinite.stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
    sieve(infinite.range 2)

console.log infinite.primes().take(20)
console.log infinite.primes().filter( (i) -> i > 1000 ).take(5)
````

## Curious about the code?

Go to the folder you just cloned:

```shell  
npm install
npm install -g mocha
mocha
```
