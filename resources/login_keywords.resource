*** Settings ***
Resource    ui_actions.resource


*** Variables ***
${USERNAME_FIELD}        id=user-name
${PASSWORD_FIELD}        id=password
${LOGIN_BUTTON}          id=login-button
${LOGIN_ERROR}           css=[data-test="error"]
${PRODUCT_LIST}          css=[data-test="inventory-list"]


*** Keywords ***
Fill Login Form
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Password    ${PASSWORD_FIELD}    ${password}

Submit Login
    Click Element Safely    ${LOGIN_BUTTON}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Login Form    ${username}    ${password}
    Submit Login

Login Should Be Successful
    Wait Until Location Contains    inventory.html
    Wait Until Element Is Visible    ${PRODUCT_LIST}

Login Error Should Be Visible
    Wait Until Element Is Visible    ${LOGIN_ERROR}

Open SauceDemo And Login With Valid User
    Open SauceDemo
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Be Successful
