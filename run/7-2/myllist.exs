defmodule MyList do
  def len([]), do: 0
  def len([ _ | tail ]), do: 1 + len(tail)
end

IO.puts MyList.len([11, 12, 13, 14, 15])
