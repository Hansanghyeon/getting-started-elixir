# 모듈의 이름: 엘릭서, 얼랭, 아톰

엘릭서 모듈은 대체로 String이나 PhotoAlbum과 같은 이름을 가진다. 그리고 모듈 안에 정의된 함수는 String.length("abc")와 같은 식으로 호출한다. 사실 이 과정에서는 내부적으로 미묘한 일이 일어난다. 모듈 이름은 사실 하나의 아톰이다. 대문자로 시작하는 모듈 이름을 하나 쓰면 엘릭서는 이를 Elixir가 붙은 아톰으로 바꾼다. 예를 들어 IO 모듈은 Elixir.IO가 되며, Dog 모듈은 Elixir.Dog가 된다.

```sh
iex> is_atom IO
true
iex> to_string IO
"Elixir.IO"
iex> :"Elixir.IO" === IO
true
```

즉 모듈 안에 있는 함수를 호출하는 코드는 실제로는 아톰 뒤에 점을 하나 찍고 함수명을 이어붙인 형태다. 따라서 함수를 다음처럼 호출할 수도 있다.

```sh
iex> IO.puts 123
123
:ok
iex> :"Elixir.IO".puts 123
123
:ok
```

심지어는 다음처럼 할 수도 있다.

```sh
iex> my_io = IO
IO
iex> my_io.puts 123
123
:ok
```
