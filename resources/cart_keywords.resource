*** Settings ***
Resource    products_keywords.resource


*** Variables ***
${CART_LINK}                  css=[data-test="shopping-cart-link"]
${CART_BADGE}                 css=[data-test="shopping-cart-badge"]
${CART_LIST}                  css=[data-test="cart-list"]
${CART_ITEM}                  css=[data-test="inventory-item"]
${CART_ITEM_NAME}             css=[data-test="inventory-item-name"]
${ADD_BACKPACK_BUTTON}        css=[data-test="add-to-cart-sauce-labs-backpack"]
${REMOVE_BACKPACK_BUTTON}     css=[data-test="remove-sauce-labs-backpack"]
${ADD_BIKE_LIGHT_BUTTON}      css=[data-test="add-to-cart-sauce-labs-bike-light"]
${REMOVE_BIKE_LIGHT_BUTTON}   css=[data-test="remove-sauce-labs-bike-light"]


*** Keywords ***
Add Backpack To Cart
    Wait Until Element Is Visible    ${ADD_BACKPACK_BUTTON}
    Click Button    ${ADD_BACKPACK_BUTTON}
    Wait Until Element Is Visible    ${REMOVE_BACKPACK_BUTTON}

Add Bike Light To Cart
    Wait Until Element Is Visible    ${ADD_BIKE_LIGHT_BUTTON}
    Click Button    ${ADD_BIKE_LIGHT_BUTTON}
    Wait Until Element Is Visible    ${REMOVE_BIKE_LIGHT_BUTTON}

Open Cart
    Click Link    ${CART_LINK}
    Wait Until Location Contains    cart.html
    Wait Until Element Is Visible    ${CART_LIST}

Cart Badge Should Show Quantity
    [Arguments]    ${expected_quantity}
    Wait Until Element Is Visible    ${CART_BADGE}
    ${cart_badge_text}=    Get Text    ${CART_BADGE}
    Should Be Equal    ${cart_badge_text}    ${expected_quantity}

Cart Should Contain Product
    [Arguments]    ${product_name}
    Wait Until Page Contains    ${product_name}

Cart Should Not Contain Product
    [Arguments]    ${product_name}
    Wait Until Page Does Not Contain    ${product_name}

Cart Should Have Item Count
    [Arguments]    ${expected_count}
    ${cart_item_count}=    Get Element Count    ${CART_ITEM}
    Should Be Equal As Integers    ${cart_item_count}    ${expected_count}

Remove Backpack From Cart
    Wait Until Element Is Visible    ${REMOVE_BACKPACK_BUTTON}
    Click Button    ${REMOVE_BACKPACK_BUTTON}

Remove Bike Light From Cart
    Wait Until Element Is Visible    ${REMOVE_BIKE_LIGHT_BUTTON}
    Click Button    ${REMOVE_BIKE_LIGHT_BUTTON}
