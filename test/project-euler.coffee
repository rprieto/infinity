should = require 'should'
infinite = require '../src/infinity'

describe 'project euler', ->
    
    it 'problem #1', ->
        divBy = (x) -> ((i) -> i % x == 0)
        under1thousand = (i) -> i < 1000
        infinite.range(1).filter(divBy 3).filter(divBy 5).takeWhile(under1thousand).reduce(0, sum).should.eql 33165
    
    it 'problem #2', ->
        even = (i) -> i % 2 == 0
        under4million = (i) -> i < 4000000
        fibo().filter(even).takeWhile(under4million).reduce(0, sum).should.eql 4613732

    it 'problem #3', ->
        true.should.eql true


#
# A few necessary algorithms
#

sum = (acc,i) -> acc + i

fibo = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    infinite.iteration([0, 1], calc).map (pair) -> pair[1]
