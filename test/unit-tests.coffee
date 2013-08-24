should = require 'should'
infinite = require '../lib/infinity'

describe 'infinity', ->
    
    it 'can return the head of a sequence', ->
        infinite.range(1).head().should.eql 1
        infinite.range(5).head().should.eql 5
        
    it 'create a natural range starting at a given integer', ->
        infinite.range(1).take(1).should.eql [1]
        infinite.range(1).take(3).should.eql [1, 2, 3]
        infinite.range(5).take(3).should.eql [5, 6, 7]
    
    it 'create a natural range incrementing both up and down', ->
    	infinite.range(1, 1).take(3).should.eql [1, 2, 3]
    	infinite.range(3, -1).take(3).should.eql [3, 2, 1]

    it 'can skip items', ->
        infinite.range(1).skip(3).take(2).should.eql [4, 5]
        infinite.range(1).skip(3).skip(4).take(2).should.eql [8, 9]

    it 'can create a stream from an array', ->
        infinite.fromArray([2, 5, 7, 9]).take(4).should.eql [2, 5, 7, 9]

    it 'can filter a stream with a predicate', ->
        divBy2 = (i) -> i % 2 == 0
        divBy3 = (i) -> i % 3 == 0
        infinite.range(1).filter(divBy2).take(4).should.eql [2, 4, 6, 8]
        infinite.range(9).filter(divBy3).take(4).should.eql [9, 12, 15, 18]
        
    it 'can combine multiple filters', ->
        divBy2 = (i) -> i % 2 == 0
        divBy3 = (i) -> i % 3 == 0
        infinite.range(1).filter(divBy2).filter(divBy3).take(3).should.eql [6, 12, 18]

    it 'can map items from the stream', ->
        double = (i) -> i * 2
        infinite.range(1).map(double).take(4).should.eql [2, 4, 6, 8]

    it 'can create a finite stream given a final predicate', ->
        lessThan5 = (i) -> i < 5
        infinite.range(1).takeWhile(lessThan5).take(10).should.eql [1, 2, 3, 4]

    it 'can reduce a finite stream to a single value', ->
        lessThan5 = (i) -> i < 5
        sum = (acc, i) -> acc + i
        infinite.range(1).takeWhile(lessThan5).reduce(0, sum).should.eql 10

    it 'can apply a function iteratively on a given seed', ->
        infinite.iteration(1, (i) -> i*2).take(4).should.eql [2, 4, 8, 16]
        infinite.iteration(3, (i) -> i*i).take(3).should.eql [9, 81, 6561]

    it 'can zip streams together', ->
        infinite.zip(infinite.range(0), infinite.range(10)).take(3).should.eql [[0,10], [1,11], [2,12]]

    it 'can create a stream cycling through an array', ->
        infinite.cycle([2, 5, 7]).take(8).should.eql [2, 5, 7, 2, 5, 7, 2, 5]
        infinite.cycle(['a', 'b', 'c']).take(4).should.eql ['a', 'b', 'c', 'a']

    it 'lazily takes elements of a stream based on a predicate', ->
        infinite.range(1).takeWhile((i) -> i < 10).take(8).should.eql [1,2,3,4,5,6,7,8]
        infinite.range(1).takeWhile((i) -> i < 10).take(20).should.eql [1,2,3,4,5,6,7,8,9]
        infinite.range(1).takeWhile((i) -> i < 1000).reduce(0, ((acc,i) -> acc + i)).should.eql 499500

    it 'can prepend a fixed values to a stream', ->
        infinite.cons(99, infinite.range(1)).take(6).should.eql [99, 1, 2, 3, 4, 5]

    it 'can prepend multiple fixed values to a stream', ->
        infinite.cons(99, 88, 77, infinite.range(1)).take(6).should.eql [99, 88, 77, 1, 2, 3]

    it 'can generate a sequence of all primes', ->
        infinite.primes().take(10).should.eql [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

    it 'can generate a fibonacci sequence', ->
        infinite.fibonacci().take(10).should.eql [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
