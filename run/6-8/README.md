# 모듈

모듈은 당신이 정의한 것들에 네임스페이스를 만들어준다. 6.1절에서 기명함수를 한데 묶을 떄 사용한 적이 있다. 모듈은 함수만이 아니라 매크로, 구조체, 프로토콜, 심지어는 다른 모듈까지도 포함할 수 있다.

모듈 안에 정의된 함수를 모듈 밖에서 참조하려면 함수명 앞에 모듈 이름을 붙여야 한다. 같은 모듈 안에 있는 함수를 호출할 떄는 붙이지 않아도 된다. 예를 들면 다음과 같다.

```exs
defmodule Mod do
  def func1 do
    IO.puts "in func1"
  end
  def func2 do
    func1
    IO.puts "in func2"
  end
end

Mod.func1
Mod.func2
```

func1과 func2는 같은 모듈 안에 있으므로 func2에서는 func1을 모듈명을 지정하지 않고 바로 호출한다. 모듈 밖에서는 `Mod.func1`과 같이 모듈명까지 지정해야 한다. 다른 프로그래밍 언어에서와 마찬가지로 엘릭서에서도 코드의 가독성과 재사용성을 높이기 위해 모듈을 중첩해 정의할 수 있다. 그런 면에서 모든 개발자는 라이브러리를 만들고 있는지도 모른다.

중첩된 모듈 안의 함수에 외부에서 접근하려면 모듈 이름을 모두 적어주어야 한다. 어떤 모듈에서 내부 모듈에 접근할 떄는 모듈 이름을 모두 적어도 되고, 내부 모듈의 이름만 적어도 괜찮다.

```exs
defmoulde Outer do
  defmodule Inner do
    def inner_func do
    end
  end

  def outer_func do
    Inner.inner_func
  end
end

Outer.outer_func
Outer.Inner.inner_func
```

사실 엘릭서에서의 모듈 중첩은 일종의 허상이다. 모든 모듈은 최상위에 정의된다. 코드상으로 모듈을 중첩해서 정의하더라도 엘릭서는 외부 모듈명을 내부 모듈명 앞에 온점(.)으로 연결해 모듈명으로 삼는다. 즉, 중첩된 모듈을 직접 정의할 수도 있다는 뜻이다.

```exs
defmodule Mix.Task.Doctest do
  def run do
  end
end

Mix.Tasks.Doctest.run
```

이는 모듈 `Mix`와 `Mix.Tasks.Doctest` 사이에 특별한 관계가 없음을 의미하기도 한다.

## 모듈 지시자

엘릭서에서는 다른 모듈을 사용할 때 세 가지 지시자를 사용한다. 셋 모두 프로그램이 시작하면 함께 실행되며 **문법적 스코프**를 가진다. 지시자의 효과는 지시자를 만난 곳부터 코드를 감싸는 블록이 끝날 때 까지 유효하다. 즉 지시자가 모듈 내에 정의했다면 해당 모듈 정의가 끝날 때까지 사용할 수 있으며, 함수 내에 정의했다면 해당 함수 정의가 끝날 떄까지 유효하다.

### import 지시자

import는 다른 모듈의 함수와 매크로를 현재 스코프로 가져온다. 코드에서 특정 모듈을 자주 사용할 때 import를 사용해서 가져오면 모듈명을 반복하는 수고를 덜 수 있다. 예를 들어 List 모듈의 faltten 함수를 임포트하면 모듈명을 지정하지 않고도 faltten 함수를 호출할 수 있다.

```exs
defmodule Example do
  def func1 do
    List.faltten [1, [2,3], 4]
  end
  def func2 do
    import List, only: [flatten: 1]
    flatten [5, [6,7], 8]
  end
end
```

import의 전체 문법은 다음과 같다

```exs
import Module [, only:|except: ]
```

두 번쨰 파라미터는 필수는 아니지만, 특정 함수나 매크로만을 가져오거나 제외하는 데 사용한다. `only:`나 `except:`뒤에 **함수명: 인자 수** 쌍의 리스트를 넣어주면 된다. 가능한 작은 스코프에서 import를 사용하고, `only:`를 이용해 필요한 함수만 임포트하기를 권장한다.

```exs
import List, only: [flatten: 1, duplicate: 2]
```

`only:`에 `:functions`나 `:macros` 아톰을 지정해 함수만, 혹은 매크로만 임포트할 수도 있다.

### alias 지시자

alias 지시자는 모듈에 별칭을 생성한다. 주목적은 타이핑할 수고를 줄이는 것이다.

```exs
defmodule Example do
  def compile_end_go(source) do
    alias My.Other.Module.Parser, as: Parser
    alias My.Other.Module.Runner, as: Runner
    source
    |> Parser.parse()
    |> Runner.execute()
  end
end
```

`as:` 파라미터는 기본적으로 모듈명의 마지막 부분으로 지정되므로 앞의 alias는 다음과 같이 줄여 쓸 수 있다.

```exs
alias My.Other.Module.Parser
alias My.Ohter.Module.Runner
```

더 줄여 쓸 수도 있다.

```exs
alias My.Other.Module.{Parser, Runner}
```

### require 지시자

require는 다른 모듈에 정의된 매크로를 호출하고자 할 때 사용한다. 코드가 컴파일될 때 다른 모듈의 매크로를 이용할 수 있음을 보장해준다.
