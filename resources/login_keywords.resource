*** Settings ***
Resource    common.resource


*** Variables ***
${USERNAME_FIELD}        id=user-name
${PASSWORD_FIELD}        id=password
${LOGIN_BUTTON}          id=login-button
${ERROR_MESSAGE}         css=[data-test="error"]
${PRODUCT_LIST}          class=inventory_list


*** Keywords ***
Fill Login Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Fill Login Password
    [Arguments]    ${password}
    Input Password    ${PASSWORD_FIELD}    ${password}

Submit Login
    Click Button    ${LOGIN_BUTTON}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Login Username    ${username}
    Fill Login Password    ${password}
    Submit Login

Login Should Be Successful
    Wait Until Location Contains    inventory.html
    Wait Until Element Is Visible    ${PRODUCT_LIST}

Login Error Message Should Be Visible
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
