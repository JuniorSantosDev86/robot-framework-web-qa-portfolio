*** Settings ***
Resource          ../resources/products_keywords.resource
Test Setup        Open SauceDemo And Login With Valid User
Test Teardown     Close Browser Session


*** Test Cases ***
Products Page Should Display Product List
    Products Page Should Be Visible
    Product Items Should Be Displayed

Products Page Should Contain Default Products
    Product List Should Contain Default Products

User Should Be Able To Sort Products By Name Z To A
    Sort Products By Name Z To A
    First Product Name Should Be    ${Z_TO_A_FIRST_PRODUCT}

User Should Be Able To Sort Products By Price Low To High
    Sort Products By Price Low To High
    First Product Price Should Be    ${LOW_TO_HIGH_FIRST_PRICE}
