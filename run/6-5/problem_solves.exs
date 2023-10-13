# 1과 1,000 사이의 임의의 숫자를 맞혀보자. 숫자를 맞히는 가장 효율적인 방법은
# 최댓값과 최솟값의 중간값으로 추정해보는 것이다.
# 추정한 값이 더 크다면 정답은 최솟값과 추정한 값 사이에 있다.
# 반대로 추정한 값이 더 작다면 정답은 추정한 ㄱ밧과 최댓갓ㅂ 사이에 있다.
# 구현할 함수는 guess(actual, range)이다. actual은 맞힐 값, range는 최솟값과 최댓값을 나타내는 엘릭서 범위 타입의 값이다.
# 출력은 다음 예와 비슷해야 한다.
# ```
# iex > Chop.guess(273, 1..1000)
# Is It 500
# Is It 250
# Is It 375
# Is It 312
# Is It 281
# Is It 273
# 273
# ```

# 힌트
# - 현재 추정한 값을 추가 파라미터로 갖는 헬퍼 함수를 구현해야 한다.
# - div(a, b) 함수로 정수 나눗셈을 할 수 있다.
# - 가드 조건절을 활용하자.
# - 패턴 매칭으로 범위 타입의 시작과 끝 값을 매칭할 수 있다.(예: a..b = 4..8 )

#################################################################################

defmodule Chop do
  def guess(actual, range) do
    guess(actual, range, div(range.first + range.last, 2))
  end

  def guess(actual, range, guess) when guess > actual do
    IO.puts "Is It #{guess}"
    guess(actual, range.first..guess, div(range.first + guess, 2))
  end

  def guess(actual, range, guess) when guess < actual do
    IO.puts "Is It #{guess}"
    guess(actual, guess..range.last, div(guess + range.last, 2))
  end

  # 위 함수를 만들긴했는데 함수의 이름과 인자의 이름이 똑같을때 elixir는 함수인지 인자인지 어떻게 구분할수있지?
  def guess(actual, _range, guess) when guess == actual do
    IO.puts "Is It #{guess}"
    IO.puts guess
  end
end



Chop.guess(273, 1..1000)
