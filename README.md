처음배우는 엘릭서 프로그래밍

## TIP

날짜와 시간을 이용한 프로그램을 작성할 때는 라우 탄스코프(Lau Taarnskov)가 만든 Calendar등 서드파티 라이브러리의 지원을 받는 것이 좋다.

앨릭서 1.8부터 타임존 데이터베이스를 지원하는 등 언어 차원에서도 지속적으로 개선이 이루어지고 있다.
httpe://exlixir-lang.org/blog/2019/01/14/elixir-v1-8-0-released/#time-zone-database-support

## 참고

엘릭서는 다른언어에 비해 값 사이의 비교를 비교적 너그럽게 허용한다. 다른 자료형 사이의 값 역시 비교가 가능하다. 같거나 비교 가능한 자료형이라면 일반적인 순서로 비교하고, 그렇지 않으면 다음과 같은 규칙으로 정렬한다.

- 숫자 < 아톰 < 레퍼런스 < 함수 < 포트 < 프로세스 ID < 튜플 < 맵 < 리스트 < 바이너리
  - nil이 아톰이므로 엘릭서에서는 숫자와 nul을 비교하면 항상 nil이 크다.

## 디버깅, 실행

`.exs`파일을 바로 실행하는 방법

```bash
elixir hello.exs
```

## 테스팅

`ExUnit`을 사용하여 테스트코드를 작성하고, 해당 파일을 직접 실행한다.

이 방법은 자동화 테스트 환경을 설정하기 어렵다. 다른 방법으로는 mix 프로젝트를 생성하고 테스팅을 작성하면 자동테스트까지 모두 가능하다.

스터디중에는 단일 테스트만 할 것이기 때문에 `ExUnit`을 통해서 단일 파일 테스트를 한다.

```ex
# math.ex

defmodule Math do
  def add(a, b) do
    a + b
  end

  def subtract(a, b) do
    a - b
  end
end
```

```exs
# math_test.exs
ExUnit.start()

defmodule MathTest do
  use ExUnit.Case

  test "addition" do
    assert Math.add(1,2) == 3
  end

  test "subtraction" do
    assert Math.subtract(5, 3) == 2
  end
end
```

터미널에서 테스트 파일을 직접 실행합니다.

```bassh
elixir math_test.exs
```

이 방법으로 실행하면 별도의 Mix 프로젝트 설정 없이도 테스트를 직접 실행할 수 있습니다.

## 최적화

### 단축문법

```exs
speak = &(IO.puts(&1))
speak.("Hello") # => Hello
```

이 방식이 꽤 똑똑해보인다면, 한발 더 나아가 코드에서 speak를 정의하는 부분을 살펴보자.
일반적으로 엘릭서가 익명 함수를 만드는 방식을 생각하면 `&(IO.puts(&1))`은 `fn x -> IO.puts(x) end`로 바뀔것이다.
그런데 이렇게 정의되는 익명 함수는 그저 기명 함수 (IO 모듈의 puts 함수)를 호출하고 있고
파라미터의 순서도 같다(다시 말해, 익명 함수의 첫 번째 파라미터가 기명 함수의 첫 번째 파라미터가 되는 식이다).
이 경우 엘릭서는 익명 함수를 최적화해 직업 `IO.puts/1` 함수를 참조하도록 한다. 이렇게 최적화되려면 인자가 같은 순서로 들어가야한다.
