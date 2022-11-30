INSERT OVERWRITE TABLE history
select res.restaurant_name, trans.order_menu, sum(trans.odr_prc) as spend_amount 
from restaurant as res
join transactions_cln as trans
on res.restaurant_name = trans.restaurant_name