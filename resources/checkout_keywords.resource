*** Settings ***
Resource    cart_keywords.resource


*** Variables ***
${CHECKOUT_BUTTON}              css=[data-test="checkout"]
${FIRST_NAME_FIELD}             css=[data-test="firstName"]
${LAST_NAME_FIELD}              css=[data-test="lastName"]
${POSTAL_CODE_FIELD}            css=[data-test="postalCode"]
${CONTINUE_BUTTON}              css=[data-test="continue"]
${FINISH_BUTTON}                css=[data-test="finish"]
${CHECKOUT_ERROR_MESSAGE}       css=[data-test="error"]
${CHECKOUT_OVERVIEW}            css=[data-test="checkout-summary-container"]
${CHECKOUT_COMPLETE_HEADER}     css=[data-test="complete-header"]
${BACK_HOME_BUTTON}             css=[data-test="back-to-products"]

${VALID_FIRST_NAME}             Ademir
${VALID_LAST_NAME}              Santos
${VALID_POSTAL_CODE}            80000-000
${CHECKOUT_COMPLETE_MESSAGE}    Thank you for your order!


*** Keywords ***
Start Checkout With Backpack In Cart
    Add Backpack To Cart
    Open Cart
    Cart Should Contain Product    ${BACKPACK_NAME}
    Proceed To Checkout From Cart
    Wait Until Element Is Visible    ${FIRST_NAME_FIELD}

Proceed To Checkout From Cart
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}
    Click Button    ${CHECKOUT_BUTTON}
    Wait Until Location Contains    checkout-step-one.html

Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${FIRST_NAME_FIELD}    ${first_name}
    Input Text    ${LAST_NAME_FIELD}    ${last_name}
    Input Text    ${POSTAL_CODE_FIELD}    ${postal_code}

Continue Checkout
    Click Button    ${CONTINUE_BUTTON}

Submit Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Checkout Information    ${first_name}    ${last_name}    ${postal_code}
    Continue Checkout

Checkout Overview Should Be Visible
    Wait Until Location Contains    checkout-step-two.html
    Wait Until Element Is Visible    ${CHECKOUT_OVERVIEW}

Checkout Overview Should Contain Product
    [Arguments]    ${product_name}
    Wait Until Page Contains    ${product_name}

Finish Checkout
    Wait Until Element Is Visible    ${FINISH_BUTTON}
    Click Button    ${FINISH_BUTTON}

Checkout Complete Should Be Visible
    Wait Until Location Contains    checkout-complete.html
    Wait Until Element Is Visible    ${CHECKOUT_COMPLETE_HEADER}
    Wait Until Page Contains    ${CHECKOUT_COMPLETE_MESSAGE}

Checkout Error Should Be Visible
    Wait Until Element Is Visible    ${CHECKOUT_ERROR_MESSAGE}

Checkout Error Should Contain
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${CHECKOUT_ERROR_MESSAGE}
    ${checkout_error_text}=    Get Text    ${CHECKOUT_ERROR_MESSAGE}
    Should Contain    ${checkout_error_text}    ${expected_error}
