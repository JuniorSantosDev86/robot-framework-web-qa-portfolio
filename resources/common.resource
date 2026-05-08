*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BASE_URL}             https://www.saucedemo.com/
${BROWSER}              chrome
${VALID_USER}           standard_user
${VALID_PASSWORD}       secret_sauce
${LOCKED_USER}          locked_out_user
${INVALID_USER}         invalid_user
${INVALID_PASSWORD}     invalid_password
${DEFAULT_TIMEOUT}      10s


*** Keywords ***
Open SauceDemo
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${headless}=    Set Variable    --headless=new
    ${no_sandbox}=    Set Variable    --no-sandbox
    ${disable_dev_shm}=    Set Variable    --disable-dev-shm-usage
    ${window_size}=    Set Variable    --window-size=1920,1080
    Call Method    ${chrome_options}    add_argument    ${headless}
    Call Method    ${chrome_options}    add_argument    ${no_sandbox}
    Call Method    ${chrome_options}    add_argument    ${disable_dev_shm}
    Call Method    ${chrome_options}    add_argument    ${window_size}
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${chrome_options}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    id=user-name

Close Browser Session
    Close Browser
