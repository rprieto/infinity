
exports.range = (start) -> 
    take: (max) ->
        ret = []
        for i in [start...start+max]
            ret.push i
        ret
