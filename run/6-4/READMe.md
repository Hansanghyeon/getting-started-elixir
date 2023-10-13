# 가드 조건절

지금까지 알아봤듯 엘릭서에서는 전달받은 인자를 이용한 패턴 매칭을 통해 어떤 함수를 실행할지를 결정한다. 그런데 인자의 타입이나 조건에 따라 실행될 함수를 결정하고 싶다면 어떻게 해야 할까? 이때 **가드 조건절(guard clause)**을 사용한다. 가드 조건절은 when 키워드를 사용해 함수 정의부에 붙일 수 있는 명제다. 패턴 매칭을 수행할 때 우선 파라미터를 이용한 전통적인 매칭을 수행하고, when이 붙어 있으면 조건을 검사한 뒤 참이어야만 함수를 실행한다.

```exs
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end
end
```

앞에서 팩토리얼을 구현한 예제를 다시 한번 보자.

```exs
defmodule Factorial do
  def of(0), do: 1
  def of(n), do: n * of(n - 1)
end
```

인자로 음수를 넣으면 무한 루프에 빠진다. n의 값이 아무리 줄이더라도 0에는 도달하지 못하기 때문이다. 즉, 무한 루프에 들어가지 않도록 가드를 추가하는 편이 좋겠다.

```exs
defmodule Factorial do
  def of(0), do: 1
  def of(n) when is_integer(n) and n > 0 do
    n * of(n - 1)
  end
end
```

이렇게 구현된 함수에 음수 인자를 넣으면 어디에도 매칭되지 않을 것이다.
파라미터는 정수여야 하므로 타입에 대한 가드도 추가했다.


## 가드 조건절에 사용할 수 있는 것들

가드 조건절에는 엘릭서 표현식 중 일부만 사용할 수 있다. 다음 목록은 엘릭서 공식 가이드에 소개된 내용을 정리한 것이다.

### 비교 연산자

`==` `!=` `===` `!==` `>` `<` `<=` `>=`

### 이진 및 부정 연산자

`or` `and` `not` (!, ||, &&는 허용되지 않음에 유의)

### 산술 연산자

`+` `-` `*` `/`

### 연결 연산자

`<>` `++` (왼쪽이 리터럴일 때만 가능)

### in 연산자

컬렉션 또는 범위 안에 값이 포함되는지를 확인한다.

### 타입 확인 함수

다음 함수는 인자가 특정 타입일 때 true를 반환한다. 자세한 내용은 엘릭서 공식 문서에서 확인하자.

- is_atom
- is_binary
- is_bitstring
- is_boolean
- is_exception
- is_float
- is_function
- is_integer
- is_list
- is_map
- is_map_key
- is_nil
- is_number
- is_pid
- is_port
- is_reference
- is_struct
- is_tuple

### 기타 함수들

다음 내장 함수는 true, false가 아닌 값을 반환한다.

- abs(number)
- bianry_part(binary, start, length)
- bit_size(bitstring)
- byte_size(bitstring)
- ceil(number)
- div(number, number)
- elem(tuple, n)
- float(term)
- floor(number)
- hd(list)
- length(list)
- map_size(map)
- node()
- node(pid|ref|port)
- rem(number, number)
- tl(list)
- self()
- trunc(number)
- tuple_size(tuple)