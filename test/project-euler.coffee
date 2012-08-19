should = require 'should'
infinite = require '../src/infinity'

describe 'project euler', ->
    
    it 'problem #1', ->
        infinite.range(1).filter(divBy 3).filter(divBy 5).takeWhile(lessThan 1000).reduce(0, sum).should.eql 33165
    
    it 'problem #2', ->
        fibo().filter(divBy 2).takeWhile(lessThan 4000000).reduce(0, sum).should.eql 4613732

    it 'problem #5', ->
        problem5(10).skip(1).first().should.eql 2520


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

problem5 = (max) ->
    sieve = (s) ->
        h = s.head()
        infinite.stream (-> h), (-> 
            sieve s.tail().filter divUpTo max
        )
    sieve(infinite.range 1)

divUpTo = (max) ->
    (x) -> [1..max].reduce(((acc, i) -> (acc && (x%i == 0))), true) == true
