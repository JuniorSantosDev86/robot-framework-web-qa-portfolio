*** Settings ***
Resource          ../resources/common.resource
Resource          ../resources/login_keywords.resource
Test Setup        Open SauceDemo
Test Teardown     Close Browser Session


*** Test Cases ***
Valid Login Should Redirect User To Products Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Be Successful

Invalid Login Should Show Error Message
    Login With Credentials    ${INVALID_USER}    ${INVALID_PASSWORD}
    Login Error Message Should Be Visible

Locked User Should Show Error Message
    Login With Credentials    ${LOCKED_USER}    ${VALID_PASSWORD}
    Login Error Message Should Be Visible
