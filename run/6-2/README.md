# 함수의 본문은 블록이다.

`do...end` 블록은 여러 줄의 표현식을 한데 묶어 다른 코드로 전달하는 한 가지 방법이다. 이 방법은 모듈이나 기명 함수를 정의할 때, 제어 구조 등 코드를 하나의 개체로 다루어야 하는 모든 곳에서 사용된다. 그런데 `do...end`는 사실 엘릭서의 기본 문법이 아니다. 실제 문법은 다음과 같다.

```exs
def double(n), do: n * 2
```

여러 줄의 코드를 괄호로 묶어 `do:`의 값으로 전달할 수도 있다.

```exs
def greet(greeting, name), do: (
  IO.puts greeting
  IO.puts "How're you doing, #{name}?"
)
```

`do...end` 문법은 개발자의 편의를 위한 문법일 뿐이다. 컴파일 과정에서 `do...end`는 `do:` 형태로 바뀐다(`do:` 형태 자체는 키워드 리스트의 한 항목으로, 특별한 문법이 아니다). 일반적으로 한 줄 짜리 코드 블록에는 `do:`를, 여러 줄짜리 블록에는 `do...end`를 사용한다. 따라서 앞서 살펴본 times 예제를 다음처럼 고쳐 쓸 수도 있다.

```exs
defmodule Times do
  def double(n), do: n * 2
end
```

심지어 이렇게 쓸 수도 있다(할 수는 있지만 권장하지 않는다)

```exs
demodule Times, do: (def double(n), do: n * 2\)
```