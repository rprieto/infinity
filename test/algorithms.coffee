should = require 'should'
infinite = require '../lib/infinity'

describe 'some typical algorithms', ->
    
    describe 'fizzbuzz', ->

        it 'can count to twenty', ->
            fizzbuzz().take(20).should.eql ['1', '2', '3 fizz', '4', '5 buzz', '6 fizz', '7', '8', '9 fizz', '10 buzz', '11', '12 fizz', '13', '14', '15 fizz buzz', '16', '17', '18 fizz', '19', '20 buzz']

        it 'can print fizzes after 100', ->
            hasFizz = (str) -> str.indexOf('fizz') isnt -1
            fizzbuzz().skip(100).filter(hasFizz).take(3).should.eql ['102 fizz', '105 fizz buzz', '108 fizz']


#
# Algorithm implementations as infinite sequences
#

fizzbuzz = ->
    naturals = infinite.range 1
    threes = infinite.cycle ['', '', ' fizz']
    fives = infinite.cycle ['', '', '', '', ' buzz']
    concat = (arr) -> arr.join ''
    infinite.zip(naturals, threes, fives).map(concat)
