#!/bin/bash
DATA_FILE="stores.txt"


#manar
compare_prices() {
	echo "Enter the product name: "
	read product
	echo "Searching for: $product"
	lowest=$(grep -i "$product" "$DATA_FILE" | awk -F',' '{print $3}' | sort -n | head -1)
	
	if [ -z "$lowest" ]; then
		echo "Product not found!"
		return
	fi

	echo "Lowest price: $lowest"
	echo "Available at:"
	grep -i "$product" "$DATA_FILE" | awk -F',' -v low="$lowest" '$3 == low {print $1 " - " $2 " - $" $3 }'
}




#amareej
manage_data() {
}




#refal
show_statistics() {
echo "========= Statistics ========"
    echo "- Total number of entries:"
    wc -l < "$DATA_FILE"

    echo "- Unique products:"
    cut -d',' -f2 "$DATA_FILE" | sort | uniq | wc -l

    echo "- Unique stores:"
    cut -d',' -f1 "$DATA_FILE" | sort | uniq | wc -l

    echo "- Average price per product:"
    cut -d',' -f2,3 "$DATA_FILE" | \
    awk -F',' '{sum[$1]+=$2; count[$1]++} END {for (p in sum) print p ": $" sum[p]/count[p]}' | sort

    echo "- Cheapest product entry:"
    sort -t',' -k3 -n "$DATA_FILE" | head -1

    echo "- Most expensive product entry:"
    sort -t',' -k3 -n "$DATA_FILE" | tail -1
}





while true; do
	echo ""
	echo "------------- Product Price Comparator -------------"
	echo "1. Compare product prices"
	echo "2. Manage product/stores"
	echo "3. View statistics"
	echo "4. Exit"
	echo "Choose an option: "
	read choice

	case $choice in
		1) compare_prices ;;
		2) manage_data ;;
		3) show_statistics ;;
		4) echo "Goodbye"; exit 0 ;;
		*) echo "Invalid choice." ;;
	esac
done
	
