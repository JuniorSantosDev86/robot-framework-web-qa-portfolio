*** Settings ***
Resource          ../resources/checkout_keywords.resource
Test Setup        Open SauceDemo And Login With Valid User
Test Teardown     Close Browser Session


*** Test Cases ***
Checkout Overview Should Display Added Product
    Start Checkout With Backpack In Cart
    Submit Checkout Information    ${VALID_FIRST_NAME}    ${VALID_LAST_NAME}    ${VALID_POSTAL_CODE}
    Checkout Overview Should Be Visible
    Checkout Overview Should Contain Product    ${BACKPACK_NAME}

User Should Complete Checkout Successfully
    Start Checkout With Backpack In Cart
    Submit Checkout Information    ${VALID_FIRST_NAME}    ${VALID_LAST_NAME}    ${VALID_POSTAL_CODE}
    Checkout Overview Should Be Visible
    Finish Checkout
    Checkout Complete Should Be Visible

Checkout Should Require First Name
    Start Checkout With Backpack In Cart
    Submit Checkout Information    ${EMPTY}    ${VALID_LAST_NAME}    ${VALID_POSTAL_CODE}
    Checkout Error Should Contain    First Name is required

Checkout Should Require Last Name
    Start Checkout With Backpack In Cart
    Submit Checkout Information    ${VALID_FIRST_NAME}    ${EMPTY}    ${VALID_POSTAL_CODE}
    Checkout Error Should Contain    Last Name is required

Checkout Should Require Postal Code
    Start Checkout With Backpack In Cart
    Submit Checkout Information    ${VALID_FIRST_NAME}    ${VALID_LAST_NAME}    ${EMPTY}
    Checkout Error Should Contain    Postal Code is required
