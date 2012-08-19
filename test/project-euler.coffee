_ = require 'underscore'
should = require 'should'
infinite = require '../src/infinity'

describe 'project euler', ->
    
    it 'problem 1', ->
        infinite.range(1).filter(divBy 3).filter(divBy 5).takeWhile(lessThan 1000).reduce(0, sum).should.eql 33165
    
    it 'problem 2', ->
        fibo().filter(divBy 2).takeWhile(lessThan 4000000).reduce(0, sum).should.eql 4613732

    it 'problem 5', ->
        infinite.range(1).filter(divUpTo 10).first().should.eql 2520

    it 'problem 7', ->
        # 10001st prime? takes too long
        prime().skip(1001).first().should.eql 7933

    it 'problem 10', ->
        # under 2 million? takes too long
        prime().takeWhile(lessThan 2000).reduce(0, sum).should.eql 277050

    it 'problem 25', ->
        fourDigits = (i) -> ('' + i).length is 4
        fibo().filter(fourDigits).first().should.eql 1597

#
# A few necessary algorithms
#

divBy = (x) -> ((i) -> i % x == 0)

lessThan = (x) -> ((i) -> i < x)

sum = (acc,i) -> acc + i

fibo = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    infinite.iteration([0, 1], calc).map (pair) -> pair[1]

divUpTo = (max) ->
    (x) -> _.all([1..max], (i) -> x%i == 0)

prime = ->
    sieve = (s) ->
        h = s.head()
        infinite.stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
    sieve(infinite.range 2)
