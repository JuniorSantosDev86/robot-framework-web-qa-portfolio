*** Settings ***
Resource          ../resources/cart_keywords.resource
Test Setup        Open SauceDemo And Login With Valid User
Test Teardown     Close Browser Session


*** Test Cases ***
Adding Product Should Update Cart Badge
    Add Backpack To Cart
    Cart Badge Should Show Quantity    1

Added Product Should Be Displayed In Cart
    Add Backpack To Cart
    Open Cart
    Cart Should Contain Product    ${BACKPACK_NAME}
    Cart Should Have Item Count    1

User Should Be Able To Remove Product From Cart
    Add Backpack To Cart
    Open Cart
    Remove Backpack From Cart
    Cart Should Not Contain Product    ${BACKPACK_NAME}
    Cart Should Have Item Count    0

User Should Be Able To Add Multiple Products To Cart
    Add Backpack To Cart
    Add Bike Light To Cart
    Cart Badge Should Show Quantity    2
    Open Cart
    Cart Should Contain Product    ${BACKPACK_NAME}
    Cart Should Contain Product    ${BIKE_LIGHT_NAME}
    Cart Should Have Item Count    2
