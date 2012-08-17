infinite = require './infinity'

sieve = (s) ->
    h = s.head()
    infinite.create (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)

list = sieve(infinite.range 2).take 100
console.log list
