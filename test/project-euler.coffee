#
# These are not intended to be optimal algorithms (many Euler problems can be solved with faster mathematical formulas)
# Instead this is just a demo of the type of operations we can do with infinite streams
#

_ = require 'underscore'
should = require 'should'
infinite = require '../src/infinity'

describe 'project euler', ->
    
    # Most Project Eurler problems can be solved using smart algorithms / mathematical properties
    # That's not the goal here, we just want to show the syntax for typical sequence operations
    # So the problems were changed slightly to be solvable using brute-force
    
    it 'problem 1', ->
        divBy3or5 = (i) -> (i % 3 == 0) || (i % 5 == 0)
        infinite.range(1).filter(divBy3or5).takeWhile(lessThan 1000).reduce(0, sum).should.eql 233168
    
    it 'problem 2', ->
        infinite.fibonacci().skip(2).filter(divBy 2).takeWhile(lessThan 4000000).reduce(0, sum).should.eql 4613732

    it 'problem 5', ->
        infinite.range(1).filter(divUpTo 10).first().should.eql 2520

    it 'problem 7 (for the 1001st prime)', ->
        infinite.primes().skip(1000).first().should.eql 7927

    it 'problem 10 (for under 2000)', ->
        infinite.primes().takeWhile(lessThan 2000).reduce(0, sum).should.eql 277050

    it 'problem 25 (with 4 digits)', ->
        fourDigits = (i) -> ('' + i).length is 4
        infinite.fibonacci().filter(fourDigits).first().should.eql 1597

#
# A few helpers
#

divBy = (x) -> ((i) -> i % x == 0)

lessThan = (x) -> ((i) -> i < x)

sum = (acc,i) -> acc + i

sigma = (n) -> n * (n+1) / 2

divUpTo = (max) ->
    (x) -> _.all([1..max], (i) -> x%i == 0)
