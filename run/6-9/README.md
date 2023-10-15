# 모듈 속성

엘릭서의 각 모듈은 메타데이터를 가질 수 있다. 메타데이터를 이루는 각 항목을 **모듈 속성**이라 부르며, 각각은 이름을 가진다. 모듈 내에서는 속성 이름 앞에 `@`를 붙여서 해당 값에 접근한다. 속성에 값을 설정하려면 다음처럼 한다.

```exs
@name value
```

이 구문은 모듈의 최상위에서만 사용할 수 있다. 다시 말해, 함수 정의 내에서는 모듈 속성에 값을 설정할 수 없고, 값을 읽는 것만 가능하다.

```exs
defmodule Example do
  @author "Dave Thomas"
  def get_author do
    @author
  end
end

IO.puts "Example was written by #{Example.get_author}"
```

모듈 안에서 같은 속성의 값을 여러 번 설정할 수도 있다. 함수에서 모듈 속성에 접근하는 경우 속성의 값은 함수가 정의될 당시의 값으로 설정된다.

```exs
defmodule Example do
  @attr "one"
  def first, do: @attr
  @attr "two"
  def second, do: @attr
end

IO.puts "#{Example.second} #{Example.first}" # => two one
```

모듈 속성은 일반 변수와는 다르다. 많은 개바라가 자바나 루비의 상수처럼 사용하지만 가급적 설정과 메타데이터 용도로만 사용하기를 권장한다.