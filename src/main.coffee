stream = require './stream'

sieve = (s) ->
    h = s.head()
    stream.create (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)

list = sieve(stream.range 2).take 100
console.log list
