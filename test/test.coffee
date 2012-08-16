
assert = require 'assert'
should = require 'should'
stream = require '../src/stream'

describe 'fizzbuzz', ->
  xit 'fizzbuzz up to twenty', ->
    fizzbuzz(20).should.eql [1, 2, 'fizz', 4, 'buzz', 'fizz', 7, 8, 'fizz', 'buzz', 11, 'fizz', 13, 14, 'fizz buzz', 16, 17, 'fizz', 19, 'buzz']
		
fizzbuzz = (max) ->
	naturals = stream.range(1)
	threes = stream.cycle(['', '', 'fizz'])
	fives = stream.cycle(['', '', '', '', 'buzz'])
	stream.zip(naturals, threes, fives).take(max)

# // function dfgdfgd() {
# // 	var output = fizzbuzz(20);
# // 	output.should.be([1, 2, 'fizz', 4, 'buzz', 'fizz', 7, 8, 'fizz', 'buzz', 11, 'fizz', 13, 14, 'fizz buzz', 16, 17, 'fizz', 19, 'buzz']);
# // }
# // 
# // function fizzbuzz(max) {
# // 	var naturals = Stream.range(1);
# // 	var threes = Stream.cycle(['', '', 'fizz']);
# // 	var fives = Stream.cycle(['', '', '', '', 'buzz']);
# // 	Stream.zip(naturals, threes, five).take(20);
# // }
