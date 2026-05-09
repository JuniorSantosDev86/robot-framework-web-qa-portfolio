*** Settings ***
Resource    products_keywords.resource


*** Variables ***
${CART_LINK}                  css=[data-test="shopping-cart-link"]
${CART_BADGE}                 css=[data-test="shopping-cart-badge"]
${CART_LIST}                  css=[data-test="cart-list"]
${CART_ITEM}                  css=[data-test="inventory-item"]
${ADD_BACKPACK_BUTTON}        css=[data-test="add-to-cart-sauce-labs-backpack"]
${REMOVE_BACKPACK_BUTTON}     css=[data-test="remove-sauce-labs-backpack"]
${ADD_BIKE_LIGHT_BUTTON}      css=[data-test="add-to-cart-sauce-labs-bike-light"]
${REMOVE_BIKE_LIGHT_BUTTON}   css=[data-test="remove-sauce-labs-bike-light"]


*** Keywords ***
Add Product To Cart
    [Arguments]    ${add_button}    ${remove_button}
    ${already_added}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${remove_button}    1s
    IF    ${already_added}
        RETURN
    END
    Click Element And Wait Until Visible    ${add_button}    ${remove_button}

Add Backpack To Cart
    Wait Until Keyword Succeeds    3x    2s    Add Product To Cart    ${ADD_BACKPACK_BUTTON}    ${REMOVE_BACKPACK_BUTTON}

Add Bike Light To Cart
    Wait Until Keyword Succeeds    3x    2s    Add Product To Cart    ${ADD_BIKE_LIGHT_BUTTON}    ${REMOVE_BIKE_LIGHT_BUTTON}

Open Cart
    Wait Until Keyword Succeeds    3x    2s    Open Cart Once

Open Cart Once
    Click Element And Wait Until Location Contains    ${CART_LINK}    cart.html
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

Remove Product From Cart
    [Arguments]    ${remove_button}
    Click Element And Wait Until Not Visible    ${remove_button}    ${remove_button}

Remove Backpack From Cart
    Wait Until Keyword Succeeds    3x    2s    Remove Product From Cart    ${REMOVE_BACKPACK_BUTTON}

Remove Bike Light From Cart
    Wait Until Keyword Succeeds    3x    2s    Remove Product From Cart    ${REMOVE_BIKE_LIGHT_BUTTON}
