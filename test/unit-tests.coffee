should = require 'should'
stream = require '../src/stream'

describe 'stream', ->
    
    it 'can return the head of a sequence', ->
        stream.range(1).head().should.eql 1
        stream.range(5).head().should.eql 5
        
    it 'create a natural range starting at a given integer', ->
        stream.range(1).take(1).should.eql [1]
        stream.range(1).take(3).should.eql [1, 2, 3]
        stream.range(5).take(3).should.eql [5, 6, 7]

    it 'can create a stream from an array', ->
        stream.fromArray([2, 5, 7, 9]).take(4).should.eql [2, 5, 7, 9]

    it 'can filter a stream with a predicate', ->
        isEven = (i) -> i%2 == 0
        stream.range(1).filter(isEven).take(3).should.eql [2, 4, 6]
        stream.range(9).filter(isEven).take(2).should.eql [10, 12]

    it 'can map items from the stream', ->
        double = (i) -> i*2
        stream.range(1).map(double).take(4).should.eql [2, 4, 6, 8]

    it 'can zip streams together', ->
        stream.zip(stream.range(0), stream.range(10)).take(3).should.eql [[0,10], [1,11], [2,12]]

    it 'can create a stream cycling through an array', ->
        stream.cycle([2, 5, 7]).take(8).should.eql [2, 5, 7, 2, 5, 7, 2, 5]
        stream.cycle(['a', 'b', 'c']).take(4).should.eql ['a', 'b', 'c', 'a']

