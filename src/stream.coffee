
stream = (head, tail) ->
    head: head
    take: (max) ->
        if max == 1
            [head]
        else
            [head].concat (tail().take (max-1))
    filter: (test) ->
        if test(head)
            stream head, tail
        else
            stream tail().take(1)[0], tail

range = (start) -> 
    stream start, -> range(start+1)

exports.range = range

