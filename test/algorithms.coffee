should = require 'should'
infinite = require '../src/infinity'

describe 'some typical algorithms', ->
    
    describe 'prime numbers', ->
    
        it 'can enumerate them all', ->
            prime().take(5).should.eql [2, 3, 5, 7, 11]

        it 'can find the first prime above 1000 and double it', ->
            above = (i) -> i > 1000
            double = (i) -> i * 2
            prime().filter(above).map(double).first().should.eql 2018


    describe 'fizzbuzz', ->

        it 'can count to twenty', ->
            fizzbuzz().take(20).should.eql ['1', '2', '3 fizz', '4', '5 buzz', '6 fizz', '7', '8', '9 fizz', '10 buzz', '11', '12 fizz', '13', '14', '15 fizz buzz', '16', '17', '18 fizz', '19', '20 buzz']

        it 'can print only fizzes', ->
            hasFizz = (str) -> str.indexOf('fizz') isnt -1
            fizzbuzz().filter(hasFizz).take(3).should.eql ['3 fizz', '6 fizz', '9 fizz']


    describe 'fibonacci', ->
    
        it 'creates the infinite sequence', ->
            fibo().take(7).should.eql [1, 2, 3, 5, 8, 13, 21]

        it 'can skip the first 5 numbers', ->
            fibo().skip(5).take(3).should.eql [13, 21, 34]
    
        it 'can return only even fibonacci numbers', ->
            even = (i) -> i % 2 == 0
            fibo().filter(even).take(5).should.eql [2, 8, 34, 144, 610]


#
# Algorithm implementations as infinite sequences
#

prime = ->
    sieve = (s) ->
        h = s.head()
        infinite.stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
    sieve(infinite.range 2)

fizzbuzz = ->
	naturals = infinite.range 1
	threes = infinite.cycle ['', '', ' fizz']
	fives = infinite.cycle ['', '', '', '', ' buzz']
	concat = (arr) -> arr.join ''
	infinite.zip(naturals, threes, fives).map(concat)

fibo = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    infinite.iteration([0, 1], calc).map (pair) -> pair[1]
