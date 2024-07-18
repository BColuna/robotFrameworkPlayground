*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
Login User
    [Arguments]    ${USER}    ${PASS}
    Input Text    ${USERNAME-FIELD}    ${USER}
    Input Text    ${PASSWORD-FIELD}    ${PASS}
    Click Element    ${LOGIN-BUTTON}

Validate Url
    [Arguments]    ${EXPECTED}
    ${NEW-ULR}=    Get Location
    Should Be Equal    ${NEW-ULR}     ${EXPECTED}

Validate Error Message
    [Arguments]    ${EXPECTED}
    Element Should Be Visible    ${LOGIN-ERROR-MESSAGE}
    ${ERROR-MESSAGE}=  Get Text  ${LOGIN-ERROR-MESSAGE}
    Should Be Equal As Strings  ${ERROR-MESSAGE}  ${EXPECTED}


*** Variables ***

${BASE-URL}    https://www.saucedemo.com/
${INVENTORY-URL}    ${BASE-URL}inventory.html
&{VALID-LOGIN}    user=standard_user    pass=secret_sauce

${USERNAME-FIELD}    css=#user-name
${PASSWORD-FIELD}    css=#password
${LOGIN-BUTTON}    css=#login-button
${LOGIN-ERROR-MESSAGE}    css=.error-message-container.error


*** Test Cases ***
Happy Path
    Open Browser    ${BASE-URL}
    Login User    ${VALID-LOGIN}[user]    ${VALID-LOGIN}[pass]
    Validate Url    ${INVENTORY-URL}
    Close Browser

Sad Path
    Open Browser    ${BASE-URL}
    Login User    ${VALID-LOGIN}[user]    ${VALID-LOGIN}[pass]-WRONG
    Validate Error Message    Epic sadface: Username and password do not match any user in this service
    Validate Url    ${BASE-URL}
    Close Browser

Sad Path - only username
    Open Browser    ${BASE-URL}
    Login User    ${VALID-LOGIN}[user]    ${EMPTY}
    Validate Error Message    Epic sadface: Password is required
    Validate Url    ${BASE-URL}
    Close Browser
    
Sad Path - only pass
    Open Browser    ${BASE-URL}
    Login User    ${EMPTY}    ${VALID-LOGIN}[pass]
    Validate Error Message    Epic sadface: Username is required
    Validate Url    ${BASE-URL}
    Close Browser

Sad Path - no username and no pass
    Open Browser    ${BASE-URL}
    Click Element    ${LOGIN-BUTTON}
    Validate Error Message    Epic sadface: Username is required
    Validate Url    ${BASE-URL}
    Close Browser