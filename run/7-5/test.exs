defmodule MyList do
  def len([]), do: 0
  def len([ _ | tail ]), do: 1 + len(tail)

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  # 리스트와 함수를 받는 mapsum 함수를 만들어보자.
  # 이 함수는 리스트의 각 요소에 함수를 적용한 뒤, 그 결과를 모두 더한 값을 반환한다.
  # iex> MyList.mapsum([1,2,3,4], &(&1 * &1)) # 14
  def mapsum(list, func) do
    list
    |> MyList.map(func)
    |> MyList.reduce(0, &(&1 + &2))
  end

  # 이번에는 max(list) 함수를 구현해보자. 이 함수는 리스트에서 가장 큰 값을 반환한다(생각보다 조금 어려울 수 있다)
  def max([]), do: 0
  def max(list) do
    list
    |> reduce(
      0,
      fn (n, n2) -> if n > n2, do: n, else: n2 end
    )
  end

  # TODO: 문제풀기
  # 엘릭서에서 작은따옴표로 둘러싸인 문자열은사실 각 문자 코드들의 리스트다.
  # 리스트의 각 요소에 n을 더하는 caesar(list, n) 함수를 만들어보자.
  # 만약 더한 문자 코드의 값이 'z'를 넘어가면 'a'로 돌아가 이어서 세어주자.
end



ExUnit.start

defmodule Ex75Test do
  use ExUnit.Case

  test "iex> MyList.mapsum([1,2,3], &(&1 * &1)) # 14" do
    assert MyList.mapsum([1,2,3], &(&1 * &1)) == 14
  end

  test "iex> MyList.max([1,2003,3,4,102]) # 2003" do
    assert MyList.max([1,2003,3,4,102]) == 2003
  end


end
