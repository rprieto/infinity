
#
# stream factory
#

create = (h, t) ->
    
    head: -> h()
    
    tail: -> t()
         
    first: -> @take(1)[0]
    
    skip: (count) ->
        if count == 1
            t()
        else
            t().skip count - 1
    
    take: (max) ->
        if max == 1
            [h()]
        else
            [h()].concat (t().take (max-1))

    filter: (test) ->
        if test h()
            create h, -> t().filter test
        else
            t().filter test
        
    map: (transform) ->
        create (-> transform h()), (-> t().map transform)


#
# utility methods
#

range = (start) -> 
    create (-> start), (-> range start+1)

fromArray = (arr) ->
    create (-> arr[0]), (-> fromArray arr.slice 1)

cycle = (arr) ->
    create (-> arr[0]), (-> cycle arr.slice(1).concat [arr[0]] )

zip = (streams...) ->
    heads = streams.reduce ((acc, item) -> acc.concat item.head()), []
    tails = streams.reduce ((acc, item) -> acc.concat item.tail()), []
    create (-> heads), (-> zip.apply null, tails)

iterate = (fn, seed) ->
    val = fn seed
    create (-> val), (-> iterate fn, val)


#
# node module exports
#

exports.create = create
exports.range = range
exports.fromArray = fromArray
exports.cycle = cycle
exports.zip = zip
exports.iterate = iterate
