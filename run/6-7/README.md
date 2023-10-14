# 끝내주는 파이프 연산자: `|>`

마지막까지 아껴둔, 함수에서 가장 맛있는 부분을 소개한다. 지금까지 이런 식의 코드를 많이 봐왔을 것이다.

```
people = DB.find_customers
orders = Orders.for_customers(people)
tax    = sales_tax(orders, 2018)
filing = prepare_filing(tax)
```

먹고 살기 위해 하는 프로그래밍이다. 이건 그나마 나은데, 다른 방식으로 쓰면 다음처럼 된다.

```
filing = prepare_filing(sales_tax(Orders.for_customers(DB.find_customers), 2018))
```
어린아이들에게 채소를 먹일 떄나 쓸 만한 코드다. 읽기도 힘들뿐더러 연산이 이루어지는 순서를 이해하려면 함수의 안쪽부터 거슬러 나와야 한다. 엘릭서에서는 더 나은 방법을 사용한다.

```exs
filing = DB.find_customers
  |> Orders.for_customers
  |> sales_tax(2018)
  |> prepare_filing
```

`|>` 연산자는 왼쪽 표현식의 결과를 받아서 오른쪽에 있는 함수의 첫 번쨰 파라미터에 넣는다. 이함수가 만환하는 주문 리스트는 `sales_tax`의 첫 번째 인자가 되며, 2018은 두 번째 인자가 된다. 기본적으로 `val |> f(a, b)`는 `f(val, a, b)`와 같다.

```exs
list
|> sales_tax(2018)
|> prepare_filing
```

이 코드는 `prepare_filing(sales_tax(list, 2018))`과 같다.

앞서 본 예제에서 식을 이루는 가가 부분을 줄을 나누어 썻는데, 다음처럼 한 줄에 이어 쓸 수도있다. 두 방법 모두 엘릭서에서 유효한 문법이다.

```sh
iex > (1..10) |> Enum.map(&(&1*&1)) |> Enum.filter(&(&1 < 40))
[1, 4, 9, 16, 25, 36]
```

함수의 인자를 전달할 때 괄호를 써야 함에 유의하자. 그렇지 않으면 함수를 축약할 떄 쓰는 `&`와 파이프 연산자가 충돌한다.

```
WARING_ 다시 한번 강조한다. 파이프라인 안에 있는 함수 호출에서는 파라미터에 항상 괄호를 씌워야 한다.
```

파이프 연산자가 좋은 점은 코드를 명세와 닮은 꼴로 쓸 수 있다는 점이다. 앞서 살펴본 매출-세금 예제에서는 명세서에 이런 식으로 쓰여 있을 것이다.

- 고객 명단을 구한다.
- 고객들이 구문한 내역을 구한다.
- 주문 내역에 대한 세금을 계산한다.
- 세금을 신고한다.

이 명세를 코드로 바꾸려면 항목 사이이에 `|>`를 넣고 각각을 함수로 구현하기만 하면 된다.

```exs
DB.find_customers
|> Orders.for_customers
|> sales_tax(2018)
|> prepare_filing
```

프로그래밍은 데이터를 변형하는 작업이며 `|>` 연산자는 변형을 명시적으로 하게 해준다. 이제 이 책의 원서에서 언어를 한 마디로 소개하는 `Function |> Concurrent |> Pragmatic |> Fun`의 의미를 이해할 수 있을 것이다.