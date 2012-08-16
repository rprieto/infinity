# lazy-stream

A library for lazy evaluation in Node.js, with support for infinite sequences.

## Creating a stream

    stream = require 'stream'

    stream.range 9                       # naturals from 9 to infinity
    stream.create (-> 2), ((i)-> i*2)    # all powers of 2


## Stream operations

    stream.filter (i) -> i%2 == 0       # a new stream with even numbers only
    stream.take(5)                      # get the first 5 elements (javascript array)


## See the unit tests for examples...
