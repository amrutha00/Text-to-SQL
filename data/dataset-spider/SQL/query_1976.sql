SELECT T1.coupon_amount FROM Discount_Coupons AS T1 JOIN customers AS T2 ON T1.coupon_id  =  T2.coupon_id WHERE T2.good_or_bad_customer  =  'good' INTERSECT SELECT T1.coupon_amount FROM Discount_Coupons AS T1 JOIN customers AS T2 ON T1.coupon_id  =  T2.coupon_id WHERE T2.good_or_bad_customer  =  'bad'