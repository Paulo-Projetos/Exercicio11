*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/user

${id}    184409097                
${username}    Tom
${firstName}    Tomaz
${lastName}    Santos
${email}    santos@bol.com.br
${password}    SantosII
${phone}    2138221653
${userStatus}    34542

*** Test Cases ***
Post user
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}
    ...    lastName=${lastName}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}
    ${response}    POST    url=${url}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body} 

    Status Should Be    200
    Should Be Equal    ${response_body}[code]            ${{int(200)}}
    Should Be Equal    ${response_body}[type]            unknown
    Should Be Equal    ${response_body}[message]         ${id}


Get user
    ${response}    GET    ${{$url + '/' + $username}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[username]            ${username}
    Should Be Equal    ${response_body}[firstName]           ${firstName}
    Should Be Equal    ${response_body}[lastName]            ${lastName}
    Should Be Equal    ${response_body}[email]               ${email}
    Should Be Equal    ${response_body}[password]            ${password}
    Should Be Equal    ${response_body}[phone]               ${phone}
    Should Be Equal    ${response_body}[userStatus]          ${{int($userStatus)}}


Put pet
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=Tomas
    ...    lastName=${lastName}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}
    ${response}    PUT    ${{$url + '/' + $username}}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]            ${{int(200)}}
    Should Be Equal    ${response_body}[type]            unknown
    Should Be Equal    ${response_body}[message]         ${id}


Delete pet
    ${response}    DELETE    ${{$url + '/' + $username}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${username}




