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

${VALID_FIRST_NAME}             Ademir
${VALID_LAST_NAME}              Santos
${VALID_POSTAL_CODE}            80000-000
${CHECKOUT_COMPLETE_MESSAGE}    Thank you for your order!


*** Keywords ***
Click Checkout Element With Fallback
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Scroll Element Into View    ${locator}
    Wait Until Element Is Enabled    ${locator}
    ${normal_click_status}=    Run Keyword And Return Status    Click Element    ${locator}
    Run Keyword If    not ${normal_click_status}    Click Checkout Element Via Javascript    ${locator}

Click Checkout Element Via Javascript
    [Arguments]    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Set Checkout Field
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}
    Scroll Element Into View    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${value}
    ${current_value}=    Get Element Attribute    ${locator}    value
    ${value_is_correct}=    Run Keyword And Return Status    Should Be Equal    ${current_value}    ${value}
    Run Keyword If    not ${value_is_correct}    Set Checkout Field Via Javascript    ${locator}    ${value}
    ${final_value}=    Get Element Attribute    ${locator}    value
    Should Be Equal    ${final_value}    ${value}

Set Checkout Field Via Javascript
    [Arguments]    ${locator}    ${value}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript
    ...    const element = arguments[0];
    ...    const value = arguments[1];
    ...    const nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
    ...    nativeInputValueSetter.call(element, value);
    ...    element.dispatchEvent(new Event('input', { bubbles: true }));
    ...    element.dispatchEvent(new Event('change', { bubbles: true }));
    ...    ARGUMENTS    ${element}    ${value}

Start Checkout With Backpack In Cart
    Add Backpack To Cart
    Open Cart
    Cart Should Contain Product    ${BACKPACK_NAME}
    Proceed To Checkout From Cart

Proceed To Checkout From Cart
    Click Checkout Element With Fallback    ${CHECKOUT_BUTTON}
    ${on_step_one}=    Run Keyword And Return Status    Wait Until Location Contains    checkout-step-one.html    5s
    Run Keyword If    not ${on_step_one}    Click Checkout Element Via Javascript    ${CHECKOUT_BUTTON}
    Wait Until Location Contains    checkout-step-one.html
    Wait Until Element Is Visible    ${FIRST_NAME_FIELD}

Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Set Checkout Field    ${FIRST_NAME_FIELD}    ${first_name}
    Set Checkout Field    ${LAST_NAME_FIELD}    ${last_name}
    Set Checkout Field    ${POSTAL_CODE_FIELD}    ${postal_code}

Continue Checkout
    Click Checkout Element With Fallback    ${CONTINUE_BUTTON}
    ${has_result}=    Run Keyword And Return Status    Wait For Checkout Step Two Or Error
    Run Keyword If    not ${has_result}    Click Checkout Element Via Javascript    ${CONTINUE_BUTTON}

Wait For Checkout Step Two Or Error
    Wait Until Keyword Succeeds    5x    1s    Checkout Step Two Or Error Should Be Visible

Checkout Step Two Or Error Should Be Visible
    ${on_step_two}=    Run Keyword And Return Status    Location Should Contain    checkout-step-two.html
    ${has_error}=      Run Keyword And Return Status    Page Should Contain Element    ${CHECKOUT_ERROR_MESSAGE}
    Should Be True    ${on_step_two} or ${has_error}

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
    Click Checkout Element With Fallback    ${FINISH_BUTTON}
    ${on_complete}=    Run Keyword And Return Status    Wait Until Location Contains    checkout-complete.html    5s
    Run Keyword If    not ${on_complete}    Click Checkout Element Via Javascript    ${FINISH_BUTTON}
    Wait Until Location Contains    checkout-complete.html

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