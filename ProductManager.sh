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
	
