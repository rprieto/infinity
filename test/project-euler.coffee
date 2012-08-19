should = require 'should'
infinite = require '../src/infinity'

describe 'project euler', ->
    
    it 'problem #1', ->
        true.should.eql true
    
    it 'problem #2', ->
        even = (i) -> i % 2 == 0
        under4million = (i) -> i < 4000000
        sum = (acc,i) -> acc + i
        fibo().filter(even).takeWhile(under4million).reduce(0, sum).should.eql 4613732

    it 'problem #3', ->
        true.should.eql true


#
# A few necessary algorithms
#

fibo = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    infinite.iteration([0, 1], calc).map (pair) -> pair[1]
