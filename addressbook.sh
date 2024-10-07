#!/bin/bash

ADDRESS_BOOK_TXT="address_book.txt"

function add_contact() {
    echo "Enter contact information:"
    read -p "Name: " name
    read -p "Phone: " phone
    read -p "Email: " email

    echo "$name,$phone,$email" >> "$ADDRESS_BOOK_TXT"
    echo "Contact added successfully."
}

function remove_contact() {
    read -p "Enter name, phone, or email of the contact to remove: " search_term
    grep -iq "$search_term" "$ADDRESS_BOOK_TXT" && {
        sed -i "/$search_term/d" "$ADDRESS_BOOK_TXT"
        echo "Contact removed successfully."
    } || echo "No contact found matching '$search_term'."
}

function search_contacts() {
    read -p "Enter search term: " search_term
    grep -i "$search_term" "$ADDRESS_BOOK_TXT" | while IFS=',' read -r name phone email; do
        echo "Name: $name"
        echo "Phone: $phone"
        echo "Email: $email"
        echo "---"
    done
}

function help() {
    echo "Possible commands: "
    echo "add - Adds a new contact with name, phone, email"
    echo "search - Finds and prints a contact"
    echo "remove - Removes a contact"
}

case "$1" in
    add)
        add_contact
        ;;
    search)
        search_contacts
        ;;
    remove)
        remove_contact
        ;;
    *)
        echo "Wrong command"
        help
        ;;
esac