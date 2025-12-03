port=3010
num=2000
conn=100

BASE="http://10.198.138.212:${port}"

curl -s "${BASE}/admin/menu.html?action=add&name=yusanseul&price=12000" > /dev/null || true
curl -s "${BASE}/admin/menu.html?action=add&name=jjampong&price=9000" > /dev/null || true
curl -s "${BASE}/admin/table.html?action=add&tid=T001" > /dev/null || true

curl -s "${BASE}/customer/order.html?action=add&tid=T001&menu=jjampong&num=2" > /dev/null || true
curl -s "${BASE}/customer/order.html?action=add&tid=T001&menu=yusanseul&num=1" > /dev/null || true

ab -n $num -c $conn "${BASE}/customer/order.html?action=stat&tid=T001"
ab -n $num -c $conn "${BASE}/admin/status.html"
ab -n $num -c $conn "${BASE}/admin/table.html?action=stat"
ab -n $num -c $conn "${BASE}/admin/menu.html?action=stat"