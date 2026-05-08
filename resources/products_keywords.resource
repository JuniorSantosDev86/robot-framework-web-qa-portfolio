*** Settings ***
Resource    common.resource
Resource    login_keywords.resource


*** Variables ***
${PRODUCT_LIST}              css=[data-test="inventory-list"]
${PRODUCT_ITEM}              css=[data-test="inventory-item"]
${PRODUCT_NAME}              css=[data-test="inventory-item-name"]
${PRODUCT_PRICE}             css=[data-test="inventory-item-price"]
${PRODUCT_SORT_DROPDOWN}     css=[data-test="product-sort-container"]
${BACKPACK_NAME}             Sauce Labs Backpack
${BIKE_LIGHT_NAME}           Sauce Labs Bike Light
${FLEECE_JACKET_NAME}        Sauce Labs Fleece Jacket


*** Keywords ***
Open SauceDemo And Login With Valid User
    Open SauceDemo
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Be Successful

Products Page Should Be Visible
    Wait Until Location Contains    inventory.html
    Wait Until Element Is Visible    ${PRODUCT_LIST}

Product List Should Contain Default Products
    Wait Until Page Contains    ${BACKPACK_NAME}
    Wait Until Page Contains    ${BIKE_LIGHT_NAME}
    Wait Until Page Contains    ${FLEECE_JACKET_NAME}

Product Items Should Be Displayed
    Wait Until Element Is Visible    ${PRODUCT_ITEM}
    ${product_count}=    Get Element Count    ${PRODUCT_ITEM}
    Should Be True    ${product_count} > 0

Sort Products By Name Z To A
    Wait Until Element Is Visible    ${PRODUCT_SORT_DROPDOWN}
    Select From List By Label    ${PRODUCT_SORT_DROPDOWN}    Name (Z to A)

Sort Products By Price Low To High
    Wait Until Element Is Visible    ${PRODUCT_SORT_DROPDOWN}
    Select From List By Label    ${PRODUCT_SORT_DROPDOWN}    Price (low to high)

First Product Name Should Be
    [Arguments]    ${expected_name}
    Wait Until Element Is Visible    ${PRODUCT_NAME}
    ${first_product_name}=    Get Text    ${PRODUCT_NAME}
    Should Be Equal    ${first_product_name}    ${expected_name}

First Product Price Should Be
    [Arguments]    ${expected_price}
    Wait Until Element Is Visible    ${PRODUCT_PRICE}
    ${first_product_price}=    Get Text    ${PRODUCT_PRICE}
    Should Be Equal    ${first_product_price}    ${expected_price}
