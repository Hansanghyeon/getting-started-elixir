# 중첩된 딕셔너리 구조

여러 딕셔너리 타입 자료형을 사용해서 키와 값을 연결할 수 있는데, 딕셔너리 타입 역시 그 값이 될 수 있다. 예를 들어 버그 제보 시스템이 있다고 해보자. 버그 제보를 자료구조로 표현하면 다음과 같이 나타낼 수 있다.

```exs
defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end
```

간단한 버그 제고 구조체를 하나 생성해보자.

```
iex> report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
```

구조체 owner 필드의 값은 Customer라는 다른 구조체다. 이렇게 중첩된 필드에도 온점(.)을 통해 접근할 수 있다.

```
iex(2)> report.owner.company 
"Pragmatic"
```

그런데 버그 제보자의 회사명이 틀렸다고 한다. Pragmatic이 아니라 PragProg여야 한다는 것이다. 한번 고쳐보자.

```
report = %BugReport{ report | owner: %Customer{ report. owner | company: "PragProg" }}
```

되긴 했지만, 코드가 참 못났다. 회사명 하나를 바꾸기 위해 owner 필드를 통째로 새 구조체로 바꿨고 코드는 길고 읽기 어려워졌다. 이런 방식을 사용하면 실수할 가능성도 높아진다. 다행스럽게도 엘릭서에는 중첩된 딕셔너리에 쉽게 접근하도록 해주는 함수들이 있다. 그중 하나인 `put_in`은 중첩된 자료구조 내에 값을 저장해준다.

```
iex(5)> put_in(report.owner.company, "PP") 
%BugReport{
  owner: %Customer{name: "Dave", company: "PP"},
  details: "broken",
  severity: 1
}
```

이 함수가 무슨 마법을 부리는 것은 아니다. 사실 그저 우리가 써야 했던 길고 긴 코드를 대신 만들어내는 매크로일 뿐이다. `update_in` 함수는 자료구조 내의 특정 값에 함수를 적용한다.

```
iex(6)> update_in(report.owner.name, &("Mr. " <>  &1))
%BugReport{
  owner: %Customer{name: "Mr. Dave", company: "PragProg"},
  details: "broken",
  severity: 1
}
```

`get_in`과 `get_and_update_in`이라는 함수도 있다. IEx로 제공되는 문서에서 필요한 정보를 모두 얻을 수 있다. 두 함수를 사용하면 중첩된 자료구조에서 값을 가져올 수 있다.

## 구조체가 아닌 경우의 데이터 접근

일반적인 맵이나 키워드 리스트에서 이 함수들을 사용하는 경우 아톰 키를 사용할 수도 있다.

```
iex(7)> report = %{ owner: %{name: "Dave", company: "Pragmatic" }, serverity: 1}
%{owner: %{name: "Dave", company: "Pragmatic"}, serverity: 1}
iex(8)> put_in(report[:owner][:company], "PragProg") 
%{owner: %{name: "Dave", company: "PragProg"}, serverity: 1}
iex(9)> update_in(report[:owner][:name], &("Mr. " <> &1)) 
%{owner: %{name: "Mr. Dave", company: "Pragmatic"}, serverity: 1}
```