*** Settings ***
Library  Selenium2Library
Suite Setup     Open Browser    ${URL}   ${BROWSER}
Suite Teardown  Close All Browsers
 
 
*** Variables ***
${URL}                 https://www.saucedemo.com/
${BROWSER}             Chrome
${user_textbox}        css=input[name=user-name]
${password_textbox}    css=input[name=password]
${login_button}        css=input[name=login-button]
${burger_button}       css=button[id="react-burger-menu-btn"]
 
*** Test Cases ***
User Login
    Wait Until Element Is Visible    ${user_textbox}
    Wait Until Element Is Visible    ${password_textbox}
    Input Text      ${user_textbox}   standard_user
    Input Text      ${password_textbox}   secret_sauce
    Click Element    ${login_button}
    Wait Until Element Is Visible    ${burger_button}
    ${url}=   Get Location
    Should Be Equal    ${url}  https://www.saucedemo.com/inventory.html