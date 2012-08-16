logger = require('tracer').console format: "{{stack}} {{message}}"

stream = (h, t) ->
    
    head: ->
        if h != null
            h()
        else
            t().first()
            
    first: ->
        @take(1)[0]
        
    take: (max) ->
        if max == 1
            [@head()]
        else
            [@head()].concat (t().take (max-1))

    filter: (test) ->
        if test(@head())
            stream h, -> t().filter(test)
        else
            t().filter(test)

range = (start) -> 
    stream (-> start),( -> range(start+1))

exports.range = range

