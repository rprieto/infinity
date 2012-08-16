should = require 'should'
stream = require '../src/stream'

describe 'fizzbuzz', ->
  xit 'can fizzbuzz up to twenty', ->
    fizzbuzz(20).should.eql [1, 2, 'fizz', 4, 'buzz', 'fizz', 7, 8, 'fizz', 'buzz', 11, 'fizz', 13, 14, 'fizz buzz', 16, 17, 'fizz', 19, 'buzz']
		
describe 'prime numbers', ->
    it 'finds them', ->
        sieve(stream.range(2)).take(5).should.eql [2, 3, 5, 7, 11]

fizzbuzz = (max) ->
	naturals = stream.range(1)
	threes = stream.cycle(['', '', 'fizz'])
	fives = stream.cycle(['', '', '', '', 'buzz'])
	stream.zip(naturals, threes, fives).take(max)

sieve = (s) ->
    h = s.head()
    stream.create (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
