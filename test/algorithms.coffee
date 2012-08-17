should = require 'should'
stream = require '../src/stream'

		
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
    
    it 'can find the first term with 4 digits', ->
        fourDigits = (i) -> ('' + i).length is 4
        fibo().filter(fourDigits).first().should.eql 1597



#
# Algorithm implementations as infinite sequences
#

prime = ->
    sieve = (s) ->
        h = s.head()
        stream.create (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
    sieve(stream.range 2)

fizzbuzz = ->
	naturals = stream.range 1
	threes = stream.cycle ['', '', ' fizz']
	fives = stream.cycle ['', '', '', '', ' buzz']
	concat = (arr) -> arr.join ''
	stream.zip(naturals, threes, fives).map(concat)

fibo = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    stream.iterate(calc, [0, 1]).map (pair) -> pair[1]
