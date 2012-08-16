should = require 'should'
stream = require '../src/stream'

describe 'stream', ->
  it 'range', ->
    stream.range(1).take(1).should.eql [1]
	stream.range(1).take(3).should.eql [1, 2, 3]
	stream.range(5).take(3).should.eql [5, 6, 7]
