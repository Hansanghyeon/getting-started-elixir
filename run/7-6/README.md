# 더 복잡한 리스트 패턴

값을 하나씩 처리하는 방법으로 모든 리스트 문제를 풀 수 있는 것은 아니다. 다행이 조인 연산자 `|`는 연산자 왼쪽에 여러 값을 두도록 해준다. 따라서 다음과 같이 쓸 수도 있다.

```sh
iex> [1, 2, 3 | [4, 5, 6]]
[1, 2, 3, 4, 5, 6]
```

패턴 매칭에서도 똑같이 동작한다. 따라서 리스트의 앞부분에 있는 여러 값을 한꺼번에 매칭할 수 있다. 예를 들어 다음 프로그램은 리스트의 값을 한 쌍씩 묶어 순서를 바꾼다.

```exs
defmodule Swapper do
  def swap([]), do: []
  def swap([ a, b | tail ]), do: [b, a | swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end
```

위 코드를 실행해보면

```log
** (RuntimeError) Can't swap a list with an odd number of elements
    swap.exs:4: Swapper.swap/1
    swap.exs:3: Swapper.swap/1
    swap.exs:8: (file)
```

swap 함수의 세 번째 정의에는 값 하나짜리 리스트가 매칭된다. 재귀 호출을 수행한 결과 리스트에 값이 하나만 남았을 때가 이 경우에 해당한다. 매 호출마다 값을 두 개씩 처리하고 있으므로, 처음에 받은 리스트의 길이가 홀수일 때 이 패턴이 매칭된다.

## 리스트의 리스트

이번에는 여러 날씨 관측소에서 온도와 강수량을 기록한다고 해보자. 각 기록은 다음 형태로 저장된다.

```
[ timestamp, location_id, temperature, rainfall ]
```

기록들의 리스트를 받아, 27번 관측소에서 보내온 기록들만 찾아보자.

```exs
defmodule WeatherHistory do
  def for_location_27([]), do: []
  def for_location_27([ time, 27, temp, rain ] | tail) do
    [ [time, 27, temp, rain] | for_location_27(tail)]
  end
  def for_location_27([ _ | tail]), do: for_location_27(tail)
end
```

이 코드는 리스트가 빌 때까지 재귀처리하는 경우의 일반적인 구현이다. 그런데 함수의 두 번째 정의를 보자. 지금까지는 리스트의 첫 번째 값을 head라는 변수에 매칭했는데, 여기에 다음과 같은 패턴이 자리하고 있다.

```exs
for_location_27([ [time, 27, temp, rain] | tail])
```

패턴에 매칭되려면 리스트의 첫 번째 값 네 개짜리 리스트여야 하고, 내부 리스트의 두번째 값이 27이어야 한다. 이 함수는 우리가 원하는 날씨 관측소의 기록에만 실행된다. 한편 이러한 방식으로 필터링을 수행할 때는 조건에 매칭되지 않는 경우도 생각해야 한다. 함수의 세 번째 정의가 바로 그 역활을 해준다. 세 번째 파라미터 목록을 다음처럼 작성할 수도 있다.

```exs
for_location_27([ [time, _, temp, rain ] | tail])
```

하지만 실제로는 리스트의 첫 번째 값이 무엇이든, 어떤 형식이든 상관없이 매칭되어야 한다. 같은 모듈에 간단한 테스트 데이터를 정의해두었다.

```exs
def test_data do
  [
    [1366225622, 26, 15, 0.125],
    [1366225622, 27, 15, 0.45],
    [1366225622, 28, 21, 0.25],
    [1366229222, 26, 19, 0.081],
    [1366229222, 27, 17, 0.468],
    [1366229222, 28, 15, 0.601],
    [1366232822, 26, 22, 0.095],
    [1366232822, 27, 21, 0.051],
    [1366232822, 28, 24, 0.03],
    [1366236422, 26, 17, 0.025]
  ]
end
```

이 데이터로 IEx에서 함수를 실행해보자. 더 쉽게 실행하기 위해 `import` 함수를 사용한다. `import`를 사용하면 WeatherHistory 모듈에 있는 함수들을 로컬 네임 스코프로 가져올 수 있다. 따라서 `import`를 호출한 다음에는 함수 호출 시 모듈명을 앞에 적지 않아도 된다.

```sh
iex> c "weahter.exs"
[WeatherHistory]
iex> import WeatherHistory
WeatherHistory
iex> for_location_27(test_data)
[
  [1366225622, 27, 15, 0.45],
  [1366229222, 27, 17, 0.468],
  [1366232822, 27, 21, 0.051]
]
```

이 함수는 특정 관측소의 데이터만 가져올 수 있다는 한계가 있다. 원하는 관측소의 위치를 파라미터로 전달할 수 있다면 더 좋을 것이다. 이때도 패턴 매칭을 사용한다.
