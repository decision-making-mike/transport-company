-- Are we profitable?

with
    total_expenses as (
        select sum (amount) as amount
        from fuel_expenses
    ),
    total_revenue as (
        select sum (amount) as amount
        from made_payments
    ),
    total_profit as (
        select (total_revenue.amount - total_expenses.amount) as amount
        from
            total_revenue,
            total_expenses
    )
select total_profit.amount > 0 as "Are we profitable?"
from total_profit
;
