infinite = require './infinity'

sieve = (s) ->
    h = s.head()
    infinite.stream (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)

list = sieve(infinite.range 2).take 100

console.log 'First 100 prime numbers'
console.log list.join(',')
