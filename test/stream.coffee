should = require 'should'
stream = require '../src/stream'
logger = require('tracer').console format: "{{stack}} {{message}}"

describe 'stream', ->
    
    it 'head', ->
        stream.range(1).head().should.eql 1
        stream.range(5).head().should.eql 5
        
    it 'range', ->
        stream.range(1).take(1).should.eql [1]
        stream.range(1).take(3).should.eql [1, 2, 3]
        stream.range(5).take(3).should.eql [5, 6, 7]

    it 'filters', ->
        isEven = (i) -> i%2 == 0
        stream.range(1).filter(isEven).take(3).should.eql [2, 4, 6]
      