# 문자열 내에 표현식을 삽입하는 방법은 #{...}을 사용해 표현식을 넣으면, 코드가 계산되어 그 실행 결과로 문자열이 대체된다.
handle_open = fn
  {:ok, file} -> "First line: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open(File.open("Rakefile"))      # 존재하는 파일을 연다.
IO.puts handle_open(File.open("nonexistent"))   # 존재하지 않는 파일을 연다.

# ** (CompileError) 따라해보기/5-2/handle_open.exs:7: undefined function handle_open/1 (there is no such import)
# 의심가는부분 터미널에서 이렇게 파일을 읽어올떄 해당 파일의 위치를 알 수 없으니까 에러가 나지 않을까?