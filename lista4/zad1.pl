possible_expression([X], X, X).
possible_expression(List, _, Expression) :-
    append(List1, List2, List),
    List1 \= [],
    List2 \= [],
    possible_expression(List1, Value1, Expression1),
    possible_expression(List2, Value2, Expression2),
    (   Expression1 = Value1,
        Expression2 = Value2,
        member(Op, ['+', '-', '*', '/']),
        Expression = expr(Op, Expression1, Expression2)
    ;   Value1 \= Expression1,
        Value2 \= Expression2,
        member(Op, ['+', '-', '*', '/']),
        Expression = expr(Op, Expression1, Expression2)
    ).

evaluate_expression(expr('+', Left, Right), Value) :-
    evaluate_expression(Left, LeftValue),
    evaluate_expression(Right, RightValue),
    Value is LeftValue + RightValue.
evaluate_expression(expr('-', Left, Right), Value) :-
    evaluate_expression(Left, LeftValue),
    evaluate_expression(Right, RightValue),
    Value is LeftValue - RightValue.
evaluate_expression(expr('*', Left, Right), Value) :-
    evaluate_expression(Left, LeftValue),
    evaluate_expression(Right, RightValue),
    Value is LeftValue * RightValue.
evaluate_expression(expr('/', Left, Right), Value) :-
    evaluate_expression(Left, LeftValue),
    evaluate_expression(Right, RightValue),
    RightValue =\= 0,
    Value is LeftValue / RightValue.

evaluate_expression(Number, Number) :- number(Number).

normalize_expression(expr(Op, Left, Right), NormalExpr) :-
    normalize_expression(Left, LeftExpr),
    normalize_expression(Right, RightExpr),
    atomic_list_concat(['(', LeftExpr, Op, RightExpr, ')'], NormalExpr).
normalize_expression(Number, Number) :- number(Number).

get_expressions(List, Value, Expression, NormalExpression) :-
    possible_expression(List, Value, Expression),
    evaluate_expression(Expression, Value),
    normalize_expression(Expression, NormalExpression).

expression(List, Value, Expression) :-
    get_expressions(List, Value, _, Expression).
