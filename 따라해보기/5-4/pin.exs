# 패턴 매칭에서 살펴봤듯, 핀 연산자(^)는 패턴 안에 있는 변수에 변수의 현재 값을 사용하도록 해준다.
# 함수 파라미터에도 이 연산자를 사용할 수 있다.

defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end
end

mr_vlim = Greeter.for("Mr Vlim", "Hello")

# 여기서 Greeter.for 함수는 두 개의 구현을 가진 함수를 반환한다.
# 내부 함수를 호출할 떄의 파라미터가 외부 함수인 for에 전달된 name의 값과 같을 때 첫 번째 구현에 매치된다.

IO.puts mr_vlim.("Mr Vlim") # => "Hello Mr Vlim"
IO.puts mr_vlim.("Dave") # => "I don't know you"
