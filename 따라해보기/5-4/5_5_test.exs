# Filename: 5_5_test.exs
ExUnit.start

# 다음 코드를 & 표기법을 사용하도록 고쳐보자
# Enum.map [1, 2, 3, 4], fn x -> x + 2 end
# Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end

defmodule Ex55Test do
  use ExUnit.Case

  test "1번문제" do
    result = Enum.map [1, 2, 3, 4], &(&1 + 2)
    assert result == [3, 4, 5, 6]
  end
  test "2번문제" do
    result = Enum.each [1, 2, 3, 4], &IO.inspect/1
    assert result == :ok
  end
end
