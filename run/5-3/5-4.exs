# 문자열을 받는 prefix 함수를 만들어보자. 이 함수는 다른 문자열을 받는 새로운 함수를 반환하고, 두 번째 함수를 호출하면 첫 번째 문자열과 두 번째 문자열을 공백으로이은 문자열을 반환해야 한다.
# msr = prefix.("Mrs")
# mrs.("Smith")
# "Mrs Smith"
# prefix.("Elixir").("Rocks")

prefix = fn prefix -> (fn str -> "#{prefix} #{str}" end) end
mrs = prefix.("Elixir")
IO.puts mrs.("Rocks")
