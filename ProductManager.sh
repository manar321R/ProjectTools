#!/bin/bash
DATA_FILE="Stores.txt"


#manar
compare_prices() {
	#ask the user to enter the product name
	echo "Enter the product name: "
	#read the product name input and store it in the variable 'product'
	read product
	
	#display the product name being searched
	echo "Searching for: $product"
	
	#search for the product in the data file (case-insensitive)
	#extract the third field (price), sort the prices in ascending order
	#and get the lowest one
	lowest=$(grep -i "$product" "$DATA_FILE" | awk -F',' '{print $3}' | sort -n | head -1)
	
	#if no product is found (lowest is empty), display a message and exit the function
	if [ -z "$lowest" ]; then
		echo "Product not found!"
		return
	fi

	#display the lowest price found
	echo "Lowest price: $lowest"
	
	echo "Available at:"
	#show the store that offer the product at the lowest price
	grep -i "$product" "$DATA_FILE" | awk -F',' -v low="$lowest" '$3 == low {print $1 " - " $2 " - $" $3 }'
}




#amareej
manage_data() {
# Function to manage data
  while true; do
# Loop keeps running until user chooses to exit
  echo ""
  echo "==== Product/Store Manager ====" # Menu title
  echo "1. View all entries" # Option to show all data
  echo "2. Add new entry" # Option to add data
  echo "3. Delete entry" # Option to delete data
  echo "4. Back to main menu" # Go back to main menu
  read -p "Choose an option: " option # Ask user for input

  case $option in
  1)
# If user chooses 1, show the data
  echo "Current Data:"
  cat "$DATA_FILE"
  ;;
  2)
# If user chooses 2, add new data
  read -p "Enter Store Name: " store # Get store name
  read -p "Enter Product Name: " product # Get product name
  read -p "Enter Price: " price # Get price
  echo "$store,$product,$price" >> "$DATA_FILE" # Save to file
  echo "Entry added!" # Confirm added
  ;;
  3)
# If user chooses 3, delete product
  read -p "Enter Product Name to delete: " product # Get product name
  sed -i "/$product/d" "$DATA_FILE" # Delete lines with product
  echo "Entries for $product deleted!" # Confirm deleted
  ;;
  4)
# If user chooses 4, exit the loop
  break
  ;;
  *)
# If wrong input, show error
  echo "Invalid option!"
  ;;
  esac
done
}




#refal
show_statistics() {
# Print header for statistics
echo "========= Statistics ========"
# Print total number of entries
    echo "- Total number of entries:"
# Count the number of lines in the data file    
    wc -l < "$DATA_FILE"
# Print unique products 
    echo "- Unique products:"
# Count unique users by extracting the second field, sorting, and removing duplicates 
    cut -d',' -f2 "$DATA_FILE" | sort | uniq | wc -l
# Print unique stores
    echo "- Unique stores:"
# Count unique stores by extracting the first field
    cut -d',' -f1 "$DATA_FILE" | sort | uniq | wc -l
# Print average price per product 
    echo "- Average price per product:"
# Calculate average price for each product using awk    
    cut -d',' -f2,3 "$DATA_FILE" | \
    awk -F',' '{sum[$1]+=$2; count[$1]++} END {for (p in sum) print p ": $" sum[p]/count[p]}' | sort
# Print cheapest product entry
    echo "- Cheapest product entry:"
# Sort by price and display the entry with the lowest price   
    sort -t',' -k3 -n "$DATA_FILE" | head -1
# Print most expensive product entry
    echo "- Most expensive product entry:"
# Sort by price in descending order and display the entry with the highest price    
    sort -t',' -k3 -n "$DATA_FILE" | tail -1
}








#start an infinite loop to display the main menu continuously
while true; do
	echo ""
	echo "------------- Product Price Comparator -------------"
	
	#display menu options to the user
	echo "1. Compare product prices"
	echo "2. Manage product/stores"
	echo "3. View statistics"
	echo "4. Exit"
	
	#ask the user to choose an option
	echo "Choose an option: "
	read choice

	#handle the user choice using a csae statement
	case $choice in
		1) compare_prices ;;	#call function to compare product prices
		2) manage_data ;;	#call function to manage product/store data
		3) show_statistics ;;	#call function to display statistics
		4) echo "Goodbye"; exit 0 ;;	#exit option
		*) echo "Invalid choice." ;;	#handle invalid input
	esac
done
	
