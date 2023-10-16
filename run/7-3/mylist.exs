defmodule Test do
  def square([]), do: []
  def square([ head | tail ]), do: [ head * head | square(tail) ]
end

IO.inspect Test.square([1, 2, 3, 4, 5])
