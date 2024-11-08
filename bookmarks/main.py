from bs4 import BeautifulSoup
import os

def load_bookmarks(file_path):
    """Load bookmarks from an HTML file."""
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as file:
            soup = BeautifulSoup(file, 'html.parser')
        print("Bookmarks loaded successfully.")
        return soup
    else:
        print("Bookmarks file not found.")
        return None

def save_bookmarks(file_path, soup):
    """Save bookmarks to an HTML file."""
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(str(soup))
    print("Bookmarks saved successfully.")

def list_bookmarks(soup):
    """List all bookmarks with index."""
    bookmarks = soup.find_all('a')
    for index, tag in enumerate(bookmarks, start=1):
        print(f"{index}. {tag.text}: {tag['href']}")

def edit_url(soup):
    """Edit a URL in the bookmarks."""
    bookmarks = soup.find_all('a')
    list_bookmarks(soup)
    
    try:
        choice = int(input("Enter the number of the bookmark to edit: "))
        if 1 <= choice <= len(bookmarks):
            tag = bookmarks[choice - 1]
            new_url = input(f"Enter the new URL for '{tag.text}': ")
            tag['href'] = new_url
            print(f"Updated '{tag.text}' to {new_url}")
        else:
            print("Invalid choice.")
    except ValueError:
        print("Please enter a valid number.")

def add_new_url(soup):
    """Add a new URL to the bookmarks."""
    new_url = input("Enter the URL: ")
    name = input("Enter the name of the bookmark: ")
    
    # Create a new 'a' tag with the URL and name
    new_tag = soup.new_tag("a", href=new_url)
    new_tag.string = name

    # Find the root element to append the new bookmark
    body = soup.find("body")
    if body:
        body.append(new_tag)
        body.append(soup.new_tag("br"))  # Add a line break for neat formatting
        print(f"Added new bookmark '{name}' with URL: {new_url}")
    else:
        print("Error: Could not find a location to add the bookmark in the file.")

# Update the main function to include the new option for adding a bookmark
def main():
    file_path = 'bookmarks.html'  # Path to your bookmarks HTML file
    soup = load_bookmarks(file_path)

    if soup:
        while True:
            print("\nMenu:")
            print("1. List bookmarks")
            print("2. Edit a bookmark URL")
            print("3. Add a new bookmark URL")  # New option for adding a bookmark
            print("4. Save and exit")

            choice = input("Choose an option (1-4): ")
            if choice == '1':
                list_bookmarks(soup)
            elif choice == '2':
                edit_url(soup)
            elif choice == '3':
                add_new_url(soup)  # Call the new add URL function
            elif choice == '4':
                save_bookmarks(file_path, soup)
                print("Exiting...")
                break
            else:
                print("Invalid choice. Please choose 1, 2, 3, or 4.")

if __name__ == "__main__":
    main()
