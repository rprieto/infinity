
create = (h, t) ->
    
    head: ->
        if h != null
            h()
        else
            t().first()
      
    tail: -> t()
         
    first: ->
        @take(1)[0]
        
    take: (max) ->
        if max == 1
            [@head()]
        else
            [@head()].concat (t().take (max-1))

    filter: (test) ->
        if test(@head())
            create h, -> t().filter(test)
        else
            t().filter(test)

range = (start) -> 
    create (-> start), (-> range start+1)

fromArray = (arr) ->
    create (-> arr[0]), (-> fromArray arr.slice 1)

exports.range = range
exports.fromArray = fromArray
exports.create = create
