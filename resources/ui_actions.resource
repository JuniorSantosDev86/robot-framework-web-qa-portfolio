*** Settings ***
Resource    common.resource


*** Keywords ***
Click Element Via Javascript
    [Arguments]    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Click Element Safely
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Scroll Element Into View    ${locator}
    Wait Until Element Is Enabled    ${locator}
    ${clicked}=    Run Keyword And Return Status    Click Element    ${locator}
    IF    not ${clicked}
        Click Element Via Javascript    ${locator}
    END

Click Element And Wait Until Visible
    [Arguments]    ${locator}    ${expected_locator}
    Click Element Safely    ${locator}
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${expected_locator}    5s
    IF    not ${visible}
        Click Element Via Javascript    ${locator}
    END
    Wait Until Element Is Visible    ${expected_locator}

Click Element And Wait Until Not Visible
    [Arguments]    ${locator}    ${expected_not_visible_locator}
    Click Element Safely    ${locator}
    ${not_visible}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${expected_not_visible_locator}    5s
    IF    not ${not_visible}
        Click Element Via Javascript    ${locator}
    END
    Wait Until Element Is Not Visible    ${expected_not_visible_locator}

Click Element And Wait Until Location Contains
    [Arguments]    ${locator}    ${expected_location}
    Click Element Safely    ${locator}
    ${location_ok}=    Run Keyword And Return Status    Wait Until Location Contains    ${expected_location}    5s
    IF    not ${location_ok}
        Click Element Via Javascript    ${locator}
    END
    Wait Until Location Contains    ${expected_location}

Set Field Value Via Javascript
    [Arguments]    ${locator}    ${value}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript
    ...    const element = arguments[0];
    ...    const value = arguments[1];
    ...    const nativeSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
    ...    nativeSetter.call(element, value);
    ...    element.dispatchEvent(new Event('input', { bubbles: true }));
    ...    element.dispatchEvent(new Event('change', { bubbles: true }));
    ...    ARGUMENTS    ${element}    ${value}

Set Field Value Safely
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}
    Scroll Element Into View    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${value}
    ${current_value}=    Get Element Attribute    ${locator}    value
    ${value_ok}=    Run Keyword And Return Status    Should Be Equal    ${current_value}    ${value}
    IF    not ${value_ok}
        Set Field Value Via Javascript    ${locator}    ${value}
    END
    ${final_value}=    Get Element Attribute    ${locator}    value
    Should Be Equal    ${final_value}    ${value}
