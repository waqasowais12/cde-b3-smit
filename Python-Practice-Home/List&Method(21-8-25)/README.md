## LIST & It's Methods

### 1. List method append()

- It will add the value at the end of the list.
- append added only single value in the list.

![append](Snaps/append.png)

### 2. List method count()
- It will count the "x" elements in the list eg. (city.count("karachi") --> the answer will depend on how many times karachi appears in a list)

![count](Snaps/count.png)

### 3. List method extend()
- It will add one or more elements in the list and add each element separately. It means that all of these items of (string,list,tuple) will add separately in the list.
- eg. city.extend(["Peshawar","Sukkur"]) --> it will add peshawar and sukkur separately in the list.
- eg. city.extend("AB") --> it will add A and B separately in the list.

![extend](Snaps/extend.png)

### 4. List method index()

- It will give the position of the first occurance of any given item.
- You can also give it a start and end range. eg. city.index("Muree",8) --> it will find position of the given item after the 8 position because we pass the starting position.
- city.index("Muree",start,end)

![index](Snaps/index.png)
![index1](Snaps/index1.png)

### 5. List method insert()

- It will add element at your given position.
- It takes two arguments.
    - position --> index where you want to insert.
    - item --> the element you want to add.
    - eg. city.insert(10,"Kagan")

![insert](Snaps/insert.png)

### 6. List method pop()

- It will remove the last element and return the remove element from the list by default if we do not give any index. --> city.pop()
- It will remove the item from the list of the given index and return the remove element. --> city.pop(11)
- It will give error if we give index out of range from the list. --> city.pop(100) index out of range
- pop() is useful when you want both to remove and use the element.
- pop() → remove by index, returns the removed item.

![pop](Snaps/pop.png)

### 7. List method remove

- It will remove the first occurance of any item.
- remove() → remove by value, no return, error if not found.

![remove](Snaps/remove.png)

### 8. List method reverse()

- The reverse() method in Python reverses the order of the list in place.
That means it directly changes the list — it does not make a new one, and it doesn’t return anything.
- It works in-place (modifies the original list).
- It doesn’t sort; it just flips the list backwards.
- It returns None, so you shouldn’t do x = nums.reverse() (that would make x = None).

![reverse](Snaps/reverse.png)

### 9. List method sort()

- The sort() method is used to arrange list elements in ascending (by default) or descending order.
- In-place: It changes the original list.
- Works on numbers and strings (alphabetical order for strings).
- It can’t sort lists with mixed types (like numbers + strings).

    #### Ascending order example (by default)
        - eg. city.sort()

    ![sort-asc](Snaps/sort-asc.png)

    #### Descending order example
        - eg. city.sort(reverse=True)

    ![sort-dsc](Snaps/sort-dsc.png)

### 10. List method copy()

- The copy() method makes a shallow copy of a list.
That means it creates a new list with the same elements, but at a different memory location.

![copy](Snaps/copy.png)

#### Shalow Copy

- If we add item into city1 it will not add into city because both list item are located in a different memory location. 

#### Shalow copy with nested list

- If we make a list and add nested list into a list and copy that list, so that mean's we have 2 list with the same items. But if we change nested list any of them the changes will occur in both list.
- This happens beacuase of nested list items of both list sharing the same memory location. 

![shalow-copy](Snaps/shalow-copy.png)

#### Deep copy

- In deep copy there is both simple and nested list there is no change in list if we change in any list beacuase in deep copy both list item are stored in a different memory location.

![deep-copy](Snaps/deep-copy.png)