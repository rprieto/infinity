
#
# stream factory
#

stream = (h, t) ->
    
    head: -> h()
    
    tail: -> t()
         
    first: -> @take(1)[0]
    
    skip: (count) ->
        if count == 1
            t()
        else
            t().skip count - 1
    
    take: (max) ->
        theTail = t()
        if max == 1 || !theTail
            [h()]
        else
            [h()].concat (theTail.take (max-1))

    takeWhile: (test) ->
        if test h()
            stream h, -> t().takeWhile test
        else
            undefined

    reduce: (seed, f) ->
        theHead = h()
        if theHead && theTail = t()
            theTail.reduce(f(seed, theHead), f)
        else
            f(seed, theHead)

    filter: (test) ->
        if test h()
            stream h, -> t().filter test
        else
            t().filter test
        
    map: (transform) ->
        stream (-> transform h()), (-> t().map transform)


#
# utility methods
#

range = (start) -> 
    stream (-> start), (-> range start+1)

fromArray = (arr) ->
    stream (-> arr[0]), (-> fromArray arr.slice 1)

cycle = (arr) ->
    stream (-> arr[0]), (-> cycle arr.slice(1).concat [arr[0]] )

zip = (streams...) ->
    heads = streams.reduce ((acc, item) -> acc.concat item.head()), []
    tails = streams.reduce ((acc, item) -> acc.concat item.tail()), []
    stream (-> heads), (-> zip.apply null, tails)

iteration = (seed, fn) ->
    val = fn seed
    stream (-> val), (-> iteration val, fn)

cons = (values..., otherStream) ->
    red = (acc, val) -> stream (-> val), (-> acc)
    values.reverse().reduce red, otherStream

primes = ->
    sieve = (s) ->
        h = s.head()
        stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)
    sieve(range 2)

fibonacci = ->
    calc = (pair) ->
        [a, b] = pair
        [b, a + b]
    secondTerm = (pair) -> pair[1]
    cons 0, 1, iteration([0, 1], calc).map(secondTerm)

#
# node module exports
#

exports.stream = stream
exports.range = range
exports.fromArray = fromArray
exports.cycle = cycle
exports.zip = zip
exports.iteration = iteration
exports.cons = cons
exports.primes = primes
exports.fibonacci = fibonacci
