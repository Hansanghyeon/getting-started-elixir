# 맵, 키워드 리스트, 집합, 구조체

- 딕셔너리 방식 자료형
- 패턴 매칭 이용하기, 맵 수정하기
- 구조체
- 중첩된 자료구조

딕셔너리는 키와 값을 연결해 데이터를 저장하는 자료형을 말한다. 패턴 매칭에서 딕셔너리 타입을 사용하는 방법과 데이터를 수정하는 방법을 다룬다. 이어서 정해진 구조를 가진 특수한 맵인 구조체struct를 알아보고, 마지막으로는 중첩된 자료구조(이를테면 맵 안에 있는 맵)에서 필드를 수정하는 방법을 찾아본다.

본격적으로 시작하기 전에 생각해볼 것이 한가지 있다. 바로 '여러 딕셔너리 방식 자료 중에서 무서을, 어떤 기준으로 선택해야 하는가? 이다.

## 무엇을 써야 할까?

딕셔너리 방식 자료형이 필요할 떄는 다음 순서대로 스스로에게 질문해보자.

| 질문 | 사용할 자료형 |
| ---- | ------------- |
| 내용을 기준으로 패턴 매칭을 하고 싶은가? | 맵 |
| (예를 들어 `:name`이라는 키가 있는 경우를 패턴 매칭하고 싶은가?) |  |
| 같은 키로 여러 항목을 저장해야 하는가? | 키워드 리스트 |
| 요소들의 순서가 보장되어야 하는가? | 키워드 리스트 |
| 필드가 정해져 있나?(즉, 데이터 구조가 항상 동일한가?) | 구조체 |
| 어느 것도 해당하지 않는 경우 | 맵 |

## 키워드 리스트

키워드 리스트는 일반적으로 함수에 옵션을 전달할 때 사용한다.

접근 연산자인 `keylist[key]`문법을 사용해 값에 쉽게 접근할 수 있다. 또한 Keyword와 Enum 모듈의 모든 함수를 사용할 수 있다.

## 맵

맵은 랜덤 엑세스가 가능한 키-값 자료구조로, 크기와 관계없이 좋은 성능을 낸다. `Map` 모듈의 API를 사용할 수 있다.

## 패턴 매칭하기, 맵 수정

맵을 다룰때 가장 많이 묻게되는 질문은 바로 '특정 키(떄로는 특정 값까지도)가 존재하는가?'이다. 예를 들어 다음과 같은 맵이 있다고 하자.

```
person = %{ name: "Dave", height: 1.88 }
```

첫 번째 패턴 매칭에서 맵의 구조를 분해해 `:name`에 연결된 값을 추철한 데 주목하자. 이러한 동작은 다양하게 응용할 수 있다. 예를 하나 들어보자. for문은 컬렉션을 순회하며 원하는 값을 필터링할 수 있게 해준다. 다음 예제에서는 for를 이용해 여러 사람의 데이터를 순회하며, 항목을 필터링하는 데 필요한 height 값을 추철하기 위해 구조 분해를 사용한다.

```exs
people = [
  %{ name: "Grumpy", height: 1.24 },
  %{ name: "Dave", height: 1.88 },
  %{ name: "Dopey", height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy", height: 1.28 },
]

IO.inspect for person = %{ height: height } <- people, height > 1.5, do: person
```

앞의 코드에서는 for 컴프리헨션 문에 people(맵의 리스트)을 입력했다. 이 리스트의 각 요소(맵 전체)가 person에 차례로 바인딩되고, 그 안에서 신장 값이 height로 바인딩되었다. 그 중에서 신장이 1.5를 넘는 사람만 필터링해 do 블록을 통해 반환되므로 전체 for문은 키가 큰 사람 리스트를 반환하고, 그것이 IO.inspect를 통해 출력되었다.

이때 패턴 매칭은 앞서 본 다른 패턴 매칭과 같은 원리로 이루어지며, 이러한 맵의 특성은 cond 표현식이나 함수의 정의부에서 매칭은 물론이고 패턴을 사용하는 모든 곳에서 사용할 수 있다.

```exs
defmodule HotelRoom do
  def book(%{name: name, height: height})
  when height > 1.9 do
    IO.puts "Need extra-long bed for #{name}"
  end

  def book(%{name: name, height: height})
  when height < 1.3 do
    IO.puts "Need low shower controls for #{name}"
  end

  def book(person) do
    IO.puts "Need regular bed for #{person.name}"
  end
end

people |> Enum.each(&HotelRoom.book/1)
# Need low shower controls for Grumpy
# Need regular bed for Dave
# Need regular bed for Dopey
# Need extra-long bed for Shaquille
# Need low shower controls for Sneezy
```

### 패턴 매칭은 키를 바인딩하지 않는다

패턴 매칭을 이용하더라도 키 자체를 변수에 바인딩할 수는 없다. 예를 들어 다음처럼 쓸 수는 있다.

```sh
iex> %{ 2 => state } = %{ 1 => :ok, 2 => :error }
%{1 => :ok, 2 => :error}
iex> state
:error
```

하지만 다음처럼은 사용 할 수 없다.

```sh
iex> %{ item => :ok } = %{ 1 => :ok, 2 => :error }
error: cannot use variable item as map key inside a pattern. Map keys in patterns can only be literals (such as atoms, strings, tuples, and the like) or an existing variable matched with the pin operator (such as ^some_var)
  iex:1

** (CompileError) cannot compile code (errors have been logged)
```

### 변수에 저장된 키로는 매칭할 수 있다.

기본적인 패턴 매칭을 다루면서 핀 연산자의 쓰임도 살펴봤다. 핀 연산자는 매칭의 좌변(패턴)에 변수가 있을 떄 변수의 값을 매칭에 사용하도록 한다. 맵의 키에 대해서도 핀 연산자를 사용할 수 있다.

```sh
iex> data = %{ name: "Dave", state: "TX", likes: "Elixir" }
iex> for key <- [:name, :likes] do
...> %{ ^key => value } = data
...> value
...> end
["Dave", "Elixir"]
```

## 맵 수정하기

맵 전체를 순회하지 않더라도 맵에 새 키-값 쌍을 추가하거나 기존 값을 수정할 수 있다. 하지만 엘릭서의 다른 값들과 마찬가지로 맵 역시 불변 데이터이므로, 맵을 수정해 얻는 결과는 새로운 맵이 된다. 맵은 다음과 같은 방법으로 간단하게 수정할 수 있다.

```exs
new_map = %{ old_map | key => value, ... }
```

이 문법을 이용하면 기존 맵의 복사본에 파이프 기호 뒤에 있는 항목들을 갱신한 맵이 반환된다.

```sh
iex> m = %{ a: 1, b: 2, c: 3}
%{ a: 1, b: 2, c: 3}
iex> m1 = %{ m | b: "two", c: "three" }
%{ a: 1, b: "two", c: "three" }
iex> m2 = %{ m1 | a: "one" }
%{ a: "one", b: "two", c: "three" }
```

하지만 이 문법은 원래 맵에 있던 항목을 수정하기 위한 것으로, 새항목을 추가해주지는 않는다. 새 항목을 추가하려면 `Map.put_new/3` 함수를 사용해야 한다.

## 구조체

엘릭서는 `%{...}`문법을 맵으로 인식한다. 하지만 그 이상, 특히 맵으로 어떤 작업을 하려고 하는지, 특정 키만 허용해야 하는지, 일부 키에 기본값이 있어야 하는지 등은 알지 못한다. 일반적으로 맵을 사용할 때는 이런 것들을 굳이 신경 쓰지 않아도 된다. 하지만 타입ㅇ ㅣ있는 맵이 필요하다면 어떻게 해야 할까? 필드가 정해져 있고, 그 필드들에 기본값이 있으며, 저장된 데이터뿐 아니라 맵의 타입 자체로도 패턴 매칭을하고 싶다면? 바로 **구조체**를 사용할 때다.

구조체는 사실 맵의 어떤 제한된 형태로 모듈로 감싼 것에 지나지 않는다. 타입에 상관없이 모든 값을 키로 사용할 수 있는 맵과 달리 구조체의 키는 항상 아톰이어야 한다. 또한 모듈의 이름이 그 구조체의 타입이 된다. 모듈 내에서 defstruct 매크로를 사용해 구조체의 필드를 정의할 수 있다.

```sh
iex defstruct.exs
Erlang/OTP 26 [erts-14.0.2] [source] [64-bit] [smp:32:8] [ds:32:8:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.15.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> s1 = %Subscriber{} 
%Subscriber{name: "", paid: false, over_18: false}
iex(2)> s2 = %Subscriber{ name: "Dave" } 
%Subscriber{name: "Dave", paid: false, over_18: false}
iex(3)> s3 = %Subscriber{ name: "Mary", over_18: true, paid: true} 
%Subscriber{name: "Mary", paid: true, over_18: true}
```

구조체는 맵을 만들 떄와 똑같은 문법으로 만든다. `%`와 `{` 사이에 모듈의 이름을 추가로 넣기만 하면 된다. 구조체 내의 필드에 접근할 떄는 온점(.)이나 패턴 매칭을 사용한다.