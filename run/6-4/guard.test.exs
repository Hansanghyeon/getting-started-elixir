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

Guard.what_is(99)
Guard.what_is(:cat)
Guard.what_is([1,2,3])

# IO.puts라서 return하는 값이 없어 실행시 리턴값은 모두 `:ok`를 리턴한다.

# ExUnit.start

# defmodule Ex64Test do
#   use ExUnit.Case

#   test "99" do
#     assert Guard.what_is(99) == "99 is a number"
#   end
#   test ":cat" do
#     assert Guard.what_is(:cat) == "cat is a atom"
#   end
#   test "[1,2,3]" do
#     assert Guard.what_is([1,2,3]) == {:ok, "[1,2,3] is a list"}
#   end
# end
