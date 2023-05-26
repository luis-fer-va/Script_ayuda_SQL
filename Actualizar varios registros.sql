update [sales_data_sample]
set STATUS=c.tbl1
from [sales_data_sample] v
join new_status c  on v.tbl2 = c.tbl1;
