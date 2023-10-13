# 기본 파라미터

기명 함수를 정의할 때 각 파라미터에 `param \\ value`문법을 사용해 기본값을 지정할 수 있다. 기본 파라미터가 있는 함수를 호출할 때, 엘릭서는 전달받은 인자 개수와 함수의 필수 파라미터 개숫(기본값이 정의되어 있지 ㅇ낳은 파라미터의 수)를 비교한다. 필수 파라미터 개수보다 적은 인자가 전달되면 함수에 매칭되지 않는다. 인자 개수와 필수 파라미터 개수가 같으면 인자들은 모두 필수 파라미터 자리에 들어가거, 나머지 파라미터들은 모두 기본값을 가진다. 인자가 필수 파라미터 개수보다 많으면 넘치는 수만큼 기본값을 왼쪽부터 덮어쓴다.

```exs
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a", "b")
Example.func("a", "b", "c")
Example.func("a", "b", "c", "d")
```

기본 파라미터를 정의한 함수는 패턴 매칭 시 신기한 동작을 보인다. 예를 들어보자.

```exs
def func(p1, p2 \\ 2, p3 \\ 3, p4) do
  IO.inspect [p1, p2, p3, p4]
end

def func(p1, p2) do
  IO.inspect [p1, p2]
end
```

코드를 컴파일하면 다음과 같은 오류가 출력된다.

```log
** (CompileError) default_params.exs:7: def func/2 conflicts with defaults from def func/4
```

오류가 출력되는 이유는 첫 번째 함수 정의(기본 파라미터가 있는 함수)가 인자 2개, 3개, 4개인 함수 호출에 모두 매칭되기 때문이다. 기억해야 할 특징이 하나 더 있다. 기본 파라미터를 가지는 함수에 여러 구현을 정의한 경우다.

```exs
defmodule DefaultParams1 do
  def func(p1, p2 \\ 123) do
    IO.inspect [p1, p2]
  end
  
  def func(p1, 99) do
    IO.puts "you said 99"
  end
end
```

코드를 컴파일하면 경고가 발생한다.

```log
warning: variable "p1" is unused (if the variable is not meant to be used, prefix it with an underscore)
  default_params1.exs:6: DefaultParams1.func/2

warning: def func/2 has multiple clauses and also declares default values. In such cases, the default values should be defined in a header. Instead of:

    def foo(:first_clause, b \\ :default) do ... end
    def foo(:second_clause, b) do ... end

one should write:

    def foo(a, b \\ :default)
    def foo(:first_clause, b) do ... end
    def foo(:second_clause, b) do ... end

  default_params1.exs:6

warning: this clause for func/2 cannot match because a previous clause at line 2 always matches
  default_params1.exs:6
```

이는 기본값으로 인해 발생하는 혼동을 줄이기 위한 의도적인 동작이다. 이때 기본 파라미터를 사용하려면 우선 기본값 파라미터가 있는 함수를 본문 없이 정의하고, 나머지 함수들은 기본값 없이 정의하면 된다. 이렇게 하면 처음에 정의한 기본값이 모든 함수 호출에 적용된다.

