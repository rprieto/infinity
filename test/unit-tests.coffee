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

    it 'can filter a stream with a predicate', ->
        isEven = (i) -> i%2 == 0
        stream.range(1).filter(isEven).take(3).should.eql [2, 4, 6]
        stream.range(9).filter(isEven).take(2).should.eql [10, 12]