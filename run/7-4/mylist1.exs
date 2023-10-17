defmodule MyList do
  def len([]), do: 0
  def len([ _ | tail ]), do: 1 + len(tail)

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
end

IO.puts MyList.len([11, 12, 13, 14, 15])
# 리스트라서 이렇게 출력하면 안된다.
# IO.puts MyList.map([1,2,3,4], fn (n) -> n*n end)
# IO.puts MyList.map [1,2,3,4], fn (n) -> n*n end
# 실무에서 가장 많이 사용하던 방식으로 구현해봤다.
[1, 2, 3, 4]
|> MyList.map(fn (n) -> n*n end)
|> IO.inspect

[1, 2, 3, 4]
|> MyList.map(&(&1 * &1))
|> IO.inspect
