# 얼랭함수를 이용해서, 소수를 소수점 아래 두자리까지 문자열로 바꾸는 함수
defmodule Test do
  def to_decimal_string(number) do
    :Decimal.to_string(number, digits: 2)
  end
end

IO.puts Test.to_decimal_string(1.2345)
